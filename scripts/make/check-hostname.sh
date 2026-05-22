#!/bin/bash
# Returns 0 if current hostname is in the given file, 1 otherwise
# Usage: check-hostname.sh <hostnames_file>
set -euo pipefail

hostfile="${1:?Usage: check-hostname.sh <hostnames_file>}"

[ -f "$hostfile" ] && grep -qxF "$(hostname)" "$hostfile"
