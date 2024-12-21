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

    {
        "scottmckendry/cyberdream.nvim",
        enabled = colorplug == "cyberdream",

        lazy = false,
        priority = 1000,
        config = function()
            require("cyberdream").setup({
                transparent = false,
                italic_comments = true,
                hide_fillchars = true,
                borderless_telescope = true,
                terminal_colors = true,
                theme = { highlights = {
                    --Comment = { fg = "#aaccdd", bg = "NONE", italic = true },
                }},
            })
            vim.cmd("colorscheme cyberdream") -- set the colorscheme
        end,
    },
}
