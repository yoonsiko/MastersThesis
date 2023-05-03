include("finite_diff.jl")
include("nominal_case.jl")

# Options for finite diff (eps = 1e-5)
# 1: u1+h, n_O2
# 2: u2+h, T_prePR
# 3: u3+h, T_ATR
# 4: d1+k, NG flow
# 5: d2+k, P_el
# 6: d3+k, P_H2
# -1: u1-h, n_O2
# -2: u2-h, T_prePR
# -3: u3-h, T_ATR
# -4: d1-k, NG flow
# -5: d2-k, P_el
# -6: d3-k, P_H2

nominal_states, nom_f = nominal();
eps = 1e-2
function J_uu(eps)
    J_uu = zeros(3,3);
    for i=1:3
        for j=1:3
            if i==j
                f1, h, k = finite_diff_1(i,eps) # f(x+h, y)
                f2, h, k = finite_diff_1(-i,eps) # f(x-h, y)
                f_xx = (f1 - 2*nom_f + f2)/(eps^2) # f(x+h,y) - 2f(x,y) + f(x-h,y) / h^2
                J_uu[i,j] = f_xx
            else
                f1, h, k = finite_diff_2(i,j,eps); # f(x+h, y+k)
                f2, h, k = finite_diff_1(i,eps) # f(x+h, y)
                f3, h, k = finite_diff_1(-i,eps) # f(x-h, y)
                f4, h, k = finite_diff_1(j,eps) # f(x, y+k)
                f5, h, k = finite_diff_1(-j,eps) # f(x, y-k)
                f6, h, k = finite_diff_2(-i, -j, eps); # f(x-h, y-k)
                f_xy = (f1 - f2 - f3 - f4 - f5 + f6 + 2*nom_f)/(2*eps*eps)
                J_uu[i,j] = f_xy
            end
        end
    end
    return J_uu
end