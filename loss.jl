include("nominal_case.jl")
include("test.jl")
using LinearAlgebra
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
y_nom, J_nom = nominal();
function Loss()
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

    # Disturb your disturbances here
    eps = 0.1
    d1 = par.init.init_stream;
    d2 = par.elCost;
    d3 = par.P_H2;
    #d1 = par.init.init_stream*(1+eps); # +d1
    #d2 = par.elCost*(1+eps); # +d2
    #d3 = par.P_H2*(1+eps); # +d3
    #d1 = par.init.init_stream*(1-eps); # -d1
    #d2 = par.elCost*(1-eps); # -d2
    #d3 = par.P_H2*(1-eps); # -d3

    # Choose your H matrix
    # H1 # 53, 148, 157
    #@NLconstraint(m, m[:pr_out_mol][3] - y_nom[53] == 0);
    #@NLconstraint(m, m[:psa_outPurge_mol][1] - y_nom[148] == 0);
    #@NLconstraint(m, m[:prePR_out_T] - y_nom[157] == 0);
    
    # H2 # 63, 148, 157
    #@NLconstraint(m, m[:preGHR_out_mol][3] - y_nom[68] == 0);
    #@NLconstraint(m, m[:psa_outPurge_mol][1] - y_nom[148] == 0);
    #@NLconstraint(m, m[:prePR_out_T] - y_nom[157] == 0);

    # H3 
    # @NLconstraint
    # @NLconstraint
    # @NLconstraint

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
    T2 = compT(m, m[:psa_outPurge_T],1,10);
    compW2 = Wrev(m, m[:F_inj],10,100,m[:psa_outPurge_T], par);
    compWsum = @NLexpression(m, compW1 + compW2);
    @NLobjective(m, Max, m[:F_H2]*d3 - compWsum*d2/1000);

    # Constraints for setting the active constraints to their boundary value
    @NLconstraint(m, m[:SC_ratio] == 5.0);
    @NLconstraint(m, m[:pr_out_T] == 609.2);
    @NLconstraint(m, m[:itsr_out_T] == 473.0);
    @NLconstraint(m, m[:preCond_out_T] == 293.0);
    @NLconstraint(m, m[:postATR_out_T] == 643.2);
    #@NLconstraint(m, m[:nO2] == 79.29706225438805);
    #@NLconstraint(m, m[:pr_in_T] == 644.5953165006283);
    #@NLconstraint(m, m[:atr_out_T] == 1291.817465833818);

    # Optimize
    optimize!(m)

    # Calculate loss
    L = objective_value(m) - J_nom;
    println("The new objective value is: ", objective_value(m));
    println("While the nominal objective value is: ", J_nom);
    #streamdf, otherdf, massdf, compositiondf = printTable(m);
    #println("Stream table"); show(streamdf, allrows=true);
    #println("\n\nOther variables"); show(otherdf, allrows=true);
    #println("\n\nMass table"); show(massdf, allrows=true);
    #println("\n\nCompostion table"); show(compositiondf, allrows=true);
    #println("");
    return L
end

#@show(Loss())
function nullspacePrint(data)
    df = DataFrame(XLSX.readtable(data, "Sheet1"));
    A = Matrix(df);
    A = A[:, end-2:end];
    A = A[[53, 148, 157], :];
    F = convert(Matrix{Float64}, A);
    return nullspace(F, rtol = 1);
end
#@show(nullspacePrint("data/F.xlsx"));


[-0.010396358480702392 -0.9990843821558919 -0.041500759782440846;
 -0.9999454720656192 0.010428244690954458 -0.0005519131554076154;
  0.0009841878917459415 0.041492758944720855 -0.9991383199183929]