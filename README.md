<div align="center">

# HyDRO+: Efficient and Privacy-Preserved Link Prediction via Condensed Graphs

[![Published in ESWA](https://img.shields.io/badge/Expert%20Systems%20with%20Applications-Elsevier-orange.svg)](https://doi.org/10.1016/j.eswa.2025.128937)
[![DOI](https://img.shields.io/badge/DOI-10.1016%2Fj.eswa.2025.128937-blue.svg)](https://doi.org/10.1016/j.eswa.2025.128937)
[![arXiv (HyDRO)](https://img.shields.io/badge/arXiv-2501.15696-b31b1b.svg)](https://arxiv.org/abs/2501.15696)
[![arXiv (HyDRO+)](https://img.shields.io/badge/arXiv-2503.12156-b31b1b.svg)](https://arxiv.org/abs/2503.12156)
[![Python](https://img.shields.io/badge/python-3.10%20%7C%203.11-blue.svg)](https://www.python.org/)
[![PyTorch](https://img.shields.io/badge/pytorch-2.2-ee4c2c.svg)](https://pytorch.org/)
[![CUDA](https://img.shields.io/badge/cuda-12.1-76b900.svg)](https://developer.nvidia.com/cuda-toolkit)
[![License: MIT](https://img.shields.io/badge/license-MIT-yellow.svg)](LICENSE)

</div>

> **News — Jan 15, 2026.** HyDRO+ is published as an **Open Access** article in [*Expert Systems with Applications*](https://doi.org/10.1016/j.eswa.2025.128937) (Elsevier), Volume 296, Part A, Article 128937. *"Efficient and Privacy-Preserved Link Prediction via Condensed Graphs"* — Yunbo Long, Liming Xu, Alexandra Brintrup. Released under a Creative Commons license. [`DOI: 10.1016/j.eswa.2025.128937`](https://doi.org/10.1016/j.eswa.2025.128937)

<p align="center">
  <img src="images/hydro_plus.png" alt="HyDRO+ workflow" width="820"/>
</p>

## Overview

**HyDRO+** is a graph distillation framework that condenses large graphs into compact synthetic graphs while preserving downstream task performance and privacy. It extends [HyDRO](https://github.com/Yunbo-max/HyDRO) — *Random Walk Guided Hyperbolic Graph Distillation* — with algorithmic and mathematical improvements aimed at **link prediction** and **anomaly detection**, and is built on top of the [GraphSlim](https://github.com/Emory-Melody/GraphSlim) framework.

**Highlights**
- Hyperbolic distillation of graph structure with random-walk guidance.
- Privacy-preserving link prediction over condensed graphs.
- Task transferability across node classification, link prediction, and anomaly detection.
- Drop-in replacement for GraphSlim's evaluation pipelines (NC / LP / AD / NAS / robustness / MIA).

## Installation

Tested on **Ubuntu 22.04**, **Python 3.10/3.11**, **CUDA 12.1** (the wheels also work on CUDA 12.4 driver thanks to forward compatibility).

```bash
git clone https://github.com/ifm-mag/HyDRO_PLUS.git
cd HyDRO_PLUS
bash install.sh
```

`install.sh` installs, in order: PyTorch (CUDA 12.1) → PyG extensions (`torch_scatter`, `torch_sparse`) → DGL (CUDA 12.1) → the remaining Python dependencies in [`graphslim/requirements.txt`](graphslim/requirements.txt). It finishes with an environment check.

> **Do not** run `pip install graphslim` from PyPI — this repository ships its own `graphslim/` package containing the HyDRO method implementation; the PyPI release does not.

### Verify

```bash
python -c "import torch; print(torch.__version__, torch.cuda.is_available())"
```

## Quick Start

Run HyDRO distillation on Cora (the dataset auto-downloads on first run):

```bash
cd run/scripts
bash performance_HyDRO.sh
```

Or, a single run with custom arguments:

```bash
cd run
python train_all.py -M hydro -D cora -R 0.5 --setting trans
```

| Flag | Meaning | Example |
|------|---------|---------|
| `-M, --method`         | distillation method        | `hydro`, `gcond`, `sgdd`, `gcondx`, … |
| `-D, --dataset`        | dataset                    | `cora`, `citeseer`, `pubmed`, `flickr`, `reddit`, `ogbn-arxiv` |
| `-R, --reduction_rate` | target compression rate    | `0.5`, `0.25`, `0.01` |
| `--setting`            | learning setting           | `trans` (transductive), `ind` (inductive) |
| `-G, --gpu_id`         | GPU id (`-1` for CPU)      | `0` |

## Experiments

All experiment driver scripts live under [`run/scripts/`](run/scripts).

### Core distillation
| Script | Description |
|--------|-------------|
| `performance_HyDRO.sh`  | HyDRO on node-classification benchmarks |
| `performance_HyDRO+.sh` | HyDRO+ on node-classification benchmarks |

### Task transferability
| Script | Description |
|--------|-------------|
| `performance_LP.sh` | Distillation performance on link prediction |
| `performance_AD.sh` | Distillation performance on anomaly detection |

### Analysis
| Script | Description |
|--------|-------------|
| `nas.sh`            | Neural architecture search on condensed graphs |
| `robustness.sh`     | Robustness under graph attacks |
| `mia_nodes.sh`      | Membership inference attack — nodes |
| `mia_links.sh`      | Membership inference attack — links |
| `graph_property.sh` | Graph-property preservation |
| `visual.sh`         | Condensation visualization |

Continual graph-learning evaluation follows the [GCondenser](https://github.com/superallen13/GCondenser) protocol.

## Repository Structure

```
HyDRO_PLUS/
├── graphslim/                # Core framework (forked from GraphSlim)
│   ├── condensation/         # Distillation methods (HyDRO, GCond, SGDD, GDEM, SimGC, ...)
│   ├── coarsening/           # Graph coarsening baselines
│   ├── sparsification/       # Sparsification baselines
│   ├── dataset/              # Loaders (PyG, OGB, DGL)
│   ├── evaluation/           # Evaluators (NC / LP / AD / NAS)
│   ├── models/               # GNN architectures (incl. HNN)
│   ├── configs/              # Per-method hyperparameter configs
│   ├── config.py             # CLI definition
│   └── requirements.txt
├── run/
│   ├── train_all.py          # Main entrypoint
│   ├── run_nas.py            # NAS evaluation
│   ├── run_cross_arch.py     # Cross-architecture evaluation
│   ├── run_eval_Link.py      # Link-prediction evaluation
│   └── scripts/              # Bash drivers for experiment sweeps
├── data/                     # Datasets (auto-downloaded)
├── images/                   # Figures
├── install.sh                # One-shot Linux + CUDA installer
├── LICENSE
└── README.md
```

## Roadmap

- [ ] Commute-time evaluation via random walks (baseline metric for downstream tasks).
- [ ] Anomaly detection experiments (AUROC / F1 / PR on labeled & unlabeled data).
- [ ] Link prediction experiments (ROC-AUC / Precision@K, supervised & unsupervised variants).

## Citation

If you use HyDRO or HyDRO+ in your research, please cite:

```bibtex
@article{long2025random,
  title   = {Random Walk Guided Hyperbolic Graph Distillation},
  author  = {Long, Yunbo and Xu, Liming and Schoepf, Stefan and Brintrup, Alexandra},
  journal = {arXiv preprint arXiv:2501.15696},
  year    = {2025}
}

@article{long2026efficient,
  title     = {Efficient and Privacy-Preserved Link Prediction via Condensed Graphs},
  author    = {Long, Yunbo and Xu, Liming and Brintrup, Alexandra},
  journal   = {Expert Systems with Applications},
  volume    = {296},
  pages     = {128937},
  year      = {2026},
  publisher = {Elsevier},
  doi       = {10.1016/j.eswa.2025.128937},
  note      = {Part A; Open Access (CC license)}
}
```

## Acknowledgments

HyDRO+ builds on:
- [GraphSlim](https://github.com/Emory-Melody/GraphSlim) — graph distillation framework.
- [HyDRO](https://github.com/Yunbo-max/HyDRO) — the original method.
- [GCondenser](https://github.com/superallen13/GCondenser) — continual graph-learning evaluation.

## License

Released under the [MIT License](LICENSE).
