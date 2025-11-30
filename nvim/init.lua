vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true

vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.mouse = "a"
vim.opt.showmode = false
vim.opt.clipboard = "unnamedplus"
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.colorcolumn = "80"
vim.opt.laststatus = 3
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣", }
vim.cmd([[highlight WinSeparator guibg=None]]) -- implement borders for splits:
vim.opt.inccommand = "split"
vim.opt.hlsearch = true
vim.opt.cursorline = false
vim.opt.scrolloff = 10

-- enable line wrapping
vim.opt.wrap = false

-- formatting
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.textwidth = 80

vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.INFO] = " ",
      [vim.diagnostic.severity.HINT] = " ",
    },
  },
  virtual_text = true, -- show inline diagnostics
})

vim.keymap.set("n", "<leader>h", "<cmd>nohlsearch<CR>") -- clear search highlights

-- NOTE: set wrap for MARKDOWN
local md_group = vim.api.nvim_create_augroup("Markdown wrap settings", { clear = true })
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = { "*.md" },
	group = md_group,
	command = "setlocal wrap",
	-- also probably add :set textwidth=80
})
-- Keymaps for better default experience See `:help vim.keymap.set()`
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("n", "Q", "<nop>")

-- Fold methods:
vim.opt.foldmethod = "indent" -- fold by indenting (zc, zM, zo, zR)
vim.o.foldlevel = 99 -- open files unfolded
vim.opt.wrap = false

vim.keymap.set("n", "<A-j>", "<Esc>:m .+1<CR>==")
vim.keymap.set("n", "<A-k>", "<Esc>:m .-2<CR>==")
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv")

-- Standart indent settings:
vim.opt.tabstop = 2
vim.opt.softtabstop = 0
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
-- [[ Force set indent ]]
local function set_indent()
	local input_avail, input = pcall(vim.fn.input, "Set indent value (>0 expandtab, <=0 noexpandtab): ")
	if input_avail then
		local indent = tonumber(input)
		if not indent or indent == 0 then
			return
		end
		vim.bo.expandtab = (indent > 0) -- local to buffer
		indent = math.abs(indent)
		vim.bo.tabstop = indent -- local to buffer
		vim.bo.softtabstop = indent -- local to buffer
		vim.bo.shiftwidth = indent -- local to buffer
	end
end
vim.keymap.set("n", "<leader>ui", set_indent)

vim.keymap.set("n", "|", "<CMD>vsplit<CR>")
vim.keymap.set("n", "\\", "<CMD>split<CR>")
vim.keymap.set("n", "<C-Up>", "<cmd>resize -2<CR>")
vim.keymap.set("n", "<C-Down>", "<cmd>resize +2<CR>")
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<CR>")
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<CR>")

-- Resize with VIM-TMUX
vim.keymap.set("n", "<C-h>", "<cmd> TmuxNavigateLeft<CR>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<cmd> TmuxNavigateRight<CR>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<cmd> TmuxNavigateDown<CR>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<cmd> TmuxNavigateUp<CR>", { desc = "Move focus to the upper window" })
-- These are without TMUX PLUGIN:
-- vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
-- vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
-- vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
-- vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- INFO: [[ Basic Autocommands ]] See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- INFO: [[ PLUGINS START ]] (`gx` to open a link)
vim.pack.add({ "https://github.com/projekt0n/github-nvim-theme" }, { confirm = false })
vim.cmd.colorscheme("github_dark_default")

-- INFO: formatting and syntax highlighting
vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter" }, { confirm = false })

-- equivalent to :TSUpdate
require("nvim-treesitter.install").update("all")

require("nvim-treesitter.configs").setup({
  sync_install = true,

  modules = {},
  ignore_install = {},

  ensure_installed = {
    "lua",
    "c",
    "rust",
    "go",
  },

  auto_install = true, -- autoinstall languages that are not installed yet

  highlight = {
    enable = true,
  },
})

