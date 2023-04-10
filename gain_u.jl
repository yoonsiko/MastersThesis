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
# Variables that are removed = S/C, nO2, T_prePR, T_PR, T_ATR, T_postATR, T_ITSR, T_cond

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

eps = 1e-5
nominal_values = nominal();

# 1: u1, n_O2, +1e-5
# 2: u2, T_prePR, +1e-5
# 3: u3, T_ATR, +1e-5
# -1: u1, n_O2, -1e-5
# -2: u2, T_prePR, -1e-5
# -3: u3, T_ATR. -1e-5
function G_y(nominal, option, eps)

    par = _par();
    optimizer = optimizer_with_attributes(Ipopt.Optimizer,
             "tol" => 1e-6, "constr_viol_tol" => 1e-8)
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

    if option == 1
        delta_u = eps*79.29706225438805;
        @NLconstraint(m, m[:nO2]-79.29706225438805*(1+eps) == 0);
    elseif option == 2
        delta_u = eps*644.5953165006283;
        @NLconstraint(m, m[:pr_in_T]-644.5953165006283*(1+eps) == 0);
    elseif option == 3
        delta_u = eps*1291.817465833818;
        @NLconstraint(m, m[:atr_out_T]-1291.817465833818*(1+eps) == 0);
    elseif option == -1
        delta_u = -eps*79.29706225438805;
        @NLconstraint(m, m[:nO2]-79.29706225438805*(1-eps) == 0);
    elseif option == -2
        delta_u = -eps*644.5953165006283;
        @NLconstraint(m, m[:pr_in_T]-644.5953165006283*(1-eps) == 0);
    elseif option == -3
        delta_u = -eps*1291.817465833818;
        @NLconstraint(m, m[:atr_out_T]-1291.817465833818*(1-eps) == 0);
    else 
        print("Option not valid")
    end
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
    compW2 = Wrev(m, m[:F_inj],10,100,m[:psa_outPurge_T], par);
    compWsum = @NLexpression(m, compW1 + compW2);
    @NLobjective(m, Max, m[:F_H2]*par.P_H2 - compWsum*par.elCost/1000);

    optimize!(m)

    input_change = [
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
    
    for i in eachindex(input_change)
        input_change[i] = (input_change[i]-nominal[i])/delta_u;
    end
    return input_change
end

dydu1_plus = G_y(nominal_values, 1, eps)
dydu2_plus = G_y(nominal_values, 2, eps)
dydu3_plus = G_y(nominal_values, 3, eps)
dydu1_minus = G_y(nominal_values, -1, eps)
dydu2_minus = G_y(nominal_values, -2, eps)
dydu3_minus = G_y(nominal_values, -3, eps)

function printG_y()
    return DataFrame(Variable = variable_name,
                     Nominal = nominal_values,
                     ∂y∂u_1_plus = dydu1_plus,
                     ∂y∂u_1_minus = dydu1_minus,
                     ∂y∂u_2_plus = dydu2_plus,
                     ∂y∂u_2_minus = dydu2_minus,
                     ∂y∂u_3_plus = dydu3_plus,
                     ∂y∂u_3_minus = dydu3_minus)
end

G_y_table = printG_y()
println("G_y"); show(G_y_table, allrows=true);