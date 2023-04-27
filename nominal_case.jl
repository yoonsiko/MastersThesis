using JuMP, Ipopt, MathOptInterface, DataFrames, PrettyTables
include("enthalpy.jl")
include("0par.jl")
include("1MIX.jl")
include("2PrePR.jl")
include("3PR.jl")
include("4PreGHR.jl")
include("5GHR.jl")
include("6ATR.jl")
include("7PostATR.jl")
include("8ITSR.jl")
include("9PreCondensate.jl")
include("10Condensate.jl")
include("11PSA.jl")
include("dataframe.jl")
include("equilibrium.jl")
include("compWork.jl")
include("active.jl")

const MOI = MathOptInterface
C = 12.01;
H = 1.008;
O = 16;
Base.@kwdef mutable struct _par
    init::init_par = init_par();
    mix::mix_par=mix_par();
    prePR::prePR_par=prePR_par();
    pr::pr_par = pr_par();
    preGHR::preGHR_par = preGHR_par();
    ghr::ghr_par = ghr_par();
    atr::atr_par = atr_par();
    postATR::postATR_par = postATR_par();
    itsr::itsr_par = itsr_par();
    preCond::preCond_par = preCond_par();
    cond::cond_par = cond_par();
    psa::psa_par = psa_par();
    hconst = heavy_const;
    smr_const = smr_const;
    wgsr_const = wgsr_const;
    HHV_H2::Float64 = 141.7*1000;
    HHV_NG::Vector = [55.5,0.0,141.7,0.0,0.0,51.9,50.4,49.1,49.1,48.6]*1000; # CH4, H2O, H2, CO, CO2, C2H6, C3H8, n-C4H10, i-C4H10, C5H12
    molarMass::Vector = [C+H*4, H*2+O, H*2, C+O, C+O*2, C*2+H*6, C*3+H*8, C*4+H*10, C*4+H*10, C*5+H*12];
    P_H2::Float64 = 3.347; #[$/kmol]
    P_inj::Float64 = 9.650; # [$/ton CO2]
    R::Float64 = 8.314;
    elCost::Float64 = 0.14; # [$/Kwh]
end

eps = 0.1

