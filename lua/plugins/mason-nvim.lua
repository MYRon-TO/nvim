return {
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate", -- :MasonUpdate updates registry contents
        lazy = true,
        config = function()
            require("mason").setup()
        end,
    },
}
