include("nominal_case.jl")
using LinearAlgebra, XLSX

nominal_states, nom_f = nominal();
#@show(nominal_states[1:142], allrows = true)

function diagWn(nom)
    ##### Index list #####
    # [1:126] - flow
    # [127:131] - compfrac
    # [132] - flow
    # [133:137] - compfrac
    # [138:152] - flow
    # [153:171] - temp
    # [172:177] - Q
    # [178:184] - flow 
    flow_pert = 0.02; # relative% [kmol/h]
    temp_pert = 1; # absolute [K]
    Q_pert = 0.05; # relative% [kmol/h]
    comp_pert = 0.01; # absolute [-]
    for i in eachindex(nom)
        if 1<=i<=126
            nom[i] = nom[i]*(1+flow_pert);
        elseif 127<=i<=131
            nom[i] += comp_pert;
        elseif i == 132
            nom[i] = nom[i]*(1+flow_pert);
        elseif 133<=i<=137
            nom[i] += comp_pert;
        elseif 138<=i<=152
            nom[i] = nom[i]*(1+flow_pert);
        elseif 153<=i<=171
            nom[i] += temp_pert;
        elseif 172<=i<=177
            nom[i] = nom[i]*(1+Q_pert);
        else
            nom[i] = nom[i]*(1+flow_pert);
        end
    end
    df = DataFrame(diagm(nom),:auto);
    return df
end

function diagWd()
    d= [145.4, 0.14, 3.347]
    for i in eachindex(d)
        d[i] = d[i]*(1+0.1)
    end
    return DataFrame(diagm(d),:auto)
end


function diag_to_xlsx()
    df1 = diagWn(nominal_states)
    XLSX.writetable("data/Wn.xlsx", df1);
    df2 = diagWd()
    XLSX.writetable("data/Wd.xlsx", df2)
end
#diag_to_xlsx()