# Score-Driven Exponential Random Graphs (SDERGM)

[![CI](https://github.com/domenicodigangi/ScoreDrivenExponentialRandomGraphs/actions/workflows/CI.yml/badge.svg)](https://github.com/domenicodigangi/ScoreDrivenExponentialRandomGraphs/actions/workflows/CI.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A Julia implementation of Score-Driven Exponential Random Graph Models for time-varying network analysis.

## Overview

This repository contains the complete codebase for the paper:

**"Score-Driven Exponential Random Graphs: A New Class of Time-Varying Parameter Models for Dynamical Networks"**
📄 [Available on SSRN](https://papers.ssrn.com/sol3/papers.cfm?abstract_id=3394593)

Score-Driven ERGMs extend traditional Exponential Random Graph Models by allowing parameters to evolve over time following a score-driven updating mechanism. This approach provides a flexible framework for modeling dynamic network data while maintaining computational tractability.

## Features

- **Time-varying parameter estimation** for network models
- **Multiple estimation methods**: Maximum Likelihood (MLE) and Pseudo-Maximum Likelihood (PMLE)
- **Filtering and forecasting** for network dynamics
- **Confidence interval estimation** using parametric bootstrap and White estimators
- **Integration with R's statnet/ergm** for comprehensive network analysis
- **Three empirical applications**: US Senate co-voting, college messaging, and Wikipedia talk networks

## Installation

### Prerequisites

- **Julia** ≥ 1.6 ([download here](https://julialang.org/downloads/))
- **R** with the `statnet` package (for certain analyses)
- **Git** (for cloning the repository)

### Setup

1. Clone the repository with submodules:

```bash
git clone --recursive https://github.com/domenicodigangi/ScoreDrivenExponentialRandomGraphs.git
cd ScoreDrivenExponentialRandomGraphs
```

If you already cloned without submodules, initialize them:

```bash
git submodule update --init --recursive
```

2. Install Julia dependencies:

```julia
using Pkg
Pkg.activate(".")
Pkg.instantiate()
```

3. (Optional) For R integration, install statnet:

```r
install.packages("statnet")
```

## Quick Start

```julia
using DrWatson
@quickactivate "ScoreDrivenExponentialRandomGraphs"

using ScoreDrivenERGM

# Load example data
# ... (see examples/ directory for detailed tutorials)
```

## Project Structure

```
ScoreDrivenExponentialRandomGraphs/
├── src/
│   ├── ScoreDrivenERGM.jl/     # Core library (submodule)
│   └── ProjUtilities/           # Project utilities
├── scripts/
│   ├── dataCode/                # Data processing scripts
│   │   ├── cleanData/          # Data cleaning
│   │   ├── dataAnalysis/       # Analysis scripts
│   │   └── estimateModels/     # Model estimation
│   └── simulationsAndPlotsPaper/ # Paper simulations
│       ├── US_senate_application/
│       └── reciprocity_p_star/
├── data/
│   ├── US_congr_covoting/      # US Congressional co-voting networks
│   ├── collegeMsg/              # College messaging data (SNAP)
│   └── wiki_tk/                 # Wikipedia talk network (SNAP)
├── test/                        # Test suite
├── examples/                    # Usage examples and tutorials
├── archive/                     # Historical code (not maintained)
└── _research/                   # Research analysis scripts

```

## Empirical Applications

### 1. US Senate Co-voting Network

Analysis of voting patterns in the US Senate, demonstrating how political networks evolve over time.

**Scripts**: `scripts/simulationsAndPlotsPaper/US_senate_application/`

### 2. College Messaging Network

Study of communication patterns in a college messaging system using SNAP dataset.

**Data**: `data/collegeMsg/`

### 3. Wikipedia Talk Network

Temporal analysis of editor interactions on Wikipedia talk pages.

**Data**: `data/wiki_tk/`

## Documentation

- **Examples**: See the `examples/` directory for tutorials and usage demonstrations
- **API Documentation**: Core functionality is documented in the `ScoreDrivenERGM.jl` submodule
- **Paper**: Full methodological details available in the [SSRN paper](https://papers.ssrn.com/sol3/papers.cfm?abstract_id=3394593)

## Running Tests

```julia
using Pkg
Pkg.test("ScoreDrivenExponentialRandomGraphs")
```

Or from the command line:

```bash
julia --project=. test/runtests.jl
```

## Reproducibility

This project uses [DrWatson.jl](https://github.com/JuliaDynamics/DrWatson.jl) for reproducible scientific workflows. All data paths, simulation parameters, and results are managed through DrWatson's conventions.

To reproduce paper results:

1. Follow the installation instructions above
2. Navigate to the relevant application directory in `scripts/simulationsAndPlotsPaper/`
3. Run scripts in numerical order (e.g., `1_estimate_models.jl`, `2_load_estimates_and_plot.jl`)

## Citation

If you use this code in your research, please cite:

```bibtex
@article{digangi2023score,
  title={Score-Driven Exponential Random Graphs: A New Class of Time-Varying Parameter Models for Dynamical Networks},
  author={Di Gangi, Domenico},
  journal={Available at SSRN 3394593},
  year={2023}
}
```

## Dependencies and Acknowledgments

This project builds upon several key libraries:

- **[statnet](http://statnet.org)** for static ERGM estimation and comparison:
  ```
  Statnet Development Team (Pavel N. Krivitsky, Mark S. Handcock, David R. Hunter,
  Carter T. Butts, Chad Klumb, Steven M. Goodreau, and Martina Morris) (2003-2020).
  statnet: Software tools for the Statistical Modeling of Network Data.
  ```

- **[DrWatson.jl](https://github.com/JuliaDynamics/DrWatson.jl)** for reproducible scientific workflows

See `Project.toml` for a complete list of Julia package dependencies.

## Data Sources

- **US Congressional Data**: Congressional voting records
- **College Messaging**: [SNAP Stanford Network Analysis Project](http://snap.stanford.edu/)
- **Wikipedia Talk**: [SNAP Stanford Network Analysis Project](http://snap.stanford.edu/)

**Note**: eMid financial network data used in some analyses is proprietary and not included in this repository.

## Contributing

Contributions are welcome! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contact

**Domenico Di Gangi**
- GitHub: [@domenicodigangi](https://github.com/domenicodigangi)

## Submodules

This repository includes the following submodules:

- `src/ScoreDrivenERGM.jl`: Core SDERGM library
- `papers/Paper_SDERGM`: LaTeX source for the paper (private repository, requires authentication)

To update submodules to their latest versions:

```bash
git submodule update --remote
```

## Version History

See [CHANGELOG.md](CHANGELOG.md) for detailed version history and changes.

---

**Status**: This codebase has been updated and improved following the paper revision. All core functionality is stable and tested.
