-- ============================Ignore ============================================
-- vim.go.loadplugins = false
-- ===================Please don't ignore this! :3 ===============================
-- Call setup
-- The setup module does:
-- Set the options
-- initalize lazy.nvim
-- Load plugins via lazy.nvim
-- Add some autocmds and keymaps

require("core.base")
require("core.editor")
require("core.highlights")
require("core.encoding")
require("core.lazy")
require("core.aucommands")
require("core.maps")
require("core.functions")
vim.opt.termguicolors = true
vim.cmd.colorscheme("gruvbox")
-- Load options that don't require any UI
vim.schedule(function()
  vim.o.clipboard = "unnamed,unnamedplus" -- Let's sync clipboards across platforms (Win###s, MacOS and, *Nix based systems)
end)

-- vim.cmd([[colorscheme gruber-darker]])
vim.cmd.colorscheme("gruvbox")
-- vim.api.nvim_set_hl(0, "SignColumn", { bg = "none"})
vim.o.background = "dark"

