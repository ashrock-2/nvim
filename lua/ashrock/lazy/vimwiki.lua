return {
  "vimwiki/vimwiki",
  init = function()
    vim.g.vimwiki_list = {
      {
        -- path = '~/Documents/ashrock',
        path = '~/Library/Mobile Documents/com~apple~CloudDocs/vimwiki',
        syntax = 'markdown',
        ext = '.md',
      },
    }
    vim.g.vimwiki_conceallevel = 0
  end,
}
