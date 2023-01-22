# Source: https://shepherd.caltech.edu/EDL/PublicResources/sdt/refs/NASA-TM-4513.pdf
# Col order: a1, a2, a3, a4, a5, b1, b2, H0_298/R
# Row order: CH4, H2O, H2, CO, CO2
# const_o: constants for temperatures over 1000K
const_o = [1.63552643 1.00842795e-2 -3.36916254e-6 5.34958667e-10 -3.15518833e-14 1.00056455e4 9.99313326 -8.97226656e3;
            2.67703787 2.97318329e-3 -7.73769690e-7 9.44336689e-11 -4.26900959e-15 -2.98858938e4 6.88255571 -2.90848168e4;
            2.93286579 8.26607967e-4 -1.46402335e-7 1.54100359e-11 -6.88804432e-16 -8.13065597e2 -1.0243288 0.00;
            3.04848583 1.35172818e-3 -4.85794075e-7 7.88536486e-11 -4.69807489e-15 -1.42661171e4 6.01709790 -1.32936276e4;
            4.63659493 2.74131991e-3 -9.95828531e-7 1.60373011e-10 -9.16103468e-15 -4.90249341e4 -1.93534855 -4.73281047e4]


# const_u: constants for temperature under 1000K            
const_u = [5.14987613 -1.36709788e-2 4.91800599e-5 -4.84743026e-8 1.66693956e-11 -1.02466476e4 -4.64130376 -8.97226656e3;
            4.19864056 -2.03643410e-3 6.52040211e-6 -5.48797062e-9 1.77197817e-12 -3.02937267e4 -8.49032208e-1 -2.90848168e4;
            2.34433112 7.98052075e-3 -1.94781510e-5 2.01572094e-8 -7.37611761e-12 -9.17935173e2 6.83010238e-1 0.00;
            3.57953347 -6.10353680e-4 1.01681433e-6 9.07005884e-10 -9.04424499e-13 -1.43440860e4 3.50840928 -1.32936276e4;
            2.35677352 8.98459677e-3 -7.12356269e-6 2.45919022e-9 -1.43699548e-13 -4.83719697e4 9.90105222 -4.73281047e4]

smr_const = [-1.51735037e-05, 4.79654639e-02, -2.91867555e+01];
wgsr_const = [2.95405564e-06, -8.48603361e-03, 4.99373583e+00];

function K_smr(model, T, par)
    T -= 273.15; # Convert kelvin to celsius
    return @NLexpression(model, exp(par.smr_const[1]*T^2 + par.smr_const[2]*T + par.smr_const[3]));
end

function K_wgsr(model, T, par)
    T -= 273.15; # Convert kelvin to celsius
    return @NLexpression(model, exp(par.wgsr_const[1]*T^2 + par.wgsr_const[2]*T + par.wgsr_const[3]));
end

function smr_u(model, T, par) # equlibrium constant for smr for temperatures under 1000K
    coeff = [-1, -1, 3, 1, 0]; # CH4 H2O H2 CO CO2
    h_vec = @NLexpression(model, [i=1:5], par.const_u[i,1] + par.const_u[i,2]*T/2 + par.const_u[i,3]*T^2/3 + par.const_u[i,4]*T^3/4 + par.const_u[i,5]*T^4/5 + par.const_u[i,6]/T);
    s_vec = @NLexpression(model, [i=1:5], par.const_u[i,1]*log(T) + par.const_u[i,2]*T + par.const_u[i,3]*T^2/2 + par.const_u[i,4]*T^3/3 + par.const_u[i,5]*T^4/4 + par.const_u[i,7]);

    Hrx = @NLexpression(model, sum(coeff[i]*h_vec[i] for i=1:5));
    Srx = @NLexpression(model, sum(coeff[i]*s_vec[i] for i=1:5));
    coeffsum = sum(coeff);
    return @NLexpression(model, exp(Srx - Hrx)*(par.P/(par.R*T))^coeffsum)
end

function smr_o(model, T, par) # equilibrum constant for smr for temperatures over 1000K
    coeff = [-1, -1, 3, 1, 0]; # CH4 H2O H2 CO CO2
    h_vec = @NLexpression(model, [i=1:5], par.const_o[i,1] + par.const_o[i,2]*T/2 + par.const_o[i,3]*T^2/3 + par.const_o[i,4]*T^3/4 + par.const_o[i,5]*T^4/5 + par.const_o[i,6]/T);
    s_vec = @NLexpression(model, [i=1:5], par.const_o[i,1]*log(T) + par.const_o[i,2]*T + par.const_o[i,3]*T^2/2 + par.const_o[i,4]*T^3/3 + par.const_o[i,5]*T^4/4 + par.const_o[i,7]);

    Hrx = @NLexpression(model, sum(coeff[i]*h_vec[i] for i=1:5));
    Srx = @NLexpression(model, sum(coeff[i]*s_vec[i] for i=1:5));
    coeffsum = sum(coeff);
    return @NLexpression(model, exp(Srx - Hrx)*(par.P/(par.R*T))^coeffsum)
end

function wgsr_u(model, T, par)
    coeff = [0, -1, 1, -1, 1]; # CH4 H2O H2 CO CO2
    h_vec = @NLexpression(model, [i=1:5], par.const_u[i,1] + par.const_u[i,2]*T/2 + par.const_u[i,3]*T^2/3 + par.const_u[i,4]*T^3/4 + par.const_u[i,5]*T^4/5 + par.const_u[i,6]/T);
    s_vec = @NLexpression(model, [i=1:5], par.const_u[i,1]*log(T) + par.const_u[i,2]*T + par.const_u[i,3]*T^2/2 + par.const_u[i,4]*T^3/3 + par.const_u[i,5]*T^4/4 + par.const_u[i,7]);

    Hrx = @NLexpression(model, sum(coeff[i]*h_vec[i] for i=1:5));
    Srx = @NLexpression(model, sum(coeff[i]*s_vec[i] for i=1:5));
    coeffsum = sum(coeff);
    return @NLexpression(model, exp(Srx - Hrx)*(par.P/(par.R*T))^coeffsum)
end

function wgsr_o(model, T, par)
    coeff = [0, -1, 1, -1, 1]; # CH4 H2O H2 CO CO2
    h_vec = @NLexpression(model, [i=1:5], par.const_o[i,1] + par.const_o[i,2]*T/2 + par.const_o[i,3]*T^2/3 + par.const_o[i,4]*T^3/4 + par.const_o[i,5]*T^4/5 + par.const_o[i,6]/T);
    s_vec = @NLexpression(model, [i=1:5], par.const_o[i,1]*log(T) + par.const_o[i,2]*T + par.const_o[i,3]*T^2/2 + par.const_o[i,4]*T^3/3 + par.const_o[i,5]*T^4/4 + par.const_o[i,7]);
    Hrx = @NLexpression(model, sum(coeff[i]*h_vec[i] for i=1:5));
    Srx = @NLexpression(model, sum(coeff[i]*s_vec[i] for i=1:5));
    coeffsum = sum(coeff);
    return @NLexpression(model, exp(Srx - Hrx)*(par.P/(par.R*T))^coeffsum)
end