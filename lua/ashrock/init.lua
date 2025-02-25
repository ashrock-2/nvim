require("ashrock.set")
require("ashrock.lazy_init")
require("ashrock.remap")
require("ashrock.autosync")
require("ashrock.bufonly")

local autocmd = vim.api.nvim_create_autocmd
autocmd('LspAttach', {
  callback = function(e)
    local opts = { buffer = e.buf }
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "gh", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    -- vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    if vim.lsp.get_client_by_id(e.data.client_id).server_capabilities.documentFormattingProvider then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = e.buf,
        callback = function()
          vim.lsp.buf.format { async = false, id = e.data.client_id }
        end,
      })
    end
    -- vim.api.nvim_create_autocmd("BufWritePre", {
    --   pattern = { "*.js", "*.jsx", "*.ts", "*.tsx" },
    --   callback = function()
    --     vim.cmd(":Prettier")
    --   end,
    -- })
  end
})
