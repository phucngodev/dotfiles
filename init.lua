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
    'numToStr/Comment.nvim',
    'windwp/nvim-autopairs',
    'mattn/emmet-vim',
    'uarun/vim-protobuf',
    'neovim/nvim-lspconfig',
    'nvim-focus/focus.nvim',
    'nvim-tree/nvim-tree.lua',
    'nvim-tree/nvim-web-devicons',
    'phucngodev/edge',
    'mattn/vim-goimports',
    'mattn/vim-goaddtags',
    'junegunn/vim-easy-align',
    'nvim-treesitter/nvim-treesitter',
    "nvim-lua/plenary.nvim",
    'pmizio/typescript-tools.nvim',
    'onsails/lspkind.nvim',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-vsnip',
    'hrsh7th/vim-vsnip',
    'rafamadriz/friendly-snippets',
    'christoomey/vim-tmux-navigator',
    'akinsho/bufferline.nvim',
    'bluz71/nvim-linefly',
    'Exafunction/codeium.nvim',
    {'ibhagwan/fzf-lua', branch = 'main'},
    {'prettier/vim-prettier', branch='master',  build = 'npm install --frozen-lockfile --production --legacy-peer-deps'}
})

if installed then
    paq.install()
    return
end


vim.opt.number                              = true
vim.opt.hidden                              = true
vim.opt.expandtab                           = true
vim.opt.autoindent                          = true
vim.opt.smartindent                         = true
vim.opt.hlsearch                            = true
vim.opt.incsearch                           = true
vim.opt.termguicolors                       = true
vim.wo.wrap                                 = false
vim.opt.ignorecase                          = true
vim.g.terraform_align                       = true
vim.g.terraform_fmt_on_save                 = true
vim.g.loaded_netrw                          = false
vim.g.loaded_netrwPlugin                    = false
vim.opt.tabstop                             = 4
vim.opt.shiftwidth                          = 4
vim.opt.filetype                            = "on"
vim.opt.syntax                              = "on"
vim.opt.encoding                            = "utf-8"
vim.opt.completeopt                         = "menu,menuone,noselect"
vim.opt.backspace                           = "indent,eol,start"
vim.opt.clipboard                           = "unnamedplus"
vim.opt.laststatus                          = 3
vim.g.mapleader                             = "\\"
-- vim.opt.list                                = true
-- vim.opt.listchars:append{tab                = "→ ", space = "⋅"}
vim.opt.fillchars                           = { vert = "|", }
vim.g.omni_sql_no_default_maps              = 1
vim.g['prettier#autoformat']                = true
vim.g['prettier#autoformat_require_pragma'] = false
vim.g['prettier#exec_cmd_async']            = true
vim.g['prettier#config#tab_width']          = '2'
vim.g.user_emmet_install_global             = 0
vim.g.user_emmet_expandabbr_key             = '<TAB>'
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'html', 'gohtml', 'css', 'scss', 'javascript', 'typescript', 'jsx', 'tsx', 'typescriptreact', 'javascriptreact', 'svelte' },
  command = 'EmmetInstall'
})

vim.g.edge_disable_italic_comment           = true
vim.g.edge_better_performance               = true
vim.opt.background                          = "light"
vim.cmd("colorscheme edge")

vim.g.linefly_options = { with_attached_clients = false }
vim.api.nvim_create_augroup('setIndent', { clear = true })
vim.api.nvim_create_autocmd('Filetype', {
  group = 'setIndent',
  pattern = { 'html', 'gohtml', 'css', 'scss', 'javascript', 'typescript', 'jsx', 'tsx', 'typescriptreact', 'javascriptreact', 'svelte' },
  command = 'setlocal shiftwidth=2 tabstop=2'
})

require('nvim-autopairs').setup{}
require('Comment').setup()
require("bufferline").setup({
    options = {
        always_show_bufferline = false,
        numbers = function(opts)
          return opts.id
        end,
    },
})
require("focus").setup({ ui = { signcolumn = false } })
require("codeium").setup({})

local ignore_filetypes = { 'NvimTree' }
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
        exclude = { '.env' },
        custom = { '^.git$', '^node_modules$', '^.DS_Store$' ,'^.next$', '^__pycache__$', '^.svelte-kit$' },
    }
})

require('fzf-lua').setup{
    files = {
        rg_opts = "--files --ignore-case --hidden --follow -g '!.git' -g '!vendor' -g '!node_modules' -g '!venv' -g '!__pycache__'",
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
    },
    indent = {
        enable = true,
    }
}

-- config diagnostics sign icon
local signs = { Error = "♳", Warn = "♴", Hint = "♵", Info = "♺" }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text     = false,
        underline        = true,
    }
)

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover,
    {
        border = 'rounded',
    }
)

vim.diagnostic.config {
    float = { border = "rounded" },
}

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    {
        border = "single"
    }
)

require("typescript-tools").setup({
    settings = {
        separate_diagnostic_server = false,
        code_lens = "off",
    }
})

local lspkind = require('lspkind')
local cmp = require'cmp'
cmp.setup({
    formatting = {
        format = lspkind.cmp_format({
            mode = "symbol",
            maxwidth = 50,
            ellipsis_char = '...',
            symbol_map = { Codeium = "", }
        }),
    },
    window = {
        completion = {
            border = 'rounded',
            winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
            col_offset = -3,
            side_padding = 0,
        },
        documentation = {
            border = 'rounded'
        }
    },
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
        { name = 'vsnip' },
        { name = 'nvim_lsp' },
        { name = 'codeium' },
    }, {
        { name = 'buffer' },
    }),
})

local nvim_lsp = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()
nvim_lsp['gopls'].setup{
    root_dir = function()
        return vim.loop.cwd()
    end,
    cmd = {'gopls'},
    capabilities = capabilities,
    init_options = {
        usePlaceholders = true,
        directoryFilters = {"-**/node_modules", "-web"},
    }
}

nvim_lsp.tailwindcss.setup {
    root_dir = function()
        return vim.loop.cwd()
    end,
    capabilities = capabilities,
    filetypes = { "html", "javascriptreact", "typescriptreact", "gohtml", "svelte" }
}

nvim_lsp.svelte.setup {
    capabilities = capabilities,
    root_pattern = {"svelte.config.js"},
}

-- custom mapping
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<C-j>', '<C-W>j', opts)
vim.keymap.set('n', '<C-k>', '<C-W>k', opts)
vim.keymap.set('n', '<C-h>', '<C-W>h', opts)
vim.keymap.set('n', '<C-l>', '<C-W>l', opts)
vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
vim.keymap.set('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.keymap.set('n', '<space>ca', '<cmd> lua vim.lsp.buf.code_action()<CR>', opts)
vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>', opts)
vim.keymap.set('n', '<c-p>', "<cmd>lua require('fzf-lua').files()<CR>", opts)
vim.keymap.set('n', '<Leader>p', "<cmd>lua require('fzf-lua').buffers()<CR>", opts)
vim.keymap.set('n', '<c-s>', "<cmd>lua require('fzf-lua').grep_project()<CR>", opts)
vim.keymap.set('n', '<Leader>s', "<cmd>lua require('fzf-lua').lgrep_curbuf()<CR>", opts)
vim.keymap.set('v', 'ga', '<Plug>(EasyAlign)', opts)
vim.keymap.set('n', 'ga', '<Plug>(EasyAlign)', opts)

