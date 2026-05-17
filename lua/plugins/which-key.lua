return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      opts.spec = opts.spec or {}

      -- 严格按照 Which-Key v3 新版规范：前缀大类用 group，具体按键功能用 desc 重写标签
      local chinese_mappings = {
        -- ====== 基础与全局 ======
        { "<leader>,", desc = "缓冲区" },
        { "<leader>-", desc = "下分窗" },
        { "<leader>|", desc = "右分窗" },
        { "<leader>.", desc = "切换草稿缓冲区" },
        { "<leader>/", desc = "Grep（根目录）" },
        { "<leader>:", desc = "命令历史" },
        { "<leader><space>", desc = "查找文件（根目录）" },
        { "<leader>?", desc = "缓冲区键位映射" },
        { "<leader>`", desc = "切换其他缓冲区" },
        { "<leader>D", desc = "切换 DBUI" },
        { "<leader>E", desc = "文件浏览器（当前目录）" },
        { "<leader>K", desc = "关键字程序" },
        { "<leader>L", desc = "LazyVim 更新日志" },
        { "<leader>S", desc = "选择草稿缓冲区" },

        -- ====== 标签页 (Tab) ======
        { "<leader><tab>", group = "标签" },
        { "<leader><tab><tab>", desc = "新建标签" },
        { "<leader><tab>[", desc = "上一个标签" },
        { "<leader><tab>]", desc = "下一个标签" },
        { "<leader><tab>d", desc = "关闭标签" },
        { "<leader><tab>f", desc = "第一个标签" },
        { "<leader><tab>l", desc = "最后一个标签" },
        { "<leader><tab>o", desc = "关闭其他标签" },

        -- ====== 缓冲区 (Buffer) ======
        { "<leader>b", group = "缓冲区" },
        { "<leader>bD", desc = "删除缓冲区和窗口" },
        { "<leader>bP", desc = "删除非固定缓冲区" },
        { "<leader>bb", desc = "切换其他缓冲区" },
        { "<leader>bd", desc = "删除缓冲区" },
        { "<leader>bl", desc = "删除左侧的缓冲区" },
        { "<leader>bo", desc = "删除其他缓冲区" },
        { "<leader>bp", desc = "切换固定" },
        { "<leader>br", desc = "删除右侧的缓冲区" },

        -- ====== 代码 (Code) ======
        { "<leader>c", group = "代码" },
        { "<leader>cF", desc = "格式化注入语言" },
        { "<leader>cS", desc = "LSP 引用/定义（Trouble）" },
        { "<leader>cd", desc = "行诊断" },
        { "<leader>cf", desc = "格式化" },
        { "<leader>cn", desc = "Mason 包管理器" },
        { "<leader>cs", desc = "符号（Trouble）" },

        -- ====== 调试 (Debug) ======
        { "<leader>d", group = "调试" },
        { "<leader>dp", desc = "性能分析" },

        -- ====== 文件/查找 (File) ======
        { "<leader>e", desc = "文件浏览器（根目录）" },
        { "<leader>f", group = "文件/查找" },
        { "<leader>fB", desc = "缓冲区（全部）" },
        { "<leader>fE", desc = "文件浏览器（当前目录）" },
        { "<leader>fF", desc = "查找文件（当前目录）" },
        { "<leader>fR", desc = "最近文件（当前目录）" },
        { "<leader>fT", desc = "终端（当前目录）" },
        { "<leader>fb", desc = "缓冲区" },
        { "<leader>fc", desc = "查找配置文件" },
        { "<leader>fe", desc = "文件浏览器（根目录）" },
        { "<leader>ff", desc = "查找文件（根目录）" },
        { "<leader>fg", desc = "查找文件（Git 文件）" },
        { "<leader>fn", desc = "新建文件" },
        { "<leader>fp", desc = "项目" },
        { "<leader>fr", desc = "最近文件" },
        { "<leader>ft", desc = "终端（根目录）" },

        -- ====== Git & GitHub ======
        { "<leader>gB", desc = "在浏览器打开" },
        { "<leader>gD", desc = "差异（origin）" },
        { "<leader>gG", desc = "GitUI（当前目录）" },
        { "<leader>gI", desc = "GitHub 议题（全部）" },
        { "<leader>gL", desc = "日志（当前目录）" },
        { "<leader>gP", desc = "GitHub 拉取请求（全部）" },
        { "<leader>gS", desc = "暂存（stash）" },
        { "<leader>gY", desc = "复制链接" },
        { "<leader>gb", desc = "逐行作者" },
        { "<leader>gd", desc = "差异（块）" },
        { "<leader>gg", desc = "GitUI（根目录）" },
        { "<leader>gi", desc = "GitHub 议题（打开）" },
        { "<leader>gp", desc = "GitHub 拉取请求（打开）" },
        { "<leader>gs", desc = "状态" },
        { "<leader>Gc", desc = "提交" },
        { "<leader>Gi", desc = "议题" },
        { "<leader>Gl", desc = "Litee" },
        { "<leader>Gp", desc = "拉取请求" },
        { "<leader>Gr", desc = "评审" },
        { "<leader>Gt", desc = "线程" },

        -- ====== 系统与包管理 ======
        { "<leader>l", group = "Lazy" },
        { "<leader>n", desc = "通知历史" },

        -- ====== 退出/会话 (Quit) ======
        { "<leader>q", group = "退出/会话" },
        { "<leader>qS", desc = "选择会话" },
        { "<leader>qd", desc = "不保存当前会话" },
        { "<leader>ql", desc = "恢复上次会话" },
        { "<leader>qq", desc = "退出全部" },
        { "<leader>qs", desc = "恢复会话" },

        -- ====== 搜索与功能 (Search) ======
        { "<leader>s", group = "搜索" },
        { '<leader>s"', desc = "寄存器" },
        { "<leader>s/", desc = "搜索历史" },
        { "<leader>sB", desc = "Grep 打开的缓冲区" },
        { "<leader>sC", desc = "命令" },
        { "<leader>sD", desc = "缓冲区诊断" },
        { "<leader>sG", desc = "Grep（当前目录）" },
        { "<leader>sH", desc = "高亮" },
        { "<leader>sM", desc = "Man 手册" },
        { "<leader>sR", desc = "恢复" },
        { "<leader>sT", desc = "待办/修复/修复我" },
        { "<leader>sW", desc = "可视选区或词（当前目录）" },
        { "<leader>sa", desc = "自动命令" },
        { "<leader>sb", desc = "缓冲区行" },
        { "<leader>sc", desc = "命令历史" },
        { "<leader>sd", desc = "诊断" },
        { "<leader>sg", desc = "Grep（根目录）" },
        { "<leader>sh", desc = "帮助页" },
        { "<leader>si", desc = "图标" },
        { "<leader>sj", desc = "跳转" },
        { "<leader>sk", desc = "键位映射" },
        { "<leader>sl", desc = "位置列表" },
        { "<leader>sm", desc = "标记" },
        { "<leader>sn", group = "+noice" },
        { "<leader>sna", desc = "Noice 全部" },
        { "<leader>snd", desc = "全部关闭" },
        { "<leader>snh", desc = "Noice 历史" },
        { "<leader>snl", desc = "Noice 最近消息" },
        { "<leader>snt", desc = "Noice 选择器" },
        { "<leader>sp", desc = "搜索插件规范" },
        { "<leader>sq", desc = "快速修复列表" },
        { "<leader>sr", desc = "查找并替换" },
        { "<leader>st", desc = "待办" },
        { "<leader>su", desc = "撤销树" },
        { "<leader>sw", desc = "可视选区或词（根目录）" },

        -- ====== 界面开关 (UI) ======
        --
        { "<leader>u", group = "界面" },
        { "<leader>uA", desc = "启用标签栏" },
        { "<leader>uD", desc = "启用暗化" },
        { "<leader>uF", desc = "缓冲区禁用自动格式化" },
        { "<leader>uG", desc = "关闭 Git 标记" },
        { "<leader>uI", desc = "检查语法树" },
        { "<leader>uL", desc = "启用相对行号" },
        { "<leader>uS", desc = "禁用平滑滚动" },
        { "<leader>uT", desc = "启用 Treesitter 高亮" },
        { "<leader>uZ", desc = "启用缩放模式" },
        { "<leader>ua", desc = "关闭动画" },
        { "<leader>ub", desc = "关闭深色背景" },
        { "<leader>uc", desc = "关闭隐藏级别" },
        { "<leader>ud", desc = "关闭诊断" },
        { "<leader>uf", desc = "全局禁用自动格式化" },
        { "<leader>ug", desc = "启用缩进指引" },
        { "<leader>uh", desc = "启用内联提示" },
        { "<leader>ui", desc = "检查位置" },
        { "<leader>ul", desc = "启用行号" },
        { "<leader>um", desc = "关闭渲染 Markdown" },
        { "<leader>un", desc = "关闭所有通知" },
        { "<leader>up", desc = "禁用 Mini Pairs" },
        { "<leader>ur", desc = "重绘/清除搜索高亮/更新差异" },
        { "<leader>us", desc = "启用拼写检查" },
        { "<leader>uw", desc = "启用换行" },
        { "<leader>uz", desc = "启用禅模式" },

        -- ====== 窗口 (Window) ======
        { "<leader>w", group = "窗口" },
        { "<leader>wd", desc = "删除窗口" },
        { "<leader>wm", desc = "启用缩放模式" },

        -- ====== 诊断与快速修复 (Trouble) ======
        { "<leader>x", group = "诊断/快速修复" },
        { "<leader>xL", desc = "位置列表（Trouble）" },
        { "<leader>xQ", desc = "快速修复列表（Trouble）" },
        { "<leader>xT", desc = "待办/修复/修复我（Trouble）" },
        { "<leader>xX", desc = "缓冲区诊断（Trouble）" },
        { "<leader>xl", desc = "位置列表" },
        { "<leader>xq", desc = "快速修复列表" },
        { "<leader>xt", desc = "待办（Trouble）" },
        { "<leader>xx", desc = "诊断（Trouble）" },

        -- 2. 补全缺失的具体按键汉化 (Code/LSP 相关)
        { "<leader>ca", desc = "代码动作 (Code Action)" },
        { "<leader>cA", desc = "源码动作 (Source Action)" },
        { "<leader>cr", desc = "重命名 (Rename)" },
        { "<leader>cR", desc = "重命名文件 (Rename File)" },
        { "<leader>cl", desc = "LSP 信息 (Lsp Info)" },
        { "<leader>cc", desc = "运行 Codelens (Run Codelens)" },
        { "<leader>cC", desc = "刷新并显示 Codelens (Refresh & Display Codelens)" },
      }

      -- 安全注入配置
      for _, v in ipairs(chinese_mappings) do
        table.insert(opts.spec, v)
      end
    end,
  },
}
