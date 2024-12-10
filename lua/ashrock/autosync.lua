local function is_texts_directory()
  local current_dir = vim.fn.getcwd()
  return string.match(current_dir, "/texts$") ~= nil
end

local function git_sync()
  if not is_texts_directory() then
    return
  end

  -- 변경사항 확인
  local status = vim.fn.system("git status --porcelain")
  if status == "" then
    return  -- 변경사항이 없으면 종료
  end

  local commands = {
    "git add .",
    'git commit -m "Auto sync: ' .. os.date("%Y-%m-%d %H:%M:%S") .. '"',
    "git push origin HEAD"
  }

  for _, cmd in ipairs(commands) do
    local result = vim.fn.system(cmd)
    if vim.v.shell_error ~= 0 then
      vim.notify("Git sync failed: " .. result, vim.log.levels.ERROR)
      return
    end
  end
end

local timer = vim.loop.new_timer()
timer:start(0, 60000, vim.schedule_wrap(git_sync))  -- 60000ms = 1분

return {
  stop = function()
    if timer then
      timer:stop()
      timer:close()
    end
  end
} 