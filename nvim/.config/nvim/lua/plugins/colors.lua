return {
    {
        "EdenEast/nightfox.nvim",
        enabled = colorplug:match("fox$"),

        -- Options for colorschemes
        lazy = false,
        priority = 1000,

        opts = {
            options = {
                styles = {
                    comments = "italic"
                }
            },
            specs = {
                all = {
                    syntax = {
                        comment = "cyan.bright",
                    }
                }
            },
            groups = {
                all = {
                    -- Instead of link=Comment
                    DiagnosticUnnecessary = { bg = "bg0" },
                }
            },
        },
        config = function(spec, opts)
            require("nightfox").setup(opts)
            vim.cmd.colorscheme(colorplug)
            -- Avoid stuttering on low-power devices
            -- https://github.com/neovim/neovim/issues/23590
            vim.cmd.highlight("clear", "CurSearch")
        end,
    },

    {
        "navarasu/onedark.nvim",
        enabled = colorplug == "onedark",

        lazy = false,
        priority = 1000,

        config = function()
            onedark = require('onedark')
            onedark.setup {
                style = "deep",
                highlights = {
                    ["@comment"] = { fg = "$cyan" },
                    ["Comment"] = { fg = "$cyan" },
                }
            }
            onedark.load()
        end,
    },
}
