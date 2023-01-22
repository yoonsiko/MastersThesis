function preGHR_model(model, par)
  # Variables
  # CH4, H2O, H2, CO, CO2
  @variable(model, 0 <= preGHR_in_mol[1:5]); # Stream 5
  @variable(model, 0 <= preGHR_out_mol[1:5]); # Stream 6

  ini_preGHR_in = [178.58124131020057, 295.5198912988238, 59.489482856563995, 0.33375721522392365, 33.28038693993136];  # CH4 H2O H2 CO CO2
  ini_preGHR_out = [178.58124131020057, 295.5198912988238, 59.489482856563995, 0.33375721522392365, 33.28038693993136];

  for i=1:5
    set_start_value(preGHR_in_mol[i] , ini_preGHR_in[i]);
    set_start_value(preGHR_out_mol[i] , ini_preGHR_out[i]);
  end

  @variable(model, 273 <= preGHR_in_T, start = 630.5201);
  @variable(model, 273 <= preGHR_out_T, start = 753.00);

  preGHR_H_out = build_enthalpy(model, preGHR_out_T, par)
  preGHR_H_in = build_enthalpy(model, preGHR_in_T, par)
  @variable(model, 0 <= preGHR_Q, start = 8918.36225526873);

  # Constraints
  # Mass balance
  @NLconstraint(model, preGHR_out_mol[1] - preGHR_in_mol[1] == 0)
  @NLconstraint(model, preGHR_out_mol[2] - preGHR_in_mol[2] == 0)
  @NLconstraint(model, preGHR_out_mol[3] - preGHR_in_mol[3] == 0)
  @NLconstraint(model, preGHR_out_mol[4] - preGHR_in_mol[4] == 0)
  @NLconstraint(model, preGHR_out_mol[5] - preGHR_in_mol[5] == 0)

  # Energy balance
  @NLconstraint(model, sum(preGHR_H_out[i]*preGHR_out_mol[i] - preGHR_H_in[i]*preGHR_in_mol[i] for i=1:5) - preGHR_Q==0);

  # Energy balance - equipment specification
  @NLconstraint(model, preGHR_out_T - par.preGHR.out_T == 0);

  return model;
end