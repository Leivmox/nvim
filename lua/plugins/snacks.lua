return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          explorer = {
            win = {
              list = {
                keys = {
                  -- 1. 这是你之前配置好的左右键
                  ["<Left>"] = "explorer_close",
                  ["<Right>"] = "confirm",

                  -- 2. 新增：捕获 Esc 键，跳回上一个窗口
                  ["<Esc>"] = function()
                    vim.cmd("wincmd p")
                  end,
                },
              },
            },
          },
        },
      },
    },
    keys = {
      {
        "<leader>e",
        function()
          local explorer_pickers = Snacks.picker.get({ source = "explorer" })
          if #explorer_pickers == 0 then
            Snacks.explorer()
          else
            explorer_pickers[1]:focus()
          end
        end,
        desc = "File Explorer (Focus or Open)",
      },
    },
  },
}
