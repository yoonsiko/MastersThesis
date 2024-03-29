variable_name = [
    "mix_in_mol[1]", "mix_in_mol[2]", "mix_in_mol[3]", "mix_in_mol[4]", "mix_in_mol[5]",
    "mix_in_mol[6]", "mix_in_mol[7]", "mix_in_mol[8]", "mix_in_mol[9]", "mix_in_mol[10]",
    "mix_out_mol[1]", "mix_out_mol[2]", "mix_out_mol[3]", "mix_out_mol[4]", "mix_out_mol[5]", 
    "mix_out_mol[6]", "mix_out_mol[7]", "mix_out_mol[8]", "mix_out_mol[9]", "mix_out_mol[10]",
    "prePR_in_mol[1]", "prePR_in_mol[2]", "prePR_in_mol[3]", "prePR_in_mol[4]", "prePR_in_mol[5]",
    "prePR_in_mol[6]", "prePR_in_mol[7]", "prePR_in_mol[8]", "prePR_in_mol[9]", "prePR_in_mol[10]",
    "prePR_out_mol[1]", "prePR_out_mol[2]", "prePR_out_mol[3]", "prePR_out_mol[4]", "prePR_out_mol[5]",
    "prePR_out_mol[6]", "prePR_out_mol[7]", "prePR_out_mol[8]", "prePR_out_mol[9]", "prePR_out_mol[10]",  
    "pr_in_mol[1]", "pr_in_mol[2]", "pr_in_mol[3]", "pr_in_mol[4]", "pr_in_mol[5]", 
    "pr_in_mol[6]", "pr_in_mol[7]", "pr_in_mol[8]", "pr_in_mol[9]", "pr_in_mol[10]", 
    "pr_out_mol[1]", "pr_out_mol[2]", "pr_out_mol[3]", "pr_out_mol[4]", "pr_out_mol[5]", 
    "pr_out_mol[6]", "pr_out_mol[7]", "pr_out_mol[8]", "pr_out_mol[9]", "pr_out_mol[10]", 
    "preGHR_in_mol[1]", "preGHR_in_mol[2]", "preGHR_in_mol[3]", "preGHR_in_mol[4]", "preGHR_in_mol[5]",
    "preGHR_out_mol[1]", "preGHR_out_mol[2]", "preGHR_out_mol[3]", "preGHR_out_mol[4]", "preGHR_out_mol[5]", 
    "ghr_in_mol[1]", "ghr_in_mol[2]", "ghr_in_mol[3]", "ghr_in_mol[4]", "ghr_in_mol[5]",
    "ghr_out_mol[1]", "ghr_out_mol[2]", "ghr_out_mol[3]", "ghr_out_mol[4]", "ghr_out_mol[5]",
    "atr_in_mol[1]", "atr_in_mol[2]", "atr_in_mol[3]", "atr_in_mol[4]", "atr_in_mol[5]",
    "atr_out_mol[1]", "atr_out_mol[2]", "atr_out_mol[3]", "atr_out_mol[4]", "atr_out_mol[5]", 
    "postATR_in_mol[1]", "postATR_in_mol[2]", "postATR_in_mol[3]", "postATR_in_mol[4]", "postATR_in_mol[5]", 
    "postATR_out_mol[1]", "postATR_out_mol[2]", "postATR_out_mol[3]", "postATR_out_mol[4]", "postATR_out_mol[5]", 
    "itsr_in_mol[1]", "itsr_in_mol[2]", "itsr_in_mol[3]", "itsr_in_mol[4]", "itsr_in_mol[5]", 
    "itsr_out_mol[1]", "itsr_out_mol[2]", "itsr_out_mol[3]", "itsr_out_mol[4]", "itsr_out_mol[5]", 
    "preCond_in_mol[1]", "preCond_in_mol[2]", "preCond_in_mol[3]", "preCond_in_mol[4]", "preCond_in_mol[5]", 
    "preCond_out_mol[1]", "preCond_out_mol[2]", "preCond_out_mol[3]", "preCond_out_mol[4]", "preCond_out_mol[5]", 
    "cond_in_mol[1]", "cond_in_mol[2]", "cond_in_mol[3]", "cond_in_mol[4]", "cond_in_mol[5]",
    "cond_L", "cond_liq_frac[1]", "cond_liq_frac[2]", "cond_liq_frac[3]", "cond_liq_frac[4]", "cond_liq_frac[5]",
    "cond_V", "cond_vap_frac[1]", "cond_vap_frac[2]", "cond_vap_frac[3]", "cond_vap_frac[4]", "cond_vap_frac[5]",
    "psa_in_mol[1]", "psa_in_mol[2]", "psa_in_mol[3]", "psa_in_mol[4]", "psa_in_mol[5]", 
    "psa_outProduct_mol[1]", "psa_outProduct_mol[2]", "psa_outProduct_mol[3]", "psa_outProduct_mol[4]", "psa_outProduct_mol[5]", 
    "psa_outPurge_mol[1]", "psa_outPurge_mol[2]", "psa_outPurge_mol[3]", "psa_outPurge_mol[4]", "psa_outPurge_mol[5]", 
    "mix_in_T", "mix_out_T", "H2O_T", "prePR_in_T", "prePR_out_T", "preGHR_in_T", "preGHR_out_T", 
    "ghr_in_T", "ghr_out_T", "atr_in_T", "postATR_in_T", "postATR_out_T",
    "preCond_out_T", "cond_in_T", "cond_L_T", "cond_V_T", "psa_in_T", "psa_outProduct_T", "psa_outPurge_T",
    "prePR_Q", "preGHR_Q", "ghr_Q", "postATR_Q", "itsr_Q", "preCond_Q",
    "H2Ostream", "F_H2", "F_H2_heat", "F_NG", "F_NG_heat", "F_fluegas", "F_inj"
]
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
include("nominal_case.jl")
include("gain_d.jl")
include("gain_u.jl")
include("J_uu.jl")
include("J_ud.jl")
eps = 1e-5
nominal_values, nominal_J = nominal();

