return {
    "Eandrju/cellular-automaton.nvim",
    lazy = true,
    keys = {
        "<leader>fmr",
        "<leader>fgl",
    },
    config = function()
        vim.keymap.set("n", "<leader>fmr", "<cmd>CellularAutomaton make_it_rain<CR>")
        vim.keymap.set("n", "<leader>fgl", "<cmd>CellularAutomaton game_of_life<CR>")
    end,
}
