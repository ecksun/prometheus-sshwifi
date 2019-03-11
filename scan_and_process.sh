#!/bin/bash

workdir="${RUNTIME_DIRECTORY:-/run/prometheus-sshwifi}/$(date --iso-8601=s)"
mkdir -p metrics
"$(dirname "$0")/scan.sh" "$workdir"
"$(dirname "$0")/process.sh" "$workdir" > metrics/assicated_aps.prom
