return {
  "j-hui/fidget.nvim",
  config = function()
    require("fidget").setup({})
    
    vim.diagnostic.config({
      float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
    })
  end
} 