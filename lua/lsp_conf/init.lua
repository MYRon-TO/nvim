local lsp_servers = {
  clangd = require("lsp_conf/clangd"),             -- C/C++
  lua_ls = require("lsp_conf/lua_ls"),             -- Lua
  -- rust_analyzer = {},          -- Rust make sure it was installed but not to load
  jdtls = require("lsp_conf/jdtls"),               -- Java
  basedpyright = require("lsp_conf/basedpyright"), -- Python
  marksman = {},                                   -- Markdown
  -- bashls = {},                 -- Bash
  gopls = {},                                      -- Go
  -- omnisharp_mono = {},              -- C#
  csharp_ls = {},
  biome = {},                              -- JS/TS JSON
  html = {},                               -- HTML
  cssls = {},                              -- CSS
  -- psalm = {},                  -- PHP
  texlab = require("lsp_conf/texlab"),     -- LaTeX
  tinymist = require("lsp_conf/tinymist"), -- Typst
  -- tinymist = {},
  -- ltex = require("lsp_conf/ltex"), -- languageTool (grammar-chacker)
  -- vale_ls = {},
  dockerls = {}, -- DockerFILE
  cmake = {},    -- CMake
  -- kotlin_language_server = {}, -- Kotlin
  -- volar = {},                  -- Vue
  -- gdtoolkit = {},                 -- Godot
  -- hls = require("lsp_conf/hls"), -- Haskell
  protols = {},
}

local packages = {
  -- formatter
  "sqlfmt", -- SQL
  "isort",  -- Python
  "black",  -- Python
  "latexindent",
  "prettierd",
  "dprint",
  "markdown-toc",
  "markdownlint-cli2",
  -- "hlint",    -- haskell
  -- "fourmolu", -- haskell
}

local function get_servers(servers)
  local server_list = {}
  for server, _ in pairs(servers) do
    table.insert(server_list, server)
  end
  table.insert(server_list, "rust_analyzer")
  return server_list
end

return {
  lsp_servers = lsp_servers,
  servers = get_servers(lsp_servers),
  packages = packages,
}
