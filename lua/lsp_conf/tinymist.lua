return {
  root_dir = function()
    return vim.fn.getcwd()
  end,
  single_file_support = true,
  offset_encoding = "utf-8",
  settings = {
    tinymist = {
      settings = {
        exportPdf = "onSave",
        compileStatus = "enable",
        -- outputPath = "$root/target/$dir/$name",
        formatterMode = "typstfmt",
      },
    }
  }
}
