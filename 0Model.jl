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
    P_H2::Float64 = 3.347;
    P_inj::Float64 = 9.65;

end

################# Initializing the model ################
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
#all_variables(m)

#### Introducing new variables for the economic objective function #######
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
@NLconstraint(m, m[:prePR_Q] + m[:preGHR_Q] - m[:F_H2_heat]*par.HHV_H2 - sum(m[:F_NG_heat]*par.HHV_NG[i]*par.init.init_comp[i]*par.molarMass[i] for i = 1:10) == 0);

@NLobjective(m, Max, 2.016*m[:F_H2]*par.P_H2 - 44*m[:F_inj]/1000*par.P_inj);
#@NLobjective(m, Max, m[:psa_outProduct_mol][3])
optimize!(m)
#@show m

##################### Printing output ################################
streamdf, otherdf, massdf, compositiondf = printTable(m);
println("Stream table"); show(streamdf, allrows=true);
println("\n\nOther variables"); show(otherdf, allrows=true);
println("\n\nMass table"); show(massdf, allrows=true);
println("\n\nCompostion table"); show(compositiondf, allrows=true);


######################### For calculating Hydrogen efficiency ###########################
H2_in = 4 * value(m[:pr_out_mol][1]) + 2*value(m[:pr_out_mol][2]) + 2*value(m[:pr_out_mol][3])
H2_eff = 2*value(m[:psa_outProduct_mol][3])/H2_in