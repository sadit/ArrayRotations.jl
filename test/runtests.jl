using ArrayRotations
using ArrayRotations: _copy!, _left_shift!, _right_shift!, _interchange_left_large!, _interchange_right_large!
using Test

@testset "_copy!" begin
    A = [7, 8, 9, 10, 1, 2, 3, 4, 5, 6]
    B = zeros(Int, 20)
    _copy!(B, 1, A, 1, 10)
    @test B == [7, 8, 9, 10, 1, 2, 3, 4, 5, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    reverse!(A)
    _copy!(B, 11, A, 1, 10)
    @test B == [7, 8, 9, 10, 1, 2, 3, 4, 5, 6, 6, 5, 4, 3, 2, 1, 10, 9, 8, 7]

    B = zeros(Int, 100)
    A = collect(1:100)
    for i in 1:96
       _copy!(B, i, A, i, 5)
    end
    @test A == B
end

@testset "_*_shift!" begin
    A = [7, 8, 9, 10, 1, 2, 3, 4, 5, 6]
    @test _left_shift!(A, 5) == [1, 2, 3, 4, 5, 6, 3, 4, 5, 6]
    A = [7, 8, 9, 10, 1, 2, 3, 4, 5, 6]
    _right_shift!(A, 4) == [7, 8, 9, 10, 1, 2, 7, 8, 9, 10]
end

@testset "AuxRotation" begin
    aux = AuxRotation(Int[])
    A = [7, 8, 9, 10, 1, 2, 3, 4, 5, 6]
    @test rotate!(aux, A, 5) == collect(1:10)
    A = [7, 8, 9, 10, 11, 12, 13, 14, 15, 1, 2, 3, 4, 5, 6]
    @test rotate!(aux, A, 10) == collect(1:15)
end

@testset "RevRotation" begin
    aux = RevRotation()
    A = [7, 8, 9, 10, 1, 2, 3, 4, 5, 6]
    @test rotate!(aux, A, 5) == collect(1:10)
    A = [7, 8, 9, 10, 11, 12, 13, 14, 15, 1, 2, 3, 4, 5, 6]
    @test rotate!(aux, A, 10) == collect(1:15)
end

#=
@testset "Interchange_*_large" begin
    A = [4, 5, 6, 7, 8, 9, 1, 2, 3]
    @test _interchange_left_large!(copy(A), 7) == [1, 2, 3, 4, 5, 6, 1, 2, 3]
    A = [7, 8, 9, 1, 2, 3, 4, 5, 6]
    @test _interchange_right_large!(copy(A), 4) == [1, 2, 3, 1, 2, 3, 7, 8, 9]
end
=#

@testset "BridgeRotation" begin
    bridge = BridgeRotation(Int[])
    A = [7, 8, 9, 10, 1, 2, 3, 4, 5, 6]
    @test rotate!(bridge, A, 5) == collect(1:10)
    A = [7, 8, 9, 10, 11, 12, 13, 14, 15, 1, 2, 3, 4, 5, 6]
    @test rotate!(bridge, A, 10) == collect(1:15)
end


@testset "GriesMillsRotation" begin
    gm = GriesMillsRotation()

    A = [3, 1, 2]
    @test rotate!(gm, A, 2) == collect(1:3)
    A = [2, 3, 1]
    @test rotate!(gm, A, 3) == collect(1:3)

    A = [7, 8, 9, 10, 1, 2, 3, 4, 5, 6]
    @test rotate!(gm, A, 5) == collect(1:10)
    A = [7, 8, 9, 10, 11, 12, 13, 14, 15, 1, 2, 3, 4, 5, 6]
    @test rotate!(gm, A, 10) == collect(1:15)
end