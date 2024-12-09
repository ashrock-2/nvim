vim.g.mapleader = ' '

vim.opt.termguicolors = true
vim.opt.nu = true
vim.opt.rnu = true
vim.opt.si = true
vim.opt.scrolloff = 8
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.g.netrw_banner = 0
vim.opt.ruler = false
vim.opt.cursorline = true

vim.api.nvim_create_autocmd("FileType", {
  pattern = "netrw",
  callback = function()
    vim.opt_local.relativenumber = true
    vim.opt_local.number = true
  end,
})

vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = "*.md",
  callback = function()
    local file_path = vim.fn.expand('%:p')
    if string.match(file_path, "/texts/") then
      local current_time = os.date("%Y-%m-%d %H:%M")
      local template = {
        "",
        "",
        "---",
        "created: " .. current_time,
        "---",
      }
      vim.api.nvim_buf_set_lines(0, 0, 0, false, template)
      vim.api.nvim_win_set_cursor(0, { 1, 0 })
    end
  end
})
