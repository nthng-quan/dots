# dotfiles

- LazyVim, Tmux/Zellij, Zsh, Alacritty/WezTerm
- Colorscheme: [Catppuccin](https://catppuccin.com/palette/)

- tpm

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

- Neovim stable

```bash
wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux-x86_64.tar.gz
tar -xzf nvim-linux-x86_64.tar.gz
mv nvim-linux-x86_64/bin/nvim /usr/local/bin/
```

- Neovim setup

  - `gcc`, `python`:

    ```bash
    sudo apt install build-essential
    ```

  - ripgrep (rg)

    ```bash
    sudo apt install ripgrep
    ```

  - `fzf` install

    ```bash
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
    ```

  - yazi

    ```bash
    wget https://github.com/sxyazi/yazi/releases/download/v25.4.8/yazi-x86_64-unknown-linux-musl.zip
    unzip yazi-x86_64-unknown-linux-musl.zip
    cd yazi-x86_64-unknown-linux-musl
    cp ya yazi /usr/local/bin/
    ```

- Neovim config clean up

```bash
mv ~/.config/nvim{,.bak}
mv ~/.local/share/nvim{,.bak}
mv ~/.local/state/nvim{,.bak}
mv ~/.cache/nvim{,.bak}
```

- Setup remote clipboard as well as GUI apps for neovim (X11Forwarding)

  - On Linux machine (server)

    - Setup X11 forwarding in ssh config: uncomment and modify `X11Forwarding yes`
      in /etc/ssh/sshd_config

  - On Windows machine (client) / Install X11 server (VcXsrv)

    ```pwsh
    ./powershell/download_vcxsrv.ps1
    ```

    - Run Xlaunch with `-ac`, Multiple windows (-1)

- Apply config

  ```bash
  cp -r nvim/ ~/.config/nvim/
  ```
