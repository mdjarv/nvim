return {
	'ahmedkhalf/project.nvim',
	event = "VimEnter",
	cmd = "Telescope projects",
	config = function()
		require('project_nvim').setup({})

		require('telescope').load_extension('projects')
	end
}
