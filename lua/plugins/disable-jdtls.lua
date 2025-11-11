-- ~/.config/nvim/lua/plugins/disable-jdtls.lua
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        jdtls = false, -- 禁用 jdtls
      },
    },
  },
}
