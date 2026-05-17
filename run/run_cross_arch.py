import os
import sys

_REPO_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
if _REPO_ROOT not in sys.path:
    sys.path.insert(0, _REPO_ROOT)

from graphslim.config import cli
from graphslim.dataset import *
from graphslim.evaluation import Evaluator

if __name__ == '__main__':
    args = cli(standalone_mode=False)
    data = get_dataset(args.dataset, args)
    evaluator = Evaluator(args)
    if args.eval_whole:
        evaluator.train_cross(data, reduced=False)

    else:
        evaluator.train_cross(data)
