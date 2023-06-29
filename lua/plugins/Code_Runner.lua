return {
    {
        "git@github.com:CRAG666/code_runner.nvim",
        lazy = true,
        config = function()
            require('code_runner').setup({
                filetype = {
                    c = {
                      "cd $dir &&",
                      "gcc $fileName -o $fileNameWithoutExt &&",
                      "time $dir/$fileNameWithoutExt"
                    },
                    cpp = {
                      "cd $dir &&",
                      "g++ $fileName -o $fileNameWithoutExt &&",
                      "time $dir/$fileNameWithoutExt"
                    },
                    java = {
                      "cd $dir &&",
                      "javac $fileName &&",
                      "time java $fileNameWithoutExt"
                    },
                    python = "time python3 -u",
                    typescript = "time deno run",
                    sh = "time bash",
                    rust = {
                      "cd $dir &&",
                      "rustc $fileName &&",
                      "time $dir/$fileNameWithoutExt"
                    },
                },
                project = {

                },
                before_run_filetype = function ()
                    vim.cmd(":w")
                end,
                term = {
                },
                filetype_path = vim.fn.expand('~/.config/nvim/code_runner.json'),
                project_path = vim.fn.expand('~/.config/nvim/project_manager.json')
            })
        end,
        keys = {
            {"<leader><CR>", ":RunCode<CR>", "n"},
        },
    },
}
