#!/bin/bash
#source ~/.bashrc_conda
#conda init
#conda activate torchnew
#
#zellij -s jupyter
## jupyter lab --ip 0.0.0.0 --port 4321 /home/nthquan/work/mapping
## jupyter lab --ip 0.0.0.0 --port 8888 /home/nthquan
## jupyter lab --ip 0.0.0.0 --port 7890 /home/nthquan/work/pipeline_ner
## jupyter lab --ip 0.0.0.0 --port 8889 /home/nthquan/work/date_parser
#
#jupyter lab --ip 0.0.0.0 --port 8888 --no-browser /home/nthquan

tmux new -s jupyter
# Inside tmux session:
source ~/.bashrc_conda
conda activate torchnew
cd /home/nthquan
jupyter lab --ip=0.0.0.0 --port=8888 --no-browser

# Detach with Ctrl+B then D
# Reattach anytime with:
tmux attach -t jupyter
