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

# Options for finite diff (eps = 1e-5)
# 1: u1+h, n_O2
# 2: u2+h, T_prePR
# 3: u3+h, T_ATR
# 4: d1+k, NG flow
# 5: d2+k, P_el
# 6: d3+k, P_H2
# -1: u1-h, n_O2
# -2: u2-h, T_prePR
# -3: u3-h, T_ATR
# -4: d1-k, NG flow
# -5: d2-k, P_el
# -6: d3-k, P_H2

eps = 1e-5

function finite_diff_1(option, eps)
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
    h = 0;
    k = 0;
    d1 = par.init.init_stream;
    d2 = par.elCost;
    d3 = par.P_H2;
    if option == 1 # u1 + h
        h = eps*79.29706225438805; 
        @NLconstraint(m, m[:nO2]-79.29706225438805+eps== 0);
        @NLconstraint(m, m[:pr_in_T]-644.5953165006283== 0);
        @NLconstraint(m, m[:atr_out_T]-1291.817465833818 == 0);
    elseif option == 2 # u2 + h 
        h = eps*644.5953165006283;
        @NLconstraint(m, m[:nO2]-79.29706225438805 == 0);
        @NLconstraint(m, m[:pr_in_T]-644.5953165006283+eps== 0);
        @NLconstraint(m, m[:atr_out_T]-1291.817465833818 == 0);
    elseif option == 3 # u3 + h
        h = eps*1291.817465833818; 
        @NLconstraint(m, m[:nO2]-79.29706225438805 == 0);
        @NLconstraint(m, m[:pr_in_T]-644.5953165006283== 0);
        @NLconstraint(m, m[:atr_out_T]-1291.817465833818+eps== 0);
    elseif option == 4 # d1 + h
        k = eps*par.init.init_stream;
        d1 = par.init.init_stream+eps;
        @NLconstraint(m, m[:nO2]-79.29706225438805 == 0);
        @NLconstraint(m, m[:pr_in_T]-644.5953165006283== 0);
        @NLconstraint(m, m[:atr_out_T]-1291.817465833818 == 0);
    elseif option == 5 # d2 + h
        k = eps*par.elCost;
        d2 = par.elCost+eps;
        @NLconstraint(m, m[:nO2]-79.29706225438805 == 0);
        @NLconstraint(m, m[:pr_in_T]-644.5953165006283== 0);
        @NLconstraint(m, m[:atr_out_T]-1291.817465833818 == 0);
    elseif option == 6 # d3 + h
        k = eps*par.P_H2;
        d3 = par.P_H2+eps;
        @NLconstraint(m, m[:nO2]-79.29706225438805 == 0);
        @NLconstraint(m, m[:pr_in_T]-644.5953165006283== 0);
        @NLconstraint(m, m[:atr_out_T]-1291.817465833818 == 0);
    elseif option == -1 # u1 - h
        h = eps*79.29706225438805;
        @NLconstraint(m, m[:nO2]-79.29706225438805-eps== 0);
        @NLconstraint(m, m[:pr_in_T]-644.5953165006283== 0);
        @NLconstraint(m, m[:atr_out_T]-1291.817465833818 == 0);
    elseif option == -2 # u2 - h
        h = eps*644.5953165006283;
        @NLconstraint(m, m[:nO2]-79.29706225438805 == 0);
        @NLconstraint(m, m[:pr_in_T]-644.5953165006283-eps== 0);
        @NLconstraint(m, m[:atr_out_T]-1291.817465833818 == 0);
    elseif option == -3 # u3 - h
        h = eps*1291.817465833818;
        @NLconstraint(m, m[:nO2]-79.29706225438805 == 0);
        @NLconstraint(m, m[:pr_in_T]-644.5953165006283== 0);
        @NLconstraint(m, m[:atr_out_T]-1291.817465833818-eps== 0);
    elseif option == -4 # d1 - h
        k = eps*par.init.init_stream;
        d1 = par.init.init_stream-eps;
        @NLconstraint(m, m[:nO2]-79.29706225438805 == 0);
        @NLconstraint(m, m[:pr_in_T]-644.5953165006283== 0);
        @NLconstraint(m, m[:atr_out_T]-1291.817465833818 == 0);
    elseif option == -5 # d2 - h
        k = eps*par.elCost;
        d2 = par.elCost-eps;
        @NLconstraint(m, m[:nO2]-79.29706225438805 == 0);
        @NLconstraint(m, m[:pr_in_T]-644.5953165006283== 0);
        @NLconstraint(m, m[:atr_out_T]-1291.817465833818 == 0);
    elseif option == -6 # d3 - h
        k = eps*par.P_H2;
        d3 = par.P_H2-eps;
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
    @NLconstraint(m, m[:F_NG] - d1 + m[:F_NG_heat] == 0);
    @NLconstraint(m, m[:F_fluegas] - m[:F_NG_heat] - 2*m[:F_NG_heat]/0.79 == 0);
    @NLconstraint(m, m[:F_inj] - m[:F_fluegas] - sum(value(m[:psa_outPurge_mol][i]) for i = 1:5) == 0);
    @NLconstraint(m, m[:prePR_Q] + m[:preGHR_Q] - m[:F_H2_heat]*par.HHV_H2*2.016 - sum(m[:F_NG_heat]*par.HHV_NG[i]*par.init.init_comp[i]*par.molarMass[i] for i = 1:10) == 0);

    compW1 = Wrev(m, m[:F_inj], 1, 10, m[:psa_outPurge_T], par);
    compW2 = Wrev(m, m[:F_inj],10,100,m[:psa_outPurge_T], par);
    compWsum = @NLexpression(m, compW1 + compW2);
    @NLobjective(m, Max, m[:F_H2]*d3 - compWsum*d2/1000);

    optimize!(m)
    if termination_status(m) == LOCALLY_SOLVED || termination_status(m) == OPTIMAL || termination_status(m) == ALMOST_LOCALLY_SOLVED
        return objective_value(m), h, k
    else
        return Inf, h, k  
    end
