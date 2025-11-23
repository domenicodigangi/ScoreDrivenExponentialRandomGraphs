using Test
using ProjUtilities

@testset "ProjUtilities Tests" begin

    @testset "Module Loading" begin
        @test isdefined(ProjUtilities, :viewDfPluto)
    end

    # Add more tests as utility functions are documented

end
