local topics_cache = {
  data = {},
  last_update = 0
}

local function get_all_topics()
  local current_time = os.time()
  -- 5분마다 캐시 갱신
  if current_time - topics_cache.last_update > 300 then
    local topics = {}
    local files = vim.fn.glob('**/*.md', false, true)

    for _, file in ipairs(files) do
      local content = vim.fn.readfile(file)
      local in_frontmatter = false

      for _, line in ipairs(content) do
        if line == '---' then
          in_frontmatter = not in_frontmatter
        elseif in_frontmatter and line:match('^topics:') then
          local topic_list = line:gsub('topics:', ''):gsub('%s+', ''):gsub(',', '\n')
          for topic in topic_list:gmatch('[^\n]+') do
            topics[topic] = true
          end
        end
      end
    end

    topics_cache.data = vim.tbl_keys(topics)
    topics_cache.last_update = current_time
  end

  return topics_cache.data
end

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  callback = function()
    vim.bo.omnifunc = 'v:lua.topic_complete'
  end
})

_G.topic_complete = function(findstart, base)
  if findstart == 1 then
    local line = vim.api.nvim_get_current_line()
    local col = vim.api.nvim_win_get_cursor(0)[2]
    local start = col
    while start > 0 and line:sub(start, start):match('[%w_-]') do
      start = start - 1
    end
    return start
  else
    local topics = get_all_topics()
    local matches = {}
    for _, topic in ipairs(topics) do
      if topic:lower():find(base:lower(), 1, true) then
        table.insert(matches, topic)
      end
    end
    return matches
  end
end

local source = {}

source.new = function()
  return setmetatable({}, { __index = source })
end

source.get_trigger_characters = function()
  return { ',', ' ' }
end

source.complete = function(self, params, callback)
  local topics = get_all_topics()
  local items = {}
  
  for _, topic in ipairs(topics) do
      table.insert(items, {
        label = topic,
        kind = vim.lsp.protocol.CompletionItemKind.Text
      })
  end
  
  callback({ items = items })
end

require('cmp').register_source('topics', source.new())
