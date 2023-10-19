local leaderkey = "<c-j>"
local MdSnippets = {
    { from = leaderkey .. leaderkey, to = "<Esc>/<++><CR>:nohlsearch<CR>\"_c4l" },
    { from = leaderkey .. "n",       to = "---<Enter><Enter>" },
    { from = leaderkey .. "b",       to = "**** <++><Esc>F*hi" },
    { from = leaderkey .. "s",       to = "~~~~ <++><Esc>F~hi" },
    { from = leaderkey .. "i",       to = "** <++><Esc>F*i" },
    { from = leaderkey .. "d",       to = "`` <++><Esc>F`i" },
    { from = leaderkey .. "c",       to = "```<Enter><++><Enter>```<Enter><Enter><++><Esc>4kA" },
    { from = leaderkey .. "m",       to = "- [ ] " },
    { from = leaderkey .. "p",       to = "![](<++>) <++><Esc>F[a" },
    { from = leaderkey .. "a",       to = "[](<++>) <++><Esc>F[a" },
    { from = leaderkey .. "1",       to = "#<Space><Enter><++><Esc>kA" },
    { from = leaderkey .. "2",       to = "##<Space><Enter><++><Esc>kA" },
    { from = leaderkey .. "3",       to = "###<Space><Enter><++><Esc>kA" },
    { from = leaderkey .. "4",       to = "####<Space><Enter><++><Esc>kA" },
    { from = leaderkey .. "5",       to = "#####<Space><Enter><++><Esc>kA" },
    { from = leaderkey .. "l",       to = "--- " },
    --中文
    -- { from = "《",           to = "《》<++><esc>F》i"                                  },
    -- { from = "》",           to = "> "                                                 },
    -- { from = "（",           to = "（）<++><Esc>F）i"                                  },
    -- { from = "“",            to = "“”<++><Esc>F”i"                                     },
    -- { from = "”",            to = "“”<++><Esc>F”i"                                     },
    { from = leaderkey .. "n",       to = "---<Enter><Enter>" },
    { from = leaderkey .. "b",       to = "****<++><Esc>F*hi" },
    { from = leaderkey .. "s",       to = "~~~~<++><Esc>F~hi" },
    { from = leaderkey .. "i",       to = "**<++><Esc>F*i" },
    { from = leaderkey .. "d",       to = "``<++><Esc>F`i" },
    { from = leaderkey .. "c",       to = "```<Enter><++><Enter>```<Enter><Enter><++><Esc>4kA" },
    { from = leaderkey .. "m",       to = "- [ ] " },
    { from = leaderkey .. "p",       to = "![](<++>)<++><Esc>F[a" },
    { from = leaderkey .. "a",       to = "[](<++>)<++><Esc>F[a" },
    { from = leaderkey .. "1",       to = "#<Space><Enter><++><Esc>kA" },
    { from = leaderkey .. "2",       to = "##<Space><Enter><++><Esc>kA" },
    { from = leaderkey .. "3",       to = "###<Space><Enter><++><Esc>kA" },
    { from = leaderkey .. "4",       to = "####<Space><Enter><++><Esc>kA" },
    { from = leaderkey .. "5",       to = "#####<Space><Enter><++><Esc>kA" },
    { from = leaderkey .. "l",       to = "--- " },
}

local MdMapping = function()
    for _, mapping in ipairs(MdSnippets) do
        vim.keymap.set("i", mapping.from, mapping.to, { noremap = true, buffer = true })
    end
end

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { '*.md' },
    callback = function()
        MdMapping()
    end
})
