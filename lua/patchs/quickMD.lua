local leaderkey = "<c-g>"
local MdSnippets = {
    { from = leaderkey .. leaderkey, to = "<Esc>/<++><CR>:nohlsearch<CR>\"_c4l" },
    { from = leaderkey .. "l",       to = "---<Enter><Enter>" },
    { from = leaderkey .. "b",       to = "**** <++><Esc>F*hi" },
    { from = leaderkey .. "s",       to = "~~~~ <++><Esc>F~hi" },
    { from = leaderkey .. "i",       to = "** <++><Esc>F*i" },
    { from = leaderkey .. "c",       to = "`` <++><Esc>F`i" },
    { from = leaderkey .. "C",       to = "```<Enter><++><Enter>```<Enter><Enter><++><Esc>4kA" },
    { from = leaderkey .. "m",       to = "$$ <++><Ese>F`i"},
    { from = leaderkey .. "M",       to = "$$$<Enter><++><Enter>$$$<Enter><Enter><++><Esc>4kA" },
    { from = leaderkey .. "t",       to = "- [ ] " },
    { from = leaderkey .. "p",       to = "![](<++>) <++><Esc>F[a" },
    { from = leaderkey .. "a",       to = "[](<++>) <++><Esc>F[a" },
    { from = leaderkey .. "1",       to = "#<Space><Enter><++><Esc>kA" },
    { from = leaderkey .. "2",       to = "##<Space><Enter><++><Esc>kA" },
    { from = leaderkey .. "3",       to = "###<Space><Enter><++><Esc>kA" },
    { from = leaderkey .. "4",       to = "####<Space><Enter><++><Esc>kA" },
    { from = leaderkey .. "5",       to = "#####<Space><Enter><++><Esc>kA" },
    { from = leaderkey .. "6",       to = "######<Space><Enter><++><Esc>kA" },
    --中文
    -- { from = "《",           to = "《》<++><esc>F》i"                                  },
    -- { from = "》",           to = "> "                                                 },
    -- { from = "（",           to = "（）<++><Esc>F）i"                                  },
    -- { from = "“",            to = "“”<++><Esc>F”i"                                     },
    -- { from = "”",            to = "“”<++><Esc>F”i"                                     },
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
