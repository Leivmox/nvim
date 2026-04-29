-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
if vim.fn.has("win32") == 1 then
  -- 1. 依然置顶 PowerShell 路径，但这只是修改 PATH，不影响 Shell 选择
  local ps_dir = "C:/Windows/System32/WindowsPowerShell/v1.0"
  if not string.find(string.lower(vim.env.PATH), "windowspowershell") then
    vim.env.PATH = ps_dir .. ";" .. vim.env.PATH
  end

  -- 2. 只有在 Mason 这种需要调用外部 spawn 的场景下才手动补环境
  -- 我们【不再】全局修改 vim.opt.shell
  -- 这样你的默认终端会退回到你启动 nvim 时的环境（即 MSYS2）
end

---- 保持光标上下至少有 10 行距离
vim.opt.scrolloff = 10

vim.opt.title = false
