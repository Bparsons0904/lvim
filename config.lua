lvim.plugins = {
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    event = "BufRead",
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build =
    'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
  },
  {
    "tpope/vim-surround",
  },
  -- make sure to change the value of `timeoutlen` if it's not triggering correctly, see https://github.com/tpope/vim-surround/issues/117
  -- setup = function()
  --  vim.o.timeoutlen = 500
  -- end
  {
    "davidmh/cspell.nvim",
    -- config = function()
    --   require("cspell").setup({
    --     find_json = function()
    --       return "~/.config/lvim/"
    --     end
    --   })
    -- end,
  },
  {
    "zbirenbaum/copilot-cmp",
    event = "InsertEnter",
    dependencies = { "zbirenbaum/copilot.lua" },
    config = function()
      vim.defer_fn(function()
        require("copilot").setup()     -- https://github.com/zbirenbaum/copilot.lua/blob/master/README.md#setup-and-configuration
        require("copilot_cmp").setup() -- https://github.com/zbirenbaum/copilot-cmp/blob/master/README.md#configuration
      end, 100)
    end,
  },
  {
    "olexsmir/gopher.nvim"
  },
  {
    "leoluz/nvim-dap-go"
  },
  {
    'kevinhwang91/nvim-hlslens',
    config = function()
      require("scrollbar.handlers.search").setup({
        -- hlslens config overrides
      })
      -- require('hlslens').setup()
    end
  },
  {
    "petertriho/nvim-scrollbar",
    config = function()
      require("scrollbar").setup()
      -- require("nvim-scrollbar").setup({
      -- auto_hide = true,
      -- auto_hide_timeout = 1000,
      -- auto_hide_lastline = true,
      -- require("scrollbar.handlers.search").setup({}),
      -- })
    end,
  }
}

-- table.insert(lvim.plugins, {
--   "zbirenbaum/copilot-cmp",
--   event = "InsertEnter",
--   dependencies = { "zbirenbaum/copilot.lua" },
--   config = function()
--     vim.defer_fn(function()
--       require("copilot").setup()     -- https://github.com/zbirenbaum/copilot.lua/blob/master/README.md#setup-and-configuration
--       require("copilot_cmp").setup() -- https://github.com/zbirenbaum/copilot-cmp/blob/master/README.md#configuration
--     end, 100)
--   end,
-- })
-- Add require("scrollbar").setup() to the gitsignts install

lvim.builtin.telescope.on_config_done = function(telescope)
  pcall(telescope.load_extension, "frecency")
  pcall(telescope.load_extension, "neoclip")
  pcall(telescope.load_extension, "fzf-native")
  -- any other extensions loading
end

lvim.builtin.project.patterns = { ".git" }
-- Keybindings
lvim.keys.normal_mode["n"] = [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]]
lvim.keys.normal_mode["N"] = [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]]
lvim.keys.normal_mode["*"] = [[*<Cmd>lua require('hlslens').start()<CR>]]
lvim.keys.normal_mode["#"] = [[#<Cmd>lua require('hlslens').start()<CR>]]
lvim.keys.normal_mode["g*"] = [[g*<Cmd>lua require('hlslens').start()<CR>]]
lvim.keys.normal_mode["g#"] = [[g#<Cmd>lua require('hlslens').start()<CR>]]




-- Insert mode bindings
lvim.keys.insert_mode["jk"] = "<Esc>"
lvim.keys.insert_mode["kj"] = "<Esc>"

-- Center after movements
lvim.keys.normal_mode["<C-d>"] = "<C-d>zz"
lvim.keys.normal_mode["<C-u>"] = "<C-u>zz"
lvim.keys.normal_mode["<C-f>"] = "<C-f>zz"
lvim.keys.normal_mode["<C-b>"] = "<C-b>zz"

-- Normal mode bindin
-- Save on cmd+s and ctrl+s
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<Cmd-s>"] = ":w<cr>"
lvim.keys.visual_mode["<C-s>"] = ":w<cr>"
lvim.keys.visual_mode["<Cmd-s>"] = ":w<cr>"
lvim.keys.insert_mode["<C-s>"] = "<C-o>:w<cr><Esc>"
lvim.keys.insert_mode["<Cmd-s>"] = "<C-o>:w<cr><Esc>"
-- lvim.keys.normal_mode["<F2>"] = ":set spell!<CR>"
lvim.keys.normal_mode["<leader>lt"] = ":lua _G.addCurrentWordToCspell()<CR>"

lvim.builtin.which_key.mappings["f"] = {
  "<cmd>lua require('telescope.builtin').find_files()<CR>", "Find Files"
}

lvim.builtin.which_key.mappings["sf"] = {
  "<cmd>lua require('telescope.builtin').git_files()<CR>", "Git Files"
}

-- LunarVim settings
lvim.format_on_save.enabled = true

lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "java",
  "yaml",
  "go",
  "gomod"
}
lvim.builtin.treesitter.highlight.enabled = true
lvim.transparent_window = true

-- Vim Settings
vim.opt.spell = false
vim.opt.spelllang = 'en_us'
vim.opt.spelloptions = 'camel'

vim.opt.relativenumber = true
vim.opt.scrolloff = 8

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  -- { name = "black" },
  {
    name = "prettier",
    ---@usage arguments to pass to the formatter
    -- these cannot contain whitespace
    -- options such as `--line-width 80` become either `{"--line-width", "80"}` or `{"--line-width=80"}`
    -- args = { "--print-width", "100" },
    ---@usage only start in these filetypes, by default it will attach to all filetypes it supports
    filetypes = { "scss", "css", "javascript", "typescript", "typescriptreact" },
  },
  { command = "goimports", filetypes = { "go" } },
  { command = "gofumpt",   filetypes = { "go" } },
}

-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { name = "flake8" },
--   {
--     name = "shellcheck",
--     args = { "--severity", "warning" },
--   },
-- }

-- local code_actions = require "lvim.lsp.null-ls.code_actions"
-- code_actions.setup {
--   {
--     name = "proselint",
--   },
-- }
local linters = require "lvim.lsp.null-ls.linters"
-- local cspell = require('cspell')
linters.setup {
  {
    name = "cspell",
    -- sources = {
    --   cspell.diagnostic.with({
    --     config = {
    --       find_json = function()
    --         return "~/.config/lvim/"
    --       end
    --     }
    --   })
    -- },

    -- Force the severity to be HINT
    diagnostics_postprocess = function(diagnostic)
      diagnostic.severity = vim.diagnostic.severity.HINT
    end,

  },
  -- {

  --   diagnostics_postprocess = function(diagnostic)
  --     diagnostic.sources = {
  --       require('cspell').diagnostic.with({
  --         config = {
  --           find_json = function()
  --             return "~/.config/lvim/"
  --           end
  --         }
  --       })
  --     }
  --   end
  -- }
}

-- Go Specific Settings
-- lvim.builtin.treesitter.ensure_installed = {
--   "go",
--   "gomod",
-- }

------------------------
-- Plugins
------------------------
-- lvim.plugins = {
--  "olexsmir/gopher.nvim", "leoluz/nvim-dap-go",
-- }

------------------------
-- Formatting
------------------------
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   { command = "goimports", filetypes = { "go" } },
--   { command = "gofumpt", filetypes = { "go" } },
-- }

