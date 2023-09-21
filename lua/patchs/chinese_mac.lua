-- smart english 2 chinese
-- 检测上次输入状态
-- 0 is english
-- 1 is chinese
local input_toggle = 0

-- whether chinese?
-- 0 is english
-- 1 is chinese
function ToChinese()
    os.execute("im-select com.sogou.inputmethod.sogou.pinyin")
end

function ToEnglish()
    os.execute("im-select com.apple.keylayout.ABC")
end

local function isInComment()
    local cur_pos = vim.fn.getcurpos()
    cur_pos[3] = cur_pos[3] - 1
    vim.fn.setpos('.', cur_pos)
    return vim.treesitter.get_node(cur_pos):type()=="comment_content" or (cur_pos and vim.treesitter.get_node():type()=="comment_content")
end

function goBack(is_doc)
    if (is_doc and input_toggle == 1) or (not is_doc and isInComment() and input_toggle == 1) then
        ToChinese()
    end
end

function leaveInsert()
    local im = io.popen("im-select"):read("*all")
    if string.find(im, "sogou") then
        input_toggle = 1
    elseif isInComment() then
        input_toggle = 0
    end
    os.execute("im-select com.apple.keylayout.ABC")
end

-- 当离开插入模式时，切换输入法为英文
vim.api.nvim_create_autocmd("InsertLeave", { pattern = "*", command = "lua leaveInsert()" })
-- 当进入插入模式时，切换为上一次用的输入法
vim.api.nvim_create_autocmd("InsertEnter", { pattern = { "*.md", "*.txt" }, command = "lua goBack(true)" })
vim.api.nvim_create_autocmd("InsertEnter", { pattern = { "*" }, command = "lua goBack(false)" })
