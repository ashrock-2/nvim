-- Basic editor commands
vim.cmd("command W w")
vim.cmd("command Q q")

-- Movement and selection
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])

-- Quickfix navigation
vim.keymap.set("n", "[q", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "]q", "<cmd>cnext<CR>zz")

-- Git related
vim.keymap.set("n", "gh", "<cmd>diffget //2<CR>")
vim.keymap.set("n", "gl", "<cmd>diffget //3<CR>")
vim.keymap.set("n", "<leader>gs", function()
  vim.cmd.Git()
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>o", true, false, true), "n", true)
end)

-- Code formatting
vim.keymap.set('n', '<leader>pr', function()
  vim.cmd.EslintFixAll()
  vim.cmd.Prettier()
end)

-- Diagnostic
vim.keymap.set("n", "<leader>e", function()
  vim.diagnostic.setqflist()
end)

-- File operations
vim.keymap.set('n', '<leader>fn', function()
  vim.fn.setreg('+', vim.fn.expand('%:t'))
end, { noremap = true, silent = true })

-- Random file opener
local function OpenRandomFileInDir()
  local output = vim.fn.system('ls -p | grep -v /')
  local files = vim.split(output, '\n')
  if #files == 0 then
    print("No files in directory.")
    return
  end
  math.randomseed(os.time())
  local idx = math.random(#files)
  local file = files[idx]
  vim.cmd('edit ' .. file)
end
vim.keymap.set('n', '<leader>r', OpenRandomFileInDir)

-- Telescope configuration
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', function()
  builtin.find_files()
end, { desc = 'Telescope find files' })

vim.keymap.set('n', '<leader>ps', function()
  builtin.live_grep()
end)

vim.keymap.set('n', '<C-p>', function()
  builtin.git_files()
end, { desc = 'Telescope find git files' })

-- Harpoon configuration
local harpoon = require("harpoon")
harpoon:setup()

local toggle_opts = {
  border = "rounded",
  title_pos = "center",
  ui_width_ratio = 1,
}

-- Harpoon mappings
vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list(), toggle_opts) end)

-- Harpoon file selection
for i = 1, 8 do
  vim.keymap.set("n", string.format("<leader>%d", i), function() harpoon:list():select(i) end)
end

-- Harpoon navigation
vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)

-- Oil Project View
vim.keymap.set({ "n" }, "-", "<CMD>Oil<CR>", { noremap = true, silent = true, buffer = false })
-- override vimwiki keybinding
vim.api.nvim_create_autocmd("FileType", {
  pattern = "vimwiki",
  callback = function()
    vim.keymap.set("n", "-", "<CMD>Oil<CR>", { noremap = true, silent = true, buffer = true })
  end
})
