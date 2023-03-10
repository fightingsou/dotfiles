local fn = vim.fn

-- auto install packer
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
	packer_BOOTSTRAP = fn.system({
		'git',
		'clone',
		'--depth',
		'1',
		'https://github.com/wbthomason/packer.nvim',
		install_path,
	})
	print('Installing packer...')
	vim.cmd([[packadd packer.nvim]])
end

-- autocmd that reloads nvim when save plugins.lua file
vim.cmd([[
	augroup packer_user_config
		autocmd!
		autocmd BufWritePost plugins.lua source <afile> | PackerSync
	augroup end
]])

-- protected call
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
	return
end

-- use popup window
packer.init({
	display = {
		open_fn = function()
			return require('packer.util').float({ border = 'rounded'})
		end,
	},
})

-- install plugins
return packer.startup(function(use)

  -- packer manages itself
  use({ 'wbthomason/packer.nvim' })

  -- colorscheme
  use({ 'EdenEast/nightfox.nvim' })

  -- lsp config
  use({ 'neovim/nvim-lspconfig' })

  -- portable package manager
  use({ 'williamboman/mason.nvim' })

  -- easily lspconfig
  use({ 'williamboman/mason-lspconfig.nvim' })

  -- completion
  use({ 'hrsh7th/nvim-cmp' })

  -- lsp completion
  use({ 'hrsh7th/cmp-nvim-lsp' })

  -- buffer
  use({ 'hrsh7th/cmp-buffer' })

  -- snippet
  use({ 'L3MON4D3/LuaSnip' })

  -- cmp + luasnip
  use({ 'saadparwaiz1/cmp_luasnip' })

  -- friendly snippets
  use({ 'rafamadriz/friendly-snippets' })

  -- ai completion
  use({ 'github/copilot.vim' })

  -- file explorer
  use({
    'nvim-tree/nvim-tree.lua',
    requires = { 'nvim-tree/nvim-web-devicons' },
    tag = 'nightly'
  })

  -- treesitter
  use({
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  })

  -- status line
  use({
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  })

  -- fuzzy finder
  use({
    'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/plenary.nvim' }
  })

  -- auto setup
	if PACKER_BOOTSTRAP then
		require('packer').sync()
	end
end)

