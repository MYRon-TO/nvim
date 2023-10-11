local pattern = {
    "*.h",
    "*.c",
    "*.cpp",
    "*.py",
    "*.go",
    "*.java",
    "*.js",
    "*.ts",
    "*.rs",
    "*.lua",

    "*.md",
    "*.txt",
    "*.tex",

    "*.sh",
}
-- smart english 2 chinese
-- 检测上次输入状态
-- 0 is english
-- 1 is chinese
local M = {}
M.start = function(os_mac)
    local input_toggle = 0
    local is_mac = os_mac

    if is_mac then
        function ToChinese()
            os.execute("im-select com.sogou.inputmethod.sogou.pinyin")
        end

        function ToEnglish()
            os.execute("im-select com.apple.keylayout.ABC")
        end

        function IsChinese()
            return string.find(io.popen("im-select"):read("*all"), "sogou")
        end
    else
        function ToChinese()
            os.execute("fcitx5-remote -o")
        end

        function ToEnglish()
            os.execute("fcitx5-remote -c")
        end

        function IsChinese()
            return tonumber(io.popen("fcitx5-remote"):read("*all")) == 2
        end
    end

    local function isDoc()
        local ft = vim.bo.filetype
        return string.find(ft, "markdown") or string.find(ft, "txt") or string.find(ft, "tex")
    end

    local function isInComment()
        local cur_pos = vim.fn.getcurpos()
        cur_pos[3] = cur_pos[3] - 1
        if cur_pos[3] > 0 then
            vim.fn.setpos('.', cur_pos)
        else
            cur_pos = nil
        end
        return cur_pos and vim.treesitter.get_node(cur_pos):type() == "comment_content" or
            (cur_pos and vim.treesitter.get_node():type() == "comment_content")
    end

    function GoBack()
        local is_doc = isDoc()
        if (is_doc and input_toggle == 1) or (not is_doc and isInComment() and input_toggle == 1) then
            ToChinese()
        end
    end

    function LeaveInsert()
        if IsChinese() then
            input_toggle = 1
        else
            input_toggle = 0
        end
        ToEnglish()
    end

    -- 当离开插入模式时，切换输入法为英文
    vim.api.nvim_create_autocmd("InsertLeave", { pattern = "*", command = "lua LeaveInsert()" })

    -- 当进入插入模式时，切换为上一次用的输入法
    vim.api.nvim_create_autocmd("InsertEnter", { pattern = pattern, command = "lua GoBack()" })
end

return M
