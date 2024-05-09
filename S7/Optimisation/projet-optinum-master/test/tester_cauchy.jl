# Ecrire les tests de l'algorithme du pas de Cauchy
using Test
using LinearAlgebra


function tester_cauchy(cauchy::Function)

    n = 4
    tol_abs = 1e-10

	@testset "Pas de Cauchy" begin
        
        @testset "g = 0 et H random" begin
            g = zeros(n)
            H = randn(n,n)
            Δ = 1
            s = cauchy(g, H, Δ)
            @testset "solution" begin
                @test s == zeros(n)
            end
        end

        @testset "g != 0 et H = 0" begin
            g = randn(n)
            while (norm(g) <= tol_abs)
                g = randn(n)
            end
            H = zeros(n,n)
            Δ = 1
            s = cauchy(g, H, Δ)
            @testset "solution" begin
                @test s == -(Δ / norm(g))*g
            end
        end

        @testset "g != 0 et H <= 0" begin
            g = randn(3)
            while (norm(g) <= tol_abs)
                g = randn(n)
            end
            H = [0 -1 -2;-1 0 0;-6 -7 -8]
            Δ = 1
            s = cauchy(g, H, Δ)
            @testset "solution" begin
                @test s == -(Δ / norm(g))*g
            end
        end

        # le min est  dans les deux cas suivants ~ 0.099 inférieur à Δ
        @testset "g != 0 et H >= 0 et intervalle atteint" begin
            g = [1, 2, 3]
            H = [0 1 2;1 0 0;6 7 8]
            Δ = 1
            s = cauchy(g, H, Δ)
            a = g' * H * g
            b = -norm(g)^2 
            @testset "solution" begin
                @test s == (b / a)*g
            end
        end

        @testset "g != 0 et H <= 0" begin
            g = [1, 2, 3]
            H = [0 1 2;1 0 0;6 7 8]
            Δ = 0.009
            s = cauchy(g, H, Δ)
            @testset "solution" begin
                @test s == -(Δ / norm(g))*g
            end
        end

        
        



















        
    end

end