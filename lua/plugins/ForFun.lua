return {
    "Eandrju/cellular-automaton.nvim",
    lazy = true,
    keys = {
        -- "<leader>fmr",
        -- "<leader>fgl",
        "<leader>ff",
    },
    config = function()
        -- vim.keymap.set("n", "<leader>fmr", "<cmd>CellularAutomaton make_it_rain<CR>")
        -- vim.keymap.set("n", "<leaderr>fgl", "<cmd>CellularAutomaton game_of_life<CR>")
        vim.keymap.set("n", "<leader>ff", "<cmd>CellularAutomaton make_it_rain<CR>")
    end,
}
