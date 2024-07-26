-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
vim.g.mapleader = " "

plugins = {
	"nvim-treesitter/nvim-treesitter", -- Treesitter highlighting
	"alaviss/nim.nvim",               -- Nim LSP plugin
	"nvim-tree/nvim-web-devicons",    -- Web devicons
	"ms-jpq/coq_nvim", -- Autocomplete
	"mrcjkb/rustaceanvim", -- Did you guys know that memory safety is key?
	"navarasu/onedark.nvim",	
	"nvimtools/none-ls.nvim",
	"neovim/nvim-lspconfig", -- Nvim LSPConfig
	"andweeb/presence.nvim", -- Discord RPC
	-- Tabs
	{'romgrk/barbar.nvim',
    		dependencies = {
      			'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
      			'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
    		},
    		init = function() 
			vim.g.barbar_auto_setup = false
		end,
    		opts = {},
    		version = '^1.0.0', -- optional: only update when a new 1.x version is released
  	},
	"nvim-lua/plenary.nvim", -- plenary
	"akinsho/ToggleTerm.nvim", -- Toggle terminal
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"j-morano/buffer_manager.nvim",
	"hrsh7th/cmp-cmdline",
	"hrsh7th/nvim-cmp",
	"nvim-lualine/lualine.nvim",
	"tpope/vim-fugitive",
	"folke/todo-comments.nvim",
	"echasnovski/mini.nvim",
	{"nvim-telescope/telescope.nvim", tag = '0.1.5',
		dependencies = { 'nvim-lua/plenary.nvim' }
	},
	"xiyaowong/transparent.nvim",
	"NvChad/nvterm",
	"nvimdev/dashboard-nvim"
}

-- Initialize lazy
require("lazy").setup(plugins, {})

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- theme
require('onedark').load({style = 'darker'})

-- Setup telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', 'ff', builtin.find_files, {})
vim.keymap.set('n', 'fg', builtin.live_grep, {})
vim.keymap.set('n', 'fb', builtin.buffers, {})
vim.keymap.set('n', 'fh', builtin.help_tags, {})

-- Todo comments
require("todo-comments").setup()
vim.keymap.set('n', 'tn', function()
	require("todo-comments").jump_next()
end)

vim.keymap.set('n', 'tp', function()
	require("todo-comments").jump_prev()
end)

local function fileExists(path)
	return vim.fn.filereadable(path) == 1
end

local function notify(title, content)
	vim.fn.system("notify-send --icon=neovim --expire-time=36000 \""..title.."\" \""..content.."\"")
end

-- Setup alignment helper
require("mini.align").setup(
	{
		mappings = {
			start = "sa",
			start_with_preview = "sA"
		},
		options = {
			justify_side = "left"
		},
		silent = false
	}
)

-- Setup notification system
local notify = require("mini.notify")
notify.setup(
	{
		-- Content management
		content = {
			-- Function which formats the notification message
			-- By default prepends message with notification time
			format = nil,

			-- Function which orders notification array from most to least important
    			-- By default orders first by level and then by update timestamp
    			sort = nil,
  		},

  		-- Notifications about LSP progress
  		lsp_progress = {
			-- Whether to enable showing
			enable = true,

    			-- Duration (in ms) of how long last message should be shown
    			duration_last = 1000,
  		},

  		-- Window options
  		window = {
    			-- Floating window config
    			config = {},

    			-- Maximum window width as share (between 0 and 1) of available columns
    			max_width_share = 0.382,

    			-- Value of 'winblend' option
    			winblend = 25,
  		}
	}
)
notify.setup()
vim.notify = notify.make_notify({
	ERROR = { duration = 5000 },
	WARN = { duration = 4000 },
	INFO = { duration = 3000 }
})

-- Setup transparency effect
require("transparent").setup({
	groups = { -- table: default groups
    		'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
    		'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
    		'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
    		'SignColumn', 'CursorLine', 'CursorLineNr', 'StatusLine', 'StatusLineNC',
    		'EndOfBuffer', 'NvimTreeNormal', 'NormalFloat', 'NvimTreeNormalNC'
  	},
	extra_groups = {
    		"NormalFloat", -- plugins which have float panel such as Lazy, Mason, LspInfo
    		"NvimTreeNormal", -- NvimTree
    		"NvimTreeNormalNC",
    		"NvimTreeWinSeparator",
    		"TelescopeNormal",
    		"TelescopeBorder",
    		"WhichKeyFloat",
  	}, -- table: additional groups that should be cleared
  	exclude_groups = {} -- table: groups you don't want to clear
})

local buffctl = require("buffer_manager.ui")

-- Nim autocomplete
local null_ls = require "null-ls"

