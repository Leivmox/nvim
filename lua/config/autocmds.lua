-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
-- 拦截退出指令：当你试图关闭最后一个代码窗口时，如果只剩文档树，就全部退出
vim.api.nvim_create_autocmd("QuitPre", {
  callback = function()
    -- 获取当前光标所在的窗口（即你正准备退出的那个窗口）
    local current_win = vim.api.nvim_get_current_win()
    local current_buf = vim.api.nvim_win_get_buf(current_win)
    local current_ft = vim.bo[current_buf].filetype

    -- 如果你此时是聚焦在文档树上输入的 :q，那就不干涉，让它正常只关文档树
    if string.match(current_ft or "", "snacks_") then
      return
    end

    local wins = vim.api.nvim_tabpage_list_wins(0)
    local normal_wins_count = 0
    local has_explorer = false

    -- 统计当前标签页的窗口情况
    for _, w in ipairs(wins) do
      local buf = vim.api.nvim_win_get_buf(w)
      local ft = vim.bo[buf].filetype
      local config = vim.api.nvim_win_get_config(w)

      -- 排除浮动窗口和 snacks 组件，剩下的就是普通代码窗口
      if config.relative == "" and not string.match(ft or "", "snacks_") then
        normal_wins_count = normal_wins_count + 1
      end
      -- 检查文档树是否开着
      if string.match(ft or "", "snacks_picker") then
        has_explorer = true
      end
    end

    -- 如果你正在关的是最后 1 个代码窗口，且文档树还在旁边开着
    if normal_wins_count == 1 and has_explorer then
      -- 使用 vim.schedule 等待本次 :wq 的保存动作完成后，再执行全关
      vim.schedule(function()
        if #vim.api.nvim_list_tabpages() > 1 then
          vim.cmd("tabclose")
        else
          vim.cmd("qall")
        end
      end)
    end
  end,
})

