#!/bin/bash
source ~/.bashrc_conda
conda init
conda activate torchnew
watch -n 1 'sensors | grep 'C' | head -n 4; nvidia-smi ; free -h ; w; df -h | grep ^/dev/s | jupyter server list'
