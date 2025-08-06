-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
--
vim.api.nvim_create_autocmd("FileType", {
  -- This handler will fire when the buffer's 'filetype' is "python"
  pattern = "lss",
  callback = function(args)
    vim.lsp.start({
      name = "Lipgoss StyleSheet",
      cmd = { "node", "/Users/rafa/dev/lss-language-server/out/server.js", "--stdio" },
      -- Set the "root directory" to the parent directory of the file in the
      -- current buffer (`args.buf`) that contains either a "setup.py" or a
      -- "pyproject.toml" file. Files that share a root directory will reuse
      -- the connection to the same LSP server.
      root_dir = vim.fs.root(args.buf, { "go.mod" }),
    })
  end,
})
