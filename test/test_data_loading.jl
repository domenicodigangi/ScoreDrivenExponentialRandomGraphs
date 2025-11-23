using Test
using DrWatson

@quickactivate "ScoreDrivenExponentialRandomGraphs"

@testset "Data Loading Tests" begin

    @testset "US Congress Covoting Data" begin
        data_path = datadir("US_congr_covoting", "clean_data")
        if isdir(data_path)
            @test true
            # Add more specific tests for data structure
        else
            @warn "US Congress data not found, skipping tests"
        end
    end

    @testset "College Messaging Data" begin
        data_path = datadir("collegeMsg")
        if isdir(data_path)
            @test true
            # Add more specific tests for data structure
        else
            @warn "College Messaging data not found, skipping tests"
        end
    end

    @testset "Wiki Talk Data" begin
        data_path = datadir("wiki_tk")
        if isdir(data_path)
            @test true
            # Add more specific tests for data structure
        else
            @warn "Wiki Talk data not found, skipping tests"
        end
    end

end
