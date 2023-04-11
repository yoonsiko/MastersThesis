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

# Options for finite_diff_1 (eps = 1e-5)
# 1: u1+h, n_O2
# 2: u2+h, T_prePR
# 3: u3+h, T_ATR
# 4: d1+h, NG flow
# 5: d2+h, P_el
# 6: d3+h, P_H2
# -1: u1-h, n_O2
# -2: u2-h, T_prePR
# -3: u3-h, T_ATR
# -4: d1-h, NG flow
# -5: d2-h, P_el
# -6: d3-h, P_H2

# Options for finite_diff_2 (eps = 1e-5)
# option_x (u)
# # 1: u1+h, n_O2
# 2: u2+h, T_prePR
# 3: u3+h, T_ATR
# -1: u1-h, n_O2
# -2: u2-h, T_prePR
# -3: u3-h, T_ATR
#
#option_y (d)
# 1: d1+k, NG_flow
# 2: d2+k, P_el
# 3: d3+k, P_H2
# -1: d1-k, NG_flow
# -2: d2-k, P_el
# -3: d3-k, P_H2

eps = 1e-5

function finite_diff_1(option, eps)
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
    delta_u = 0;
    delta_d = 0;
    if option == 1 # u1 + h
        delta_u = eps*79.29706225438805; 
        @NLconstraint(m, m[:nO2]-79.29706225438805*(1+eps) == 0);
    elseif option == 2 # u2 + h 
        delta_u = eps*644.5953165006283;
        @NLconstraint(m, m[:pr_in_T]-644.5953165006283*(1+eps) == 0);
    elseif option == 3 # u3 + h
        delta_u = eps*1291.817465833818; 
        @NLconstraint(m, m[:atr_out_T]-1291.817465833818*(1+eps) == 0);
    elseif option == 4 # d1 + h
        delta_d = eps*par.init.init_stream;
        par.init.init_stream = par.init.init_stream*(1+eps);
    elseif option == 5 # d2 + h
        delta_d = eps*par.elCost;
        par.elCost = par.elCost*(1+eps);
    elseif option == 6 # d3 + h
        delta_d = eps*par.P_H2;
        par.P_H2 = par.P_H2*(1+eps);
    elseif option == -1 # u1 - h
        delta_u = -eps*79.29706225438805;
        @NLconstraint(m, m[:nO2]-79.29706225438805*(1-eps) == 0);
    elseif option == -2 # u2 - h
        delta_u = -eps*644.5953165006283;
        @NLconstraint(m, m[:pr_in_T]-644.5953165006283*(1-eps) == 0);
    elseif option == -3 # u3 - h
        delta_u = -eps*1291.817465833818;
        @NLconstraint(m, m[:atr_out_T]-1291.817465833818*(1-eps) == 0);
    elseif option == -4 # d1 - h
        delta_d = -eps*par.init.init_stream;
        par.init.init_stream = par.init.init_stream*(1-eps);
    elseif option == -5 # d2 - h
        delta_d = -eps*par.elCost;
        par.elCost = par.elCost*(1-eps);
    elseif option == -6 # d3 - h
        delta_d = -eps*par.P_H2;
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
    compW2 = Wrev(m, m[:F_inj],10,100,m[:psa_outPurge_T], par);
    compWsum = @NLexpression(m, compW1 + compW2);
    @NLobjective(m, Max, m[:F_H2]*par.P_H2 - compWsum*par.elCost/1000);

    optimize!(m)
    f = objective_value(m)
    return f, delta_u, delta_d
end

function finite_diff_2(option_x, option_y, eps)
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
    delta_u = 0;
    delta_d = 0;
    if option_x == 1 # u1+h
        delta_u = eps*79.29706225438805; 
        @NLconstraint(m, m[:nO2]-79.29706225438805*(1+eps) == 0);
    elseif option_x == 2 # u2+h
        delta_u = eps*79.29706225438805; 
        @NLconstraint(m, m[:nO2]-79.29706225438805*(1+eps) == 0);
    elseif option_x == 3 # u3+h
        delta_u = eps*79.29706225438805; 
        @NLconstraint(m, m[:nO2]-79.29706225438805*(1+eps) == 0);
    elseif option_x == -1 # u1-h
        delta_u = -eps*79.29706225438805; 
        @NLconstraint(m, m[:nO2]-79.29706225438805*(1-eps) == 0);
    elseif option_x == -2 # u2-h
        delta_u = -eps*79.29706225438805; 
        @NLconstraint(m, m[:nO2]-79.29706225438805*(1-eps) == 0);
    elseif option_x == -3 # u3-h
        delta_u = -eps*79.29706225438805; 
        @NLconstraint(m, m[:nO2]-79.29706225438805*(1-eps) == 0);
    else 
        print("Option not valid")
    end    

    if option_y == 1 # d1+k
        delta_d = eps*par.init.init_stream;
        par.init.init_stream = par.init.init_stream*(1+eps);
    elseif option_y == 2 # d2+k
        delta_d = eps*par.elCost;
        par.elCost = par.elCost*(1+eps);
    elseif option_y == 3 # d3+k
        delta_d = eps*par.P_H2;
        par.P_H2 = par.P_H2*(1+eps);
    elseif option_y == -1 # d1-k
        delta_d = -eps*par.init.init_stream;
        par.init.init_stream = par.init.init_stream*(1-eps);
    elseif option_y == -2 # d2-k
        delta_d = -eps*par.elCost;
        par.elCost = par.elCost*(1-eps);
    elseif option_y == -3 # d3-k
        delta_d = -eps*par.P_H2;
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
    compW2 = Wrev(m, m[:F_inj],10,100,m[:psa_outPurge_T], par);
    compWsum = @NLexpression(m, compW1 + compW2);
    @NLobjective(m, Max, m[:F_H2]*par.P_H2 - compWsum*par.elCost/1000);

    optimize!(m)
    f = objective_value(m)
    return f, delta_u, delta_d
end