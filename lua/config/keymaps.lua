-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- 1. 普通模式：Alt + t 打开/切换终端
-- Snacks.terminal() 是最新版 LazyVim 的标准写法
vim.keymap.set("n", "<M-t>", function()
  Snacks.terminal()
end, { desc = "Terminal" })

-- 2. 终端模式：Alt + t 关闭 (隐藏) 窗口
-- 注意：在 Snacks 终端里，直接用 <cmd>close 即可
vim.keymap.set("t", "<M-t>", [[<C-\><C-n><cmd>close<cr>]], { desc = "Hide Terminal" })

-- 3. 插入模式：也能一键呼出
vim.keymap.set("i", "<M-t>", function()
  Snacks.terminal()
end, { desc = "Terminal" })

-- 将空格键映射为：下方开辟新行并回到普通模式
-- 我们使用 <leader> 还是直接用 " "？既然你要改的是空格键本身：
vim.keymap.set("n", "<Enter>", "o<Esc>", { desc = "Insert empty line below", silent = true })

-- zz 会让光标所在行居中显示
vim.keymap.set("n", "<C-u>", "10kzz", { desc = "Jump up and center" })
vim.keymap.set("n", "<C-d>", "10jzz", { desc = "Jump down and center" })

-- 将空格 + fm 映射为格式化代码
-- 兼容普通模式和可视模式（局部格式化）
vim.keymap.set({ "n", "v" }, "<leader>fm", function()
  LazyVim.format({ force = true })
end, { desc = "Format Document/Selection" })
