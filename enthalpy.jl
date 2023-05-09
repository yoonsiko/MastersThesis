# Order of components: CH4, H2O, H2, CO, CO2, C2H6, C3H8, n-C4H10, i-C4H10, C5+
# Order of coefficients: A, B, C, H298, Cp298/R <- remember to multiply with 8.314
heavy_const = [1.702 9.081 -2.164 -74.520 4.217; 
                3.470 1.450 0.000 -241.818 4.038;
                3.249 0.422 0.000 0.000 3.468;
                3.376 0.557 0.000 -110.525 3.507;
                5.457 0.557 0.000 -393.509 4.467;
                1.131 19.225 -5.561 -83.820 6.369;
                1.213 28.785 -8.824 -104.680 9.011;
                1.935 36.915 -11.402 -125.790 11.298;
                1.935 36.915 -11.402 -125.790 11.298;
                2.464 45.351 -14.111 -146.760 14.731]


function build_enthalpy(model, T, par)
  return @NLexpression(model, [i = 1:10], (par.hconst[i,4] + (((par.hconst[i,1]*T + par.hconst[i,2]/2*T^2*10^(-3) + par.hconst[i,3]/3*T^3*10^(-6)) 
  - (par.hconst[i,1]*298 + par.hconst[i,2]/2*298^2*10^(-3) + par.hconst[i,3]/3*298^3*10^(-6)))*8.314/1000))*1000)
end