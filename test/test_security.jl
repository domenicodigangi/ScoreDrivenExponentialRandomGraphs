using Test
using DrWatson

@quickactivate "ScoreDrivenExponentialRandomGraphs"

# Load the Security module
include(projectdir("src", "Security.jl"))
using .Security

@testset "Security Module Tests" begin

    @testset "ERGM Formula Validation" begin

        @testset "Valid Formulas" begin
            # Basic formulas
            @test validate_ergm_formula("edges") == "edges"
            @test validate_ergm_formula("edges + mutual") == "edges + mutual"
            @test validate_ergm_formula("edges + gwesp(decay=0.25, fixed=TRUE)") == "edges + gwesp(decay=0.25, fixed=TRUE)"

            # Complex valid formulas
            @test validate_ergm_formula("edges + gwesp(decay=0.25, fixed=TRUE) + mutual") isa String
            @test validate_ergm_formula("edges + nodecov('age') + nodematch('gender')") isa String
            @test validate_ergm_formula("edges + triangle + twopath") isa String
        end

        @testset "Invalid Formulas - Command Injection" begin
            # Semicolon injection
            @test_throws ArgumentError validate_ergm_formula("edges; system('rm -rf /')")
            @test_throws ArgumentError validate_ergm_formula("edges'); system('whoami'); #")

            # Pipe injection
            @test_throws ArgumentError validate_ergm_formula("edges | cat /etc/passwd")
            @test_throws ArgumentError validate_ergm_formula("edges & malicious")

            # System calls
            @test_throws ArgumentError validate_ergm_formula("edges + system('ls')")
            @test_throws ArgumentError validate_ergm_formula("edges + eval('1+1')")

            # Backticks
            @test_throws ArgumentError validate_ergm_formula("edges + `rm file`")

            # Redirection
            @test_throws ArgumentError validate_ergm_formula("edges >> /tmp/output")
            @test_throws ArgumentError validate_ergm_formula("edges << EOF")

            # Command substitution
            @test_throws ArgumentError validate_ergm_formula("edges + \$(whoami)")
        end

        @testset "Invalid Formulas - Unknown Terms" begin
            @test_throws ArgumentError validate_ergm_formula("edges + unknownterm")
            @test_throws ArgumentError validate_ergm_formula("malicious_function()")
            @test_throws ArgumentError validate_ergm_formula("edges + not_a_real_ergm_term")
        end

        @testset "Invalid Formulas - Malformed" begin
            # Empty formula
            @test_throws ArgumentError validate_ergm_formula("")
            @test_throws ArgumentError validate_ergm_formula("   ")

            # Excessive length
            long_formula = repeat("edges + ", 100) * "edges"
            @test_throws ArgumentError validate_ergm_formula(long_formula)

            # Invalid characters
            @test_throws ArgumentError validate_ergm_formula("edges + @#\$%")
            @test_throws ArgumentError validate_ergm_formula("edges {malicious}")
        end

        @testset "Edge Cases" begin
            # With spaces
            @test validate_ergm_formula("  edges  + mutual  ") isa String

            # Numbers in parameters
            @test validate_ergm_formula("gwesp(decay=0.25, fixed=TRUE)") isa String
            @test validate_ergm_formula("degrange(1, 5)") isa String

            # Multiple parameters
            @test validate_ergm_formula("nodematch('attr', diff=TRUE)") isa String
        end
    end

    @testset "Filename Sanitization" begin

        @testset "Path Traversal Prevention" begin
            @test sanitize_filename("../../etc/passwd") == "__etc_passwd"
            @test sanitize_filename("../../../root") == "____root"
            @test !occursin("..", sanitize_filename("file..name"))
        end

        @testset "Dangerous Characters" begin
            @test !occursin("/", sanitize_filename("path/to/file"))
            @test !occursin("\\", sanitize_filename("path\\to\\file"))
            @test !occursin(":", sanitize_filename("C:\\Windows\\file"))
            @test !occursin("<", sanitize_filename("file<script>"))
            @test !occursin(">", sanitize_filename("file>output"))
            @test !occursin("|", sanitize_filename("file|pipe"))
            @test !occursin("*", sanitize_filename("file*.txt"))
            @test !occursin("?", sanitize_filename("file?.txt"))
            @test !occursin("\"", sanitize_filename("file\"quote.txt"))
        end

        @testset "Null Bytes" begin
            @test !occursin('\0', sanitize_filename("file\0name"))
        end

        @testset "Valid Filenames" begin
            @test sanitize_filename("file.txt") == "file.txt"
            @test sanitize_filename("my_file_123.csv") == "my_file_123.csv"
            @test sanitize_filename("data-2024.jld2") == "data-2024.jld2"
        end

        @testset "Empty Filename" begin
            @test sanitize_filename("") == "unnamed_file"
            @test sanitize_filename("...") == "_unnamed_file"  # All chars removed
        end

        @testset "Length Limits" begin
            long_name = repeat("a", 300)
            result = sanitize_filename(long_name)
            @test length(result) <= 255
        end
    end

    @testset "Numeric Input Validation" begin

        @testset "Valid Ranges" begin
            @test validate_numeric_input(50, 1, 100, "test") == 50
            @test validate_numeric_input(1, 1, 100, "test") == 1
            @test validate_numeric_input(100, 1, 100, "test") == 100
            @test validate_numeric_input(50.5, 1.0, 100.0, "test") == 50.5
        end

        @testset "Out of Range" begin
            @test_throws ArgumentError validate_numeric_input(0, 1, 100, "test")
            @test_throws ArgumentError validate_numeric_input(101, 1, 100, "test")
            @test_throws ArgumentError validate_numeric_input(-10, 1, 100, "test")
        end

        @testset "Non-Numeric Input" begin
            @test_throws ArgumentError validate_numeric_input("50", 1, 100, "test")
            @test_throws ArgumentError validate_numeric_input(nothing, 1, 100, "test")
            @test_throws ArgumentError validate_numeric_input(NaN, 1, 100, "test")
            @test_throws ArgumentError validate_numeric_input(Inf, 1, 100, "test")
            @test_throws ArgumentError validate_numeric_input(-Inf, 1, 100, "test")
        end
    end

    @testset "Safe File Path Construction" begin
        # Test that safe_file_path creates valid paths
        base = "/tmp/test"
        filename = "output.csv"
        path = safe_file_path(base, filename)
        @test occursin("output.csv", path)
        @test isabspath(path)

        # Test that dangerous filenames are sanitized
        dangerous = "../../etc/passwd"
        path = safe_file_path(base, dangerous)
        @test !occursin("..", path)
        @test !occursin("/etc/", path)
    end

end

@info "Security tests completed successfully!"
