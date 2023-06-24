return {
    {
        "git@github.com:ggandor/leap.nvim",
        dependencies = {
            "git@github.com:tpope/vim-repeat",
        }, config = function ()
           require("leap").add_default_mappings(true)
        end,

    },
}
