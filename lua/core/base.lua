vim.cmd("autocmd!")

vim.opt_global.history = 10000
vim.opt_global.updatetime = 300
vim.opt.hlsearch = true
vim.opt.backup = false
vim.opt.showcmd = true
vim.opt.scrolloff = 10
vim.opt.shell = 'bash'
vim.opt.backupskip = { '/tmp/*', '/private/tmp/*' }
vim.opt.inccommand = 'split'
vim.opt.ignorecase = true    -- Case insensitive searching UNLESS /C or capital in search
vim.opt.backspace = { 'start', 'eol', 'indent' }
vim.opt.path:append { '**' } -- Finding files - Search down into subfolders
vim.opt.wildignore:append { '*/node_modules/*' }

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])


-- Add asterisks in block comments
vim.opt.formatoptions:append { 'r' }
