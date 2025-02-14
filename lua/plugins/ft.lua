local rust = {
  'mrcjkb/rustaceanvim',
  lazy = true,
  ft = { 'rust' },
}
local haskell = {
  'mrcjkb/haskell-tools.nvim',
  -- version = '^4', -- Recommended
  lazy = true, -- This plugin is already lazy
  ft = { 'haskell' },
}

return{
  rust,
  haskell
}
