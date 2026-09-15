#!/bin/bash

# Ensure script locates hw1 root directory regardless of current working directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
MARKER_DIR="$SCRIPT_DIR/markers"
MARKER_FILE="$MARKER_DIR/marker.txt"

# 1. Reject if not exactly one argument
if [ "$#" -ne 1 ]; then
    echo "Error: Exactly one argument required." >&2
    exit 1
fi

# 2. Reject all arguments except "course-marker"
if [ "$1" != "course-marker" ]; then
    echo "Error: Invalid argument '$1'. Only 'course-marker' is allowed." >&2
    exit 1
fi

# 3. Create hw1/markers/marker.txt safely
mkdir -p "$MARKER_DIR"
echo "MARKER_CREATED_$(date -u +'%Y-%m-%dT%H:%M:%SZ')" > "$MARKER_FILE"
echo "Marker successfully created at $MARKER_FILE"
exit 0
