return function()
	require("modules.utils").load_plugin("autoclose", {
		keys = {
			["("] = { escape = false, close = true, pair = "()" },
			["["] = { escape = false, close = true, pair = "[]" },
			["{"] = { escape = false, close = true, pair = "{}" },

			["<"] = { escape = true, close = true, pair = "<>", enabled_filetypes = { "cpp" } },
			[">"] = { escape = true, close = false, pair = "<>" },
			[")"] = { escape = true, close = false, pair = "()" },
			["]"] = { escape = true, close = false, pair = "[]" },
			["}"] = { escape = true, close = false, pair = "{}" },

			['"'] = { escape = true, close = true, pair = '""' },
			["`"] = { escape = true, close = true, pair = "``" },
			["'"] = { escape = true, close = true, pair = "''" },
		},
		options = {
			disable_when_touch = false,
			disabled_filetypes = {
				"alpha",
				"checkhealth",
				"diff",
				"help",
				"log",
				"notify",
				"NvimTree",
				"Outline",
				"qf",
				"TelescopePrompt",
				"toggleterm",
				"undotree",
				"vimwiki",
			},
		},
	})
end
