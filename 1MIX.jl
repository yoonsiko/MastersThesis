function MIX_model(model, par)
  # Variables
  # CH4, H2O, H2, CO, CO2
  @variable(model, 0 <= mix_in_mol[1:10]); # Stream 1
  @variable(model, 0 <= H2Ostream, start = 358.5177276354675); # Stream 2
  @variable(model, 0 <= mix_out_mol[1:10]); # Stream 3
   # CH4 H2O H2 CO CO2 C2 C3 i-C4 n-C4 C5
  ini_mix_in = [113.76022309722791, 0.0, 0.0, 0.0, 1.9483473792214394, 8.869342547202073, 9.741736896107197, 3.605896642141171, 2.0501267199270368, 5.379765151581587];
  ini_mix_out = [113.76022309722791, 358.5177276354675, 0.0, 0.0, 1.9483473792214394, 8.869342547202073, 9.741736896107197, 3.605896642141171, 2.0501267199270368, 5.379765151581587];

  for i=1:10
      set_start_value(mix_in_mol[i] , ini_mix_in[i]);
      set_start_value(mix_out_mol[i] , ini_mix_out[i]);
  end
  
  @variable(model, 273 <= mix_in_T, start = 311);
  @variable(model, 273 <= mix_out_T, start = 381.41);
  @variable(model, 273 <= H2O_T, start = 423.00);

  # Expressions
  mix_H_out = build_enthalpy(model, mix_out_T, par)
  mix_H_in = build_enthalpy(model, mix_in_T, par)
  mix_H_inH2O = build_enthalpy(model, H2O_T, par)
  mix_n_Carbon = @NLexpression(model, sum(mix_out_mol[i] for i=6:10)+mix_out_mol[1])

  # Mass balance
  @NLconstraint(model, H2Ostream - par.mix.carbon_ratio*mix_n_Carbon == 0);
  @NLconstraint(model, mix_out_mol[1] - mix_in_mol[1] == 0)
  @NLconstraint(model, mix_out_mol[2] - mix_in_mol[2] - H2Ostream == 0)
  @NLconstraint(model, mix_out_mol[3] - mix_in_mol[3] == 0)
  @NLconstraint(model, mix_out_mol[4] - mix_in_mol[4] == 0)
  @NLconstraint(model, mix_out_mol[5] - mix_in_mol[5] == 0)
  @NLconstraint(model, mix_out_mol[6] - mix_in_mol[6] == 0)
  @NLconstraint(model, mix_out_mol[7] - mix_in_mol[7] == 0)
  @NLconstraint(model, mix_out_mol[8] - mix_in_mol[8] == 0)
  @NLconstraint(model, mix_out_mol[9] - mix_in_mol[9] == 0)
  @NLconstraint(model, mix_out_mol[10] - mix_in_mol[10] == 0)

  # Energy balance
  @NLconstraint(model, sum(mix_H_out[i]*mix_out_mol[i] - mix_H_in[i]*mix_in_mol[i] for i=1:10) - mix_H_inH2O[2]*H2Ostream == 0);
end