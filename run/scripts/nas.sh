#!/bin/bash
# Experiment Runner for Graph Distillation Methods
# Usage: ./run_experiments.sh
for method in gdem; do
  for dataset in flickr dblp pubmed citeseer; do
    case $dataset in
      cora)
        for r in 0.5 0.25 1; do
          python ../run_nas.py -M $method -D $dataset -R $r 
        done
        ;;
      dblp)
        for r in 0.001; do
          python ../run_nas.py -M $method -D $dataset -R $r 
        done
        ;;
      amazon)
        for r in 0.005 0.01 0.02; do
          python ../run_nas.py -M $method -D $dataset -R $r 
        done
        ;;
      yelp)
        for r in 0.001 0.005 0.01; do
          python ../run_nas.py -M $method -D $dataset -R $r 
        done
        ;;
      pubmed)
        for r in 0.25 1 0.5; do
          python ../run_nas.py -M $method -D $dataset -R $r 
        done
        ;;
      citeseer)
        for r in 0.25; do
          python ../run_nas.py -M $method -D $dataset -R $r
        done
        ;;
      ogbn-arxiv)
        for r in 0.001 0.005 0.01; do
          python ../run_nas.py -M $method -D $dataset -R $r
        done
        ;;
      flickr)
        for r in 0.005; do
          python ../run_nas.py -M $method -D $dataset -R $r
        done
        ;;
      reddit)
        for r in 0.0005 0.001 0.002; do
          python ../run_nas.py -M $method -D $dataset -R $r
        done
        ;;
    esac
  done
done

