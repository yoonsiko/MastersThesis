using JuMP, Ipopt, MathOptInterface

# Parameters for initial flow values
Base.@kwdef mutable struct mix_par
    in_T::Float64 = 311.00;
    out_T::Float64 = 381.41;
    H2O_T::Float64 = 423.00;
    carbon_ratio::Float64 = 2.5;
    ini_mix_in::Vector = [113.76022309722791, 0.0, 0.0, 0.0, 1.9483473792214394, 8.869342547202073,
     9.741736896107197, 3.605896642141171, 2.0501267199270368, 5.379765151581587];
end

Base.@kwdef mutable struct prePR_par
    out_T::Float64 = 693.00;
end

Base.@kwdef mutable struct pr_par
    out_T::Float64 = 630.52;
end

Base.@kwdef mutable struct preGHR_par
    out_T::Float64 = 753.0;
end

Base.@kwdef mutable struct ghr_par
    out_T::Float64 = 973.0;
end

Base.@kwdef mutable struct atr_par
    out_T::Float64 = 1323.0;
    nO2_H::Float64 = 22.7;
end

Base.@kwdef mutable struct postATR_par
    out_T::Float64 = 512.79;
end

Base.@kwdef mutable struct itsr_par
    out_T::Float64 = 523.0;
end

Base.@kwdef mutable struct preCond_par
    out_T::Float64 = 313.0;
end

Base.@kwdef mutable struct cond_par
    L_T::Float64 = 313.0;
    V_T::Float64 = 313.0;
    ant_par::Vector = [6.20963, 2354.731, 7.559];
    cond_P::Float64 = 15.0;
end

Base.@kwdef mutable struct psa_par
    outPurge_T::Float64 = 313.0;
    outProduct_T::Float64 = 313.0;
    splitratio::Vector = [0.01, 0.01, 0.999, 0.01, 0.01]; # Almost ideal
end