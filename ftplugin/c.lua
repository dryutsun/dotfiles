vim.opt_local.makeprg = "gcc -Wall -Wextra -std=c11 -pedantic -ggdb % -o %<"
vim.bo.softtabstop = 4
vim.bo.shiftwidth = 4
vim.bo.autoindent = true
vim.bo.smartindent = true
vim.bo.tabstop = 4
vim.bo.expandtab = true
vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.ignorecase = true
vim.opt_local.smartcase = true
vim.opt_local.hlsearch = true
vim.opt_local.incsearch = true

vim.cmd([[
  augroup c_make
    autocmd!
    autocmd QuickFixCmdPost [^l]* cwindow
  augroup END
]])
