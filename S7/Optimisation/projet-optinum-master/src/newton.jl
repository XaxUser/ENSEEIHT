using LinearAlgebra
"""
Approximation d'une solution du problÃ¨me min f(x), x âˆˆ Râ¿, en utilisant l'algorithme de Newton.

# Syntaxe

   x_sol, f_sol, flag, nb_iters, xs = newton(f, gradf, hessf, x0; kwargs...)

# EntrÃ©es

   - f       : (Function) la fonction Ã  minimiser
   - gradf   : (Function) le gradient de la fonction f
   - hessf   : (Function) la Hessienne de la fonction f
   - x0      : (Union{Real,Vector{<:Real}}) itÃ©rÃ© initial
   - kwargs  : les options sous formes d'arguments "keywords"
      â€¢ max_iter : (Integer) le nombre maximal d'iterations (optionnel, par dÃ©faut 1000)
      â€¢ tol_abs  : (Real) la tolÃ©rence absolue (optionnel, par dÃ©faut 1e-10)
      â€¢ tol_rel  : (Real) la tolÃ©rence relative (optionnel, par dÃ©faut 1e-8)
      â€¢ epsilon  : (Real) le epsilon pour les tests de stagnation (optionnel, par dÃ©faut 1)

# Sorties

   - x_sol : (Union{Real,Vector{<:Real}}) une approximation de la solution du problÃ¨me
   - f_sol : (Real) f(x_sol)
   - flag  : (Integer) indique le critÃ¨re sur lequel le programme s'est arrÃªtÃ©
      â€¢ 0  : convergence
      â€¢ 1  : stagnation du xk
      â€¢ 2  : stagnation du f
      â€¢ 3  : nombre maximal d'itÃ©ration dÃ©passÃ©
   - nb_iters : (Integer) le nombre d'itÃ©rations faites par le programme
   - xs    : (Vector{Vector{<:Real}}) les itÃ©rÃ©s

# Exemple d'appel

   f(x)=100*(x[2]-x[1]^2)^2+(1-x[1])^2
   gradf(x)=[-400*x[1]*(x[2]-x[1]^2)-2*(1-x[1]) ; 200*(x[2]-x[1]^2)]
   hessf(x)=[-400*(x[2]-3*x[1]^2)+2  -400*x[1];-400*x[1]  200]
   x0 = [1; 0]
   x_sol, f_sol, flag, nb_iters, xs = newton(f, gradf, hessf, x0)

"""
function newton(f::Function, gradf::Function, hessf::Function, x0::Union{Real,Vector{<:Real}}; 
    max_iter::Integer = 1000, 
    tol_abs::Real = 1e-10, 
    tol_rel::Real = 1e-8, 
    epsilon::Real = 1)

    #
    x_sol = x0
    f_sol = f(x_sol)
    flag  = 0
    nb_iters = 0
    xs = [x0] # vous pouvez faire xs = vcat(xs, [xk]) pour concatÃ©ner les valeurs
    Non_arret = (norm(gradf(x_sol)) > max(tol_rel*norm(gradf(x0)), tol_abs)) && (nb_iters < max_iter )
    while Non_arret
        d_k = -hessf(x_sol) \ gradf(x_sol)
        x_sol = x_sol + d_k
        xs = vcat(xs, [x_sol])
        nb_iters = nb_iters + 1
        critere1 = norm(gradf(x_sol)) <= max(tol_rel*norm(gradf(x0)), tol_abs)
        critere2 = norm(d_k) <= epsilon*max(tol_rel*norm(x_sol-d_k), tol_abs)
        critere3 = norm(f(x_sol) - f(x_sol - d_k)) <= epsilon*max(tol_rel*abs(f(x_sol - d_k)), tol_abs)
        critere4 = nb_iters == max_iter
        Non_arret = ~critere1 && ~critere2 && ~critere3 && ~critere4
        if (critere1)
            flag = 0
        elseif (critere2)
            flag = 1
        elseif (critere3)
            flag = 2
        elseif (critere4)
            flag = 3
        end
    end
    f_sol = f(x_sol)

    return x_sol, f_sol, flag, nb_iters, xs
end