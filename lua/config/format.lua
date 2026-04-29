return {
  "stevearc/conform.nvim",
  dependencies = { "mason.nvim" }, -- 确保 Mason 先加载
  opts = {
    -- 重点：让 conform 自动去 Mason 找格式化工具
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "black" },
      json = { "prettier" },
      html = { "prettier" },
      javascript = { "prettier" },
      markdown = { "prettier" },
    },
    -- 如果找不到命令，不报错，这样更丝滑
    format_on_save = false,
  },
  config = function(_, opts)
    -- 这一行非常重要：它能强制把 Mason 的路径加入到 conform 搜索范围内
    require("conform").setup(opts)
  end,
}
