vim.opt.suffixes:remove { ".h", ".obj" }
vim.opt.suffixes:append {
    ".aux", ".bbl", ".blg", ".brf", ".cb", ".dvi", ".idx", ".ilg", ".ind",
    ".inx", ".jpg", ".log", ".out", ".png", ".toc"
}
vim.g.python3_host_prog = "/usr/bin/python3"

vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.expandtab = true
vim.o.shiftwidth = 4

vim.opt.langmap = { "hk", "jh", "kj" }
vim.o.clipboard = "unnamedplus"
vim.opt.guicursor = { "n-v-ve-i-c-ci-sm:block", "r-cr-o:hor20", "a:blinkon0" }
-- Disable preview window when selecting completion (e.g. omnifunc)
vim.opt.completeopt:remove { "preview" }
vim.o.termguicolors = true
vim.o.undofile = true
vim.o.cursorline = true
vim.o.autowriteall = true
vim.o.textwidth = 79
vim.o.number = true
vim.o.relativenumber = true
vim.o.conceallevel = 2

-- WGSL is not automatically detected (yet)
vim.filetype.add({extension = {wgsl = "wgsl"}})

-- Global mappings from nvim-lspconfig, but also relevant for nvim-lint
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)
vim.keymap.set('i', '<C-space>', '<C-X><C-O>')
vim.diagnostic.config({ signs = false })

-- Used to determine which colorscheme plugin to load, disabling the rest
colorplug = "nightfox"

vim.opt.runtimepath:prepend("/home/gabriel/.opam/default/share/ocp-indent/vim")

-- Bootstrap lazy package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath
    })
end
vim.opt.runtimepath:prepend(lazypath)

-- Load/Install all plugins as configured in lua/plugins/*.lua
require("lazy").setup("plugins", {
    performance = {
        rtp = {
            disabled_plugins = {
                --"netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
            }
        }
    }
})

-- Uncomment to use custom WGSL treesitter parser
--local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
--parser_config.wgsl = {
--  install_info = {
--    url = "~/programs/tree-sitter-wgsl", -- local path or git repo
--    files = {"src/parser.c", "src/scanner.c"}, -- note that some parsers also require src/scanner.c or src/scanner.cc
--    -- optional entries:
--    --branch = "main", -- default branch in case of git repo if different from master
--    generate_requires_npm = false, -- if stand-alone parser without npm dependencies
--    requires_generate_from_grammar = true, -- if folder contains pre-generated src/parser.c
--  },
--  filetype = "wgsl", -- if filetype does not match the parser name
--}
