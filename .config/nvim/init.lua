local path = vim.fn.stdpath('data') .. '/site/pack/paqs/start/paq-nvim'
local installed = false

if vim.fn.glob(path) == "" then
    installed = true
    vim.fn.system({ 'git', 'clone', 'https://github.com/savq/paq-nvim', path })
    vim.cmd.packadd('paq-nvim')
end

local paq = require('paq')
paq({ 'savq/paq-nvim',
    'windwp/nvim-autopairs',
    'kylechui/nvim-surround',
    'mattn/emmet-vim',
    'junegunn/vim-easy-align',
    'christoomey/vim-tmux-navigator',
    'nvim-focus/focus.nvim',
    'nvim-tree/nvim-tree.lua',
    'nvim-tree/nvim-web-devicons',
    'phucngodev/modus-themes.nvim',
    'phucngodev/everforest-nvim',
    'willothy/nvim-cokeline',
    'mattn/vim-goaddtags',
    'mattn/vim-goimports',
    'mattn/vim-goimpl',
    'nvim-treesitter/nvim-treesitter',
    'pmizio/typescript-tools.nvim',
    'neovim/nvim-lspconfig',
    'bluz71/nvim-linefly',
    'nvim-lua/plenary.nvim',
    'stevearc/dressing.nvim',
    'MunifTanjim/nui.nvim',
    'MeanderingProgrammer/render-markdown.nvim',
    'mfussenegger/nvim-dap',
    'nvim-neotest/nvim-nio',
    'rcarriga/nvim-dap-ui',
    'leoluz/nvim-dap-go',
    'rafamadriz/friendly-snippets',
    'HakonHarnes/img-clip.nvim',
    'mikavilpas/blink-ripgrep.nvim',
    {'ibhagwan/fzf-lua', branch = 'main'},
    { 'saghen/blink.cmp', branch = 'v1.5.1' },
    {'yetone/avante.nvim', branch = 'main', build = 'make' },
    {'L3MON4D3/LuaSnip', branch = 'v2.4.0', build = 'make install_jsregexp'},
    {'phucngodev/vim-prettier', branch='master',  build = 'npm install --frozen-lockfile --production'},
})

if installed then
    paq.install()
    return
end

vim.o.winborder                 = 'single'
vim.opt.number                  = true
vim.opt.signcolumn              = 'number'
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
vim.opt.list                    = true
vim.opt.listchars:append{tab    =  ' ', space = '·'}
vim.g.mapleader                 = '\\'
vim.g.omni_sql_no_default_maps  = 1
vim.g.user_emmet_install_global = 0
vim.g.user_emmet_expandabbr_key = ',,'
vim.g['prettier#autoformat']                = true
vim.g['prettier#autoformat_require_pragma'] = false
vim.g['prettier#exec_cmd_async']            = true
vim.g['prettier#config#tab_width']          = '2'
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'html', 'svelte', 'typescriptreact', 'typescript.tsx'  },
  command = 'EmmetInstall'
})

vim.g.everforest_background         = 'soft'
vim.g.everforest_better_performance = true
vim.g.everforest_enable_italic      = false
vim.opt.background='light'
vim.cmd.colorscheme('modus')

local get_hex = require('cokeline.hlgroups').get_hl_attr
require('cokeline').setup({
    show_if_buffers_are_at_least = 2,
    sidebar = {
        filetype = {'NvimTree'},
        components = {
            {
                text = '  File Explorer',
            }

        },
    },
    default_hl = {
        bg = function() return get_hex('TabLine', 'bg') end,
        fg = function() return get_hex('TabLine', 'fg') end,
    },
    components = {
        {
            text = function(buffer)
                if buffer.index <= 1 then
                    return ' '
                else
                    return  ' ▏'
                end
            end
        },
        {
            text = function(buffer)
                return buffer.number .. ':' .. buffer.pick_letter .. ':' .. buffer.filename .. ' '
            end,
            fg = function(buffer)
                if buffer.is_focused then
                    return get_hex('Directory', 'fg')
                else
                    return get_hex('TabLine', 'fg')
                end
            end,
        },
        {
            text = function(buffer)
                if buffer.is_last then
                    return '× '
                else
                    return '×'
                end
            end,
            on_click = function(_, _, _, _, buffer)
                buffer:delete()
            end
        },
    },
})

vim.api.nvim_create_augroup('setIndent', { clear = true })
vim.diagnostic.config { float = { border = 'single' }, }
vim.api.nvim_create_autocmd('Filetype', {
  group = 'setIndent',
  pattern = { 'html', 'css', 'scss', 'svelte', 'javascript', 'typescript', 'typescriptreact', 'typescript.tsx' },
  command = 'setlocal shiftwidth=2 tabstop=2'
})

require("nvim-web-devicons").setup({})

require('render-markdown').setup ({
    file_types = { 'markdown', 'Avante' },
    render_modes = { 'n', 'c', 't' },
})

require('img-clip').setup ({ })
require('avante').setup ({
    provider = "ollama",
    providers = {
        ollama = {
            -- endpoint = 'http://127.0.0.1:11434/chat/v1'
            model = 'deepseek-r1:8b',
            disable_tools = true,
        },
    },
    behaviour = {
        auto_suggestions = false,
        auto_set_highlight_group = true,
        auto_set_keymaps = true,
        auto_apply_diff_after_generation = false,
        support_paste_from_clipboard = false,
        minimize_diff = true,
        enable_token_counting = true,
    },
})