local CompletionItemKind = vim.lsp.protocol.CompletionItemKind
local kinds = {
  d = CompletionItemKind.Keyword,
  f = CompletionItemKind.Function,
  t = CompletionItemKind.Struct,
  v = CompletionItemKind.Variable,
}

null_ls.register({
  method = null_ls.methods.COMPLETION,
  filetypes = { "nim", "c", "rs" },
  generator = {
    async = true,
    fn = function(params, done)
      vim.fn["nim#suggest#sug#GetAllCandidates"](function(start, candidates)
        local items = vim.tbl_map(function(candidate)
          return {
            kind = kinds[candidate.kind] or CompletionItemKind.Text,
            label = candidate.word,
            documentation = candidate.info,
          }
        end, candidates)
        done { { items = items } }
      end)
    end,
  },
})

-- Setup barbar
local barbar = require("barbar.api")
require("barbar").setup({
  animation = true,
  auto_hide = true,
  sidebar_filetypes = {
    -- Use the default values: {event = 'BufWinLeave', text = nil}
    NvimTree = true,
    -- Or, specify the text used for the offset:
    undotree = {text = 'undotree'},
    -- Or, specify the event which the sidebar executes when leaving:
    ['neo-tree'] = {event = 'BufWipeout'},
    -- Or, specify both
    Outline = {event = 'BufWinLeave', text = 'symbols-outline'},
  },	
})

local buffer_register = 0

vim.keymap.set('n', 'bc', function()
		barbar.close_all_but_current()	
	end
)

vim.keymap.set('n', 'br', function()
		barbar.restore_buffer()
	end
)

vim.keymap.set('n', 'bn', function()
		buffer_register = buffer_register + 1
		barbar.goto_buffer(buffer_register)
	end
)

vim.keymap.set('n', 'bp', function()
		buffer_register = buffer_register - 1
		if buffer_register < 0 then
			buffer_register = 0
		end
		barbar.goto_buffer(buffer_register)
	end
)

vim.keymap.set('n', 'df', function()
		local file = vim.api.nvim_buf_get_name(0)
		if fileExists(file) then
			local answer = vim.fn.input("Do you want to delete this file? [y/n] ")
			if answer == "y" then
				os.remove(file)
				vim.notify("Deleted file \""..file.."\" successfully.")
			end
		end
	end
)

-- Setup NvTerm
require("nvterm").setup({
  terminals = {
    shell = vim.o.shell,
    list = {},
    type_opts = {
      float = {
        relative = 'editor',
        row = 0.3,
        col = 0.25,
        width = 0.5,
        height = 0.4,
        border = "single",
      },
      horizontal = { location = "rightbelow", split_ratio = .3, },
      vertical = { location = "rightbelow", split_ratio = .5 },
    }
  },
  behavior = {
    autoclose_on_quit = {
      enabled = false,
      confirm = true,
    },
    close_on_exit = true,
    auto_insert = true,
  },
})

-- Add some terminal keybinds
local term = require("nvterm.terminal")

vim.keymap.set('n', 'tt', function() 
		term.toggle "float"
	end, 
	{}
)

vim.keymap.set('n', 'nb', function()
		term.send("nimble build", "float")
	end,
	{}
)

vim.keymap.set('n', 'nr', function()
		term.send("nimble run", "float")
	end,
	{}
)

-- Dashboard
--[[require('dashboard').setup(
	{
		theme = 'doom',
		config = {
			header = {},
			center = {
				{
					icon = '',
					icon_hl = 'group',
					desc = 'Hello'
				}
			}
		}
	}
)--]]

-- Setup my status bar
require('lualine').setup {
  options = {
    theme = "codedark",
  },
  disabled_filetypes = {
      'NvimTree',
      statusline = {},
      winbar = {},
  },
  offsets = {{filetype = "NvimTree", text = "File Explorer", padding = 0 }},
}

local theme = {
  fill = 'TabLineFill',
  -- Also you can do this: fill = { fg='#f2e9de', bg='#907aa9', style='italic' }
  head = 'TabLine',
  current_tab = 'TabLineSel',
  tab = 'TabLine',
  win = 'TabLine',
  tail = 'TabLine',
}

-- Initialize treesitter
require("nvim-treesitter.configs").setup({
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "cpp", "json", "toml", "glsl", "nim", "rust", "javascript", "markdown" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (for "all")
  ignore_install = { },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
        local max_filesize = 102400 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
})

-- Discord rich presence
local quotes = {
	"Those who can, do. Those who cannot, complain.",
	"Any sufficiently advanced technology is indistinguishable from magic.",
	"The only way of discovering the limits of the possible is to venture a little way past them into the impossible.",
	"Premature optimization is the root of all evil.",
	"A primary cause of complexity is that software vendors uncritically adopt almost any feature that users want.",
	"Expected a quote here? Tough luck."
}

