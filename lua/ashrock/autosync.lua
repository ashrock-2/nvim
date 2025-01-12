local function is_texts_directory()
  local current_dir = vim.fn.getcwd()
  return string.match(current_dir, "/texts$") ~= nil
end

local function git_sync()
  if not is_texts_directory() then
    return
  end

  -- 변경사항 확인
  vim.fn.jobstart("git status --porcelain", {
    on_stdout = function(_, data)
      if #data == 1 and data[1] == "" then
        return  -- 변경사항이 없으면 종료
      end

      -- Git 명령어들을 순차적으로 실행
      local function run_commands(commands, index)
        if index > #commands then return end
        
        vim.fn.jobstart(commands[index], {
          on_exit = function(_, code)
            if code == 0 then
              if index < #commands then
                run_commands(commands, index + 1)
              end
            else
              vim.schedule(function()
                vim.notify("Git sync failed at: " .. commands[index], vim.log.levels.ERROR)
              end)
            end
          end
        })
      end

      local commands = {
        "git add .",
        'git commit -m "Auto sync: ' .. os.date("%Y-%m-%d %H:%M:%S") .. '"',
        "git push origin HEAD"
      }

      run_commands(commands, 1)
    end
  })
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