#!/usr/bin/env bats

load 'test_helper'

readonly ARGPARSE='./argparse-plain'

@test "invalid option" {
  run "${ARGPARSE}" --invalid
  [ "$status" -eq 1 ]
  [ "${lines[0]}" = "Invalid option: --invalid" ]
  contains_string "${lines[1]}" "usage"
}

@test "mix invalid option" {
  run "${ARGPARSE}" --option-a -invalid
  [ "$status" -eq 1 ]
  contains_string "$output" "Invalid option: -invalid"
}

@test "single long option without value" {
  run "${ARGPARSE}" --option-a
  [ "$status" -eq 0 ]
  contains_string "$output" "option-a: activated"
}

@test "single short option without value" {
  run "${ARGPARSE}" -a
  [ "$status" -eq 0 ]
  contains_string "$output" "option-a: activated"
}

@test "single long option with value" {
  run "${ARGPARSE}" --option-b 'b-value'
  [ "$status" -eq 0 ]
  contains_string "$output" "option-b: b-value"
}

@test "single short option with value" {
  run "${ARGPARSE}" -b 'b-value'
  [ "$status" -eq 0 ]
  contains_string "$output" "option-b: b-value"
}

@test "multiple options" {
  run "${ARGPARSE}" -b 'b-value' --option-a
  [ "$status" -eq 0 ]
  contains_string "$output" "option-b: b-value"
  contains_string "$output" "option-a: activated"
}
