#!/usr/bin/env bash
# HyDRO+ install script — Linux + CUDA 12.1 (forward-compatible with CUDA 12.4 drivers).
# Tested with Python 3.10 and 3.11.
set -euo pipefail

CUDA="cu121"
TORCH_VER="2.2.2"
TORCH_PYG_VER="2.2.0"   # PyG hosts wheels keyed to torch 2.2.0; compatible across 2.2.x.

echo ">>> [0/4] Upgrading pip / setuptools / wheel..."
pip install --upgrade pip setuptools wheel

echo ">>> [1/4] Installing PyTorch ${TORCH_VER} (${CUDA})..."
pip install \
    torch==${TORCH_VER} \
    torchvision==0.17.2 \
    torchaudio==${TORCH_VER} \
    --index-url https://download.pytorch.org/whl/${CUDA}

echo ">>> [2/4] Installing PyG extensions (torch_scatter, torch_sparse)..."
pip install \
    torch_scatter==2.1.2 \
    torch_sparse==0.6.18 \
    -f https://data.pyg.org/whl/torch-${TORCH_PYG_VER}+${CUDA}.html

echo ">>> [3/4] Installing DGL (${CUDA})..."
pip install dgl==1.1.3 -f https://data.dgl.ai/wheels/${CUDA}/repo.html

echo ">>> [4/4] Installing remaining Python dependencies..."
pip install -r graphslim/requirements.txt

echo ""
echo "Install complete. Verifying environment:"
python - <<'PY'
import torch, torch_geometric, torch_scatter, torch_sparse
print(f"  torch          : {torch.__version__}")
print(f"  torch_geometric: {torch_geometric.__version__}")
print(f"  torch_scatter  : {torch_scatter.__version__}")
print(f"  torch_sparse   : {torch_sparse.__version__}")
print(f"  cuda available : {torch.cuda.is_available()}  (device count: {torch.cuda.device_count()})")
try:
    import dgl
    print(f"  dgl            : {dgl.__version__}")
except Exception as e:
    print(f"  dgl            : FAILED ({e})")
PY
