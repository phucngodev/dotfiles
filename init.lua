local path = vim.fn.stdpath('data') .. '/site/pack/paqs/start/paq-nvim'
local installed = false

if vim.fn.glob(path) == "" then
    installed = true
    vim.fn.system({ 'git', 'clone', 'https://github.com/savq/paq-nvim', path })
    vim.cmd.packadd('paq-nvim')
end

local paq = require('paq')
paq({
    'savq/paq-nvim',
    'windwp/nvim-autopairs',
    'mattn/emmet-vim',
    'junegunn/vim-easy-align',
    'nvim-focus/focus.nvim',
    'christoomey/vim-tmux-navigator',
    'nvim-tree/nvim-tree.lua',
    'nvim-tree/nvim-web-devicons',
    'phucngodev/edge',
    'mattn/vim-goaddtags',
    'mattn/vim-goimports',
    'mattn/vim-goimpl',
    'nvim-treesitter/nvim-treesitter',
    'pmizio/typescript-tools.nvim',
    'neovim/nvim-lspconfig',
    'onsails/lspkind.nvim',
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-vsnip',
    'hrsh7th/vim-vsnip',
    'rafamadriz/friendly-snippets',
    'bluz71/nvim-linefly',
    'nvim-lua/plenary.nvim',
    'stevearc/dressing.nvim',
    'MunifTanjim/nui.nvim',
    'MeanderingProgrammer/render-markdown.nvim',
    'mfussenegger/nvim-dap',
    'nvim-neotest/nvim-nio',
    'rcarriga/nvim-dap-ui',
    'leoluz/nvim-dap-go',
    'mxsdev/nvim-dap-vscode-js',
    {'yetone/avante.nvim', branch = 'main', build = 'make' },
    {'ibhagwan/fzf-lua', branch = 'main'},
    {'prettier/vim-prettier', branch='master',  build = 'npm install --frozen-lockfile --production'},
})

if installed then
    paq.install()
    return
end

vim.opt.number                  = true
vim.opt.relativenumber          = true
vim.opt.hidden                  = true
vim.opt.expandtab               = true
vim.opt.autoindent              = true
vim.opt.smartindent             = true
vim.opt.hlsearch                = true
vim.opt.incsearch               = true
vim.opt.termguicolors           = true
vim.wo.wrap                     = false
vim.opt.ignorecase              = true
vim.g.terraform_align           = true
vim.g.terraform_fmt_on_save     = true
vim.g.loaded_netrw              = false
vim.g.loaded_netrwPlugin        = false
vim.opt.tabstop                 = 4
vim.opt.shiftwidth              = 4
vim.opt.filetype                = 'on'
vim.opt.filetype.plugin         = 'on'
vim.opt.filetype.indent         = 'on'
vim.opt.syntax                  = 'on'
vim.opt.encoding                = 'utf-8'
vim.opt.completeopt             = 'menu,menuone,noselect'
vim.opt.backspace               = 'indent,eol,start'
vim.opt.clipboard:append { 'unnamed', 'unnamedplus' }
vim.opt.laststatus              = 3
-- vim.opt.list                    = true
-- vim.opt.listchars:append{tab    = "→ ", space = "⋅"}
vim.g.mapleader                 = '\\'
vim.g.omni_sql_no_default_maps  = 1
vim.g.user_emmet_install_global = 0
vim.g.user_emmet_expandabbr_key = ',,'
vim.g['prettier#autoformat']                = true
vim.g['prettier#autoformat_require_pragma'] = false
vim.g['prettier#exec_cmd_async']            = true
vim.g['prettier#config#tab_width']          = '2'
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'html', 'svelte' },
  command = 'EmmetInstall'
})

vim.g.edge_disable_italic_comment = true
vim.g.edge_better_performance     = true
vim.opt.background                = 'light'
vim.cmd 'colorscheme edge'

vim.api.nvim_create_augroup('setIndent', { clear = true })
vim.diagnostic.config { float = { border = 'rounded' }, }
vim.api.nvim_create_autocmd('Filetype', {
  group = 'setIndent',
  pattern = { 'html', 'css', 'scss', 'svelte', 'javascript' },
  command = 'setlocal shiftwidth=2 tabstop=2'
})

