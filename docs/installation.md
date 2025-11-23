# Installation Guide

This guide provides detailed instructions for installing and setting up the Score-Driven ERGM package.

## Prerequisites

### Required Software

1. **Julia** (version 1.6 or later)
   - Download from: https://julialang.org/downloads/
   - Installation guides: https://julialang.org/downloads/platform/

2. **Git** (for cloning the repository)
   - Download from: https://git-scm.com/downloads

### Optional Software

3. **R** (version 4.0 or later) - Required for certain analyses
   - Download from: https://www.r-project.org/
   - Required R packages: `statnet`, `ergm`

   Install in R with:
   ```r
   install.packages(c("statnet", "ergm"))
   ```

4. **Python** (version 3.7 or later) - Required for data preprocessing
   - Download from: https://www.python.org/downloads/
   - Required packages: `pandas`, `numpy`

   Install with pip:
   ```bash
   pip install pandas numpy
   ```

## Installation Steps

### 1. Clone the Repository

```bash
git clone --recursive https://github.com/domenicodigangi/ScoreDrivenExponentialRandomGraphs.git
cd ScoreDrivenExponentialRandomGraphs
```

**Important**: Use the `--recursive` flag to automatically initialize submodules.

If you already cloned without `--recursive`, initialize submodules:

```bash
git submodule update --init --recursive
```

### 2. Install Julia Dependencies

Open Julia in the project directory:

```bash
julia --project=.
```

In the Julia REPL:

```julia
using Pkg
Pkg.instantiate()
```

This will install all required Julia packages listed in `Project.toml`.

### 3. Verify Installation

Test that everything is working:

```julia
using DrWatson
@quickactivate "ScoreDrivenExponentialRandomGraphs"

using ScoreDrivenERGM
using ProjUtilities

println("✓ Installation successful!")
```

### 4. Run Tests (Optional but Recommended)

```julia
Pkg.test()
```

Or from the command line:

```bash
julia --project=. test/runtests.jl
```

## Platform-Specific Notes

### Windows

- Ensure Git is in your PATH
- If using RCall, R must be properly installed and in PATH
- Consider using Windows Subsystem for Linux (WSL) for better compatibility

### macOS

- Xcode Command Line Tools may be required:
  ```bash
  xcode-select --install
  ```
- If using Homebrew, install R with: `brew install r`

### Linux

- Install build essentials if not already installed:
  ```bash
  sudo apt-get install build-essential  # Ubuntu/Debian
  sudo yum groupinstall "Development Tools"  # CentOS/RHEL
  ```

## Configuration

### Setting Up R Integration

If you plan to use R integration (for comparison with statnet):

1. Install R and the statnet package (see Prerequisites)

2. Configure RCall.jl:
   ```julia
   using Pkg
   ENV["R_HOME"] = "path/to/R"  # e.g., "/usr/lib/R" on Linux
   Pkg.build("RCall")
   ```

3. Test R integration:
   ```julia
   using RCall
   R"library(statnet)"
   ```

### Setting Up Python Integration

If you plan to use Python data preprocessing:

1. Install Python and required packages (see Prerequisites)

2. Configure PyCall.jl:
   ```julia
   using Pkg
   ENV["PYTHON"] = "path/to/python"  # or use Conda.jl
   Pkg.build("PyCall")
   ```

## Troubleshooting

### Submodule Not Initialized

**Problem**: `src/ScoreDrivenERGM.jl/` directory is empty

**Solution**:
```bash
git submodule update --init --recursive
```

### Package Installation Fails

**Problem**: `Pkg.instantiate()` fails with errors

**Solution**:
1. Update Julia to the latest version
2. Try:
   ```julia
   using Pkg
   Pkg.update()
   Pkg.resolve()
   Pkg.instantiate()
   ```

### RCall Configuration Issues

**Problem**: RCall.jl cannot find R

**Solution**:
1. Ensure R is installed and in PATH
2. Set R_HOME explicitly:
   ```julia
   ENV["R_HOME"] = "/path/to/R"
   using Pkg
   Pkg.build("RCall")
   ```

### PyCall Configuration Issues

**Problem**: PyCall.jl cannot find Python

**Solution**:
1. Use Conda.jl for automatic management:
   ```julia
   using Pkg
   Pkg.add("Conda")
   using Conda
   Conda.add("numpy")
   Conda.add("pandas")
   Pkg.build("PyCall")
   ```

## Updating

To update to the latest version:

```bash
git pull origin main
git submodule update --init --recursive
```

Then in Julia:

```julia
using Pkg
Pkg.instantiate()
Pkg.update()
```

## Uninstalling

To remove the package:

```bash
cd ..
rm -rf ScoreDrivenExponentialRandomGraphs
```

To also remove Julia packages (optional):

```julia
using Pkg
Pkg.rm("ScoreDrivenERGM")
# Remove other packages as needed
```

## Getting Help

If you encounter issues not covered here:

1. Check the [main README](../README.md)
2. Review [existing issues](https://github.com/domenicodigangi/ScoreDrivenExponentialRandomGraphs/issues)
3. Open a new issue with:
   - Your operating system
   - Julia version
   - Error messages
   - Steps to reproduce

## Next Steps

After successful installation:

1. Review the [examples](../examples/) directory
2. Read the [paper](https://papers.ssrn.com/sol3/papers.cfm?abstract_id=3394593)
3. Try running the [US Senate application](../scripts/simulationsAndPlotsPaper/US_senate_application/)
4. Check [CONTRIBUTING.md](../CONTRIBUTING.md) if you want to contribute
