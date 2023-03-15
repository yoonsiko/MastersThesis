function ATR_model(model, par)
  # Variables
  # CH4, H2O, H2, CO, CO2
  @variable(model, 0 <= atr_in_mol[1:5]); # Stream 7
  @variable(model, 0 <= atr_out_mol[1:5]); # Stream 8

  ini_atr_in = [22.543406840790453, 122.15875765109533, 544.9262854431126, 139.04829250631568, 50.60368611824971];  # CH4 H2O H2 CO CO2
  ini_atr_out = [0.00032515179570229987, 217.23336631977338, 494.9378401524241, 184.6822048577565, 27.51285545580364];

  for i=1:5
      set_start_value(atr_in_mol[i] , ini_atr_in[i])
      set_start_value(atr_out_mol[i] , ini_atr_out[i])
  end

  @variable(model, 912.18 <= atr_in_T <= 1012.18, start = 962.18);
  @variable(model, 1273 <= atr_out_T <= 1373, start = 1323);
  @variable(model, 0 <= nO2 <= 100, start = 47.26342984761337);
  
  # Expressions
  atr_K_smr_model = K_smr(model, atr_out_T, par);
  atr_K_wgsr_model = K_wgsr(model, atr_out_T, par);

  atr_ksi_smr = @NLexpression(model, atr_in_mol[1] - atr_out_mol[1]);
  atr_ksi_wgsr = @NLexpression(model, atr_out_mol[5] - atr_in_mol[5]);

  atr_ntot = @NLexpression(model, sum(atr_out_mol[i] for i=1:5));

  atr_H_out = build_enthalpy(model, atr_out_T, par);
  atr_H_in = build_enthalpy(model, atr_in_T, par);


  # Constraints
  # Mass balance
  @NLconstraint(model, atr_K_smr_model*((atr_out_mol[1]/atr_ntot) * (atr_out_mol[2]/atr_ntot )) - (((atr_out_mol[4]/atr_ntot) * (atr_out_mol[3]/atr_ntot)^3)) == 0);
  @NLconstraint(model, atr_K_wgsr_model*((atr_out_mol[4]/atr_ntot) * (atr_out_mol[2]/atr_ntot)) - (((atr_out_mol[5]/atr_ntot) * (atr_out_mol[3]/atr_ntot))) == 0);
  @NLconstraint(model, atr_out_mol[2] - atr_in_mol[2] + atr_ksi_smr + atr_ksi_wgsr - 2*nO2 == 0);
  @NLconstraint(model, atr_out_mol[3] - atr_in_mol[3] - 3 * atr_ksi_smr - atr_ksi_wgsr + 2*nO2 == 0);
  @NLconstraint(model, atr_out_mol[4] - atr_in_mol[4] - atr_ksi_smr + atr_ksi_wgsr == 0);

  # Energy balance
  @NLconstraint(model, sum(atr_H_out[i]*atr_out_mol[i] - atr_H_in[i]*atr_in_mol[i] for i=1:5) - nO2*par.atr.nO2_H == 0);

  # Energy balance - equipment specification
  #@NLconstraint(model, atr_out_T - par.atr.out_T == 0);
  return model;
end