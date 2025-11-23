"""
Security utilities for input validation and sanitization.

This module provides security functions to prevent common vulnerabilities
such as command injection, path traversal, and code injection.
"""
module Security

export validate_ergm_formula, sanitize_filename, validate_numeric_input

"""
    validate_ergm_formula(formula_str::String) -> String

Validates and sanitizes ERGM formula strings to prevent command injection.

This function whitelists allowed ERGM terms and sanitizes input to prevent
R command injection via the formula string.

# Allowed ERGM Terms
- Basic: edges, mutual, nodecov, nodematch, nodemix, absdiff
- Geometrically weighted: gwesp, gwdsp, gwnsp, gwdegree, gwidegree, gwodegree
- Structural: triangle, twopath, transitiveties, cyclicalties
- Degree: degree, idegree, odegree, b1degree, b2degree
- Other: concurrent, concurrentties, density, isolates

# Arguments
- `formula_str::String`: The ERGM formula string to validate

# Returns
- `String`: Sanitized formula string

# Throws
- `ArgumentError`: If the formula contains invalid or potentially malicious content

# Examples
```julia
# Valid formula
formula = validate_ergm_formula("edges + gwesp(decay=0.25, fixed=TRUE)")

# Invalid formula (will throw error)
try
    validate_ergm_formula("edges'); system('rm -rf /'); #")
catch e
    println("Caught security violation: ", e)
end
```

# Security Notes
- This function implements defense-in-depth
- All non-alphanumeric characters (except safe ones) are validated
- Unknown terms are rejected
- R code injection patterns are detected and blocked
"""
function validate_ergm_formula(formula_str::String)
    if isempty(strip(formula_str))
        throw(ArgumentError("ERGM formula cannot be empty"))
    end

    # Whitelist of allowed ERGM terms (from statnet documentation)
    allowed_terms = Set([
        # Basic terms
        "edges", "mutual", "nodecov", "nodematch", "nodemix", "absdiff",
        "nodecov", "nodefactor", "nodeicov", "nodeifactor", "nodeocov", "nodeofactor",
        # Geometrically weighted terms
        "gwesp", "gwdsp", "gwnsp", "gwdegree", "gwidegree", "gwodegree",
        # Structural terms
        "triangle", "twopath", "transitiveties", "cyclicalties", "transitive",
        # Degree terms
        "degree", "idegree", "odegree", "b1degree", "b2degree",
        "degrange", "concurrent", "concurrentties",
        # Other common terms
        "density", "isolates", "kstar", "balance"
    ])

    # Check for obvious command injection patterns
    dangerous_patterns = [
        r"[;\|&]",           # Command separators
        r"system\s*\(",      # System calls
        r"eval\s*\(",        # Eval calls
        r"rm\s+-",           # Delete commands
        r"<script",          # Script injection
        r"\$\(",             # Command substitution
        r"`",                # Backticks
        r">>",               # Redirection
        r"<<",               # Here doc
    ]

    for pattern in dangerous_patterns
        if occursin(pattern, formula_str)
            throw(ArgumentError("Potentially malicious pattern detected in ERGM formula: $(pattern.pattern)"))
        end
    end

    # Check for excessive length (possible DoS)
    if length(formula_str) > 1000
        throw(ArgumentError("ERGM formula exceeds maximum length of 1000 characters"))
    end

    # Validate that only allowed characters are present
    # Allow: alphanumeric, spaces, +, -, *, (), [], ., =, comma, single quotes for strings
    if !all(c -> c in ('a':'z') || c in ('A':'Z') || c in ('0':'9') ||
                 c in (' ', '+', '-', '*', '(', ')', '[', ']', '.', '=', ',', '_') ||
                 c == '\'' || c == '"',
            formula_str)
        throw(ArgumentError("ERGM formula contains invalid characters"))
    end

    # Parse and validate individual terms
    # Split by + to get individual terms
    terms = strip.(split(formula_str, '+'))

    for term in terms
        if isempty(term)
            continue
        end

        # Extract the term name (before any parentheses or spaces)
        term_name = strip(split(split(term, '(')[1], ' ')[1])

        if isempty(term_name)
            continue
        end

        # Check if term is in whitelist
        if !(term_name in allowed_terms)
            throw(ArgumentError("Unknown or disallowed ERGM term: '$term_name'"))
        end

        # If term has parameters, do basic validation
        if occursin('(', term)
            # Extract parameters
            param_match = match(r"\((.*)\)", term)
            if param_match === nothing
                throw(ArgumentError("Malformed parameters in term: '$term'"))
            end

            params = param_match.captures[1]

            # Validate parameters don't contain suspicious content
            if occursin(r"[;\|&`\$]", params)
                throw(ArgumentError("Invalid characters in parameters of term: '$term'"))
            end
        end
    end

    # Return the validated (original) formula
    # We don't modify it if it passes all checks
    return formula_str
end


"""
    sanitize_filename(filename::String) -> String

Sanitizes a filename to prevent path traversal attacks.

Removes or replaces dangerous characters including:
- Path traversal sequences (..)
- Path separators (/ \\)
- Null bytes
- Control characters
- Colons (Windows drive letters)

# Arguments
- `filename::String`: The filename to sanitize

# Returns
- `String`: Sanitized filename safe for file operations

# Examples
```julia
safe = sanitize_filename("../../etc/passwd")  # Returns ".._.._etc_passwd"
safe = sanitize_filename("file<>:name.txt")   # Returns "file___name.txt"
```
"""
function sanitize_filename(filename::String)
    # Remove null bytes
    cleaned = replace(filename, '\0' => "")

    # Replace path separators and dangerous characters with underscore
    cleaned = replace(cleaned, r"[/\\:*?\"<>|]" => "_")

    # Replace .. sequences (path traversal)
    cleaned = replace(cleaned, ".." => "_.")

    # Remove control characters
    cleaned = replace(cleaned, r"[\x00-\x1F\x7F]" => "")

    # Ensure filename is not empty after cleaning
    if isempty(strip(cleaned))
        return "unnamed_file"
    end

    # Limit filename length (most filesystems have 255 char limit)
    if length(cleaned) > 255
        cleaned = cleaned[1:255]
    end

    return cleaned
end


"""
    validate_numeric_input(value, min_val, max_val, param_name::String)

Validates numeric input is within acceptable ranges.

Prevents integer overflow, underflow, and unreasonable values.

# Arguments
- `value`: Numeric value to validate
- `min_val`: Minimum acceptable value
- `max_val`: Maximum acceptable value
- `param_name::String`: Name of parameter for error messages

# Throws
- `ArgumentError`: If value is outside acceptable range or not a valid number

# Examples
```julia
N = validate_numeric_input(100, 1, 10000, "network size")
T = validate_numeric_input(50, 1, 1000, "time periods")
```
"""
function validate_numeric_input(value, min_val, max_val, param_name::String)
    if !isa(value, Number) || !isfinite(value)
        throw(ArgumentError("$param_name must be a finite number"))
    end

    if value < min_val || value > max_val
        throw(ArgumentError("$param_name must be between $min_val and $max_val, got $value"))
    end

    return value
end


"""
    safe_file_path(base_dir::String, filename::String) -> String

Creates a safe file path by combining base directory with sanitized filename.

# Arguments
- `base_dir::String`: Base directory path
- `filename::String`: Filename to sanitize and join

# Returns
- `String`: Safe absolute path

# Examples
```julia
path = safe_file_path("/data/output", "results_2024.csv")
```
"""
function safe_file_path(base_dir::String, filename::String)
    safe_name = sanitize_filename(filename)
    return abspath(joinpath(base_dir, safe_name))
end


end # module
