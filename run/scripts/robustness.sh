#!/bin/bash
# Experiment Runner for Graph Distillation Methods
# Usage: ./run_experiments.sh
for method in hydro; do
  for dataset in pubmed flickr; do
    for attack in metattack random_adj random_feat; do
      case $dataset in
      cora)
        for r in 0.25 0.5 1; do
          python ../train_all.py -M $method -D $dataset -R $r -A $attack -P 0.5 
        done
        ;;
      dblp)
        for r in 0.001 0.005 0.01; do
          python ../train_all.py -M $method -D $dataset -R $r -A $attack -P 0.5
        done
        ;;
      amazon)
        for r in 0.005 0.01 0.02; do
          python ../train_all.py -M $method -D $dataset -R $r -A $attack -P 0.5
        done
        ;;
      yelp)
        for r in 0.001 0.005 0.01; do
          python ../train_all.py -M $method -D $dataset -R $r -A $attack -P 0.5
        done
        ;;
      pubmed)
        for r in 1; do
          python ../train_all.py -M $method -D $dataset -R $r -A $attack -P 0.5 
        done
        ;;
      citeseer)
        for r in 0.5 0.25 1; do
          python ../train_all.py -M $method -D $dataset -R $r -A $attack -P 0.5
        done
        ;;
      ogbn-arxiv)
        for r in 0.001 0.005 0.01; do
          python ../train_all.py -M $method -D $dataset -R $r -A $attack -P 0.5
        done
        ;;
      flickr)
        for r in 0.005; do
          python ../train_all.py -M $method -D $dataset -R $r -A $attack -P 0.5
        done
        ;;
      reddit)
        for r in 0.0005 0.001 0.002; do
          python ../train_all.py -M $method -D $dataset -R $r -A $attack -P 0.5 
        done
        ;;
      esac
  
    done
  done
done
