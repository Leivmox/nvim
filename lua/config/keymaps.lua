-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
-- 在lua/config/keymaps.lua中添加
-- ===========================
-- 自定义快捷键 for LazyVim
-- ===========================

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- --- 插入模式退出 ---
keymap("i", "jj", "<Esc>", { noremap = true })
keymap("i", "jk", "<Esc>", { noremap = true })

-- --- 行首 / 行尾 ---
keymap({ "n", "v" }, "H", "^", opts)
keymap({ "n", "v" }, "L", "$", opts)

-- --- 新行插入 ---
keymap("n", "<CR>", "o<Esc>", opts)

-- --- 快速上下移动 ---
keymap("n", "J", "5j", opts)
keymap("v", "J", "5j", opts)

-- --- 清除高亮搜索 ---
keymap("n", "<leader>nl", ":nohlsearch<CR>", opts)

-- --- 窗口导航 (window navigation) ---
keymap("n", "<leader>h", "<C-w>h", opts)
keymap("n", "<leader>j", "<C-w>j", opts)
keymap("n", "<leader>k", "<C-w>k", opts)
keymap("n", "<leader>l", "<C-w>l", opts)
keymap("v", "<leader>h", "<C-w>h", opts)
keymap("v", "<leader>j", "<C-w>j", opts)
keymap("v", "<leader>k", "<C-w>k", opts)
keymap("v", "<leader>l", "<C-w>l", opts)

-- --- 窗口管理 (split / close / layout) ---
keymap("n", "<leader>wv", ":vsplit<CR>", opts) -- 垂直分屏
keymap("n", "<leader>ws", ":split<CR>", opts) -- 水平分屏
keymap("n", "<leader>wc", "<C-w>c", opts) -- 关闭当前窗口
keymap("n", "<leader>wo", "<C-w>o", opts) -- 只保留当前窗口
keymap("n", "<leader>w=", "<C-w>=", opts) -- 等宽分配

-- --- 窗口移动 (move window) ---
keymap("n", "<leader>wH", "<C-w>H", opts)
keymap("n", "<leader>wJ", "<C-w>J", opts)
keymap("n", "<leader>wK", "<C-w>K", opts)
keymap("n", "<leader>wL", "<C-w>L", opts)

-- 普通 gt / gT 映射到 buffer 切换
keymap("n", "gt", ":bnext<CR>", { noremap = true, silent = true }) -- 下一个 buffer
keymap("n", "gT", ":bprev<CR>", { noremap = true, silent = true }) -- 上一个 buffer

-- 数字 + gt 映射到 buffer 切换到第 N 个 buffer
-- 这里用 :bN 直接切换到 buffer 列表里编号为 N 的 buffer
for i = 1, 9 do
  keymap("n", tostring(i) .. "gt", ":" .. i .. "b<CR>", { noremap = true, silent = true })
end

-- 在 keymaps.lua 或 options.lua 中直接全局绑定
vim.keymap.set("n", "K", "5k", { noremap = true, silent = true })
vim.keymap.set("v", "K", "5k", { noremap = true, silent = true })
-- --- LSP 覆盖 K ---
local M = {}
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    vim.defer_fn(function()
      pcall(vim.keymap.del, "n", "K", { buffer = bufnr })
      vim.keymap.set("n", "K", "5k", { buffer = bufnr, noremap = true, silent = true, desc = "Move up 5 lines" })
      vim.keymap.set("v", "K", "5k", { buffer = bufnr, noremap = true, silent = true, desc = "Move up 5 lines" })
    end, 10)
  end,
})

return M
