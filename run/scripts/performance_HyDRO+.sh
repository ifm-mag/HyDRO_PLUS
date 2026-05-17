#!/bin/bash
# Experiment Runner for Graph Distillation Methods
# Usage: ./run_experiments.sh
for method in hydro ; do
  for initial in algebraic_jaccard; do
    for dataset in computers; do
      case $dataset in
        photo) 
          for r in 0.05; do
            python ../train_all.py -M $method -D $dataset -R $r --setting trans --init $initial
          done
          ;;
        
        computers)
          for r in 0.02 ; do
            python ../train_all.py -M $method -D $dataset -R $r --setting trans --init $initial
          done
          ;;
        SCNn1)
          for r in 0.1; do
            python ../train_all.py -M $method -D $dataset -R $r --init $initial --setting trans
          done
          ;;
        SCNp)
          for r in 0.1; do
            python ../train_all.py -M $method -D $dataset -R $r --init $initial --setting trans
          done
          ;;
      esac
    done
  done
done
