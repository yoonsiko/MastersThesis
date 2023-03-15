function PR_model(model, par)
  # Variables
  # CH4, H2O, H2, CO, CO2
  @variable(model, 0 <= pr_in_mol[1:10]); # Stream 4
  @variable(model, 0 <= pr_out_mol[1:10]); # Stream 5

  ini_pr_in = [113.76022309722791, 358.5177276354675, 0.0, 0.0, 1.9483473792214394, 8.869342547202073, 9.741736896107197, 3.605896642141171, 2.0501267199270368, 5.379765151581587];  # CH4 H2O H2 CO CO2 C2 C3 i-C4 n-C4 C5
  ini_pr_out = [178.58124131020057, 295.5198912988238, 59.489482856563995, 0.33375721522392365, 33.28038693993136, 0, 0, 0, 0, 0];

  for i=1:10
    set_start_value(pr_in_mol[i] , ini_pr_in[i]);
    set_start_value(pr_out_mol[i] , ini_pr_out[i]);
  end

  @variable(model, 643 <= pr_in_T <= 743, start = 693.00);
  @variable(model, 609.2 <= pr_out_T <= 709.2, start = 659.2);
  
  # Expressions
  pr_ksi1 = @NLexpression(model, pr_in_mol[6]); # C2H6
  pr_ksi2 = @NLexpression(model, pr_in_mol[7]); # C3H8
  pr_ksi3 = @NLexpression(model, pr_in_mol[8]); # n-C4H10
  pr_ksi4 = @NLexpression(model, pr_in_mol[9]); # i-C4H10
  pr_ksi5 = @NLexpression(model, pr_in_mol[10]); # C5+
  pr_ksi6 = @NLexpression(model, pr_in_mol[1] - pr_out_mol[1]);
  pr_ksi7 = @NLexpression(model, pr_out_mol[5] - pr_in_mol[5]);

  #pr_Ksmr_model = @NLexpression(model, exp(-22790 / pr_out_T + 8.156 * log(pr_out_T) - 4.421 / 10^3 * pr_out_T

  #- 4.330 * 10^3 / (pr_out_T^2) - 26.030));

  #pr_Kwgsr_model = @NLexpression(model, exp(5693.5/pr_out_T + 1.077*log(pr_out_T) + 5.44e-4*pr_out_T - 1.125e-7*pr_out_T^2 - 49170/(pr_out_T^2)-13.148));
  pr_K_smr_model = K_smr(model, pr_out_T, par);
  pr_K_wgsr_model = K_wgsr(model, pr_out_T, par);

  pr_ntot = @NLexpression(model, sum(pr_out_mol[i] for i=1:10));

  pr_H_out = build_enthalpy(model, pr_out_T, par);
  pr_H_in = build_enthalpy(model, pr_in_T, par);

  # Constraints
  # Mass balance
  @NLconstraint(model, pr_out_mol[2] - pr_in_mol[2] + 2 * pr_ksi1 + 3 * pr_ksi2 + 4 * pr_ksi3 + 4 * pr_ksi4 + 5 * pr_ksi5 + pr_ksi6 + pr_ksi7 == 0);
  @NLconstraint(model, pr_out_mol[3] - pr_in_mol[3] - 5 * pr_ksi1 - 7 * pr_ksi2 - 9 * pr_ksi3 - 9 * pr_ksi4 - 11 * pr_ksi5 - 3 * pr_ksi6 - pr_ksi7 == 0);
  @NLconstraint(model, pr_out_mol[4] - pr_in_mol[4] - 2 * pr_ksi1 - 3 * pr_ksi2 - 4 * pr_ksi3 - 4 * pr_ksi4 - 5 * pr_ksi5 - pr_ksi6 + pr_ksi7 == 0);
  @NLconstraint(model, pr_K_smr_model*((pr_out_mol[1]/pr_ntot) * (pr_out_mol[2]/pr_ntot )) - (((pr_out_mol[4]/pr_ntot) * (pr_out_mol[3]/pr_ntot)^3)) == 0);
  @NLconstraint(model, pr_K_wgsr_model*((pr_out_mol[4]/pr_ntot) * (pr_out_mol[2]/pr_ntot)) - (((pr_out_mol[5]/pr_ntot) * (pr_out_mol[3]/pr_ntot))) == 0);
  @NLconstraint(model, pr_out_mol[6] - pr_in_mol[6] + pr_ksi1 == 0)
  @NLconstraint(model, pr_out_mol[7] - pr_in_mol[7] + pr_ksi2 == 0)
  @NLconstraint(model, pr_out_mol[8] - pr_in_mol[8] + pr_ksi3 == 0)
  @NLconstraint(model, pr_out_mol[9] - pr_in_mol[9] + pr_ksi4 == 0)
  @NLconstraint(model, pr_out_mol[10] - pr_in_mol[10] + pr_ksi5 == 0)

  # Add NLconstraint for the last 5 carbons as 0

  # Energy balance
  @NLconstraint(model, sum(pr_H_out[i]*pr_out_mol[i] - pr_H_in[i]*pr_in_mol[i] for i=1:10) ==0);
  return model;
end