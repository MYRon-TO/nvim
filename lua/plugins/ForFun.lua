return {
    {
        -- A plugin make an Code rain
        "Eandrju/cellular-automaton.nvim",
        lazy = true,
        keys = {
            -- "<leader>fmr",
            -- "<leader>fgl",
            "<leader>fr",
        },
        cmd = {
            "CellularAutomaton make_it_rain",
            "CellularAutomaton game_of_life",
        },
        config = function()
            -- vim.keymap.set("n", "<leader>fmr", "<cmd>CellularAutomaton make_it_rain<CR>")
            -- vim.keymap.set("n", "<leaderr>fgl", "<cmd>CellularAutomaton game_of_life<CR>")
            vim.keymap.set("n", "<leader>fr", "<cmd>CellularAutomaton make_it_rain<CR>")
        end,
    },
    {
        -- Take some ducks
        'tamton-aquib/duck.nvim',
        lazy = true,
        config = function()
            vim.keymap.set('n', '<leader>fd', function() require("duck").hatch() end, {})
            vim.keymap.set('n', '<leader>fk', function() require("duck").cook() end, {})
        end,
        keys = {
            "<leader>fd",
            "<leader>fk",
        },
    }
}
