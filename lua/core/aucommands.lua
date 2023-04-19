local augroup = vim.api.nvim_create_augroup -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd -- Create autocommand

local BufferGroup = augroup("BufferSet", { clear = true })

autocmd({ "BufReadPost", "FileReadPost" }, {
	pattern = "*",
	command = "normal zR",
	group = BufferGroup
})

-- Turn off paste mode when leaving insert
autocmd("InsertLeave", {
	pattern = '*',
	command = "set nopaste",
	group = BufferGroup
})

-- Search All LC files using vimgrep
function search_leetcode()
	local search_string = "leetcode\\.com\\/problems\\/"
	local search_path = vim.fn.getcwd() .. "/**/*"
	vim.cmd("vimgrep /" .. search_string .. "/ " .. search_path)
	vim.cmd("copen")
end

vim.api.nvim_set_keymap('n', '<leader>l', ':lua search_leetcode()<CR>', { noremap = true })

-- Open a Terminal on the right tab
autocmd('CmdlineEnter', {
	command = 'command! Term :botright vsplit term://$SHELL',
	group = BufferGroup
})

autocmd('TermOpen', {
	command = 'setlocal listchars= nonumber norelativenumber nocursorline',
	group = BufferGroup
})
