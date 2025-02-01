#!/bin/bash

# Copy Dockerfile to current directory
cp "../Dockerfile" ./Dockerfile

files_to_scan=("Dockerfile")
echo "Files to scan: ${files_to_scan[*]}"

for file in "${files_to_scan[@]}"; do
    echo "Scanning file: $file"
    docker run --rm \
      -v "$(pwd)":/rego-policies-opaconftest \
      openpolicyagent/conftest test "$file" \
      --policy rego-policies-opaconftest/opa-docker-security.rego
done

# Clean up
rm ./Dockerfile