require("nvim-web-devicons").setup {
    override_by_filename = {
        [".prettierrc"] = {
            icon = "󰒓",
            name = "Prettier"
        },
        [".prettierignore"] = {
            icon = "󰒓",
            name = "Prettier"
        },
    },
}

require('render-markdown').setup ({
    opts = {
      file_types = { "markdown", "Avante" },
    },
    ft = { "markdown", "Avante" },
})

require('avante_lib').load()
require('avante').setup ({
    provider = "ollama",
    vendors = {
        ollama = {
            ["local"] = true,
            endpoint = "127.0.0.1:11434/v1",
            model = "qwen2.5-coder",
            parse_curl_args = function(opts, code_opts)
                return {
                    url = opts.endpoint .. "/chat/completions",
                    headers = {
                        ["Accept"] = "application/json",
                        ["Content-Type"] = "application/json",
                    },
                    body = {
                        model = opts.model,
                        messages = require("avante.providers").copilot.parse_messages(code_opts),
                        max_tokens = 2048,
                        stream = true,
                    },
                }
            end,
            parse_response_data = function(data_stream, event_state, opts)
                require("avante.providers").openai.parse_response(data_stream, event_state, opts)
            end,
        },
    },
})


local signs = { Error = '󰅙', Info = '󰋼', Hint = '󰌵', Warn = '' }
vim.g.linefly_options = {
    with_lsp_status = false,
    with_attached_clients = false,
    error_symbol = '󰅙',
    warning_symbol = '',
    information_symbol = '󰌵',
}
require('nvim-autopairs').setup{}
require("focus").setup({
    ui = { signcolumn = false },
    autoresize = {
        enable = true,
        minwidth = 30,
    },
})

local ignore_filetypes = { 'NvimTree', 'dapui_stacks', 'dap-repl', 'dapui_breakpoints', 'dapui_scopes' }
local augroup = vim.api.nvim_create_augroup('FocusDisable', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
    group = augroup,
    callback = function(_)
        if vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then
            vim.b.focus_disable = true
        else
            vim.b.focus_disable = false
        end
    end,
    desc = 'Disable focus autoresize for FileType',
})

require("nvim-tree").setup({
    renderer = {
        root_folder_label = false,
        icons = {
            show  = {
                git = false,
                folder_arrow = false,
            }
        },
    },
    view = {
        side = 'left',
    },
    filters = {
        custom = { '^.git$', '^node_modules$', '^.DS_Store$' },
    }
})

require('fzf-lua').setup{
    file_ignore_patterns = { '%.git$', '%node_modules$', '%vendor$' },
    files = {
        rg_opts = "--files --ignore-case --follow -g '!.git' -g '!vendor' -g '!node_modules' -g '!build'",
    },
    keymap = {
    fzf = {
      ["ctrl-q"] = "select-all+accept",
    }
  },
}

require'nvim-treesitter.configs'.setup {
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false
    },
    indent = {
        enable = true,
    }
}

-- config diagnostics sign icon
local signs = { Error = '󰅙', Info = '󰋼', Hint = '󰌵', Warn = '' }
for type, icon in pairs(signs) do
    local hl = 'DiagnosticSign' .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local nvim_lsp = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local handlers = {
	["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' }),
	["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' }),
    ["textDocument/publishDiagnostics"] = vim.lsp.with( vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = true, underline = true }),
}

local servers = {'gopls', 'tailwindcss' }
for _, server in ipairs(servers) do
    nvim_lsp[server].setup({
        capabilities = capabilities,
        handlers = handlers,
        autostart = true,
    })
end

require("typescript-tools").setup({
    capabilities = capabilities,
    handlers = handlers,
    autostart = false,
    settings = {
        separate_diagnostic_server = false,
        code_lens = "off",
    }
})


local lspkind = require('lspkind')
local cmp = require'cmp'
cmp.setup({
    snippet = {
         expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
         end,
    },
    formatting = {
        format = lspkind.cmp_format({}),
    },
    window = {
        completion = {
            border = 'rounded',
        },
        documentation = {
            border = 'rounded'
        }
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
        { name = 'buffer' },
        { name = 'nvim_lsp' },
        { name = 'vsnip' },
    }),
})



