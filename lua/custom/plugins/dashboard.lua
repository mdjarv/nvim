return {
	'goolord/alpha-nvim',
	depends = { 'nvim-tree/nvim-web-devicons' },
	config = function()
		local theme = require('alpha.themes.dashboard')
		require('alpha').setup(theme.config)
	end
}
