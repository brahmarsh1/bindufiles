-- Ensure Lazy.nvim is installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugin Management with Lazy.nvim
require("lazy").setup({
  -- Debugging (DAP)
  { "mfussenegger/nvim-dap" },   -- Core Debugger
  { "rcarriga/nvim-dap-ui", dependencies = { "nvim-neotest/nvim-nio" } }, -- UI for Debugging
  { "leoluz/nvim-dap-go" },      -- Go Debugging
  { "simrat39/rust-tools.nvim" },-- Rust LSP & Debugging
  { "nvim-neotest/nvim-nio" },   -- Fix for `nvim-dap-ui` dependency

  -- Treesitter (Better Syntax Highlighting)
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

  -- Fuzzy Finder (Telescope)
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },

  -- LSP and Auto-completion
  { "neovim/nvim-lspconfig" },  -- Language Server Protocol
  { "hrsh7th/nvim-cmp" },       -- Completion Engine
  { "hrsh7th/cmp-nvim-lsp" },   -- LSP Completion
  { "saadparwaiz1/cmp_luasnip" }, -- Snippets completion
  { "L3MON4D3/LuaSnip" },        -- Snippets Engine

  -- UI Enhancements
  { "nvim-lualine/lualine.nvim" },  -- Status bar
  { "kyazdani42/nvim-tree.lua" },  -- File explorer
  { "folke/tokyonight.nvim" },     -- Theme
})

-- DAP Setup (Rust & Go Debugging)
require("dap-go").setup()
require("dapui").setup()

-- Configure Rust Debugging (`lldb-vscode`)
local dap = require("dap")
dap.adapters.lldb = {
  type = "executable",
  command = "/usr/bin/lldb-vscode", -- Ensure `lldb-vscode` is installed
  name = "lldb"
}

dap.configurations.rust = {
  {
    name = "Launch",
    type = "lldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    args = {},
  },
}

-- Keybindings for DAP (Debugger)
vim.keymap.set("n", "<F5>", dap.continue, { desc = "Start Debugging" })
vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Step Over" })
vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Step Into" })
vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Step Out" })
vim.keymap.set("n", "<Leader>b", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
vim.keymap.set("n", "<Leader>dr", require("dapui").toggle, { desc = "Toggle DAP UI" })

-- Enable Rust LSP (`rust-analyzer`)
require("lspconfig").rust_analyzer.setup({
  settings = {
    ["rust-analyzer"] = {
      cargo = { allFeatures = true },
      checkOnSave = { command = "clippy" },
    },
  },
})

-- Enable Golang LSP (`gopls`)
require("lspconfig").gopls.setup({})

-- Enable Treesitter (Syntax Highlighting)
require("nvim-treesitter.configs").setup({
  ensure_installed = { "rust", "go", "lua", "json", "yaml", "toml" },
  highlight = { enable = true },
  indent = { enable = true },
})

-- Set Theme
vim.cmd("colorscheme tokyonight")

-- Telescope (Fuzzy Finder)
vim.keymap.set("n", "<Leader>ff", ":Telescope find_files<CR>", { desc = "Find Files" })
vim.keymap.set("n", "<Leader>fg", ":Telescope live_grep<CR>", { desc = "Live Grep" })

-- File Explorer Keybinds
vim.keymap.set("n", "<Leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle File Explorer" })

-- LSP Keybindings
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show Documentation" })
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Go to References" })
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to Implementation" })
vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, { desc = "Rename Symbol" })
vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action, { desc = "Code Actions" })

