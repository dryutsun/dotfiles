local augroup = vim.api.nvim_create_augroup -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd -- Create autocommand

vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.winblend = 0
vim.opt.wildoptions = 'pum'
vim.opt.pumblend = 5
vim.opt.background = 'dark'
vim.opt.hlsearch = true



-- highlight yanked text for 200ms using the "Visual" highlight group
augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
    group = "YankHighlight",
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = '1000' })
    end
})

--
-- vim.cmd [[
--   augroup highlight_yank
--   autocmd!
--   au TextYankPost * silent! lua vim.highlight.on_yank({higroup="Visual", timeout=1000})
--   augroup END
-- ]]
