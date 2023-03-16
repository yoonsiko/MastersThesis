using JuMP, Ipopt, MathOptInterface, DataFrames, PrettyTables


function Cond_model(model, par)
  @variable(model, 0 <= cond_in_mol[1:5]); # Stream 11
  #@variable(model, 0 <= cond_outPurge_mol[1:5]); # Stream 13 (H2O stream)
  #@variable(model, 0 <= cond_outProduct_mol[1:5]); # Stream 12 (PSA)
  @variable(model, 0 <= cond_liq_frac[1:5]);  # Outlet liquid phase fractions
  @variable(model, 0 <= cond_vap_frac[1:5]);
  @variable(model, 0 <= cond_L, start = 141);
  @variable(model, 0 <= cond_V, start = 923);

  ini_cond_in = [0.00032515179570229987, 55.89429423256371, 656.2769122396338, 23.343132770546816, 188.85192754301332];  # CH4 H2O H2 CO CO2
  ini_cond_liq_frac = [0.01,0.999,0.01,0.01,0.01];
  ini_cond_vap_frac = [0.99,0.001,0.99,0.99,0.99];

  for i=1:5
    set_start_value(cond_in_mol[i] , ini_cond_in[i]);
    set_start_value(cond_liq_frac[i], ini_cond_liq_frac[i]);
    set_start_value(cond_vap_frac[i], ini_cond_vap_frac[i]);
  end

  @variable(model, 273 <= cond_in_T, start = 313.00);
  @variable(model, 273 <= cond_L_T, start = 313.00);
  @variable(model, 273 <= cond_V_T, start = 313.00);

  psat_H2O = @NLexpression(model, (10^(par.cond.ant_par[1] - par.cond.ant_par[2]/(cond_in_T + par.cond.ant_par[3])))/par.cond.cond_P);
  cond_K = @expression(model, [1e6, psat_H2O, 1e6, 1e6, 1e6]);
  cond_F = @expression(model, sum(cond_in_mol[i] for i = 1:5));
  cond_z = @NLexpression(model, [i=1:5], cond_in_mol[i]/cond_F);

  # Constraints
  # Flash equations and Raoults law
  for i=1:5
    @NLconstraint(model, cond_z[i] - cond_liq_frac[i]*(1+(cond_V/cond_F*(cond_K[i]-1))) == 0);
    @NLconstraint(model, cond_vap_frac[i] - cond_K[i]*cond_liq_frac[i] == 0);
  end

  # Rachford-Rice equation
  @NLconstraint(model, sum(cond_z[i]*(cond_K[i]-1)/(1+(cond_V/cond_F*(cond_K[i]-1)))  for i = 1:5) == 0); # insert sum rice equation here
  
  # Total mass balance
  @NLconstraint(model, cond_L + cond_V - cond_F == 0);

  # Energy balance - Equipment specification
  @NLconstraint(model, cond_V_T - cond_in_T == 0);
  @NLconstraint(model, cond_L_T - cond_in_T == 0);

  return model;
end