include("gain_d.jl")
include("gain_u.jl")
include("J_uu.jl")
include("J_ud.jl")
include("nominal_case.jl")
using LinearAlgebra

eps = 1e-5
nominal_values, nominal_J = nominal();


function Fmatrix(nominal)
    G_y_matrix = matrix_Gy(nominal, eps);
    G_y_d_matrix = matrix_Gyd(nominal, eps);
    J_uu_matrix = J_uu(1e-2);
    J_ud_matrix = J_ud(1e-2);
    F = G_y_d_matrix' - G_y_matrix'*inv(J_uu_matrix)*J_ud_matrix;
    return F
end

F = Fmatrix(nominal_values);

function print_F(matrix)
    return DataFrame(Variable = variable_name,
                     Nominal = nominal_values,
                     ∂y∂d_1 = matrix[:,1],
                     ∂y∂d_2 = matrix[:,2],
                     ∂y∂d_3 = matrix[:,3])
end

show(print_F(Fmatrix(nominal_values)), allrows=true)

show(nullspace(Fmatrix(nominal_value)))