#!/usr/bin/env bash

EXCLUDE=("$@")
if [ ${#EXCLUDE[@]} -eq 0 ]; then
    echo "Usage: $0 <input1> [input2...]"
    exit 1
fi

PATTERN=$(IFS='|'; echo "${EXCLUDE[*]}")
INPUTS=$(nix flake metadata --json | jq -r '.locks.nodes.root.inputs | keys[]' | grep -vE "$PATTERN")

if [ -n "$INPUTS" ]; then
    nix flake update $INPUTS
else
    echo "No inputs to update"
fi
