# Security Policy

## Reporting Security Vulnerabilities

If you discover a security vulnerability in this project, please follow responsible disclosure practices:

1. **DO NOT** open a public issue
2. Email the maintainer directly at the email listed in the project
3. Include:
   - Description of the vulnerability
   - Steps to reproduce
   - Potential impact
   - Suggested fix (if any)

We will respond within 48 hours and work with you to address the issue.

## Security Model

### Threat Model

This package is designed for **research and academic use** with the following assumptions:

- Users have trusted access to the system
- Input data comes from trusted sources
- The package runs in a controlled research environment
- R and Python integrations are considered trusted components

However, we implement defense-in-depth security measures to protect against:
- Command injection via R integration
- Path traversal attacks
- Code injection via dynamic evaluation
- Unsafe deserialization

### Security Boundaries

**Trusted:**
- Code in the repository
- Data from known research datasets
- R packages from CRAN (statnet, ergm)
- Python packages from PyPI (pandas, numpy)

**Untrusted:**
- User-provided ERGM formula strings
- File paths from external sources
- Deserialized data from unknown sources
- Network data from untrusted sources

## Security Features

### 1. Input Validation

**ERGM Formula Validation** (`src/Security.jl`):
- Whitelists allowed ERGM terms
- Blocks command injection patterns
- Validates formula syntax
- Prevents path traversal in parameters

```julia
using Security

# Safe usage
formula = validate_ergm_formula("edges + gwesp(decay=0.25, fixed=TRUE)")

# Blocked - would throw ArgumentError
try
    validate_ergm_formula("edges'); system('rm -rf /'); #")
catch e
    # Security violation detected
end
```

### 2. R Integration Security

**R Command Execution** (`src/ScoreDrivenERGM.jl/src/ErgmRcall.jl`):
- All R formula strings are validated before execution
- R environment isolation (per-session seed randomization)
- No direct `eval()` or `system()` calls from R
- Parameter binding instead of string interpolation where possible

**Security Measures:**
- Input validation before `reval()` calls
- Random seed per session (not fixed seed)
- Error handling to prevent information leakage

### 3. File Operations Security

**Path Handling** (`src/Security.jl`):
- Filename sanitization to prevent path traversal
- Removal of dangerous characters (..  / \\ : etc.)
- Absolute path resolution
- Length limits on filenames

```julia
using Security

# Safe file path construction
safe_path = safe_file_path("/data/output", user_filename)

# Filename sanitization
safe_name = sanitize_filename("../../etc/passwd")  # Returns "__etc_passwd"
```

### 4. Data Validation

**Numeric Input Validation**:
- Range checking to prevent overflow
- Finite value requirements
- Type validation

```julia
N = validate_numeric_input(100, 1, 10000, "network size")
```

## Known Security Considerations

### 1. R Code Execution (HIGH)

**Risk**: The package executes R code via RCall.jl

**Mitigation**:
- All ERGM formula strings are validated
- No direct user control over R code execution
- Limited to statnet/ergm package functions

**Residual Risk**: LOW
- R packages themselves could have vulnerabilities
- Updates to R packages should be reviewed

### 2. Deserialization (MEDIUM)

**Risk**: Julia's `deserialize()` can execute arbitrary code

**Usage**:
- Only in research scripts, not core library
- Used for trusted data files only

**Mitigation**:
- Users should only deserialize files they created
- Consider migrating to JLD2 (type-safe)

**Residual Risk**: MEDIUM
- Users must ensure file provenance

### 3. Python Integration (LOW)

**Risk**: PyCall executes Python code

**Usage**:
- Only for matplotlib plotting
- No dynamic code execution
- No user-controlled Python code

**Residual Risk**: LOW
- Standard library usage only

### 4. Development/Test Code (MEDIUM)

**Risk**: Test files use `eval(parse())` for dynamic variable creation

**Scope**:
- Only in `devUtils/` and test directories
- Not in production code paths

**Mitigation**:
- Clearly separated from production code
- Not called by end users

**Residual Risk**: LOW
- Confined to development environment

## Security Best Practices for Users

### 1. Data Provenance

✅ **DO:**
- Use data from trusted research sources
- Verify checksums of downloaded datasets
- Keep data files in project-controlled directories

❌ **DON'T:**
- Load `.jls` files from untrusted sources
- Deserialize data from unknown origins
- Use ERGM formulas from untrusted sources

### 2. ERGM Formula Strings

✅ **DO:**
- Use documented ERGM terms from statnet
- Validate formulas before use
- Keep formulas simple and reviewable

❌ **DON'T:**
- Copy-paste formulas from untrusted sources
- Use complex nested expressions without review
- Include special characters or shell metacharacters

### 3. File Operations

✅ **DO:**
- Use DrWatson's `datadir()`, `projectdir()` functions
- Validate file paths before operations
- Use relative paths within the project

❌ **DON'T:**
- Use absolute paths from user input
- Concatenate user input into file paths
- Use `..` for path traversal

### 4. R and Python Integration

✅ **DO:**
- Keep R and Python packages updated
- Use official CRAN and PyPI packages
- Review R code before execution

❌ **DON'T:**
- Install untrusted R/Python packages
- Modify R integration code without security review
- Pass unsanitized user input to R/Python

## Security Updates

### Version History

**2024-11-23: Security Hardening**
- Added comprehensive input validation for ERGM formulas
- Implemented `Security` module with validation functions
- Fixed R command injection vulnerability in `ErgmRcall.jl`
- Changed R seed from fixed (0) to random
- Added security documentation

**Known Issues Addressed:**
- ✅ R command injection via formula strings (CRITICAL)
- ✅ Fixed seed in R environment (MEDIUM)
- ⚠️  `eval(parse())` in test code (MEDIUM - isolated)
- ⚠️  Unsafe deserialization in research scripts (MEDIUM - documented)

## Security Checklist for Contributors

Before submitting code that:

### Interacts with R
- [ ] All R formula strings are validated with `validate_ergm_formula()`
- [ ] No string concatenation of user input into R code
- [ ] No direct `system()` or `eval()` calls in R
- [ ] Error messages don't reveal sensitive information

### Reads/Writes Files
- [ ] File paths are sanitized with `sanitize_filename()`
- [ ] No path traversal possibilities
- [ ] File permissions are checked
- [ ] No hardcoded absolute paths

### Accepts User Input
- [ ] Input is validated and range-checked
- [ ] No direct use in shell commands
- [ ] No use in `eval()` or `Meta.parse()`
- [ ] Appropriate error messages

### Uses External Code
- [ ] Python/R code is from trusted sources
- [ ] Versions are pinned or constrained
- [ ] No dynamic code loading from files
- [ ] No `eval()` on external input

## Security Audit Logs

### 2024-11-23: Comprehensive Security Audit
- **Scope**: Full codebase review
- **Files Analyzed**: 135 Julia files, 3 Python files
- **Critical Issues Found**: 2
- **High Issues Found**: 1
- **Medium Issues Found**: 2
- **Status**: All critical and high issues addressed

See `IMPLEMENTATION_SUMMARY.md` for full audit report.

## Contact

For security concerns, contact the project maintainer:
- **GitHub**: [@domenicodigangi](https://github.com/domenicodigangi)

## Acknowledgments

Security improvements made with assistance from Claude (Anthropic) during codebase finalization in November 2024.

---

**Last Updated**: 2024-11-23
**Security Policy Version**: 1.0
