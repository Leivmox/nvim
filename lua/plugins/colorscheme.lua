return {
  {
    "olimorris/onedarkpro.nvim",
    priority = 1000, -- 确保主题最早加载
    config = function()
      require("onedarkpro").setup({
        options = {
          transparency = true, -- 如果你想要透明背景（配合 Windows Terminal 的毛玻璃）
          cursorline = true, -- 高亮当前行
        },
        styles = {
          types = "NONE", -- 去掉不必要的斜体，更像 VS Code
          methods = "NONE",
          numbers = "NONE",
        },
        -- highlights = {
        --   Cursor = { bg = "#00ff00", fg = "#000000" },
        -- },
      })
      -- 立即生效
      vim.cmd("colorscheme onedark")
    end,
  },
}
