return { -- Autocompletion
  'hrsh7th/nvim-cmp',
  dependencies = { 
    'hrsh7th/cmp-nvim-lsp',
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',
    'hrsh7th/cmp-buffer',
  },
  config = function()
		local cmp = require 'cmp'
		local luasnip = require 'luasnip'
		local snippet = luasnip.snippet
		local tn = luasnip.text_node
		luasnip.add_snippets(nil,{
			all = {
				snippet({
						trig = "htdp",
						name = "func recipe"	
					},
					{ tn({"// @structure\t:", "// @datadefn\t:", "// @type\t:", "// @purpose\t:"})}
				),
				snippet({
					trig = "htdd",
					name = "data recipe"
				},
					{ tn({"// @"})}
				)
			},
		})

		
		cmp.setup {
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert {
				['<C-d>'] = cmp.mapping.scroll_docs(-4),
				['<C-f>'] = cmp.mapping.scroll_docs(4),
				['<C-Space>'] = cmp.mapping.complete {},
				['<CR>'] = cmp.mapping.confirm {
					behavior = cmp.ConfirmBehavior.Replace,
					select = true,
				},
				['<Tab>'] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					else
						fallback()
					end
				end, { 'i', 's' }),
				['<S-Tab>'] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { 'i', 's' }),
			},
			sources = {
				{ name = 'nvim_lsp' },
				{ name = 'luasnip' },
				{ name = 'path' },
				{ name = "buffer" },
				{ name = 'conjure'}
			},
			-- formatting = {
			-- 	format = lspkind.cmp_format({
			-- 		with_text = true,
			-- 		maxwidth = 50,
			-- 		menu = {
			-- 			buffer = "[buf]",
			-- 			nvim_lsp = "[LSP]",
			-- 			nvim_lua = "[api]",
			-- 			path = "[path]",
			-- 			luasnip = "[snip]"
			-- 		}
			-- 	}),
			-- },
		}
  end,
}
