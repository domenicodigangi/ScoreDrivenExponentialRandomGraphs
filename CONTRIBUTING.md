# Contributing to Score-Driven Exponential Random Graphs

Thank you for your interest in contributing to the SDERGM project! This document provides guidelines for contributing to this repository.

## Code of Conduct

We are committed to providing a welcoming and inclusive environment for all contributors. Please be respectful and professional in all interactions.

## How to Contribute

### Reporting Issues

If you find a bug or have a suggestion for improvement:

1. **Search existing issues** to avoid duplicates
2. **Create a new issue** with:
   - A clear, descriptive title
   - Detailed description of the problem or suggestion
   - Steps to reproduce (for bugs)
   - Expected vs. actual behavior
   - Julia version and operating system
   - Minimal reproducible example when possible

### Submitting Changes

1. **Fork the repository** and create a feature branch
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make your changes**
   - Follow the coding style guidelines below
   - Add tests for new functionality
   - Update documentation as needed
   - Ensure all tests pass

3. **Commit your changes**
   - Use clear, descriptive commit messages
   - Reference related issues (e.g., "Fixes #123")

4. **Push to your fork**
   ```bash
   git push origin feature/your-feature-name
   ```

5. **Open a Pull Request**
   - Provide a clear description of the changes
   - Reference related issues
   - Ensure CI tests pass

## Development Setup

1. Clone the repository with submodules:
   ```bash
   git clone --recursive https://github.com/domenicodigangi/ScoreDrivenExponentialRandomGraphs.git
   cd ScoreDrivenExponentialRandomGraphs
   ```

2. Activate the project environment:
   ```julia
   using Pkg
   Pkg.activate(".")
   Pkg.instantiate()
   ```

3. Run tests:
   ```julia
   Pkg.test()
   ```

## Coding Style Guidelines

### Julia Code Style

- Follow [Julia style guidelines](https://docs.julialang.org/en/v1/manual/style-guide/)
- Use 4 spaces for indentation (no tabs)
- Maximum line length: 92 characters
- Use descriptive variable names
- Add docstrings for public functions
- Use type annotations where they improve clarity

### Naming Conventions

- **Functions**: `lowercase_with_underscores` or `camelCase` (be consistent within modules)
- **Types**: `CapitalizedCamelCase`
- **Constants**: `UPPERCASE_WITH_UNDERSCORES`
- **Private functions**: Prefix with `_` (e.g., `_internal_function`)

### Documentation

- Add docstrings to all exported functions
- Use Julia's docstring format:
  ```julia
  """
      function_name(arg1, arg2)

  Brief description of what the function does.

  # Arguments
  - `arg1`: Description of arg1
  - `arg2`: Description of arg2

  # Returns
  - Description of return value

  # Examples
  ```julia
  result = function_name(1, 2)
  ```
  """
  ```

### Testing

- Write tests for new functionality in the `test/` directory
- Use the `Test` standard library
- Aim for high code coverage
- Test edge cases and error conditions

### Git Workflow

- Keep commits focused and atomic
- Write clear commit messages:
  ```
  Short (50 chars or less) summary

  More detailed explanatory text, if necessary. Wrap it to
  about 72 characters. The blank line separating the summary
  from the body is critical.
  ```

- Commit message prefixes:
  - `feat:` New feature
  - `fix:` Bug fix
  - `docs:` Documentation changes
  - `test:` Adding or updating tests
  - `refactor:` Code refactoring
  - `perf:` Performance improvements
  - `chore:` Maintenance tasks

## Project Structure

```
ScoreDrivenExponentialRandomGraphs/
├── src/                    # Source code
│   ├── ScoreDrivenERGM.jl/ # Core library (submodule)
│   └── ProjUtilities/      # Utility modules
├── scripts/                # Analysis scripts
├── data/                   # Data files
├── test/                   # Test suite
├── examples/               # Usage examples
├── _research/              # Research scripts (experimental)
└── archive/                # Historical code (not maintained)
```

## Areas for Contribution

We welcome contributions in the following areas:

### High Priority

- **Testing**: Expand test coverage
- **Documentation**: Improve API documentation and tutorials
- **Examples**: Add more usage examples
- **Bug fixes**: Address reported issues

### Medium Priority

- **Performance optimization**: Profile and optimize hot paths
- **Cross-platform support**: Test and fix platform-specific issues
- **Code refactoring**: Reduce duplication and improve organization
- **New features**: After discussion in issues

### Low Priority

- **Visualization improvements**: Better plotting utilities
- **Extended functionality**: Support for new network types
- **Benchmarking**: Performance comparisons with other methods

## Code Review Process

1. All contributions require review before merging
2. Reviewer will check:
   - Code quality and style
   - Test coverage
   - Documentation completeness
   - Compatibility with existing code
3. Address reviewer feedback
4. Once approved, maintainer will merge

## Questions?

If you have questions about contributing:

- Open an issue with the `question` label
- Check existing documentation
- Review closed issues and PRs for similar discussions

## Recognition

Contributors will be acknowledged in:
- GitHub contributors list
- CHANGELOG for significant contributions
- Documentation credits (for major features)

## License

By contributing to this project, you agree that your contributions will be licensed under the MIT License.

---

Thank you for contributing to Score-Driven ERGM!
