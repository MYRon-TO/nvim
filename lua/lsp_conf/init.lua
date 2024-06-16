local lsp_servers = {
  clangd = require("lsp_conf/clangd"),   -- C/C++
  lua_ls = require("lsp_conf/lua_ls"),   -- Lua
  -- rust_analyzer = {},          -- Rust make sure it was installed but not to load
  jdtls = require("lsp_conf/jdtls"),     -- Java
  pyright = require("lsp_conf/pyright"), -- Python
  marksman = {},                         -- Markdown
  -- bashls = {},                 -- Bash
  gopls = {},                            -- Go
  -- omnisharp = {},              -- C#
  biome = {},                            -- JS/TS JSON
  html = {},                             -- HTML
  cssls = {},                            -- CSS
  -- psalm = {},                  -- PHP
  texlab = require("lsp_conf/texlab"),   -- LaTeX
  typst_lsp = {},                        -- Typst
  ltex = require("lsp_conf/ltex"),       -- languageTool (grammar-chacker)
  -- vale_ls = {},
  dockerls = {}, -- DockerFILE
  cmake = {},    -- CMake
  -- kotlin_language_server = {}, -- Kotlin
  -- volar = {},                  -- Vue
}

local packages = {
  -- formatter
  "sqlfmt",   -- SQL
  "isort",    -- Python
  "black",    -- Python
  "typstfmt", -- Typst
  "latexindent",
  "prettierd",
  "xmlformatter",
}

-- -- ### Debug ###
-- function printTable(my_table, indent)
--   indent = indent or 0
--   for key, value in pairs(my_table) do
--     if type(value) == "table" then
--       print(string.rep(" ", indent) .. key .. " = {")
--       printTable(value, indent + 2)
--       print(string.rep(" ", indent) .. "}")
--     else
--       print(string.rep(" ", indent) .. key .. " = " .. tostring(value))
--     end
--   end
-- end

local function get_servers(servers)
  local server_list = {}
  for server, _ in pairs(servers) do
    table.insert(server_list, server)
  end
  return server_list
end

return {
  lsp_servers = lsp_servers,
  servers = get_servers(lsp_servers),
  packages = packages,
}
