#!/bin/bash

contains_string() {
  local target="$1"
  local substring="$2"
  case "${target}" in *"${substring}"*);; *) false;; esac
}
