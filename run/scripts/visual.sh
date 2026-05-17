#!/bin/bash
# Experiment Runner for Graph Distillation Methods
# Usage: ./run_experiments.sh

for method in hydro; do
  for dataset in photo; do
    python ../visual.py -D $dataset -M $method -R 0.01 -W
  done
done