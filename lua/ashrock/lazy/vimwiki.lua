return {
  "vimwiki/vimwiki",
  init = function()
    vim.g.vimwiki_list = {
      {
        path = '~/Library/Mobile Documents/com~apple~CloudDocs/vimwiki',
        syntax = 'markdown',
        ext = '.md',
      },
    }
  end,
}
