# Examples and Tutorials

This directory contains examples and tutorials for using the Score-Driven ERGM package.

## Contents

1. **01_basic_setup.jl** - Getting started with the package and basic setup
2. **02_data_loading.jl** - Loading and preparing network data
3. **03_model_estimation.jl** - Estimating SDERGM models
4. **04_confidence_intervals.jl** - Computing confidence intervals for parameters
5. **05_forecasting.jl** - Forecasting future network statistics

## Running the Examples

Each example is self-contained and can be run independently. Make sure you have:

1. Activated the project environment
2. Installed all dependencies
3. Initialized the submodules

To run an example:

```julia
using DrWatson
@quickactivate "ScoreDrivenExponentialRandomGraphs"

include("examples/01_basic_setup.jl")
```

Or from the command line:

```bash
julia --project=. examples/01_basic_setup.jl
```

## Empirical Applications

For complete empirical applications, see:

- `scripts/simulationsAndPlotsPaper/US_senate_application/` - US Senate voting analysis
- `scripts/dataCode/` - College messaging and Wikipedia talk networks

## Additional Resources

- **Paper**: [SSRN Link](https://papers.ssrn.com/sol3/papers.cfm?abstract_id=3394593)
- **Core Library**: `src/ScoreDrivenERGM.jl/`
- **Documentation**: See main README.md

## Getting Help

If you encounter issues:

1. Check that all dependencies are installed
2. Ensure submodules are initialized (`git submodule update --init --recursive`)
3. Verify your Julia version is ≥ 1.6
4. Open an issue on GitHub with a minimal reproducible example
