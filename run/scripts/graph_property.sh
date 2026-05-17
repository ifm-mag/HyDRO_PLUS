#!/bin/bash
# Experiment Runner for Graph Distillation Methods
# Usage: ./run_experiments.sh
for dataset in citeseer cora flickr pubmed dblp; do
    python ../graph_property.py -D $dataset -W
done