function test_delta_y(option)
    delta_u = 0;
    delta_d = 0;

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

    if option == 1 # u1 + h
        delta_u = eps*79.29706225438805; 
        @NLconstraint(m, m[:nO2]-79.29706225438805*(1+eps) == 0);
        @NLconstraint(m, m[:pr_in_T]-644.5953165006283== 0);
        @NLconstraint(m, m[:atr_out_T]-1291.817465833818 == 0);
    elseif option == 2 # u2 + h 
        delta_u = eps*644.5953165006283;
        @NLconstraint(m, m[:nO2]-79.29706225438805 == 0);
        @NLconstraint(m, m[:pr_in_T]-644.5953165006283*(1+eps) == 0);
        @NLconstraint(m, m[:atr_out_T]-1291.817465833818 == 0);
    elseif option == 3 # u3 + h
        delta_u = eps*1291.817465833818; 
        @NLconstraint(m, m[:nO2]-79.29706225438805 == 0);
        @NLconstraint(m, m[:pr_in_T]-644.5953165006283== 0);
        @NLconstraint(m, m[:atr_out_T]-1291.817465833818*(1+eps) == 0);
    elseif option == 4 # d1 + k
        delta_d = eps*par.init.init_stream;
        par.init.init_stream = par.init.init_stream*(1+eps);
        @NLconstraint(m, m[:nO2]-79.29706225438805 == 0);
        @NLconstraint(m, m[:pr_in_T]-644.5953165006283== 0);
        @NLconstraint(m, m[:atr_out_T]-1291.817465833818 == 0);
    elseif option == 5 # d2 + k
        delta_d = eps*par.elCost;
        par.elCost = par.elCost*(1+eps);
        @NLconstraint(m, m[:nO2]-79.29706225438805 == 0);
        @NLconstraint(m, m[:pr_in_T]-644.5953165006283== 0);
        @NLconstraint(m, m[:atr_out_T]-1291.817465833818 == 0);
    elseif option == 6 # d3 + k
        delta_d = eps*par.P_H2;
        par.P_H2 = par.P_H2*(1+eps);
        @NLconstraint(m, m[:nO2]-79.29706225438805 == 0);
        @NLconstraint(m, m[:pr_in_T]-644.5953165006283== 0);
        @NLconstraint(m, m[:atr_out_T]-1291.817465833818 == 0);
    elseif option == -1 # u1 - h
        delta_u = -eps*79.29706225438805;
        @NLconstraint(m, m[:nO2]-79.29706225438805*(1-eps) == 0);
        @NLconstraint(m, m[:pr_in_T]-644.5953165006283== 0);
        @NLconstraint(m, m[:atr_out_T]-1291.817465833818 == 0);
    elseif option == -2 # u2 - h
        delta_u = -eps*644.5953165006283;
        @NLconstraint(m, m[:nO2]-79.29706225438805 == 0);
        @NLconstraint(m, m[:pr_in_T]-644.5953165006283*(1-eps) == 0);
        @NLconstraint(m, m[:atr_out_T]-1291.817465833818 == 0);
    elseif option == -3 # u3 - h
        delta_u = -eps*1291.817465833818;
        @NLconstraint(m, m[:nO2]-79.29706225438805 == 0);
        @NLconstraint(m, m[:pr_in_T]-644.5953165006283== 0);
        @NLconstraint(m, m[:atr_out_T]-1291.817465833818*(1-eps) == 0);
    elseif option == -4 # d1 - k
        delta_d = -eps*par.init.init_stream;
        par.init.init_stream = par.init.init_stream*(1-eps);
        @NLconstraint(m, m[:nO2]-79.29706225438805 == 0);
        @NLconstraint(m, m[:pr_in_T]-644.5953165006283== 0);
        @NLconstraint(m, m[:atr_out_T]-1291.817465833818 == 0);
    elseif option == -5 # d2 - k
        delta_d = -eps*par.elCost;
        par.elCost = par.elCost*(1-eps);
        @NLconstraint(m, m[:nO2]-79.29706225438805 == 0);
        @NLconstraint(m, m[:pr_in_T]-644.5953165006283== 0);
        @NLconstraint(m, m[:atr_out_T]-1291.817465833818 == 0);
    elseif option == -6 # d3 - k
        delta_d = -eps*par.P_H2;
        par.P_H2 = par.P_H2*(1-eps);
        @NLconstraint(m, m[:nO2]-79.29706225438805 == 0);
        @NLconstraint(m, m[:pr_in_T]-644.5953165006283== 0);
        @NLconstraint(m, m[:atr_out_T]-1291.817465833818 == 0);
    else 
        print("Option not valid")
    end

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

    output_change = [
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

    ###### Calculating left hand side ######
    lhs = zeros(length(output_change))
    for i in eachindex(output_change)
        lhs[i] = output_change[i] - nominal_values[i]
    end

    ##### Calculating right hand side #####
    if -3 <= option <= 3
        G_y_matrix = G_y(nominal_values, option, eps);
        rhs = G_y_matrix*delta_u;
    else
        G_yd_matrix = G_yd(nominal_values, option+3, eps);
        rhs = G_yd_matrix*delta_d;
    end

    ##### Calculating the difference between left hand side and right hand side ##### 
    diff = zeros(length(lhs));
    for i in eachindex(lhs)
        diff[i] = lhs[i] - rhs[i];
    end

    ##### Printing the results of the linearization #####
    return DataFrame(Variable = variable_name,
                     delta_y = lhs,
                     linearized = rhs,
                     Difference = diff)
end

#show(test_delta_y(-6), allrows=true)

function test_matrix(option)
    delta_d = 0;
    input_list = [79.29706225438805,644.5953165006283,1291.817465833818]
    par = _par();
    optimizer = optimizer_with_attributes(Ipopt.Optimizer,
             "tol" => 1e-10, "constr_viol_tol" => 1e-10,
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

    if option == 1 # d1 + k
        delta_d = [eps*par.init.init_stream; 0; 0];
        par.init.init_stream = par.init.init_stream*(1+eps);
    elseif option == 2 # d2 + k
        delta_d = [0;eps*par.elCost;0];
        par.elCost = par.elCost*(1+eps);
    elseif option == 3 # d3 + k
        delta_d = [0;0;eps*par.P_H2];
        par.P_H2 = par.P_H2*(1+eps);
    elseif option == -1 # d1 - k
        delta_d = [-eps*par.init.init_stream; 0; 0];
        par.init.init_stream = par.init.init_stream*(1-eps);
    elseif option == -2 # d2 - k
        delta_d = [0;-eps*par.elCost;0];
        par.elCost = par.elCost*(1-eps);
    elseif option == -3 # d3 - k
        delta_d = [0;0;-eps*par.P_H2];
        par.P_H2 = par.P_H2*(1-eps);
    else 
        print("Option not valid")
    end

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
    optimize!(m);

    J_uu_matrix = J_uu(5e-2);
    J_ud_matrix = J_ud(5e-2);
    rhs = inv(J_uu_matrix)*J_ud_matrix*(delta_d);
    lhs = [value(m[:nO2])-79.29706225438805,
        value(m[:pr_in_T])-644.5953165006283,
        value(m[:atr_out_T])-1291.817465833818]
    input_name = ["nO2", "pr_in_T", "atr_out_T"];
    diff = zeros(length(lhs));

    for i in eachindex(lhs)
        diff[i] = lhs[i] - rhs[i];
    end
    return DataFrame(Variable = input_name,
                    lhs = lhs,
                    rhs = rhs,
                    diff = diff);
end

#show(test_matrix(1), allrows=true)