return function()
	vim.api.nvim_create_autocmd("User", {
		pattern = "PersistedLoadPost",
		desc = "Fix LSP/Highlighting on auto session restore",
		callback = function()
			local bufname = vim.api.nvim_buf_get_name(0)
			if bufname and bufname ~= "" then
				vim.defer_fn(function()
					vim.cmd("edit")
				end, 1)
			end
		end,
	})

	require("modules.utils").load_plugin("persisted", {
		save_dir = vim.fn.expand(vim.fn.stdpath("data") .. "/sessions/"),
		autostart = true,
		-- Set `lazy = false` in `plugins/editor.lua` to enable this
		autoload = true,
		follow_cwd = true,
		use_git_branch = true,
		should_save = function()
			return vim.bo.filetype == "alpha" and false or true
		end,
	})

	local restore_cwd_session = function()
		if vim.g.persisted_loaded_session then
			return
		end

		local argc = vim.fn.argc()
		if argc > 1 then
			return
		end

		if argc == 1 then
			local arg = vim.fn.argv(0)
			if vim.fn.isdirectory(arg) == 0 then
				return
			end
			vim.cmd("cd " .. vim.fn.fnameescape(vim.fn.fnamemodify(arg, ":p")))
		end

		vim.defer_fn(function()
			if vim.g.persisted_loaded_session then
				return
			end

			local persisted = require("persisted")
			persisted.load()

			if argc == 1 and not vim.g.persisting then
				persisted.start()
			end
		end, 100)
	end

	restore_cwd_session()

	vim.api.nvim_create_autocmd("VimEnter", {
		once = true,
		desc = "Restore saved session for the current directory",
		callback = restore_cwd_session,
	})
end
