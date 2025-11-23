# Test Suite

This directory contains the test suite for the ScoreDrivenExponentialRandomGraphs package.

## Running Tests

### Run All Tests

```julia
using Pkg
Pkg.activate(".")
Pkg.test()
```

Or from the command line:

```bash
julia --project=. test/runtests.jl
```

### Run Specific Test Files

```julia
include("test/test_security.jl")
include("test/test_data_loading.jl")
include("test/test_utilities.jl")
```

## Test Files

### `runtests.jl`
Main test entry point that orchestrates all tests. This is the file called by `Pkg.test()` and GitHub Actions CI.

**Tests:**
- Project structure validation
- Data directory existence
- Submodule loading
- Utility module availability
- Security tests (via inclusion)

### `test_security.jl`
Comprehensive security validation tests for the Security module.

**Test Coverage:**
- **ERGM Formula Validation** (30+ tests)
  - Valid formulas (basic and complex)
  - Command injection attempts (semicolons, pipes, system calls)
  - Unknown/malicious terms
  - Malformed formulas
  - Edge cases

- **Filename Sanitization** (15+ tests)
  - Path traversal prevention
  - Dangerous character removal
  - Null byte handling
  - Length limits

- **Numeric Input Validation** (10+ tests)
  - Valid ranges
  - Out of range values
  - Non-numeric inputs
  - Special values (NaN, Inf)

- **Safe File Path Construction** (5+ tests)
  - Path sanitization
  - Absolute path generation

**Total:** 60+ security test cases

### `test_data_loading.jl`
Tests for data loading functionality.

**Tests:**
- US Congress co-voting data
- College messaging data
- Wikipedia talk data

Note: Tests gracefully skip if data is not present.

### `test_utilities.jl`
Tests for utility modules.

**Tests:**
- ProjUtilities module loading
- Utility function availability

## Continuous Integration

Tests run automatically on GitHub Actions for:
- **Julia versions:** 1.6, 1.9, nightly
- **Operating systems:** Ubuntu, macOS, Windows
- **On:** Push to main/master, Pull requests

See `.github/workflows/CI.yml` for configuration.

## Test Requirements

### Dependencies
All test dependencies are specified in `Project.toml`:
- Test (standard library)
- DrWatson (project management)
- ScoreDrivenERGM (core library, from submodule)
- ProjUtilities (project utilities)

### Data
Tests check for the existence of data directories but don't require actual data files to run. Missing data results in warnings, not failures.

### Submodules
The `ScoreDrivenERGM.jl` submodule must be initialized:
```bash
git submodule update --init --recursive
```

## Adding New Tests

### Structure
Follow the existing pattern:

```julia
using Test
using DrWatson

@quickactivate "ScoreDrivenExponentialRandomGraphs"

# Your imports here

@testset "Your Test Suite Name" begin

    @testset "Specific Feature" begin
        # Your tests here
        @test condition
    end

end
```

### Best Practices
1. Use descriptive `@testset` names
2. Group related tests together
3. Use `@test_throws` for error conditions
4. Add `@warn` for skipped tests (e.g., missing data)
5. Keep tests fast and isolated
6. Don't assume test execution order

### Security Tests
When adding security-related tests:
1. Test both valid and invalid inputs
2. Cover edge cases
3. Test all dangerous input patterns
4. Verify error messages don't leak information
5. Include positive tests (valid inputs should work)

## Troubleshooting

### "Package not found" errors
```julia
using Pkg
Pkg.instantiate()  # Install all dependencies
```

### Submodule issues
```bash
git submodule update --init --recursive
```

### Test failures in CI
1. Check if tests pass locally first
2. Verify submodules are initialized (CI.yml includes this)
3. Check for platform-specific issues
4. Review CI logs on GitHub Actions tab

### Security test failures
Security tests are strict by design. If tests fail:
1. Verify the Security module is loadable
2. Check that validation functions work correctly
3. Don't modify tests to pass - fix the security issue

## Code Coverage

Coverage reports are generated for Julia 1.9 on Ubuntu and uploaded to Codecov.

View coverage at: https://codecov.io/gh/domenicodigangi/ScoreDrivenExponentialRandomGraphs

## Validation

To validate the test setup locally:

```bash
# Check YAML syntax
python3 -c "import yaml; yaml.safe_load(open('.github/workflows/CI.yml'))"

# Check test structure
test -f test/runtests.jl && echo "✓ runtests.jl exists"
test -f test/test_security.jl && echo "✓ test_security.jl exists"

# Verify submodules
test -d src/ScoreDrivenERGM.jl/src && echo "✓ Submodule initialized"
```

## Contributing

When contributing new features:
1. Add corresponding tests
2. Ensure all existing tests pass
3. Run tests locally before pushing
4. Add test documentation if introducing new test patterns

See `CONTRIBUTING.md` for full guidelines.

---

**Last Updated:** 2024-11-23