# return_list should be either d1, d2 or d3,
function nominal()
    par = _par();
    optimizer = optimizer_with_attributes(Ipopt.Optimizer,
             "tol" => 1e-6, "constr_viol_tol" => 1e-8,
             "print_level" => 0)
    m = Model(optimizer);

    ###### Assembling the submodels to a larger model #######
    MIX_model(m, par);
    prePR_model(m, par);
    PR_model(m, par);
    preGHR_model(m, par);
    GHR_model(m, par);
    ATR_model(m, par);
    postATR_model(m, par);
    ITSR_model(m, par);
    preCond_model(m, par);
    Cond_model(m, par);
    PSA_model(m, par);

    @variable(m, 0 <= F_H2, start = 500); # H2 product that is being sold in the obj function
    @variable(m, 0 <= F_H2_heat, start = 1); # H2 from the product stream that is being used to heat up the process
    @variable(m, 0 <= F_NG_heat, start = 1); # NG from the initial stream that is being used to heat up the process
    @variable(m, 0 <= F_NG, start = 150); # NG from the initial stream that is being used in the process
    @variable(m, 0 <= F_fluegas, start = 1); # CO2 gas that generates from combusting natural gas which needs to be injected
    @variable(m, 0 <= F_inj, start = 200); # CO2 and other component gases that is being injected

    ##################### Connection constraints #######################
    for i = 1:10
        @NLconstraint(m, m[:mix_out_mol][i] - m[:prePR_in_mol][i] == 0)
        @NLconstraint(m, m[:prePR_out_mol][i] - m[:pr_in_mol][i] == 0)
    end

    for i = 1:5 # After all heavier carbons are removed
        @NLconstraint(m, m[:pr_out_mol][i] - m[:preGHR_in_mol][i] == 0)
        @NLconstraint(m, m[:preGHR_out_mol][i] - m[:ghr_in_mol][i] == 0)
        @NLconstraint(m, m[:ghr_out_mol][i] - m[:atr_in_mol][i] == 0)
        @NLconstraint(m, m[:atr_out_mol][i] - m[:postATR_in_mol][i] == 0)
        @NLconstraint(m, m[:postATR_out_mol][i] - m[:itsr_in_mol][i] == 0)
        @NLconstraint(m, m[:itsr_out_mol][i] - m[:preCond_in_mol][i] == 0)
        @NLconstraint(m, m[:preCond_out_mol][i] - m[:cond_in_mol][i] == 0)
        @NLconstraint(m, m[:cond_vap_frac][i]*m[:cond_V] - m[:psa_in_mol][i] == 0)
    end
    ################# Same for the temperature ##################################
    @NLconstraint(m, m[:mix_out_T] - m[:prePR_in_T] == 0);
    @NLconstraint(m, m[:prePR_out_T] - m[:pr_in_T] == 0);
    @NLconstraint(m, m[:pr_out_T] - m[:preGHR_in_T] == 0);
    @NLconstraint(m, m[:preGHR_out_T] - m[:ghr_in_T] == 0);
    @NLconstraint(m, m[:ghr_out_T] - m[:atr_in_T] == 0);
    @NLconstraint(m, m[:atr_out_T] - m[:postATR_in_T] == 0);
    @NLconstraint(m, m[:postATR_out_T] - m[:itsr_in_T] == 0);
    @NLconstraint(m, m[:itsr_out_T] - m[:preCond_in_T] == 0);
    @NLconstraint(m, m[:preCond_out_T] - m[:cond_in_T] == 0);
    @NLconstraint(m, m[:cond_V_T] - m[:psa_in_T] == 0);


    ############## Initial values ##########################################
    for i = 1:10
        @NLconstraint(m, par.init.init_comp[i]*m[:F_NG] - m[:mix_in_mol][i] == 0);
    end
    @NLconstraint(m, par.mix.in_T - m[:mix_in_T] == 0);
    @NLconstraint(m, par.mix.H2O_T - m[:H2O_T] == 0);

    ############# To ensure the GHR and ATR heat exchange ###################
    @NLconstraint(m, m[:ghr_Q] + m[:postATR_Q] == 0); #- additional_Q == 0);

    ##To ensure that the inlet hot stream is hotter than outlet cold stream##
    @NLconstraint(m, m[:atr_out_T] - m[:ghr_out_T] >= 25);
    @NLconstraint(m, m[:postATR_out_T] - m[:ghr_in_T] >= 25);

    ######## New constraints for the economic objective function #############
    @NLconstraint(m, m[:F_H2] - m[:psa_outProduct_mol][3] + m[:F_H2_heat] == 0);
    @NLconstraint(m, m[:F_NG] - par.init.init_stream + m[:F_NG_heat] == 0);
    @NLconstraint(m, m[:F_fluegas] - m[:F_NG_heat] - 2*m[:F_NG_heat]/0.79 == 0);
    @NLconstraint(m, m[:F_inj] - m[:F_fluegas] - sum(value(m[:psa_outPurge_mol][i]) for i = 1:5) == 0);
    @NLconstraint(m, m[:prePR_Q] + m[:preGHR_Q] - m[:F_H2_heat]*par.HHV_H2*2.016 - sum(m[:F_NG_heat]*par.HHV_NG[i]*par.init.init_comp[i]*par.molarMass[i] for i = 1:10) == 0);


    compW1 = Wrev(m, m[:F_inj], 1, 10, m[:psa_outPurge_T], par);
    T2 = compT(m, m[:psa_outPurge_T],1,10);
    compW2 = Wrev(m, m[:F_inj],10,100,m[:psa_outPurge_T], par);
    compWsum = @NLexpression(m, compW1 + compW2);
    @NLobjective(m, Max, m[:F_H2]*par.P_H2 - compWsum*par.elCost/1000); # 44*m[:F_inj]/1000*par.P_inj
    #@NLobjective(m, Max, m[:psa_outProduct_mol][3])
    optimize!(m)
    nominal_J = objective_value(m)

    nominal_values = [
        value(m[:mix_in_mol][1]), value(m[:mix_in_mol][2]), value(m[:mix_in_mol][3]), value(m[:mix_in_mol][4]), value(m[:mix_in_mol][5]),
        value(m[:mix_in_mol][6]), value(m[:mix_in_mol][7]), value(m[:mix_in_mol][8]), value(m[:mix_in_mol][9]), value(m[:mix_in_mol][10]),
        value(m[:mix_out_mol][1]), value(m[:mix_out_mol][2]), value(m[:mix_out_mol][3]), value(m[:mix_out_mol][4]), value(m[:mix_out_mol][5]), 
        value(m[:mix_out_mol][6]), value(m[:mix_out_mol][7]), value(m[:mix_out_mol][8]), value(m[:mix_out_mol][9]), value(m[:mix_out_mol][10]),
        value(m[:prePR_in_mol][1]), value(m[:prePR_in_mol][2]), value(m[:prePR_in_mol][3]), value(m[:prePR_in_mol][4]), value(m[:prePR_in_mol][5]),
        value(m[:prePR_in_mol][6]), value(m[:prePR_in_mol][7]), value(m[:prePR_in_mol][8]), value(m[:prePR_in_mol][9]), value(m[:prePR_in_mol][10]),
        value(m[:prePR_out_mol][1]), value(m[:prePR_out_mol][2]), value(m[:prePR_out_mol][3]), value(m[:prePR_out_mol][4]), value(m[:prePR_out_mol][5]),
        value(m[:prePR_out_mol][6]), value(m[:prePR_out_mol][7]), value(m[:prePR_out_mol][8]), value(m[:prePR_out_mol][9]), value(m[:prePR_out_mol][10]),  
        value(m[:pr_in_mol][1]), value(m[:pr_in_mol][2]), value(m[:pr_in_mol][3]), value(m[:pr_in_mol][4]), value(m[:pr_in_mol][5]), 
        value(m[:pr_in_mol][6]), value(m[:pr_in_mol][7]), value(m[:pr_in_mol][8]), value(m[:pr_in_mol][9]), value(m[:pr_in_mol][10]), 
        value(m[:pr_out_mol][1]), value(m[:pr_out_mol][2]), value(m[:pr_out_mol][3]), value(m[:pr_out_mol][4]), value(m[:pr_out_mol][5]), 
        value(m[:pr_out_mol][6]), value(m[:pr_out_mol][7]), value(m[:pr_out_mol][8]), value(m[:pr_out_mol][9]), value(m[:pr_out_mol][10]), 
        value(m[:preGHR_in_mol][1]), value(m[:preGHR_in_mol][2]), value(m[:preGHR_in_mol][3]), value(m[:preGHR_in_mol][4]), value(m[:preGHR_in_mol][5]),
        value(m[:preGHR_out_mol][1]), value(m[:preGHR_out_mol][2]), value(m[:preGHR_out_mol][3]), value(m[:preGHR_out_mol][4]), value(m[:preGHR_out_mol][5]), 
        value(m[:ghr_in_mol][1]), value(m[:ghr_in_mol][2]), value(m[:ghr_in_mol][3]), value(m[:ghr_in_mol][4]), value(m[:ghr_in_mol][5]),
        value(m[:ghr_out_mol][1]), value(m[:ghr_out_mol][2]), value(m[:ghr_out_mol][3]), value(m[:ghr_out_mol][4]), value(m[:ghr_out_mol][5]),
        value(m[:atr_in_mol][1]), value(m[:atr_in_mol][2]), value(m[:atr_in_mol][3]), value(m[:atr_in_mol][4]), value(m[:atr_in_mol][5]),
        value(m[:atr_out_mol][1]), value(m[:atr_out_mol][2]), value(m[:atr_out_mol][3]), value(m[:atr_out_mol][4]), value(m[:atr_out_mol][5]), 
        value(m[:postATR_in_mol][1]), value(m[:postATR_in_mol][2]), value(m[:postATR_in_mol][3]), value(m[:postATR_in_mol][4]), value(m[:postATR_in_mol][5]), 
        value(m[:postATR_out_mol][1]), value(m[:postATR_out_mol][2]), value(m[:postATR_out_mol][3]), value(m[:postATR_out_mol][4]), value(m[:postATR_out_mol][5]), 
        value(m[:itsr_in_mol][1]), value(m[:itsr_in_mol][2]), value(m[:itsr_in_mol][3]), value(m[:itsr_in_mol][4]), value(m[:itsr_in_mol][5]), 
        value(m[:itsr_out_mol][1]), value(m[:itsr_out_mol][2]), value(m[:itsr_out_mol][3]), value(m[:itsr_out_mol][4]), value(m[:itsr_out_mol][5]), 
        value(m[:preCond_in_mol][1]), value(m[:preCond_in_mol][2]), value(m[:preCond_in_mol][3]), value(m[:preCond_in_mol][4]), value(m[:preCond_in_mol][5]), 
        value(m[:preCond_out_mol][1]), value(m[:preCond_out_mol][2]), value(m[:preCond_out_mol][3]), value(m[:preCond_out_mol][4]), value(m[:preCond_out_mol][5]), 
        value(m[:cond_in_mol][1]), value(m[:cond_in_mol][2]), value(m[:cond_in_mol][3]), value(m[:cond_in_mol][4]), value(m[:cond_in_mol][5]),
        value(m[:cond_L]), value(m[:cond_liq_frac][1]), value(m[:cond_liq_frac][2]), value(m[:cond_liq_frac][3]), value(m[:cond_liq_frac][4]), value(m[:cond_liq_frac][5]),
        value(m[:cond_V]), value(m[:cond_vap_frac][1]), value(m[:cond_vap_frac][2]), value(m[:cond_vap_frac][3]), value(m[:cond_vap_frac][4]), value(m[:cond_vap_frac][5]),
        value(m[:psa_in_mol][1]), value(m[:psa_in_mol][2]), value(m[:psa_in_mol][3]), value(m[:psa_in_mol][4]), value(m[:psa_in_mol][5]), 
        value(m[:psa_outProduct_mol][1]), value(m[:psa_outProduct_mol][2]), value(m[:psa_outProduct_mol][3]), value(m[:psa_outProduct_mol][4]), value(m[:psa_outProduct_mol][5]), 
        value(m[:psa_outPurge_mol][1]), value(m[:psa_outPurge_mol][2]), value(m[:psa_outPurge_mol][3]), value(m[:psa_outPurge_mol][4]), value(m[:psa_outPurge_mol][5]), 
        value(m[:mix_in_T]), value(m[:mix_out_T]), value(m[:H2O_T]), value(m[:prePR_in_T]), value(m[:prePR_out_T]), value(m[:preGHR_in_T]), value(m[:preGHR_out_T]), 
        value(m[:ghr_in_T]), value(m[:ghr_out_T]), value(m[:atr_in_T]), value(m[:postATR_in_T]), value(m[:postATR_out_T]),
        value(m[:preCond_out_T]), value(m[:cond_in_T]), value(m[:cond_L_T]), value(m[:cond_V_T]), value(m[:psa_in_T]), value(m[:psa_outProduct_T]), value(m[:psa_outPurge_T]),
        value(m[:prePR_Q]), value(m[:preGHR_Q]), value(m[:ghr_Q]), value(m[:postATR_Q]), value(m[:itsr_Q]), value(m[:preCond_Q]),
        value(m[:H2Ostream]), value(m[:F_H2]), value(m[:F_H2_heat]), value(m[:F_NG]), value(m[:F_NG_heat]), value(m[:F_fluegas]), value(m[:F_inj])
    ]
    return nominal_values, nominal_J
end