vim.pack.add({ "https://github.com/tpope/vim-fugitive" }, { confirm = false })
vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
vim.pack.add({"https://github.com/christoomey/vim-tmux-navigator" }, { confirm = false })

vim.pack.add({"https://github.com/lewis6991/gitsigns.nvim" }, { confirm = false })
require("gitsigns").setup({
  signs = {
    add = { text = "+" },
    change = { text = "~" },
    delete = { text = "_" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
    untracked    = { text = '┆' },
  },
  signs_staged = {
    add = { text = "+" },
    change = { text = "~" },
    delete = { text = "_" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
    untracked    = { text = '┆' },
  },
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map({ "n", "v" }, "]c", function()
      if vim.wo.diff then
        return "]c"
      end
      vim.schedule(function()
        gs.next_hunk()
      end)
      return "<Ignore>"
    end, { expr = true, desc = "Jump to next hunk" })

    map({ "n", "v" }, "[c", function()
      if vim.wo.diff then
        return "[c"
      end
      vim.schedule(function()
        gs.prev_hunk()
      end)
      return "<Ignore>"
    end, { expr = true, desc = "Jump to previous hunk" })

    -- Actions
    -- visual mode
    map("v", "<leader>hs", function()
      gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end, { desc = "stage git hunk" })
    map("v", "<leader>hr", function()
      gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end, { desc = "reset git hunk" })
    -- normal mode
    map("n", "<leader>ghs", gs.stage_hunk, { desc = "git stage hunk" })
    map("n", "<leader>ghr", gs.reset_hunk, { desc = "git reset hunk" })
    map("n", "<leader>ghS", gs.stage_buffer, { desc = "git Stage buffer" })
    map("n", "<leader>ghu", gs.undo_stage_hunk, { desc = "undo stage hunk" })
    map("n", "<leader>ghR", gs.reset_buffer, { desc = "git Reset buffer" })
    map("n", "<leader>ghp", gs.preview_hunk, { desc = "preview git hunk" })
    map("n", "<leader>ghb", function()
      gs.blame_line({ full = false })
    end, { desc = "git blame line" })
    map("n", "<leader>ghd", gs.diffthis, { desc = "git diff against index" })
    map("n", "<leader>ghD", function()
      gs.diffthis("~")
    end, { desc = "git diff against last commit" })
    -- Toggles
    map("n", "<leader>gb", gs.toggle_current_line_blame, { desc = "toggle git blame line" })
    map("n", "<leader>gtd", gs.toggle_deleted, { desc = "toggle git show deleted" })
    -- Text object
    map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "select git hunk" })
  end,
})

-- INFO: completion engine
vim.pack.add({ "https://github.com/saghen/blink.cmp" }, { confirm = false })

require("blink.cmp").setup({
  keymap = {
    preset = 'default',
    ["<C-j>"] = {'select_next', 'fallback'},
    ["<C-k>"] = {'select_prev', 'fallback'},
    ["<Tab>"] = {'select_next', 'fallback'},
    ["<S-Tab>"] = {'select_prev', 'fallback'},
  },
  appearance = {
    nerd_font_variant = 'mono'
  },
  -- (Default) Only show the documentation popup when manually triggered
  completion = { documentation = { auto_show = false } },
  -- Default list of enabled providers defined so that you can extend it
  -- elsewhere in your config, without redefining it, due to `opts_extend`
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },
  fuzzy = {
    implementation = "lua",
  },
})

-- INFO: lsp server installation and configuration

-- lsp servers we want to use and their configuration
-- see `:h lspconfig-all` for available servers and their settings
local lsp_servers = {
  lua_ls = {
    -- https://luals.github.io/wiki/settings/ | `:h nvim_get_runtime_file`
    Lua = { workspace = { library = vim.api.nvim_get_runtime_file("lua", true) }, },
  },
  clangd = {},
  rust_analyzer = {},
  eslint = {}
}

