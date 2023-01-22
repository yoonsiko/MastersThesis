function GHR_model(model, par)
  # Variables
  # CH4, H2O, H2, CO, CO2
  @variable(model, 0 <= ghr_in_mol[1:5]); # Stream 6
  @variable(model, 0 <= ghr_out_mol[1:5]); # Stream 7

  # CH4 H2O H2 CO CO2
  ini_ghr_in = [178.58124131020057, 295.5198912988238, 59.489482856563995, 0.33375721522392365, 33.28038693993136];
  ini_ghr_out = [100.543406840790453, 122.15875765109533, 544.9262854431126, 139.04829250631568, 50.60368611824971];

  for i=1:5
      set_start_value(ghr_in_mol[i] , ini_ghr_in[i]);
      set_start_value(ghr_out_mol[i] , ini_ghr_out[i]);
  end

  @variable(model, 273 <= ghr_in_T, start = 753);
  @variable(model, 923 <= ghr_out_T <= 1023, start = 973);

  @variable(model, 0 <= ghr_Q, start = 34472000);

  ghr_K_smr_model = K_smr(model, ghr_out_T, par);
  ghr_K_wgsr_model = K_wgsr(model, ghr_out_T, par);

  ghr_ksi_smr = @NLexpression(model, ghr_in_mol[1] - ghr_out_mol[1]);

  ghr_ksi_wgsr = @NLexpression(model, ghr_out_mol[5] - ghr_in_mol[5]);

  ghr_ntot = @NLexpression(model, sum(ghr_out_mol[i] for i=1:5));

  ghr_H_out = build_enthalpy(model, ghr_out_T, par);
  ghr_H_in = build_enthalpy(model, ghr_in_T, par);

  # Constraints
  # Mass balance
  @NLconstraint(model, ghr_K_smr_model*((ghr_out_mol[1]/ghr_ntot) * (ghr_out_mol[2]/ghr_ntot )) -
   (((ghr_out_mol[4]/ghr_ntot) * (ghr_out_mol[3]/ghr_ntot)^3)) == 0);
  @NLconstraint(model, ghr_K_wgsr_model*((ghr_out_mol[4]/ghr_ntot) * (ghr_out_mol[2]/ghr_ntot)) -
   (((ghr_out_mol[5]/ghr_ntot) * (ghr_out_mol[3]/ghr_ntot))) == 0);
  @NLconstraint(model, ghr_out_mol[2] - ghr_in_mol[2] + ghr_ksi_smr + ghr_ksi_wgsr == 0);
  @NLconstraint(model, ghr_out_mol[3] - ghr_in_mol[3] - 3 * ghr_ksi_smr - ghr_ksi_wgsr == 0);
  @NLconstraint(model, ghr_out_mol[4] - ghr_in_mol[4] - ghr_ksi_smr + ghr_ksi_wgsr == 0);

  # Energy balance
  @NLconstraint(model, sum(ghr_H_out[i]*ghr_out_mol[i] - ghr_H_in[i]*ghr_in_mol[i] for i=1:5) - ghr_Q==0);

  # Energy balance - equipment specification
  #@NLconstraint(model, ghr_out_T - par.ghr.out_T == 0);
  return model;
end