-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- ==========================================================================
-- 1. 基础与文本编辑增强
-- ==========================================================================

-- 回车键：下方开辟新行并回到普通模式
map("n", "<Enter>", "o<Esc>", { desc = "Insert empty line below", silent = true })

-- 空格 + 回车：在上方插入空行并退回命令模式（完美平替并解决 Shift+Enter 被终端拦截的问题）
map("n", "<leader><Enter>", "O<Esc>", { desc = "在上方插入空行" })

-- 半屏滚动居中显示 (10行)
map("n", "<C-u>", "10kzz", { desc = "Jump up" })
map("n", "<C-d>", "10jzz", { desc = "Jump down" })

-- 空格 + fm：格式化代码（兼容普通模式和可视模式的局部格式化）
map({ "n", "v" }, "<leader>fm", function()
  LazyVim.format({ force = true })
end, { desc = "Format Document/Selection" })

-- ==========================================================================
-- 2. Buffer (标签页) 切换增强
-- ==========================================================================

-- 让 LazyVim 的 gt 和 gT 直接切换顶部的标签页
map("n", "gt", "<cmd>bnext<cr>", { desc = "切到右边标签" })
map("n", "gT", "<cmd>bprevious<cr>", { desc = "切到左边标签" })

-- ==========================================================================
-- 3. 终端管理 (基于 Snacks.terminal)
-- ==========================================================================

-- 普通模式：Alt + t 打开/切换终端
map("n", "<M-t>", function()
  Snacks.terminal()
end, { desc = "Terminal" })

-- 插入模式：Alt + t 也能一键呼出
map("i", "<M-t>", function()
  Snacks.terminal()
end, { desc = "Terminal" })

-- 终端模式：Alt + t 隐藏并关闭终端窗口
map("t", "<M-t>", [[<C-\><C-n><cmd>close<cr>]], { desc = "Hide Terminal" })

-- ==========================================================================
-- 4. 窗口管理增强 (完美对齐 Ctrl+w 习惯)
-- ==========================================================================

-- 4.1 核心分割窗口映射
map("n", "<leader>wv", "<C-w>v", { desc = "垂直分割窗口 (Vertical Split)" })
map("n", "<leader>ws", "<C-w>s", { desc = "水平分割窗口 (Horizontal Split)" })

-- 4.2 关闭窗口与标签
map("n", "<leader>wc", "<C-w>c", { desc = "关闭当前窗口 (Close Window)" })
map("n", "<leader>wo", "<C-w>o", { desc = "关闭其他窗口 (Only Window)" })

-- 4.3 窗口间标准跳转 (Leader + w + hjkl)
map("n", "<leader>wh", "<C-w>h", { desc = "跳到左边窗口" })
map("n", "<leader>wj", "<C-w>j", { desc = "跳到下边窗口" })
map("n", "<leader>wk", "<C-w>k", { desc = "跳到上边窗口" })
map("n", "<leader>wl", "<C-w>l", { desc = "跳到右边窗口" })

-- 4.4 窗口间极致简化跳转 (去掉 w 盲操极速版，注意会覆盖默认的帮助菜单)
map("n", "<leader>h", "<C-w>h", { desc = "极速：跳到左边窗口" })
map("n", "<leader>j", "<C-w>j", { desc = "极速：跳到下边窗口" })
map("n", "<leader>k", "<C-w>k", { desc = "极速：跳到上边窗口" })
map("n", "<leader>l", "<C-w>l", { desc = "极速：跳到右边窗口" })

-- 4.5 调整窗口大小
map("n", "<leader>w=", "<C-w>=", { desc = "平分所有窗口大小" })
--
-- ==========================================================================
-- 5. 文件树智能切换 (完美复刻 VS Code 的 Alt+1 逻辑)
-- ==========================================================================
map("n", "<M-1>", function()
  -- 1. 安全检查：先看看当前焦点是不是已经落在 neo-tree 窗口里了
  local current_win = vim.api.nvim_get_current_win()
  local current_buf = vim.api.nvim_win_get_buf(current_win)
  local ft = vim.api.nvim_get_option_value("filetype", { buf = current_buf })

  if ft == "neo-tree" then
    -- 如果焦点在侧边栏，直接关闭它（这里必须加 pcall 防止插件还没完全准备好时报错）
    pcall(function()
      vim.cmd("Neotree close")
    end)
  else
    -- 如果焦点在编辑器，使用 LazyVim 内置的那个最安全的“大招”
    -- 它不仅能完美解决懒加载没命令的问题，还能自动实现：打开、聚焦、reveal 当前文件
    LazyVim.pick("explorer")()
  end
end, { desc = "智能切换/关闭文件树", silent = true })
