function prePR_model(model, par)
  # Variables
  # CH4, H2O, H2, CO, CO2
  @variable(model, 0 <= prePR_in_mol[1:10]);
  @variable(model, 0 <= prePR_out_mol[1:10]);

  # CH4 H2O H2 CO CO2 C2 C3 i-C4 n-C4 C5
  ini_prePR_in = [113.76022309722791, 358.5177276354675, 0.0, 0.0, 1.9483473792214394, 8.869342547202073, 9.741736896107197, 3.605896642141171, 2.0501267199270368, 5.379765151581587];   # Stream 3 
  ini_prePR_out = [113.76022309722791, 358.5177276354675, 0.0, 0.0, 1.9483473792214394, 8.869342547202073, 9.741736896107197, 3.605896642141171, 2.0501267199270368, 5.379765151581587]; # Stream 4

  for i=1:10
      set_start_value(prePR_in_mol[i] , ini_prePR_in[i])
      set_start_value(prePR_out_mol[i] , ini_prePR_out[i])
  end

  @variable(model, 273 <= prePR_in_T, start = 381.41);
  @variable(model, 273 <= prePR_out_T, start = 693.00);
  @variable(model, 0 <= prePR_Q, start = 6890.45);

  # Expressions
  prePR_H_out = build_enthalpy(model, prePR_out_T, par)
  prePR_H_in = build_enthalpy(model, prePR_in_T, par)

  # Constraints
  # Mass balance
  @NLconstraint(model, prePR_out_mol[1] - prePR_in_mol[1] == 0)
  @NLconstraint(model, prePR_out_mol[2] - prePR_in_mol[2] == 0)
  @NLconstraint(model, prePR_out_mol[3] - prePR_in_mol[3] == 0)
  @NLconstraint(model, prePR_out_mol[4] - prePR_in_mol[4] == 0)
  @NLconstraint(model, prePR_out_mol[5] - prePR_in_mol[5] == 0)
  @NLconstraint(model, prePR_out_mol[6] - prePR_in_mol[6] == 0)
  @NLconstraint(model, prePR_out_mol[7] - prePR_in_mol[7] == 0)
  @NLconstraint(model, prePR_out_mol[8] - prePR_in_mol[8] == 0)
  @NLconstraint(model, prePR_out_mol[9] - prePR_in_mol[9] == 0)
  @NLconstraint(model, prePR_out_mol[10] - prePR_in_mol[10] == 0) 
  
  # Energy balance
  @NLconstraint(model, sum(prePR_H_out[i]*prePR_out_mol[i] - prePR_H_in[i]*prePR_in_mol[i] for i=1:10) - prePR_Q==0);

  # Energy balance  - equipment specification
  #@NLconstraint(model, prePR_out_T - par.prePR.out_T == 0);

  return model;
end