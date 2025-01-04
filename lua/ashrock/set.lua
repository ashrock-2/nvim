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
  pattern = "netrw|oil",
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

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.md",
  callback = function()
    local file_path = vim.fn.expand('%:p')
    if string.match(file_path, "/texts/") then
      local current_time = os.date("%Y-%m-%d %H:%M")
      local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

      -- created 라인의 인덱스를 찾습니다
      local created_index = -1
      for i, line in ipairs(lines) do
        if line:match("^created:") then
          created_index = i
          break
        end
      end

      if created_index ~= -1 then
        -- created 다음 라인에 updated를 추가/업데이트합니다
        local next_line = lines[created_index + 1] or ""
        if next_line:match("^updated:") then
          -- 이미 updated가 있다면 업데이트
          lines[created_index + 1] = "updated: " .. current_time
        else
          -- updated가 없다면 새로 추가
          table.insert(lines, created_index + 1, "updated: " .. current_time)
        end

        -- 변경된 내용을 버퍼에 적용
        vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
      end
    end
  end
})
