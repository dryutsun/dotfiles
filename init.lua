local global = vim.g
local api = vim.api

vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- set leader key
require("core")

vim.cmd([[
    filetype plugin indent on
    syntax on
]])

