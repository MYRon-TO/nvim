return {
    {
        "iamcco/markdown-preview.nvim",
        build = "cd app && npm install",
        setup = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" },
        config = function()
            vim.cmd [[
                let g:mkdp_auto_start = 0
                let g:mkdp_auto_close = 1
                let g:mkdp_refresh_slow = 0
                let g:mkdp_command_for_global = 0
                let g:mkdp_open_to_the_world = 0
                let g:mkdp_open_ip = ''
                let g:mkdp_browser = ''
                let g:mkdp_browserfunc = ''
                let g:mkdp_preview_options = {
                    \ 'mkit': {},
                    \ 'katex': {},
                    \ 'uml': {},
                    \ 'maid': {},
                    \ 'disable_sync_scroll': 0,
                    \ 'sync_scroll_type': 'middle',
                    \ 'hide_yaml_meta': 1,
                    \ 'sequence_diagrams': {},
                    \ 'flowchart_diagrams': {},
                    \ 'content_editable': v:false,
                    \ 'disable_filename': 0,
                    \ 'toc': {}
                    \ }
                let g:mkdp_markdown_css = ''
                let g:mkdp_highlight_css = ''
                let g:mkdp_port = ''
                let g:mkdp_page_title = '「${name}」'
                let g:mkdp_filetypes = ['markdown']
                let g:mkdp_theme = 'light'
                let g:mkdp_path_to_chrome = "/Users/miaoyuanrong/Desktop/everything/Google Chrome.app"
                function OpenMarkdownPreview (url)
                    execute "silent ! chrome --new-window " . a:url
                endfunction
                let g:mkdp_browserfunc = 'OpenMarkdownPreview'
            ]]
        end
    }
}

