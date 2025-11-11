-- 文件路径: ~/.config/nvim/lua/plugins/conform.lua
return {
  "stevearc/conform.nvim",
  -- 我们在这里添加一个 `keys` 表格来定义我们自己的快捷键
  keys = {
    {
      -- 这是我们新的快捷键
      "<leader>fm",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      mode = "n", -- 只在普通模式下生效
      desc = "Format Document", -- which-key 的描述
    },
    {
      -- 同时为可视模式也设置一个快捷键
      "<leader>fm",
      function()
        require("conform").format()
      end,
      mode = "v", -- 只在可视模式下生效
      desc = "Format Range", -- which-key 的描述
    },
  },
  opts = {
    -- 在这里定义不同文件类型应该使用哪个格式化工具
    formatters_by_ft = {
      -- Lua 文件使用 stylua
      lua = { "stylua" },

      -- Python 文件使用 isort 先排序 import，然后用 black 格式化代码
      python = { "isort", "black" },

      -- C 和 C++ 文件使用 clang-format
      c = { "clang-format" },
      cpp = { "clang-format" },

      -- java用clang-format
      java = { "clang-format" },

      -- 前端和其他文件使用 prettier
      javascript = { "prettier" },
      typescript = { "prettier" },
      javascriptreact = { "prettier" },
      typescriptreact = { "prettier" },
      vue = { "prettier" },
      css = { "prettier" },
      scss = { "prettier" },
      less = { "prettier" },
      html = { "prettier" },
      json = { "prettier" },
      yaml = { "prettier" },
      markdown = { "prettier" },
      graphql = { "prettier" },

      -- Shell 脚本使用 shfmt
      sh = { "shfmt" },
      zsh = { "shfmt" },
      bash = { "shfmt" },
    },

    -- 警告信息让我们删除这里的 format_on_save
    -- 因为 LazyVim 会自动处理！
    -- 我们已经删除了 format_on_save = { ... }
  },
}
