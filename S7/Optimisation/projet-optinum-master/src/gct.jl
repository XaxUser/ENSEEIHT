using LinearAlgebra
"""
Approximation de la solution du problème 

    min qₖ(s) = s'gₖ + 1/2 s' Hₖ s, sous la contrainte ‖s‖ ≤ Δₖ

# Syntaxe

    s = gct(g, H, Δ; kwargs...)

# Entrées

    - g : (Vector{<:Real}) le vecteur gₖ
    - H : (Matrix{<:Real}) la matrice Hₖ
    - Δ : (Real) le scalaire Δₖ
    - kwargs  : les options sous formes d'arguments "keywords", c'est-à-dire des arguments nommés
        • max_iter : le nombre maximal d'iterations (optionnel, par défaut 100)
        • tol_abs  : la tolérence absolue (optionnel, par défaut 1e-10)
        • tol_rel  : la tolérence relative (optionnel, par défaut 1e-8)

# Sorties

    - s : (Vector{<:Real}) une approximation de la solution du problème

# Exemple d'appel

    g = [0; 0]
    H = [7 0 ; 0 2]
    Δ = 1
    s = gct(g, H, Δ)

"""

function resoudre(s::Vector{<:Real},p::Vector{<:Real},Δ::Real,g::Vector{<:Real},H::Matrix{<:Real},choix::String)
    a = p' * p
    b = 2 * s' * p
    c = s' * s - Δ * Δ
    delta = b * b - 4 * a * c
    sol1 = (-b - sqrt(delta)) / (2 * a)
    sol2 = (-b + sqrt(delta)) / (2 * a)
    q(y) = g' * y + ((y' * H * y) / 2 )
    q1 = q(s + sol1 * p)
    q2 = q(s + sol2 * p)
    if (choix == "petite")
        if (q1 > q2)
            return sol2
        else
            return sol1
        end
    elseif (choix == "positive")
        return max(sol1, sol2)
    end
end
        
    

    
function gct(g::Vector{<:Real}, H::Matrix{<:Real}, Δ::Real; 
    max_iter::Integer = 100, 
    tol_abs::Real = 1e-10, 
    tol_rel::Real = 1e-8)

    j = 0
    g0 = g
    s = zeros(length(g))
    p = -g
    
    while (j <= max_iter) && (norm(g) > max(norm(g0) * tol_rel, tol_abs)) 
        κj = p' * H * p
        if (κj <= 0)
            σj = resoudre(s, p, Δ, g0, H, "petite")
            return s + σj * p
            
        end
        αj = g' * g / κj
        if (norm(s + αj * p) >= Δ)
            σj = resoudre(s, p, Δ, g0, H, "positive")
            return s + σj * p
            
        end
        s = s + αj * p
        g1 = g + αj * H * p
        βj = (g1' * g1) / (g' * g)
        p = -g1 + βj * p
        g = g1
        j = j + 1
    end
    return s
        
end
