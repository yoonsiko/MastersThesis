function ITSR_model(model, par)
  # Variables
  # CH4, H2O, H2, CO, CO2 
  @variable(model, 0 <= itsr_in_mol[1:5]); # Stream 9
  @variable(model, 0 <= itsr_out_mol[1:5]); # Stream 10

  ini_itsr_in = [0.00032515179570229987, 217.23336631977338, 494.9378401524241, 184.6822048577565, 27.51285545580364];  # CH4 H2O H2 CO CO2
  ini_itsr_out = [0.00032515179570229987, 55.89429423256371, 656.2769122396338, 23.343132770546816, 188.85192754301332];

  for i=1:5
      set_start_value(itsr_in_mol[i] , ini_itsr_in[i])
      set_start_value(itsr_out_mol[i] , ini_itsr_out[i])
  end

  @variable(model, 550 <= itsr_in_T <= 650, start = 600.00);
  @variable(model, 473 <= itsr_out_T <= 573, start = 523.00);

  @variable(model, 0 >= itsr_Q, start = -5913000)

  # Expressions
  #itsr_Kwgsr_model = @NLexpression(model, exp(5693.5/itsr_out_T + 1.077*log(itsr_out_T) + 5.44e-4*itsr_out_T - 1.125e-7*itsr_out_T^2 - 49170/(itsr_out_T^2)-13.148))
  itsr_ksi_wgsr = @NLexpression(model, itsr_in_mol[2] - itsr_out_mol[2])
  
  itsr_K_wgsr_model = K_wgsr(model, itsr_out_T, par);

  itsr_ntot = @NLexpression(model, sum(itsr_out_mol[i] for i=1:5))

  itsr_H_out = build_enthalpy(model, itsr_out_T, par)
  itsr_H_in = build_enthalpy(model, itsr_in_T, par)

  # Constraints
  # Mass balance
  @NLconstraint(model, itsr_out_mol[1] - itsr_in_mol[1] == 0)
  @NLconstraint(model, itsr_K_wgsr_model*((itsr_out_mol[4]/itsr_ntot) * (itsr_out_mol[2]/itsr_ntot)) - (((itsr_out_mol[5]/itsr_ntot) * (itsr_out_mol[3]/itsr_ntot))) == 0)
  @NLconstraint(model, itsr_out_mol[3] - itsr_in_mol[3] - itsr_ksi_wgsr == 0)
  @NLconstraint(model, itsr_out_mol[4] - itsr_in_mol[4] + itsr_ksi_wgsr == 0)
  @NLconstraint(model, itsr_out_mol[5] - itsr_in_mol[5] - itsr_ksi_wgsr == 0)

  # Energy balance
  @NLconstraint(model, sum(itsr_H_out[i]*itsr_out_mol[i] - itsr_H_in[i]*itsr_in_mol[i] for i=1:5) - itsr_Q==0)

  # Energy balance - equipment specification
  #@NLconstraint(model, itsr_out_T - par.itsr.out_T == 0)
  return model;
end