end

function finite_diff_2(option_x, option_y, eps;m=0.)
    par = _par();
    optimizer = optimizer_with_attributes(Ipopt.Optimizer,
             "tol" => 1e-10, "constr_viol_tol" => 1e-10
             ,"print_level" => 0)
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
    h = 0;
    k = 0;
    d1 = par.init.init_stream;
    d2 = par.elCost;
    d3 = par.P_H2;
    
    if option_x == 1 # u1 + h
        h = eps*79.29706225438805; 
        @NLconstraint(m, m[:nO2]-79.29706225438805+eps== 0);
    elseif option_x == 2 # u2 + h 
        h = eps*644.5953165006283;
        @NLconstraint(m, m[:pr_in_T]-644.5953165006283+eps== 0);
    elseif option_x == 3 # u3 + h
        h = eps*1291.817465833818; 
        @NLconstraint(m, m[:atr_out_T]-1291.817465833818+eps== 0);
    elseif option_x == 4 # d1 + k
        h = eps*par.init.init_stream;
        d1 = par.init.init_stream+eps;
    elseif option_x == 5 # d2 + k
        h = eps*par.elCost;
        d2 = par.elCost+eps;
    elseif option_x == 6 # d3 + k
        h = eps*par.P_H2;
        d3 = par.P_H2+eps;
    elseif option_x == -1 # u1 - h
        h = eps*79.29706225438805;
        @NLconstraint(m, m[:nO2]-79.29706225438805-eps== 0);
    elseif option_x == -2 # u2 - h
        h = eps*644.5953165006283;
        @NLconstraint(m, m[:pr_in_T]-644.5953165006283-eps== 0);
    elseif option_x == -3 # u3 - h
        h = eps*1291.817465833818;
        @NLconstraint(m, m[:atr_out_T]-1291.817465833818-eps== 0);
    elseif option_x == -4 # d1 - k
        h = eps*par.init.init_stream;
        d1 = par.init.init_stream-eps;
    elseif option_x == -5 # d2 - k
        h = eps*par.elCost;
        d2 = par.elCost-eps;
    elseif option_x == -6 # d3 - k
        h = eps*par.P_H2;
        d3 = par.P_H2-eps;
    else 
        print("Option not valid")
    end

    if option_y == 1 # u1 + h
        k = eps*79.29706225438805; 
        @NLconstraint(m, m[:nO2]-79.29706225438805+eps== 0);
    elseif option_y == 2 # u2 + h 
        k = eps*644.5953165006283;
        @NLconstraint(m, m[:pr_in_T]-644.5953165006283+eps== 0);
    elseif option_y == 3 # u3 + h
        k = eps*1291.817465833818; 
        @NLconstraint(m, m[:atr_out_T]-1291.817465833818+eps== 0);
    elseif option_y == 4 # d1 + k
        k = eps*par.init.init_stream;
        d1 = par.init.init_stream+eps;
    elseif option_y == 5 # d2 + k
        k = eps*par.elCost;
        d2 = par.elCost+eps;
    elseif option_y == 6 # d3 + k
        k = eps*par.P_H2;
        d3 = par.P_H2+eps;
    elseif option_y == -1 # u1 - h
        k = eps*79.29706225438805;
        @NLconstraint(m, m[:nO2]-79.29706225438805-eps== 0);
    elseif option_y == -2 # u2 - h
        k = eps*644.5953165006283;
        @NLconstraint(m, m[:pr_in_T]-644.5953165006283-eps== 0);
    elseif option_y == -3 # u3 - h
        k = eps*1291.817465833818;
        @NLconstraint(m, m[:atr_out_T]-1291.817465833818-eps== 0);
    elseif option_y == -4 # d1 - k
        k = eps*par.init.init_stream;
        d1 = par.init.init_stream-eps;
    elseif option_y == -5 # d2 - k
        k = eps*par.elCost;
        d2 = par.elCost-eps;
    elseif option_y == -6 # d3 - k
        k = eps*par.P_H2;
        d3 = par.P_H2-eps;
    else 
        print("Option not valid")
    end
    if abs(option_y) != 1 && abs(option_x) !=1
        @NLconstraint(m, m[:nO2]-79.29706225438805 == 0);
    end
    if abs(option_y) != 2 && abs(option_x) !=2
        @NLconstraint(m, m[:pr_in_T]-644.5953165006283== 0);
    end
    if abs(option_y) != 3 && abs(option_x) !=3
        @NLconstraint(m, m[:atr_out_T]-1291.817465833818 == 0);
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
    @NLconstraint(m, m[:F_NG] - d1 + m[:F_NG_heat] == 0);
    @NLconstraint(m, m[:F_fluegas] - m[:F_NG_heat] - 2*m[:F_NG_heat]/0.79 == 0);
    @NLconstraint(m, m[:F_inj] - m[:F_fluegas] - sum(value(m[:psa_outPurge_mol][i]) for i = 1:5) == 0);
    @NLconstraint(m, m[:prePR_Q] + m[:preGHR_Q] - m[:F_H2_heat]*par.HHV_H2*2.016 - sum(m[:F_NG_heat]*par.HHV_NG[i]*par.init.init_comp[i]*par.molarMass[i] for i = 1:10) == 0);

    compW1 = Wrev(m, m[:F_inj], 1, 10, m[:psa_outPurge_T], par);
    compW2 = Wrev(m, m[:F_inj],10,100,m[:psa_outPurge_T], par);
    compWsum = @NLexpression(m, compW1 + compW2);
    @NLobjective(m, Max, m[:F_H2]*d3 - compWsum*d2/1000);

    optimize!(m)
    
    if termination_status(m) == LOCALLY_SOLVED || termination_status(m) == OPTIMAL || termination_status(m) == ALMOST_LOCALLY_SOLVED
        return objective_value(m), h, k
    else
        return Inf, h, k       
    end
    #return f, h, k
end