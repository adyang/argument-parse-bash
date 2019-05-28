#!/usr/bin/env bats

load 'test_helper'

readonly ARGPARSE='./argparse-getopt'

@test "invalid option" {
  run "${ARGPARSE}" --invalid
  [ "$status" -eq 1 ]
  echo "${lines[0]}"
  contains_string "${lines[0]}" "unrecognized option \`--invalid"
  contains_string "${lines[1]}" "usage"
}

@test "mix invalid option" {
  run "${ARGPARSE}" --option-a -iav
  [ "$status" -eq 1 ]
  contains_string "$output" "invalid option -- i"
  contains_string "$output" "invalid option -- v"
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
  run "${ARGPARSE}" -b 'b-short-value'
  [ "$status" -eq 0 ]
  contains_string "$output" "option-b: b-short-value"
}

@test "single long option with optional value requires '=' sign" {
  run "${ARGPARSE}" --option-c='c-value' --option-c
  [ "$status" -eq 0 ]
  echo $output
  contains_string "$output" "option-c: c-value"
  contains_string "$output" "option-c: no-value"
}

@test "single short option with optional value must be written directly after the option" {
  run "${ARGPARSE}" -c -c'c-short-value'
  [ "$status" -eq 0 ]
  contains_string "$output" "option-c: no-value"
  contains_string "$output" "option-c: c-short-value"
}
@test "multiple options" {
  run "${ARGPARSE}" -b 'b-value' --option-a --option-c='c-value-long' -c'c-value-short'
  [ "$status" -eq 0 ]
  contains_string "$output" "option-b: b-value"
  contains_string "$output" "option-a: activated"
  contains_string "$output" "option-c: c-value-long"
  contains_string "$output" "option-c: c-value-short"
}

