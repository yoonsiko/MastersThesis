function preCond_model(model, par)
  # Variables
  # CH4, H2O, H2, CO, CO2
  @variable(model, 0 <= preCond_in_mol[1:5]); # Stream 10
  @variable(model, 0 <= preCond_out_mol[1:5]); # Stream 11

  ini_preCond_in = [0.00032515179570229987, 55.89429423256371, 656.2769122396338, 23.343132770546816, 188.85192754301332];  # CH4 H2O H2 CO CO2
  ini_preCond_out = [0.00032515179570229987, 55.89429423256371, 656.2769122396338, 23.343132770546816, 188.85192754301332];

  for i=1:5
    set_start_value(preCond_in_mol[i] , ini_preCond_in[i]);
    set_start_value(preCond_out_mol[i] , ini_preCond_out[i]);
  end

  @variable(model, 273 <= preCond_in_T, start = 523.00);
  @variable(model, 293 <= preCond_out_T <= 333, start = 313.00);

  preCond_H_out = build_enthalpy(model, preCond_out_T, par)
  preCond_H_in = build_enthalpy(model, preCond_in_T, par)
  @variable(model, 0 >= preCond_Q, start = -6345000);

  # Constraints
  # Mass balance
  @NLconstraint(model, preCond_out_mol[1] - preCond_in_mol[1] == 0)
  @NLconstraint(model, preCond_out_mol[2] - preCond_in_mol[2] == 0)
  @NLconstraint(model, preCond_out_mol[3] - preCond_in_mol[3] == 0)
  @NLconstraint(model, preCond_out_mol[4] - preCond_in_mol[4] == 0)
  @NLconstraint(model, preCond_out_mol[5] - preCond_in_mol[5] == 0)

  # Energy balance
  @NLconstraint(model, sum(preCond_H_out[i]*preCond_out_mol[i] - preCond_H_in[i]*preCond_in_mol[i] for i=1:5) - preCond_Q==0);

  # Energy balance - equipment specification
  #@NLconstraint(model, preCond_out_T - par.preCond.out_T == 0);

  return model;
end