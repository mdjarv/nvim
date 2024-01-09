local logo = {
	"                                              ",
	"       ███████████           █████      ██",
	"      ███████████             █████ ",
	"      ████████████████ ███████████ ███   ███████",
	"     ████████████████ ████████████ █████ ██████████████",
	"    ██████████████    █████████████ █████ █████ ████ █████",
	"  ██████████████████████████████████ █████ █████ ████ █████",
	" ██████  ███ █████████████████ ████ █████ █████ ████ ██████",
}


return {
	'goolord/alpha-nvim',
	depends = { 'nvim-tree/nvim-web-devicons' },
	event = 'VimEnter',
	opts = function()
		local dashboard = require('alpha.themes.dashboard')
		require('alpha.term')

		dashboard.section.header.val = logo

		dashboard.section.buttons.val = {
			dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
			dashboard.button("f", "  Find file", ":Telescope find_files<CR>"),
			dashboard.button("r", "  Recent", ":Telescope oldfiles<CR>"),
			dashboard.button('l', '󰒲  Lazy', ':Lazy<CR>'),
			dashboard.button('m', '󱌣  Mason', ':Mason<CR>'),
			dashboard.button("s", "  Settings", ":e $MYVIMRC<CR>"),
			dashboard.button("q", "  Quit", ":qa<CR>"),
		}

		for _, button in ipairs(dashboard.section.buttons.val) do
			button.opts.hl = 'Normal'
			button.opts.hl_shortcut = 'Function'
		end

		dashboard.section.footer.opts.hl = "Special"

		return dashboard
	end,
	config = function(_, dashboard)
		-- close lazy and re-open when the dashboard is ready
		if vim.o.filetype == 'lazy' then
			vim.cmd.close()
			vim.api.nvim_create_autocmd('User', {
				pattern = 'AlphaReady',
				callback = function()
					require('lazy').show()
				end,
			})
		end

		require('alpha').setup(dashboard.opts)

		vim.api.nvim_create_autocmd('User', {
			pattern = 'LazyVimStarted',
			callback = function()
				local stats = require('lazy').stats()
				local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
				-- stylua: ignore
				dashboard.section.footer.val = '󱐋 ' .. stats.count .. ' plugins loaded in ' .. ms .. 'ms'
				pcall(vim.cmd.AlphaRedraw)
			end
		})
	end
}