require('nvim-autopairs').setup({})
require("nvim-surround").setup({})
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
    fzf_colors = true,
    files = {
        rg_opts = "--files --ignore-case --follow -g '!.git' -g '!vendor' -g '!node_modules' -g '!build'",
    },
    keymap = {
    fzf = {
      ['ctrl-q'] = 'select-all+accept',
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

require("luasnip.loaders.from_vscode").lazy_load()
local source_priority = { path = 1, snippets = 2, ripgrep= 3, buffer = 4, lsp = 5}
require('blink.cmp').setup({
    appearance = {
        use_nvim_cmp_as_default = true,
    },
    keymap = { preset = 'enter',     ['<CR>'] = { 'select_and_accept', 'fallback' }, },
    completion = {
        menu = { border = 'single', },
        documentation = { auto_show = true },
        list = { selection = { preselect = true, auto_insert = false } },
    },
    signature = {enabled = true },
    snippets = { preset = 'luasnip' },
    fuzzy = {
        implementation = "prefer_rust_with_warning",
        sorts = {
            function(a, b)
                local a_priority = source_priority[a.source_id]
                local b_priority = source_priority[b.source_id]
                if a_priority ~= b_priority then return a_priority > b_priority end
            end,
            'score',
            'sort_text'
        },
    },
    sources = {
        default = { 'path', 'snippets', 'ripgrep', 'buffer', 'lsp' },
        providers = {
            buffer = {
                opts = {
                    get_bufnrs = function()
                        return vim.tbl_filter(function(bufnr)
                            return vim.bo[bufnr].buftype == ''
                        end, vim.api.nvim_list_bufs())
                    end
                },

                transform_items = function(_, items)
                    for _, item in ipairs(items) do
                        item.labelDetails = {
                            description = '(BUF)',
                        }
                    end
                    return items
                end,
            },

            lsp = {
                transform_items = function(_, items)
                    for _, item in ipairs(items) do
                        item.labelDetails = {
                            description = '(LSP)',
                        }
                    end
                    return items
                end,
            },

            snippets = {
                transform_items = function(_, items)
                    for _, item in ipairs(items) do
                        item.labelDetails = {
                            description = '(SNIP)',
                        }
                    end
                    return items
                end,
            },

            ripgrep = {
                module = 'blink-ripgrep',
                name = "Ripgrep",
                opts = {
                    prefix_min_len = 3,
                    context_size = 5,
                    max_filesize = '1M',
                    project_root_marker = { '.git', 'go.mod' },
                    project_root_fallback = false,
                    search_casing = "--ignore-case",
                    fallback_to_regex_highlighting = true,
                },
                transform_items = function(_, items)
                    for _, item in ipairs(items) do
                        item.labelDetails = {
                            description = '(RG)',
                        }
                    end
                    return items
                end,
            },
        },
    },
    cmdline = {
        enabled = false,
    }
})

local signs = { Error = '', Warn = '', Info = '', Hint = '󰛩' }
vim.g.linefly_options = {
    with_lsp_status = false,
    with_attached_clients = false,
    error_symbol = signs['Error'],
    warning_symbol = signs['Warn'],
    information_symbol = signs['Info'],
}

vim.diagnostic.config({
    underline = false,
    virtual_text = {
        severity = { min = vim.diagnostic.severity.WARN },
        prefix = function(diagnostic)
            if diagnostic.severity == vim.diagnostic.severity.ERROR then
                return signs['Error']
            elseif diagnostic.severity == vim.diagnostic.severity.WARN then
                return signs['Warn']
            elseif diagnostic.severity == vim.diagnostic.severity.INFO then
                return signs['Info']
            else
                return signs['Hint']
            end
        end
    },
    signs = {
        -- severity = { min = vim.diagnostic.severity.WARN },
        text = {
            [vim.diagnostic.severity.ERROR] = signs['Error'],
            [vim.diagnostic.severity.WARN] = signs['Warn'],
            [vim.diagnostic.severity.INFO] = signs['Info'],
            [vim.diagnostic.severity.HINT] = signs['Hint'],
        },
    },
})

local nvim_lsp = require('lspconfig')
local capabilities = require('blink.cmp').get_lsp_capabilities()
local handlers = {
	["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover),
	["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help),
    ["textDocument/publishDiagnostics"] = vim.lsp.with( vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = true, underline = false }),
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

--- config debugger
local dap, dapui, dapgo = require('dap'),require('dapui'), require('dap-go')
dapgo.setup({})
dap.configurations.go = {
    {
          name = 'Debug web',
          type = "go",
          request = 'launch',
          program = './cmd/server/main.go',
          cwd = '${workspaceFolder}',
          buildFlags = '-tags=dev',
    },
    {
      name = 'Debug',
      type = 'go',
      request = 'launch',
      program = '${file}',
      buildFlags = dapgo.build_flags,
    },
    {
      name = 'Debug test',
      type = 'go',
      request = 'launch',
      mode = 'test',
      program = './${relativeFileDirname}',
      buildFlags = dapgo.build_flags,
    },
}

dapui.setup({
    layouts = { {
        elements = { 
            {
                id = 'breakpoints',
                size = 0.25
            }, 
            {
                id = 'stacks',
                size = 0.25
            },
            {
                id = 'watches',
                size = 0.25
            },
            {
                id = 'repl',
                size = 0.25
            }, 
        },
        position = 'left',
        size = 40
      },
        {
        elements = { 
          {
            id = 'scopes',
            size = 1
          }, 
        },
        position = 'bottom',
        size = 10
      } 
    },
})

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
vim.keymap.set('n', '<leader>b', require 'dap'.toggle_breakpoint)

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
vim.keymap.set('n', '<c-[>', '<Plug>(cokeline-pick-focus)', opts)

