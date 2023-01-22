function postATR_model(model, par)
   # Variables
  # CH4, H2O, H2, CO, CO2
  @variable(model, 0 <= postATR_in_mol[1:5]); # Stream 8
  @variable(model, 0 <= postATR_out_mol[1:5]); # Stream 9

  ini_postATR_in = [0.00032515179570229987, 217.23336631977338, 494.9378401524241, 184.6822048577565, 27.51285545580364];  # CH4 H2O H2 CO CO2
  ini_postATR_out = [0.00032515179570229987, 217.23336631977338, 494.9378401524241, 184.6822048577565, 27.51285545580364];

  for i=1:5
      set_start_value(postATR_in_mol[i] , ini_postATR_in[i])
      set_start_value(postATR_out_mol[i] , ini_postATR_out[i])
  end

  @variable(model, 273 <= postATR_in_T, start = 1323.00);
  @variable(model, 273 <= postATR_out_T, start = 600.00);

  @variable(model, 0 >= postATR_Q, start = -34472000)

  # Expressions
  postATR_H_out = build_enthalpy(model, postATR_out_T, par)
  postATR_H_in = build_enthalpy(model, postATR_in_T, par)

  # Constraints
  # Mass balance
  @NLconstraint(model, postATR_out_mol[1] - postATR_in_mol[1] == 0)
  @NLconstraint(model, postATR_out_mol[2] - postATR_in_mol[2] == 0)
  @NLconstraint(model, postATR_out_mol[3] - postATR_in_mol[3] == 0)
  @NLconstraint(model, postATR_out_mol[4] - postATR_in_mol[4] == 0)
  @NLconstraint(model, postATR_out_mol[5] - postATR_in_mol[5] == 0)

  # Energy balance
  @NLconstraint(model, sum(postATR_H_out[i]*postATR_out_mol[i] - postATR_H_in[i]*postATR_in_mol[i] for i=1:5) - postATR_Q==0)
  return model;
end