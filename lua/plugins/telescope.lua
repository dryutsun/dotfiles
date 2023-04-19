return {
  'nvim-telescope/telescope.nvim', 
  version = '*', 
  dependencies = { 
   'nvim-lua/plenary.nvim', 
    'nvim-telescope/telescope-file-browser.nvim' },
  config = function()

	local status, telescope = pcall(require, "telescope")
	if (not status) then return end
	local actions = require('telescope.actions')
	local builtin = require("telescope.builtin")

	local function telescope_buffer_dir()
		return vim.fn.expand('%:p:h')
	end

	local fb_actions = require "telescope".extensions.file_browser.actions
	
	require('telescope').setup {
		defaults = {
			mappings = {
				i = {
					['<C-u>'] = false,
					['<C-d>'] = false,
					},
				n = {
						["q"] = actions.close
				},
			},
		},
		extensions = {
			file_browser = {
				theme = "dropdown",
				-- disables netrw and use telescope-file-browser in its place
				hijack_netrw = true,
				mappings = {
				-- your custom insert mode mappings
					["i"] = {
						["<C-w>"] = function() vim.cmd('normal vbd') end,
					},
					["n"] = {
					-- your custom normal mode mappings
						["N"] = fb_actions.create,
						["h"] = fb_actions.goto_parent_dir,
						["/"] = function()
							vim.cmd('startinsert')
						end,
					},
				},
			},
		},
	}
	telescope.load_extension("file_browser")


      -- Enable telescope fzf native, if installed
      -- pcall(require('telescope').load_extension, 'fzf')

      -- See `:help telescope.builtin`
	vim.keymap.set('n', '<leader>?', builtin.oldfiles, { desc = '[?] Find recently opened files' })
	vim.keymap.set('n', '<leader><space>', builtin.buffers, { desc = '[ ] Find existing buffers' })
	vim.keymap.set('n', '<leader>/', function()
	-- You can pass additional configuration to telescope to change theme, layout, etc.
	builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
		winblend = 10,
		previewer = false,
	})
	end, { desc = '[/] Fuzzily search in current buffer' })

	vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
	vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
	vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
	vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
	vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
	vim.keymap.set("n", "sf", function()
		telescope.extensions.file_browser.file_browser({
			path = "%:p:h",
			cwd = telescope_buffer_dir(),
			respect_gitignore = false,
			hidden = true,
			grouped = true,
			previewer = false,
			initial_mode = "normal",
			layout_config = { height = 40 }
		})
	end,
	{desc = "[S]earch [F]olders"})
	
  end
}
