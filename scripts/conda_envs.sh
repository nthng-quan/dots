# conda deactivate
conda activate $(conda env list | fzf | awk '{print $1}')
