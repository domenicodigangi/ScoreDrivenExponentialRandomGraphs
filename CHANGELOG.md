# Changelog

All notable changes to the Score-Driven Exponential Random Graphs project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Comprehensive test suite in `test/` directory
- GitHub Actions CI workflow for automated testing
- Examples directory with 5 tutorial files
- CONTRIBUTING.md with contribution guidelines
- Archive directory for old repository versions
- Improved README with installation instructions and project overview
- CI status badges in README

### Changed
- Updated Julia version compatibility from 1.5.3 to ≥1.6
- Replaced hard-coded Windows paths with cross-platform DrWatson functions
- Updated file headers to remove absolute path references
- Improved README documentation with better structure and examples

### Removed
- ENV["JULIA_DEBUG"] statements from production code
- Old repository version directories moved to archive/
- Hard-coded absolute Windows paths

### Fixed
- Cross-platform path compatibility issues
- Submodule initialization in documentation

## [2023-03-15] - Paper Revision Update

### Added
- Confidence interval analysis in `_research/analysis_for_paper_revision/conf_int_analysis/`
- College messaging network application
- Wikipedia talk network application
- Reddit network analysis
- Parametric bootstrap confidence bands
- White's robust standard errors implementation

### Changed
- Major codebase refactoring following paper revision
- Updated estimation methods
- Improved filtering algorithms
- Enhanced plotting functions

### Fixed
- Migration from JLD to JLD2 format
- Various bugs in filtering methods

## [2021-06-03] - US Senate Application

### Added
- US Senate co-voting network analysis
- Reciprocity p-star model comparisons
- Multiple simulation studies for paper
- AR(1) vs GAS model forecasting comparisons

### Changed
- Improved score-driven updating mechanism
- Enhanced visualization tools
- Better integration with R's statnet package

## [2020-11-xx] - Initial Release

### Added
- Core Score-Driven ERGM implementation
- Maximum Likelihood (MLE) estimation
- Pseudo-Maximum Likelihood (PMLE) estimation
- Filtering and smoothing for time-varying parameters
- Basic plotting utilities
- DrWatson integration for reproducibility
- Integration with R's ergm package via RCall

### Features
- Directed and undirected network models
- Binary network support
- Time-varying parameter estimation
- GAS (Generalized Autoregressive Score) framework
- Multiple network statistics (density, reciprocity, GWESP, etc.)

---

## Version History Notes

### Version Numbering
- Major version (X.0.0): Breaking API changes
- Minor version (0.X.0): New features, backward compatible
- Patch version (0.0.X): Bug fixes, backward compatible

### Categories
- **Added**: New features
- **Changed**: Changes in existing functionality
- **Deprecated**: Soon-to-be removed features
- **Removed**: Removed features
- **Fixed**: Bug fixes
- **Security**: Vulnerability fixes

### Repository History

This repository has undergone significant evolution:

1. **2019-2020**: Initial development and first paper submission
2. **2021**: Major revision following referee reports
3. **2023**: Additional applications and robustness analyses
4. **2024**: Code finalization, testing, and documentation improvements

For detailed commit history, see: https://github.com/domenicodigangi/ScoreDrivenExponentialRandomGraphs/commits/

---

## Related Projects

- **ScoreDrivenERGM.jl**: Core library (submodule)
- **Paper_SDERGM**: Paper LaTeX source (private submodule)

## Migration Notes

### From JLD to JLD2
If you have old data files saved with JLD format:
```julia
using JLD, JLD2
old_data = JLD.load("old_file.jld")
JLD2.save("new_file.jld2", old_data)
```

### From Julia 1.5 to 1.6+
Most code should work without changes. Key differences:
- Package loading may be faster
- Some deprecation warnings may appear
- Minor performance improvements in core operations

---

**Note**: This CHANGELOG was created during the 2024 code finalization. Earlier changes are documented retrospectively based on commit history and paper revision notes.
