# Forecasting with Score-Driven ERGM
# ====================================
#
# This example demonstrates how to use estimated SDERGM models
# for forecasting future network statistics.
#
# For complete implementations with real data, see:
#   - scripts/dataCode/estimateModels/ApplicAndTestsOnData/
#     compareAR1SS_GAS_in_1_step_forecasting.jl
#
# Author: Domenico Di Gangi
# Date: 2024

using DrWatson
@quickactivate "ScoreDrivenExponentialRandomGraphs"

using ScoreDrivenERGM
using Statistics
using Distributions

println("Forecasting with Score-Driven ERGM")
println("="^50)

println("\nForecasting workflow:")
println("-" * "="^49)

println("\n1. Model Estimation")
println("   - Estimate SDERGM on historical data")
println("   - Obtain filtered parameter trajectories")
println("   - Validate in-sample fit")

println("\n2. Parameter Forecasting")
println("   - Project time-varying parameters forward")
println("   - Use score-driven updating equations")
println("   - Account for parameter uncertainty")

println("\n3. Network Statistic Forecasting")
println("   - Predict future network statistics")
println("   - Generate prediction intervals")
println("   - Compare with benchmark models")

println("\n4. Model Comparison")
println("   - AR(1) models with static statistics")
println("   - Score-driven models (GAS)")
println("   - Evaluate forecasting accuracy (RMSE, MAE)")

println("\n" * "="^50)
println("\nKey advantages of SDERGM for forecasting:")
println("------------------------------------------")
println("- Incorporates network structure evolution")
println("- Time-varying parameters adapt to changes")
println("- Principled uncertainty quantification")
println("- Can forecast multiple steps ahead")

println("\n" * "="^50)
println("\nFor working examples:")
println("---------------------")
println("One-step-ahead forecasting:")
println("  scripts/dataCode/estimateModels/ApplicAndTestsOnData/")
println("    compareAR1SS_GAS_in_1_step_forecasting.jl")
println()
println("Multi-step forecasting:")
println("  scripts/dataCode/estimateModels/ApplicAndTestsOnData/")
println("    estimateDirBinGasDataAndForecastTest.jl")
println()
println("="^50)
