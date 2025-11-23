using Test
using ScoreDrivenExponentialRandomGraphs
using ScoreDrivenERGM
using DrWatson

@quickactivate "ScoreDrivenExponentialRandomGraphs"

@testset "ScoreDrivenExponentialRandomGraphs Tests" begin

    @testset "Data Loading and Processing" begin
        @info "Testing data loading utilities..."
        # Test that data directories exist
        @test isdir(datadir())
        @test isdir(datadir("US_congr_covoting"))
        @test isdir(datadir("collegeMsg"))
        @test isdir(datadir("wiki_tk"))
    end

    @testset "Model Estimation" begin
        @info "Testing basic model estimation..."
        # Add basic model estimation tests
        # These would test core functionality from ScoreDrivenERGM
        @test true  # Placeholder - to be expanded
    end

    @testset "Utilities" begin
        @info "Testing utility functions..."
        using ProjUtilities
        # Test utility functions
        @test true  # Placeholder - to be expanded
    end

    @testset "Reproducibility" begin
        @info "Testing reproducibility features..."
        # Test that project structure follows DrWatson conventions
        @test projectdir() == dirname(dirname(@__DIR__))
        @test isdir(scriptsdir())
    end

end

@info "All tests completed!"
