# Basic Setup for Score-Driven ERGM
# ===================================
#
# This example demonstrates basic setup and package loading for SDERGM analysis.
#
# Author: Domenico Di Gangi
# Date: 2024

using DrWatson
@quickactivate "ScoreDrivenExponentialRandomGraphs"

# Load required packages
using ScoreDrivenERGM
using DataFrames
using CSV
using Distributions
using LinearAlgebra
using Statistics

println("✓ All packages loaded successfully!")

# Display project information
println("\nProject Information:")
println("===================")
println("Project name: ", projectname())
println("Project path: ", projectdir())
println("Data directory: ", datadir())
println("Scripts directory: ", scriptsdir())

# Check that submodule is available
if isdir(projectdir("src", "ScoreDrivenERGM.jl", "src"))
    println("✓ ScoreDrivenERGM.jl submodule is properly initialized")
else
    println("✗ ScoreDrivenERGM.jl submodule not found!")
    println("  Run: git submodule update --init --recursive")
end

# Display available data directories
println("\nAvailable Data:")
println("===============")
for datadir_name in readdir(datadir())
    if isdir(datadir(datadir_name))
        println("  - ", datadir_name)
    end
end

println("\n" * "="^50)
println("Setup complete! Ready to run SDERGM analyses.")
println("="^50)
