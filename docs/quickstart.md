# Quick Start Guide

Get up and running with Score-Driven ERGM in 10 minutes!

## 1. Installation (5 minutes)

```bash
# Clone the repository with submodules
git clone --recursive https://github.com/domenicodigangi/ScoreDrivenExponentialRandomGraphs.git
cd ScoreDrivenExponentialRandomGraphs

# Start Julia
julia --project=.
```

In Julia:
```julia
using Pkg
Pkg.instantiate()  # Install dependencies
```

## 2. Verify Setup (1 minute)

```julia
using DrWatson
@quickactivate "ScoreDrivenExponentialRandomGraphs"

using ScoreDrivenERGM
println("✓ Ready to go!")
```

## 3. Run Your First Example (4 minutes)

### Basic Setup Check

```julia
include("examples/01_basic_setup.jl")
```

This will:
- Load all required packages
- Display project information
- Verify submodule initialization
- List available data

### Explore Data

```julia
include("examples/02_data_loading.jl")
```

This will show you:
- Available datasets (US Senate, College Messaging, Wikipedia)
- How to load network data
- Data directory structure

## What's Next?

### Learn More
- Read the [full installation guide](installation.md)
- Study the [paper](https://papers.ssrn.com/sol3/papers.cfm?abstract_id=3394593)
- Explore more [examples](../examples/)

### Try Real Analyses
- **US Senate Voting Networks**
  ```julia
  # Navigate to the application
  cd("scripts/simulationsAndPlotsPaper/US_senate_application/")

  # Run the analysis (note: this may take some time)
  include("1_estimate_models_on_Data_fromVCERGM_paper.jl")
  ```

- **Reciprocity Model Comparison**
  ```julia
  cd("scripts/simulationsAndPlotsPaper/reciprocity_p_star/")
  include("rec_p_star_comparison_1_simulate_dgp_estimate_dirBid0Rec0.jl")
  ```

### Understand the Workflow

Typical SDERGM workflow:

1. **Prepare Data**
   - Load temporal network snapshots
   - Compute change statistics
   - Specify model structure

2. **Estimate Model**
   ```julia
   using ScoreDrivenERGM
   import ScoreDrivenERGM: DynNets, StaticNets

   # Define model
   model = DynNets.SdErgmPml(
       staticModel = StaticNets.NetModeErgmPml(
           "edges + gwesp(decay = 0.25, fixed = TRUE)",
           true
       ),
       indTvPar = [false, true],
       scoreScalingType = "FISH_D"
   )

   # Estimate (with your data)
   # res = DynNets.estimate_and_filter(model, N, obsT)
   ```

3. **Analyze Results**
   - Plot time-varying parameters
   - Compute confidence intervals
   - Forecast future networks

### Key Concepts

- **Score-Driven Models**: Parameters evolve based on score (gradient) of likelihood
- **ERGM**: Exponential Random Graph Models for network data
- **Time-Varying Parameters**: Network features change over time
- **MLE vs PMLE**: Maximum Likelihood vs Pseudo-Maximum Likelihood estimation

### Common Tasks

**Load Network Data**
```julia
using CSV, DataFrames
data = CSV.read(datadir("your_data.csv"), DataFrame)
```

**Plot Filtered Parameters**
```julia
fig, ax = DynNets.plot_filtered(model, N, filtered_params)
```

**Compute Confidence Bands**
```julia
res_conf = DynNets.conf_bands_given_SD_estimates(
    model, N, obsT,
    estimates, ftot_0,
    [[0.975, 0.025]];
    plotFlag = true
)
```

## Troubleshooting

**Submodule empty?**
```bash
git submodule update --init --recursive
```

**Package errors?**
```julia
using Pkg
Pkg.update()
Pkg.resolve()
```

**Need help?**
- Check [installation.md](installation.md) for detailed setup
- Review [examples/](../examples/) for usage patterns
- Open an [issue](https://github.com/domenicodigangi/ScoreDrivenExponentialRandomGraphs/issues)

## Resources

- **Paper**: [SSRN Link](https://papers.ssrn.com/sol3/papers.cfm?abstract_id=3394593)
- **Examples**: See `examples/` directory
- **Tests**: See `test/` directory for code examples
- **Scripts**: See `scripts/` for complete analyses

## Tips

1. **Use DrWatson**: Always start with `@quickactivate` for proper paths
2. **Check Data**: Verify data directories exist before running scripts
3. **Start Small**: Begin with small networks to understand the workflow
4. **Read the Paper**: Understanding the methodology helps with implementation
5. **Explore Code**: The scripts show real-world usage patterns

Happy modeling! 🎉