-- lvim.format_on_save = {
--   pattern = { "*.go" },
-- }

------------------------
-- Dap
------------------------
local dap_ok, dapgo = pcall(require, "dap-go")
if not dap_ok then
  return
end

dapgo.setup()

------------------------
-- LSP
------------------------
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "gopls" })

local lsp_manager = require "lvim.lsp.manager"
lsp_manager.setup("golangci_lint_ls", {
  on_init = require("lvim.lsp").common_on_init,
  capabilities = require("lvim.lsp").common_capabilities(),
})

lsp_manager.setup("gopls", {
  on_attach = function(client, bufnr)
    require("lvim.lsp").common_on_attach(client, bufnr)
    local _, _ = pcall(vim.lsp.codelens.refresh)
    local map = function(mode, lhs, rhs, desc)
      if desc then
        desc = desc
      end

      vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc, buffer = bufnr, noremap = true })
    end
    map("n", "<leader>Ci", "<cmd>GoInstallDeps<Cr>", "Install Go Dependencies")
    map("n", "<leader>Ct", "<cmd>GoMod tidy<cr>", "Tidy")
    map("n", "<leader>Ca", "<cmd>GoTestAdd<Cr>", "Add Test")
    map("n", "<leader>CA", "<cmd>GoTestsAll<Cr>", "Add All Tests")
    map("n", "<leader>Ce", "<cmd>GoTestsExp<Cr>", "Add Exported Tests")
    map("n", "<leader>Cg", "<cmd>GoGenerate<Cr>", "Go Generate")
    map("n", "<leader>Cf", "<cmd>GoGenerate %<Cr>", "Go Generate File")
    map("n", "<leader>Cc", "<cmd>GoCmt<Cr>", "Generate Comment")
    map("n", "<leader>DT", "<cmd>lua require('dap-go').debug_test()<cr>", "Debug Test")
  end,
  on_init = require("lvim.lsp").common_on_init,
  capabilities = require("lvim.lsp").common_capabilities(),
  settings = {
    gopls = {
      usePlaceholders = true,
      gofumpt = true,
      codelenses = {
        generate = false,
        gc_details = true,
        test = true,
        tidy = true,
      },
    },
  },
})

local status_ok, gopher = pcall(require, "gopher")
if not status_ok then
  return
end

gopher.setup {
  commands = {
    go = "go",
    gomodifytags = "gomodifytags",
    gotests = "gotests",
    impl = "impl",
    iferr = "iferr",
  },
}


-- _G.addCurrentWordToCspell = function()
--   local current_word = vim.fn.expand("<cword>")
--   local command = string.format("solidgo addword %s", current_word)
--   vim.fn.system(command)
--   print("Added '" .. current_word .. "' to cspell.json")
-- end

-- _G.addCurrentWordToCspell = function()
--   local git_root = getGitRoot()
--   if git_root then
--     local current_word = vim.fn.expand("<cword>")
--     local command = string.format("cd %s && solidgo addword %s", git_root, current_word)
--     vim.fn.system(command)
--     print(string.format("Added '%s' to cspell.json in git repository %s", current_word, git_root))
--   end
-- end

-- Define the getGitRoot function in a global scope or before the use
function getGitRoot()
  local git_root = vim.fn.trim(vim.fn.system('git rev-parse --show-toplevel'))
  if vim.v.shell_error ~= 0 then
    print("Not inside a git repository.")
    return nil
  else
    return git_root
  end
end

-- Then define your addCurrentWordToCspell function
_G.addCurrentWordToCspell = function()
  local git_root = getGitRoot() -- This should now recognize getGitRoot
  if git_root then
    local current_word = vim.fn.expand("<cword>")
    local command = string.format("cd %s && solidgo addword %s", git_root, current_word)
    vim.fn.system(command)
    print(string.format("Added '%s' to cspell.json in git repository %s", current_word, git_root))
  else
    print("Operation aborted: Not inside a git repository.")
  end
end

-- Assuming you're setting up a keymap for this function
-- vim.api.nvim_set_keymap('n', '<leader>aw', ':lua _G.addCurrentWordToCspell()<CR>', { noremap = true, silent = true })
