#!/bin/bash
# Experiment Runner for Graph Distillation Methods
# Usage: ./run_experiments.sh

# Define methods and datasets to test
METHODS=("doscond" "gcond" "gcondx" "doscondx" "msgc" "sgdd" "gcsntk")
DATASETS=("yelp" "dblp" "cora" "amazon" "pubmed" "citeseer" "ogbn-arxiv" "flickr" "reddit")

# Base command
PYTHON_CMD="python ../run_eval_Link.py"

# Main experiment loop
for method in "${METHODS[@]}"; do
  for dataset in "${DATASETS[@]}"; do
    
    echo "Running experiments for method: $method on dataset: $dataset"
    
    case $dataset in
      cora|pubmed|citeseer)
        # Standard reduction rates for small datasets
        for r in 0.5 0.25 1; do
          echo "Running $method on $dataset with reduction rate $r"
          $PYTHON_CMD -M $method -D $dataset -R $r
        done
        ;;
        
      dblp|amazon|ogbn-arxiv|flickr)
        # Moderate reduction rates for medium datasets
        for r in 0.001 0.005 0.01; do
          echo "Running $method on $dataset with reduction rate $r"
          $PYTHON_CMD -M $method -D $dataset -R $r
        done
        ;;
        
      yelp)
        # Special case for Yelp
        for r in 0.01; do
          echo "Running $method on $dataset with reduction rate $r"
          $PYTHON_CMD -M $method -D $dataset -R $r
        done
        ;;
        
      reddit)
        # Very small reduction rates for large dataset
        for r in 0.0005 0.001 0.002; do
          echo "Running $method on $dataset with reduction rate $r"
          $PYTHON_CMD -M $method -D $dataset -R $r
        done
        ;;
    esac
    
  done
done

echo "All experiments completed!"