vim.pack.add({
  "https://github.com/neovim/nvim-lspconfig", -- default configs for lsps
  "https://github.com/mason-org/mason.nvim",                     -- package manager
  "https://github.com/mason-org/mason-lspconfig.nvim",           -- lspconfig bridge
  "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" -- auto installer
}, { confirm = false })

require("mason").setup()
require("mason-lspconfig").setup()
require("mason-tool-installer").setup({
  ensure_installed = vim.tbl_keys(lsp_servers),
})

-- configure each lsp server on the table
-- to check what clients are attached to the current buffer, use
-- `:checkhealth vim.lsp`. to view default lsp keybindings, use `:h lsp-defaults`.
for server, config in pairs(lsp_servers) do
  vim.lsp.config(server, {
    settings = config,

    -- only create the keymaps if the server attaches successfully
    on_attach = function(_, bufnr)
      vim.keymap.set("n", "grd", vim.lsp.buf.definition,
        { buffer = bufnr, desc = "vim.lsp.buf.definition()", })

      vim.keymap.set("n", "<leader>f", vim.lsp.buf.format,
        { buffer = bufnr, desc = "LSP: [F]ormat Document", })
    end,
  })
end

-- NOTE: if all you want is lsp + completion + highlighting, you're done.
-- the rest of the lines are just quality-of-life/appearance plugins and
-- can be removed.

-- INFO: fuzzy finder + browser
vim.pack.add({
  "https://github.com/nvim-lua/plenary.nvim",        -- library dependency
  "https://github.com/nvim-tree/nvim-web-devicons",  -- icons (nerd font)
  "https://github.com/nvim-telescope/telescope.nvim", -- the fuzzy finder
  "https://github.com/nvim-telescope/telescope-file-browser.nvim",
  "https://github.com/nvim-telescope/telescope-ui-select.nvim",
  "https://github.com/nvim-telescope/telescope-live-grep-args.nvim" ,
}, { confirm = false })
 -- Enable Telescope extensions if they are installed  


local actions = require("telescope.actions")
require("telescope").setup({
  defaults = {
    path_display = { "smart" },
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      },
      n = { q = actions.close },
    },
  },
  -- pickers = {}
  extensions = {
    ['ui-select'] = {
      require('telescope.themes').get_dropdown(),
    },
    file_browser = {
      theme = 'ivy',
      hidden = true,
      layout_strategy = 'bottom_pane',
      layout_config = { height = 40 },
      prompt_title = 'File browser',
      cwd_to_path = true,
      prompt_path = true,
      -- depth = 2, -- shows two dirs deeper
      -- previewer = false, -- turn off the previewer
      use_fd = true, -- install FD first!
      hijack_netrw = true,
      initial_mode = 'normal',
      prompt_prefix = '> ',
      mappings = { ['i'] = {}, ['n'] = {} },
    },
  },
})

pcall(require('telescope').load_extension, 'fzf')
pcall(require('telescope').load_extension, 'ui-select')
pcall(require('telescope').load_extension, 'file_browser')
pcall(require('telescope').load_extension, 'live_grep_args')

-- NOTE: fileexplorer -- based on Telescope
-- vim.keymap.set("n", "<leader>e", vim.cmd.Ex) -- default explorer netrw
vim.keymap.set('n', '<leader>e', ':Telescope file_browser path=%:p:h select_buffer=true<CR><Esc>')
vim.keymap.set('n', '<leader>c', ':bdelete<CR>', { desc = '[C]lose buffer' }) -- Close buffer

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
vim.keymap.set("n", "<leader>sa", builtin.find_files, { desc = "[S]earch [A]ll Files" })
vim.keymap.set("n", "<leader>sf", builtin.git_files, { desc = "[S]earch Git [F]iles" })
vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sg", require("telescope").extensions.live_grep_args.live_grep_args, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
vim.keymap.set("n", "<leader>sm", builtin.marks, { desc = '[S]earch [M]arks' })
vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

-- Slightly advanced example of overriding default behavior and theme
vim.keymap.set("n", "<leader>s/", function()
  -- You can pass additional configuration to Telescope to change the theme, layout, etc.
  builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
    winblend = 10,
    previewer = false,
  }))
