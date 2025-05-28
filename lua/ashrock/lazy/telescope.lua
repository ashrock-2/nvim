return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('telescope').setup {
      defaults = {
        -- 긴 경로 중간을 … 으로 잘라내고, 끝부분(파일명)은 항상 보이게
        path_display = { "truncate" },
      },
    }
  end
}
