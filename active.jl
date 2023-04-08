function printActive(model)
    # CV:     S/C_ratio, n_O2,   prePR_T,   PR_T,   ATR_T,   postATR_T,   ITSR_T,  Cond_T
    l_bound = [0.0,      0.0,    643.0,     609.2,  1273,    550,         473,     293];
    u_bound = [5.0,      100.0,  743.0,     709.2,  1373,    650,         573,     333];

    variables = [value(model[:SC_ratio]),
                 value(model[:nO2]),
                 value(model[:prePR_out_T]),
                 value(model[:pr_out_T]),
                 value(model[:atr_out_T]),
                 value(model[:postATR_out_T]),
                 value(model[:itsr_out_T]),
                 value(model[:preCond_out_T])]
    variable_name = ["SC_ratio", "n_O2", "T_prePR", "T_PR", "T_ATR", "T_postATR", "T_ITSR", "T_Cond"]
    for i = 1:8
        if variables[i] ≈ l_bound[i]
            println("The variable ", variable_name[i], " is at its lower bound of ",l_bound[i]);
        elseif variables[i] ≈ u_bound[i]
            println("The variable ", variable_name[i], " is at its upper bound of ",u_bound[i]);
        else 
            println("The variable ",variable_name[i], " is not active, with a value of ", variables[i], ", where the bounds are: ",l_bound[i]," ≤ ",variable_name[i], " ≤ ",u_bound[i]);
        end
    end
end