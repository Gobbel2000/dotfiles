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
vim.o.termguicolors = true
vim.o.undofile = true
vim.o.cursorline = true
vim.o.autowriteall = true
vim.o.textwidth = 79

vim.o.showmode = false
--vim.o.showcmdloc = "statusline"
--vim.o.commandheight = 0

-- Global mappings from nvim-lspconfig, but also relevant for nvim-lint
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Used to determine which colorscheme plugin to load, disabling the rest
colorplug = "nightfox"

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
