# Confidence Interval Estimation for Score-Driven ERGM
# ======================================================
#
# This example demonstrates approaches for computing confidence intervals
# for time-varying parameters in SDERGM models.
#
# Methods covered:
#   - Parametric bootstrap
#   - White's robust standard errors
#   - Coverage analysis
#
# For complete implementations, see:
#   - scripts/simulationsAndPlotsPaper/reciprocity_p_star/
#     rec_p_star_comparison_3_load_estimates_and_comp_coverage_conf_bands_dirBid0Rec0.jl
#   - _research/analysis_for_paper_revision/conf_int_analysis/
#
# Author: Domenico Di Gangi
# Date: 2024

using DrWatson
@quickactivate "ScoreDrivenExponentialRandomGraphs"

using ScoreDrivenERGM
using Statistics
using Distributions

println("Confidence Interval Estimation for SDERGM")
println("="^50)

println("\nApproaches for uncertainty quantification:")
println("-" * "="^49)

println("\n1. Parametric Bootstrap")
println("   - Simulate networks from estimated model")
println("   - Re-estimate parameters on simulated data")
println("   - Construct percentile-based confidence bands")
println("   - Computationally intensive but flexible")

println("\n2. White's Robust Standard Errors")
println("   - Asymptotic approximation")
println("   - Fast computation")
println("   - Robust to heteroskedasticity")

println("\n3. Coverage Analysis")
println("   - Evaluate confidence interval performance")
println("   - Compare nominal vs. actual coverage")
println("   - Assess across different parameter values")

println("\n" * "="^50)
println("\nKey considerations:")
println("------------------")
println("- Time-varying parameters require time-specific intervals")
println("- Bootstrap methods capture parameter uncertainty")
println("- Score-driven models allow analytical derivatives")
println("- See paper for theoretical justification")

println("\n" * "="^50)
println("\nFor working implementations:")
println("----------------------------")
println("Bootstrap confidence bands:")
println("  scripts/simulationsAndPlotsPaper/reciprocity_p_star/")
println("    rec_p_star_comparison_5_simulate_AR_and_estimate_variance_dirBin0Rec0.jl")
println()
println("Coverage analysis:")
println("  _research/analysis_for_paper_revision/conf_int_analysis/")
println()
println("="^50)