--- config debugger
local dap, dapui, dapgo = require("dap"),require("dapui"), require("dap-go")
dapgo.setup({})
dap.configurations.go = {
    {
          name = "Debug web",
          type = "go",
          request = "launch",
          program = "./cmd/server/main.go",
          cwd = "${workspaceFolder}",
          buildFlags = "-tags=dev",
    },
    {
      name = "Debug",
      type = "go",
      request = "launch",
      program = "${file}",
      buildFlags = dapgo.build_flags,
    },
    {
      name = "Debug test",
      type = "go",
      request = "launch",
      mode = "test",
      program = "./${relativeFileDirname}",
      buildFlags = dapgo.build_flags,
    },
}

dapui.setup({
    layouts = { {
        elements = { 
            {
                id = "breakpoints",
                size = 0.25
            }, 
            {
                id = "stacks",
                size = 0.25
            },
            {
                id = "watches",
                size = 0.25
            },
            {
                id = "repl",
                size = 0.25
            }, 
        },
        position = "left",
        size = 40
      },
        {
        elements = { 
          {
            id = "scopes",
            size = 1
          }, 
        },
        position = "bottom",
        size = 10
      } 
    },
})

require("dap-vscode-js").setup({
  debugger_path = vim.fn.stdpath('data') .. "/vscode-js-debug",
  adapters = { 'pwa-node', 'pwa-chrome' },
})

local js_based_languages = { "typescript", "javascript" }
for _, language in ipairs(js_based_languages) do
  require("dap").configurations[language] = {
    {
      name = "Node",
      type = "pwa-node",
      request = "launch",
      program = "${file}",
      cwd = "${workspaceFolder}",
    },
    {
      name = "Chrome",
      type = "pwa-chrome",
      request = "launch",
      url = "http://localhost:7000",
      webRoot = "${workspaceFolder}",
    }
  }
end

dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end


vim.api.nvim_set_hl(0, 'DapBreakpoint', { ctermbg = 0, fg = '#f70707' })
vim.api.nvim_set_hl(0, 'DapStopped', { ctermbg = 0, fg = '#98c379' })
vim.fn.sign_define('DapBreakpoint', { text='', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl='DapBreakpoint' })
vim.fn.sign_define('DapStopped', { text='', texthl='DapStopped', linehl='DapStopped', numhl= 'DapStopped' })

vim.keymap.set('n', '<leader>d', require 'dap'.continue)
vim.keymap.set('n', '<leader>t', require 'dap'.terminate)
vim.keymap.set('n', '<leader>r', require 'dap'.restart)
vim.keymap.set('n', '<leader>b', require 'dap'.toggle_breakpoint)
vim.keymap.set('n', '<leader>n', require 'dap'.step_over)
vim.keymap.set('n', '<leader>s', require 'dap'.step_into)
vim.keymap.set('n', '<leader>o', require 'dap'.step_out)

vim.keymap.set('n', '<leader>k', "<cmd>lua require('dapui').eval()<CR>", opts)

-- custom mapping
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<C-j>', '<C-W>j', opts)
vim.keymap.set('n', '<C-k>', '<C-W>k', opts)
vim.keymap.set('n', '<C-h>', '<C-W>h', opts)
vim.keymap.set('n', '<C-l>', '<C-W>l', opts)
vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
vim.keymap.set('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.keymap.set('n', '<space>ca', '<cmd> lua vim.lsp.buf.code_action()<CR>', opts)
vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>', opts)
vim.keymap.set('n', '<c-p>', "<cmd>lua require('fzf-lua').files({ cwd_prompt = false, prompt = 'Files❯ ' })<CR>", opts)
vim.keymap.set('n', '<c-f>', "<cmd>lua require('fzf-lua').buffers()<CR>", opts)
vim.keymap.set('n', '<c-g>', "<cmd>lua require('fzf-lua').live_grep_native()<CR>", opts)
vim.keymap.set('n', '<c-s>', "<cmd>lua require('fzf-lua').lgrep_curbuf()<CR>", opts)
vim.keymap.set('v', 'ga', '<Plug>(EasyAlign)', opts)
vim.keymap.set('n', 'ga', '<Plug>(EasyAlign)', opts)

