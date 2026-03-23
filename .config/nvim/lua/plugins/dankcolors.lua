return {
	{
		"RRethy/base16-nvim",
		priority = 1000,
		config = function()
			require('base16-colorscheme').setup({
				base00 = '#0f131c',
				base01 = '#0f131c',
				base02 = '#999da5',
				base03 = '#999da5',
				base04 = '#eff5ff',
				base05 = '#f8faff',
				base06 = '#f8faff',
				base07 = '#f8faff',
				base08 = '#ff9fba',
				base09 = '#ff9fba',
				base0A = '#b5d0ff',
				base0B = '#a5ffb2',
				base0C = '#d7e6ff',
				base0D = '#b5d0ff',
				base0E = '#c2d8ff',
				base0F = '#c2d8ff',
			})

			vim.api.nvim_set_hl(0, 'Visual', {
				bg = '#999da5',
				fg = '#f8faff',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Statusline', {
				bg = '#b5d0ff',
				fg = '#0f131c',
			})
			vim.api.nvim_set_hl(0, 'LineNr', { fg = '#999da5' })
			vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#d7e6ff', bold = true })

			vim.api.nvim_set_hl(0, 'Statement', {
				fg = '#c2d8ff',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Keyword', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Repeat', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Conditional', { link = 'Statement' })

			vim.api.nvim_set_hl(0, 'Function', {
				fg = '#b5d0ff',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Macro', {
				fg = '#b5d0ff',
				italic = true
			})
			vim.api.nvim_set_hl(0, '@function.macro', { link = 'Macro' })

			vim.api.nvim_set_hl(0, 'Type', {
				fg = '#d7e6ff',
				bold = true,
				italic = true
			})
			vim.api.nvim_set_hl(0, 'Structure', { link = 'Type' })

			vim.api.nvim_set_hl(0, 'String', {
				fg = '#a5ffb2',
				italic = true
			})

			vim.api.nvim_set_hl(0, 'Operator', { fg = '#eff5ff' })
			vim.api.nvim_set_hl(0, 'Delimiter', { fg = '#eff5ff' })
			vim.api.nvim_set_hl(0, '@punctuation.bracket', { link = 'Delimiter' })
			vim.api.nvim_set_hl(0, '@punctuation.delimiter', { link = 'Delimiter' })

			vim.api.nvim_set_hl(0, 'Comment', {
				fg = '#999da5',
				italic = true
			})

			local current_file_path = vim.fn.stdpath("config") .. "/lua/plugins/dankcolors.lua"
			if not _G._matugen_theme_watcher then
				local uv = vim.uv or vim.loop
				_G._matugen_theme_watcher = uv.new_fs_event()
				_G._matugen_theme_watcher:start(current_file_path, {}, vim.schedule_wrap(function()
					local new_spec = dofile(current_file_path)
					if new_spec and new_spec[1] and new_spec[1].config then
						new_spec[1].config()
						print("Theme reload")
					end
				end))
			end
		end
	}
}
