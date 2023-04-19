local M = {
	'Olical/conjure',
	lazy = true,
	ft = { "clojure", "racket", "scheme" },
}


M.config = function()
	vim.g["conjure#mapping#doc_word"] = false
	vim.g["conjure#highlight#enabled"] = true
	vim.g["conjure#highlight#timeout"] = 150
	vim.g["conjure#log#wrap"] = true
	vim.g["conjure#log#jump_to_latest#enabled"] = true
	vim.g["conjure#log#jump_to_latest#cursor_scroll_position"] = "top"
	vim.g["conjure#log#hud#enabled"] = true
	vim.g["conjure#client#racket#stdio#command"] = "racket"
	vim.g["conjure#log#vsplit"] = true
	local colors = {
		amber = "CC9933",
		black = "000000",
	}
	

--
end

return M


