# Documentation

Welcome to the Score-Driven ERGM documentation!

## Getting Started

- **[Quick Start Guide](quickstart.md)** - Get running in 10 minutes
- **[Installation Guide](installation.md)** - Detailed installation instructions
- **[Examples](../examples/)** - Code examples and tutorials

## Documentation Structure

### For Users

- **Quick Start**: Jump right in with a minimal example
- **Installation**: Step-by-step setup for all platforms
- **Examples**: Learn by example with annotated code
- **API Reference**: Detailed function documentation (in ScoreDrivenERGM.jl submodule)

### For Developers

- **[Contributing Guidelines](../CONTRIBUTING.md)** - How to contribute
- **[Changelog](../CHANGELOG.md)** - Version history and changes
- **Tests**: See `test/` directory for test examples
- **Development Setup**: See CONTRIBUTING.md

## Key Documentation

### Understanding SDERGM

1. **Read the Paper**: [SSRN Link](https://papers.ssrn.com/sol3/papers.cfm?abstract_id=3394593)
   - Core methodology and theory
   - Mathematical derivations
   - Empirical applications

2. **Examples**:
   - `examples/01_basic_setup.jl` - Getting started
   - `examples/02_data_loading.jl` - Working with data
   - `examples/03_model_estimation.jl` - Fitting models
   - `examples/04_confidence_intervals.jl` - Uncertainty quantification
   - `examples/05_forecasting.jl` - Prediction

3. **Real Applications**:
   - US Senate co-voting networks
   - College messaging networks
   - Wikipedia talk networks

### Package Components

- **ScoreDrivenERGM.jl** (submodule): Core implementation
  - `DynNets`: Dynamic network models
  - `StaticNets`: Static ERGM models
  - `Utilities`: Helper functions
  - `ErgmRcall`: R integration

- **ProjUtilities**: Project-specific utilities
  - Data viewing functions
  - Custom helpers

### Data Structure

```
data/
├── US_congr_covoting/  # US Congressional networks
├── collegeMsg/          # College messaging data
└── wiki_tk/             # Wikipedia talk networks
```

See [02_data_loading.jl](../examples/02_data_loading.jl) for data access examples.

## Methodology Overview

### Score-Driven Models

Score-Driven ERGMs extend traditional ERGMs by allowing parameters to evolve over time:

```
θ(t) = f(θ(t-1), s(t-1))
```

where `s(t)` is the scaled score (gradient) of the log-likelihood.

### Key Features

- **Time-varying parameters**: Adapt to network evolution
- **Observation-driven**: Updates based on observed network changes
- **Computationally efficient**: Avoids MCMC for filtering
- **Theoretically grounded**: GAS framework with optimality properties

### Estimation Methods

1. **Maximum Likelihood (MLE)**
   - Full likelihood evaluation
   - Most accurate but computationally intensive
   - Suitable for smaller networks

2. **Pseudo-Maximum Likelihood (PMLE)**
   - Approximation based on conditional edge probabilities
   - Much faster computation
   - Suitable for large networks

### Model Components

- **Static ERGM**: Baseline network model
  - Network statistics (edges, reciprocity, transitivity, etc.)
  - Parameter interpretation

- **Dynamic Extension**: Time-varying parameters
  - Score-driven updating
  - Filtering and smoothing
  - Forecasting

## Common Workflows

### 1. Data Preparation

```julia
using DrWatson, ScoreDrivenERGM
@quickactivate "ScoreDrivenExponentialRandomGraphs"

# Load your temporal network data
# Compute change statistics
# Set up model structure
```

### 2. Model Estimation

```julia
# Define model
model = DynNets.SdErgmPml(...)

# Estimate parameters
res = DynNets.estimate_and_filter(model, N, obsT)
```

### 3. Analysis

```julia
# Plot results
fig, ax = DynNets.plot_filtered(model, N, res.fVecT_filt)

# Confidence intervals
conf = DynNets.conf_bands_given_SD_estimates(...)

# Forecasting
forecast = DynNets.forecast_ahead(...)
```

## API Reference

Detailed API documentation is available in the ScoreDrivenERGM.jl submodule:

```julia
using ScoreDrivenERGM
?DynNets.estimate_and_filter
```

## FAQs

**Q: What Julia version do I need?**
A: Julia 1.6 or later.

**Q: Do I need R installed?**
A: Only if you want to compare with statnet or use R-based estimation.

**Q: How do I handle large networks?**
A: Use PMLE instead of MLE, and consider subsampling or aggregation.

**Q: Can I use weighted networks?**
A: The current implementation focuses on binary networks. Extensions are possible.

**Q: How do I cite this package?**
A: See the citation information in the main [README](../README.md).

## Additional Resources

- **GitHub Repository**: [domenicodigangi/ScoreDrivenExponentialRandomGraphs](https://github.com/domenicodigangi/ScoreDrivenExponentialRandomGraphs)
- **Issues**: Report bugs or request features
- **Discussions**: Ask questions and share ideas
- **Paper**: Full methodology and applications

## Contributing

We welcome contributions! See [CONTRIBUTING.md](../CONTRIBUTING.md) for:
- How to report issues
- Development setup
- Coding guidelines
- Pull request process

## Support

Need help?
1. Check this documentation
2. Review [examples](../examples/)
3. Search [existing issues](https://github.com/domenicodigangi/ScoreDrivenExponentialRandomGraphs/issues)
4. Open a new issue with a minimal reproducible example

---

**Navigation**
- [← Back to Main README](../README.md)
- [Quick Start →](quickstart.md)
- [Installation →](installation.md)