math.randomseed(os.clock())
local qIdx = math.floor(math.random() * #quotes) + 1
local rpcKillSwitch = "/home/"..os.getenv("USER").."/.neovim-no-rpc"

local presence = require("presence")
presence.setup({
	-- General options
    	auto_update         = true,
    	neovim_image_text   = quotes[qIdx],
    	--main_image          = "neovim-mark-flat",                   -- Main image display (either "neovim" or "file")
    	--client_id           = "1145710737055039660",
    	log_level           = nil,                        -- Log messages at or above this level (one of the following: "debug", "info", "warn", "error")
    	debounce_timeout    = 10,                         -- Number of seconds to debounce events (or calls to `:lua package.loaded.presence:update(<filename>, true)`)
    	enable_line_number  = true,                      -- Displays the current line number instead of the current project
    	blacklist           = {},                         -- A list of strings or Lua patterns that disable Rich Presence if the current file name, path, or workspace matches
    	buttons             = true,                       -- Configure Rich Presence button(s), either a boolean to enable/disable, a static table (`{{ label = "<label>", url = "<url>" }, ...}`, or a function(buffer: string, repo_url: string|nil): table)
    	file_assets         = {},                         -- Custom file asset definitions keyed by file names and extensions (see default config at `lua/presence/file_assets.lua` for reference)
    	show_time           = true,                       -- Show the timer

    		-- Rich Presence text options
    	editing_text        = "Editing %s",               -- Format string rendered when an editable file is loaded in the buffer (either string or function(filename: string): string)
    	file_explorer_text  = "Browsing",              -- Format string rendered when browsing e file explorer (either string or function(file_explorer_name: string): string)
    	git_commit_text     = "Committing changes",       -- Format string rendered when committing changes in git (either string or function(filename: string): string)
    	plugin_manager_text = "Managing plugins",         -- Format string rendered when managing plugins (either string or function(plugin_manager_name: string): string)
    	reading_text        = "Reading %s",               -- Format string rendered when a read-only or unmodifiable file is loaded in the buffer (either string or function(filename: string): string)
    	workspace_text      = "Working on %s",            -- Format string rendered when in a git repository (either string or function(project_name: string|nil, filename: string): string)
    	line_number_text    = "Line %s out of %s",        -- Format string rendered when `enable_line_number` is set to true (either string or function(line_number: number, line_count: number): string)
})

--[[if fileExists(rpcKillSwitch) ~= true then -- sneak 100
	presence.cancel()
end--]]

vim.keymap.set('n', 'rd', function()
		if fileExists(rpcKillSwitch) ~= true then
			local f = io.open(rpcKillSwitch, "w")
			assert(f, "Can't open: "..rpcKillSwitch)
			f:write("sneak 100")
			
			presence.cancel()
			vim.notify("Discord RPC has been disabled.")
		else
			os.remove(rpcKillSwitch)
			presence.connect()
			vim.notify("Discord RPC has been enabled.")
		end
	end,
	{}
)

-- LSP and autocompletion
local cmp = require("cmp")

cmp.setup({
	sources = cmp.config.sources({
		{ name = "nvim_lsp" }
	})
})

local capabilities = require('cmp_nvim_lsp').default_capabilities() --nvim-cmp

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
end

-- Setup lspconfig.
local nvim_lsp = require('lspconfig')

-- setup languages 
-- Nim
nvim_lsp['nimls'].setup {
  cmd = {'nimlsp'},
  -- on_attach = on_attach,
  capabilities = capabilities,
  settings = {},
  init_options = {
    usePlaceholders = true,
  }
}

-- Nix
nvim_lsp['nil_ls'].setup {}

-- Lua
require('lspconfig').lua_ls.setup {
  on_init = function(client)
    local path = client.workspace_folders[1].name
    if not vim.loop.fs_stat(path..'/.luarc.json') and not vim.loop.fs_stat(path..'/.luarc.jsonc') then
      client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using
            -- (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT'
          },
          -- Make the server aware of Neovim runtime files
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME
            }
            -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
            -- library = vim.api.nvim_get_runtime_file("", true)
          }
        }
      })

      client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
    end
    return true
  end
}

-- C/C++
nvim_lsp['clangd'].setup {
  cmd = {'clangd'},
  capabilities = capabilities,
  settings = {},
  init_options = {
    usePlaceholders = true,
  }
}

-- More keybinds
vim.keymap.set('n', 'qq',
	function()
		vim.cmd(":bdelete")
	end,
	{}
)
