initial_value = [113.76022309722791, 0.0, 0.0, 0.0, 1.9483473792214394, 8.869342547202073,
9.741736896107197, 3.605896642141171, 2.0501267199270368, 5.379765151581587];
total_mole = sum(initial_value);

""" # Used for calculating the compostion for methanol -10% step change
x = initial_value/total_mole;
change_x = 0.1;


y = x[1] - change_x;
#print(y)

for i = 5:10
    x[i] = x[i]/(1-x[1])*(1-y);
end
x[1] -= change_x;
print("CH4 -10% change", x)
"""
function comp(x_list, y)
    # x_list = list of mole streams
    # y = change in methanol%
    total_mole = sum(x_list);
    x = x_list/total_mole;
    x_ch4 = x[1];
    new_x = x_ch4 + y;
    for i = 5:10
        x[i] = x[i]/(1-x_ch4) * (1-new_x);
    end
    x[1] = new_x;
    return x
end

#print(comp(initial_value, 0.1));


#start = [0.682634790437131, 0.0, 0.0, 0.0, 0.019570611174148374, 0.08909009564351124,
# 0.09785305587074186, 0.03622023560588654, 0.020592956533991943, 0.0540382547345888]*total_mole;
#print(comp(start, -0.01));