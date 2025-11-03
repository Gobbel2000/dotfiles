function do_lsp_config()
    vim.lsp.config("pylsp", {
        settings = {
            pylsp = {
                plugins = {
                    mccabe = { enabled = false },
                    pyflakes = { enabled = false },
                    pycodestyle = { enabled = false },
                    autopep8 = { enabled = false },
                    yapf = { enabled = false },
                },
            },
        },
    })
    vim.lsp.config("rust_analyzer", {
        settings = {
            ["rust-analyzer"] = {
                cargo = {
                    buildScripts = {
                        enable = true,
                    },
                    --target = "wasm32-unknown-unknown",
                },
                procMacro = {
                    enable = true,
                },
            },
        },
    })
    vim.lsp.enable({"pylsp", "ruff", "rust_analyzer", "ocamllsp"})

    -- Use LspAttach autocommand to only map the following keys
    -- after the language server attaches to the current buffer
    vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
            -- Enable completion triggered by <c-x><c-o>
            vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

            -- Buffer local mappings.
            -- See `:help vim.lsp.*` for documentation on any of the below functions
            local opts = { buffer = ev.buf }
            vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
            vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
            vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
            vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
            vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
            vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
            vim.keymap.set("n", "<space>wl", function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, opts)
            vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
            vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
            vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
            vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
            vim.keymap.set("n", "<space>f", function()
                vim.lsp.buf.format({ async = true })
            end, opts)
        end,
    })
end

return {

    {
        "neovim/nvim-lspconfig",
        --ft = { "python", "rust", "ocaml", "lua" },
        config = do_lsp_config,
    },

    {
        "mfussenegger/nvim-lint",
        ft = { "sh", "python" },
        main = "lint",
        config = function()
            local lint = require("lint")
            lint.linters_by_ft = {
                sh = { "shellcheck" },
                python = { "mypy" },
            }
            table.insert(lint.linters.mypy.args, "--ignore-missing-imports")
            vim.api.nvim_create_autocmd({ "BufWinEnter", "FileType", "BufWritePost" }, {
                callback = function()
                    lint.try_lint()
                end,
            })
        end,
    },

    {
        "nvimtools/none-ls.nvim",
        config = function()
            local none_ls = require("null-ls")

            none_ls.setup({
                sources = {
                    none_ls.builtins.formatting.stylua.with({
                        extra_args = { "--indent-type=Spaces" },
                    }),
                    none_ls.builtins.formatting.ocamlformat,
                    none_ls.builtins.completion.spell,
                },
            })
        end,
        dependencies = { "nvim-lua/plenary.nvim" },
    },

    {
        "SirVer/ultisnips",
        init = function()
            vim.g.UltiSnipsExpandOrJumpTrigger = "<tab>"
            vim.g.UltiSnipsJumpBackwardTrigger = "<s-tab>"
            vim.g.UltiSnipsListSnippets = "<c-s>"
            vim.g.UltiSnipsEditSplit = "vertical"
        end,
        dependencies = { "honza/vim-snippets" },
    },

    {
        "nvim-lualine/lualine.nvim",
        opts = {
            options = {
                component_separators = { left = "", right = "" },
                section_separators = { left = "", right = "" },
            },
            sections = {
                lualine_a = {
                    {
                        "mode",
                        fmt = function(mode)
                            -- Ensure that all mode strings have the same length
                            if #mode < 7 then
                                mode = mode .. string.rep(" ", 7 - #mode)
                            end
                            return mode
                        end,
                    },
                },
                lualine_c = { { "filename", path = 1 } }, -- path = 1 means relative path
                lualine_x = {
                    --{ "%S", separator = "" },
                    --"searchcount",
                    --"selectioncount",
                    "filetype",
                },
            },
            inactive_sections = {
                lualine_x = { "filetype" },
                lualine_y = { "progress" },
                lualine_z = { "location" },
            },
        },
        config = function(spec, opts)
            require("lualine").setup(opts)
            vim.o.showmode = false
            --vim.o.showcmdloc = "statusline"
            --vim.o.commandheight = 0
        end,

        dependencies = { "nvim-tree/nvim-web-devicons" },
    },

    {
        "nvim-treesitter/nvim-treesitter",
        build = function()
            require("nvim-treesitter.install").update({ with_sync = true })
        end,
        config = function()
            require("nvim-treesitter.configs").setup({
                highlight = {
                    enable = true,
                },
            })
        end,
    },

    -- Kitty configuration highlighting
    "fladson/vim-kitty",

    {
        "mechatroner/rainbow_csv",
        ft = {
            "csv",
            "tsv",
            "csv_semicolon",
            "csv_whitespace",
            "csv_pipe",
            "rfc_csv",
            "rfc_semicolon",
        },
        cmd = {
            "RainbowDelim",
            "RainbowDelimSimple",
            "RainbowDelimQuoted",
            "RainbowMultiDelim",
        },
        config = function()
            vim.keymap.set("n", "<C-Left>", function()
                return (vim.b.rbcsv == 1) and ":RainbowCellGoLeft<CR>" or "<C-Left>"
            end, { expr = true })
            vim.keymap.set("n", "<C-Right>", function()
                return (vim.b.rbcsv == 1) and ":RainbowCellGoRight<CR>" or "<C-Right>"
            end, { expr = true })
            vim.keymap.set("n", "<C-Up>", function()
                return (vim.b.rbcsv == 1) and ":RainbowCellGoUp<CR>" or "<C-Up>"
            end, { expr = true })
            vim.keymap.set("n", "<C-Down>", function()
                return (vim.b.rbcsv == 1) and ":RainbowCellGoDown<CR>" or "<C-Down>"
            end, { expr = true })
        end,
    },
}
