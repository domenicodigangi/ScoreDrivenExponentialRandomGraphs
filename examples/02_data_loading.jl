# Data Loading Example for Score-Driven ERGM
# ===========================================
#
# This example shows how to load and prepare network data for SDERGM analysis.
#
# Author: Domenico Di Gangi
# Date: 2024

using DrWatson
@quickactivate "ScoreDrivenExponentialRandomGraphs"

using ScoreDrivenERGM
using DataFrames
using CSV
using JLD2

println("Data Loading Example")
println("="^50)

# Example 1: Loading US Congress Co-voting Data
# ----------------------------------------------
println("\n1. US Congress Co-voting Network")

congress_data_dir = datadir("US_congr_covoting", "clean_data")

if isdir(congress_data_dir)
    println("✓ Congress data directory found")

    # List available data files
    files = filter(f -> endswith(f, ".csv") || endswith(f, ".jld2"),
                   readdir(congress_data_dir))

    if !isempty(files)
        println("  Available files:")
        for file in files
            println("    - ", file)
        end
    end
else
    println("✗ Congress data not found at: ", congress_data_dir)
end

# Example 2: Loading College Messaging Data
# ------------------------------------------
println("\n2. College Messaging Network")

college_data_dir = datadir("collegeMsg")

if isdir(college_data_dir)
    println("✓ College messaging data directory found")

    # List available files
    files = readdir(college_data_dir)
    println("  Available files:")
    for file in files
        if !startswith(file, ".")
            println("    - ", file)
        end
    end
else
    println("✗ College messaging data not found at: ", college_data_dir)
end

# Example 3: Loading Wikipedia Talk Data
# ---------------------------------------
println("\n3. Wikipedia Talk Network")

wiki_data_dir = datadir("wiki_tk")

if isdir(wiki_data_dir)
    println("✓ Wikipedia talk data directory found")

    # List available files
    files = readdir(wiki_data_dir)
    println("  Available files:")
    for file in files
        if !startswith(file, ".")
            println("    - ", file)
        end
    end
else
    println("✗ Wikipedia data not found at: ", wiki_data_dir)
end

println("\n" * "="^50)
println("Data loading example complete!")
println("\nNote: To work with specific datasets, follow the")
println("preprocessing scripts in scripts/dataCode/cleanData/")
println("="^50)
