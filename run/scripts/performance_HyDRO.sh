#!/bin/bash
# Experiment Runner for Graph Distillation Methods
# Usage: ./run_experiments.sh
for method in  hydro ; do
  for dataset in  cora citeseer flickr pubmed; do
    case $dataset in
      cora)
        for r in 0.5 0.25 1; do
          python ../train_all.py -M $method -D $dataset -R $r 
        done
        ;;
      dblp)
        for r in 0.001 0.005 0.01; do
          python ../train_all.py -M $method -D $dataset -R $r 
        done
        ;;
      amazon)
        for r in 0.005 0.01 0.02; do
          python ../train_all.py -M $method -D $dataset -R $r 
        done
        ;;
      yelp)
        for r in 0.001 0.005 0.01; do
          python ../train_all.py -M $method -D $dataset -R $r 
        done
        ;;
      pubmed)
        for r in 0.5 0.25 1; do
          python ../train_all.py -M $method -D $dataset -R $r 
        done
        ;;
      citeseer)
        for r in 0.5 0.25 1; do
          python ../train_all.py -M $method -D $dataset -R $r
        done
        ;;
      ogbn-arxiv)
        for r in 0.001 0.005 0.01; do
          python ../train_all.py -M $method -D $dataset -R $r
        done
        ;;
      flickr)
        for r in 0.001 0.005 0.01; do
          python ../train_all.py -M $method -D $dataset -R $r
        done
        ;;
      reddit)
        for r in 0.0005 0.001 0.002; do
          python ../train_all.py -M $method -D $dataset -R $r
        done
        ;;
    esac
  done
done

