function PSA_model(model, par)
  @variable(model, 0 <= psa_in_mol[1:5]); # Stream 12
  @variable(model, 0 <= psa_outPurge_mol[1:5]); # Stream 15 (Purge)
  @variable(model, 0 <= psa_outProduct_mol[1:5]); # Stream 14 (H2)

  ini_psa_in = [0.00032515179570229987, 0.05589429423256371, 656.2769122396338, 23.343132770546816, 188.85192754301332];  # CH4 H2O H2 CO CO2
  ini_psa_outPurge = [0.0003219002777452769, 0.05533535129023807, 0.6562769122396344, 23.10970144284135, 186.9634082675832];
  ini_psa_outProduct = [3.2515179570229986e-06, 0.0005589429423256371, 655.6206353273942, 0.23343132770546818, 1.8885192754301332];

  for i=1:5
    set_start_value(psa_in_mol[i] , ini_psa_in[i]);
    set_start_value(psa_outPurge_mol[i], ini_psa_outPurge[i]);
    set_start_value(psa_outProduct_mol[i], ini_psa_outProduct[i]);
  end

  @variable(model, 273 <= psa_in_T, start = 313.00);
  @variable(model, 273 <= psa_outPurge_T, start = 313.00);
  @variable(model, 273 <= psa_outProduct_T, start = 313.00)
  
  # Constraints
  # Mass balance
  for i = 1:5
    @NLconstraint(model, par.psa.splitratio[i]*psa_in_mol[i] - psa_outProduct_mol[i] == 0);
    @NLconstraint(model, (1-par.psa.splitratio[i])*psa_in_mol[i] - psa_outPurge_mol[i] == 0);
  end

  @NLconstraint(model, psa_outPurge_T - psa_in_T == 0);
  @NLconstraint(model, psa_outProduct_T - psa_in_T == 0);
  return model;
end