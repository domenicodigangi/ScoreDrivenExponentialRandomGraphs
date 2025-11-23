using Test
using DrWatson

@quickactivate "ScoreDrivenExponentialRandomGraphs"

# Load the ScoreDrivenERGM submodule
using ScoreDrivenERGM

@testset "ScoreDrivenExponentialRandomGraphs Tests" begin

    @testset "Project Structure" begin
        @info "Testing project structure..."
        # Test that project structure follows DrWatson conventions
        @test isdir(projectdir())
        @test isdir(datadir())
        @test isdir(scriptsdir())
    end

    @testset "Data Directories" begin
        @info "Testing data directories exist..."
        # Test that data directories exist
        @test isdir(datadir("US_congr_covoting"))
        @test isdir(datadir("collegeMsg"))
        @test isdir(datadir("wiki_tk"))
    end

    @testset "Submodule Loading" begin
        @info "Testing ScoreDrivenERGM submodule..."
        # Test that the core module is available
        @test isdefined(ScoreDrivenERGM, :DynNets)
        @test isdefined(ScoreDrivenERGM, :StaticNets)
        @test isdefined(ScoreDrivenERGM, :Utilities)
    end

    @testset "Utilities" begin
        @info "Testing utility functions..."
        using ProjUtilities
        # Test that ProjUtilities module is available
        @test isdefined(ProjUtilities, :viewDfPluto)
    end

    # Include security tests
    include("test_security.jl")

end

@info "All tests completed!"
