# Function for calculating the reversible adiabatic isentropic process compression work

function Wrev(model, n, P1, P2, T1, par)
    #ntot = @NLexpression(model, sum(n[i] for i = 1:5));
    #cp = @NLexpression(model, sum(n[i]*par.cp_list[i]/ntot for i = 1:5));
    gamma = @NLexpression(model, 5/3.0);
    return @NLexpression(model, n*5/2*par.R*T1*((P2/P1)^((gamma-1)/gamma)-1));
end

function compT(model, T1, P1, P2)
    #ntot = @NLexpression(model, sum(n[i] for i = 1:5));
    #cp = @NLexpression(model, sum(n[i]*par.cp_list[i]/ntot for i = 1:5));
    gamma = @NLexpression(model, 5/3.0);
    return @NLexpression(model, T1*(P1/P2)^((gamma - 1)/gamma))
end