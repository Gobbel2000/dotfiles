return {
    {
        "lervag/vimtex",
        --ft = "tex",
        --cmd = "VimtexInverseSearch",
        config = function()
            vim.g.vimtex_view_general_viewer = "okular"
            vim.g.vimtex_view_general_options = "--unique file:@pdf#src:@line@tex"
            vim.g.vimtex_compiler_latexmk = {
                -- Put auxiliary files into 'latexmk' subdirectories
                aux_dir = 'latexmk',
            }
            vim.g.vimtex_syntax_conceal = { spacing = 0 }
            vim.g.vimtex_quickfix_method = 'pplatex'
            vim.g.vimtex_quickfix_ignore_filters = {
                'Font shape .* not available'
            }
            --vim.g.vimtex_quickfix_open_on_warning = 0
        end,
    },
}
