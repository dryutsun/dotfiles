local option = vim.opt
local global = vim.go
local buffer = vim.bo
local window = vim.wo


-- turn off swap
option.swapfile = false

option.number = true
-- indent settings
option.smartindent = true
-- templates
vim.g.tmpl_author_name = 'dryutsun'
-- vim.g.tmpl_search_paths = "templates/"
-- tab settings
option.shiftround = true
option.shiftwidth = 4
option.softtabstop = 4
option.tabstop = 4

-- window settings
option.updatetime = 50
option.title = true
option.cmdheight = 1
option.numberwidth = 4
option.signcolumn = 'yes'
option.textwidth = 120
option.colorcolumn = "80"
option.mouse = 'a'
option.showmatch = true
option.splitbelow = true
option.splitright = true
-- floating window?
option.wildmenu = true
option.pumblend = 17
option.wildmode = "longest:full"
option.wildoptions = "pum"

-- tty settings
option.ttyfast = true
option.lazyredraw = true
-- persist hidden buffers
option.hidden = true
--clipboard
option.clipboard = "unnamedplus"

-- Wrap Settings
option.breakindent = true
option.wrap = false -- No Wrap lines

-- Display List Characters
vim.o.list = true
vim.o.listchars = [[tab:» ,trail:-]]

option.scrolloff = 8

-- code folding
option.foldmethod = "indent"
-- option.foldexpr = "nvim_treesitter#foldexpr()"
option.foldcolumn = "1"
option.foldlevelstart = -1
option.foldnestmax = 10   -- deepest fold is 10 levelf
option.foldenable = false -- don't fold by default
option.foldlevel = 1

-- ignore list
option.wildignore:append { '*/node_modules/*' }

-- compiler options
vim.cmd('command! -nargs=* -complete=file Make silent make! <args>')