end, { desc = "[S]earch [/] in current buffer" })

vim.keymap.set("n", "<leader>s?", function()
  builtin.live_grep({
    grep_open_files = true,
    prompt_title = "Live Grep in Open Files",
  })
end, { desc = "[S]earch [?] in Open Files" })

vim.keymap.set("n", "<leader>sn", function()
  builtin.find_files({ cwd = vim.fn.stdpath("config") })
end, { desc = "[S]earch [N]eovim files" })

-- INFO: better statusline
vim.pack.add({ "https://github.com/nvim-lualine/lualine.nvim" }, { confirm = false })

require("lualine").setup({
  options = {
    section_separators = { left = "", right = "", },
    component_separators = { left = "", right = "", },
  },
})

-- INFO: keybinding helper
vim.pack.add({ "https://github.com/folke/which-key.nvim" }, { confirm = false })

require("which-key").setup({
  spec = {
    { "<leader>s", group = "[S]earch", icon = { icon = "", color = "green", }, },
    { "<leader>c", group = "[C]ode" },
    { "<leader>d", group = "[D]ocument" },
    { "<leader>h", group = "[H]unk Git" },
    { "<leader>r", group = "[R]ename" },
    { "<leader>w", group = "[W]orkspace" },
  }
})

-- NOTE: there are many more quality-of-life plugins available and others that
-- achieve what these do. these are just our recommendations to start.

-- INFO: utility plugins
vim.pack.add({
  "https://github.com/windwp/nvim-autopairs",    -- auto pairs
  "https://github.com/VidocqH/auto-indent.nvim", -- auto indent
  "https://github.com/numToStr/Comment.nvim",    -- gb/gc to (un)comment lines
  "https://github.com/folke/todo-comments.nvim",  -- highlight TODO/INFO/WARN comments
  "https://github.com/chentoast/marks.nvim",

}, { confirm = false })

require("nvim-autopairs").setup()
require("auto-indent").setup()
require("Comment").setup()
require("todo-comments").setup()

vim.keymap.set("n", "<leader>/", function()
  require("Comment.api").toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1)
end, { desc = "Comment this line" })
vim.keymap.set(
  "v",
  "<leader>/",
  "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>"
)

-- NOTE: AI
vim.pack.add({ "https://github.com/folke/snacks.nvim"}, { confirm = false })
vim.pack.add({ "https://github.com/NickvanDyke/opencode.nvim"}, { confirm = false })
vim.g.opencode_opts = {
  -- Your configuration, if any — see `lua/opencode/config.lua`, or "goto definition".
}

-- Required for `opts.events.reload`.
vim.o.autoread = true

-- Recommended/example keymaps.
vim.keymap.set({ "n", "x" }, "<C-a>", function() require("opencode").ask("@this: ", { submit = true }) end, { desc = "Ask opencode" })
vim.keymap.set({ "n", "x" }, "<C-x>", function() require("opencode").select() end,                          { desc = "Execute opencode action…" })
vim.keymap.set({ "n", "x" },    "ga", function() require("opencode").prompt("@this") end,                   { desc = "Add to opencode" })
vim.keymap.set({ "n", "t" }, "<C-.>", function() require("opencode").toggle() end,                          { desc = "Toggle opencode" })
vim.keymap.set("n",        "<S-C-u>", function() require("opencode").command("session.half.page.up") end,   { desc = "opencode half page up" })
vim.keymap.set("n",        "<S-C-d>", function() require("opencode").command("session.half.page.down") end, { desc = "opencode half page down" })
-- You may want these if you stick with the opinionated "<C-a>" and "<C-x>" above — otherwise consider "<leader>o".
vim.keymap.set('n', '+', '<C-a>', { desc = 'Increment', noremap = true })
vim.keymap.set('n', '-', '<C-x>', { desc = 'Decrement', noremap = true })

-- uncomment to enable automatic plugin updates
-- vim.pack.update()
