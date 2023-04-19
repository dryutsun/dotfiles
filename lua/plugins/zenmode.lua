return {
	'folke/zen-mode.nvim',
	config = function()
		local status, zenMode = pcall(require, "zen-mode")
		if (not status) then return end

		zenMode.setup {
			window = {
				width = 120,
			}
		}

		vim.keymap.set('n', '<C-w>o', '<cmd>ZenMode<cr>', { silent = true })
	end,
}
