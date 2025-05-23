local topics_cache = {
  data = {},
  last_update = 0
}

local objects_cache = {
  data = {},
  last_update = 0
}

local function get_all_topics()
  local current_time = os.time()
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

local function get_all_objects()
  local current_time = os.time()
  if current_time - objects_cache.last_update > 300 then
    local objects = {}
    local files = vim.fn.glob('**/*.md', false, true)

    for _, file in ipairs(files) do
      local content = vim.fn.readfile(file)
      local in_frontmatter = false

      for _, line in ipairs(content) do
        if line == '---' then
          in_frontmatter = not in_frontmatter
        elseif in_frontmatter and line:match('^objects:') then
          local object_list = line:gsub('objects:', ''):gsub('%s+', ''):gsub(',', '\n')
          for object in object_list:gmatch('[^\n]+') do
            objects[object] = true
          end
        end
      end
    end

    objects_cache.data = vim.tbl_keys(objects)
    objects_cache.last_update = current_time
  end

  return objects_cache.data
end

-- 자동완성 소스 설정
local source = {}

source.new = function()
  return setmetatable({}, { __index = source })
end

source.get_trigger_characters = function()
  return { ',', ' ' }
end

source.complete = function(self, params, callback)
  local line = params.context.cursor_before_line
  local items = {}
  
  local is_topics = line:match('topics:')
  local is_objects = line:match('objects:')
  
  if is_topics then
    local topics = get_all_topics()
    for _, topic in ipairs(topics) do
      if vim.startswith(topic:lower(), line:match("[^,%s]*$"):lower()) then
        table.insert(items, {
          label = topic,
          kind = vim.lsp.protocol.CompletionItemKind.Text
        })
      end
    end
  elseif is_objects then
    local objects = get_all_objects()
    for _, object in ipairs(objects) do
      if vim.startswith(object:lower(), line:match("[^,%s]*$"):lower()) then
        table.insert(items, {
          label = object,
          kind = vim.lsp.protocol.CompletionItemKind.Text
        })
      end
    end
  end
  
  callback({ items = items })
end

return {
  get_all_topics = get_all_topics,
  get_all_objects = get_all_objects,
  completion_source = source,
}
