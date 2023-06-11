setup() {
    load 'test_helper/bats-support/load'
    load 'test_helper/bats-assert/load'

    # get the containing directory of this file
    # use $BATS_TEST_FILENAME instead of ${BASH_SOURCE[0]} or $0,
    # as those will point to the bats executable's location or the preprocessed file respectively
    DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )"
    # make executables in src/ visible to PATH
    PATH="$DIR/..:$PATH"
}

@test "addition" {
    run lua interpreter.lua tests/inputs/math_ops/add
    assert_output "5"
}

@test "substraction" {
    run lua interpreter.lua tests/inputs/math_ops/sub
    assert_output "-1"
}

@test "multiplication" {
    run lua interpreter.lua tests/inputs/math_ops/mul
    assert_output "6"
}

@test "division" {
    run lua interpreter.lua tests/inputs/math_ops/div
    assert_output "3.0"
}

@test "modulo" {
    run lua interpreter.lua tests/inputs/math_ops/mod
    assert_output "0"
}

@test "rpn evaluation" {
    run lua interpreter.lua tests/inputs/evals/re
    assert_output "3"
}

@test "dup" {
    run lua interpreter.lua tests/inputs/stackops/dup
    assert_output "3"
}

@test "drop" {
    run lua interpreter.lua tests/inputs/stackops/drop
    assert_output "3"
}

@test "over" {
    run lua interpreter.lua tests/inputs/stackops/over
    assert_output "2"
}

@test "swap" {
    run lua interpreter.lua tests/inputs/stackops/swap
    assert_output "2"
}

@test "tuck" {
    run lua interpreter.lua tests/inputs/stackops/tuck
    assert_output "3 2 3"
}

@test "rot" {
    run lua interpreter.lua tests/inputs/stackops/rot
    assert_output "3 1 2"
}

@test "minrot" {
    run lua interpreter.lua tests/inputs/stackops/minrot
    assert_output "1 2 3"
}