# 🔥 bindufiles – My Ultimate Dev Setup
🚀 **Neovim + Tmux + SSH Dotfiles** 

---

## 📁 Included Configurations

### 🛠 Neovim (`.config/nvim/init.lua`)
✅ **Lazy.nvim** – Plugin manager  
✅ **LSP Support** – Rust (`rust-analyzer`), Golang (`gopls`)  
✅ **Debugging (`nvim-dap`)** – Rust (`lldb`), Go (`delve`)  
✅ **Telescope** – Fuzzy Finder (`<Leader>ff`, `<Leader>fg`)  
✅ **Treesitter** – Better syntax highlighting  
✅ **File Explorer (`nvim-tree`)** – `<Leader>e` to toggle  

### 📟 Tmux (`.tmux/tmux.conf`)
✅ **Prefix Key: `C-s` (Instead of `C-b`)**  
✅ **Vim-like navigation (`h/j/k/l`)**  
✅ **Dracula Theme** – With weather widget  
✅ **Split Windows (`C-s |` and `C-s -`)**  
✅ **Session Management (`C-s H/L` to switch)**  

---

## 📦 Installation (Setup on a New Machine)
```sh
git clone git@github.com:yourusername/bindufiles.git ~/bindufiles
ln -s ~/bindufiles/.config/nvim ~/.config/nvim
ln -s ~/bindufiles/.tmux/tmux.conf ~/.tmux.conf
```

