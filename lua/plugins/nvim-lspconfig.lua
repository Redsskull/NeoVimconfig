local on_attach = require("util.lsp").on_attach

local config = function()
	require("neoconf").setup({})
	local cmp_nvim_lsp = require("cmp_nvim_lsp")
	local lspconfig = require("lspconfig")

	local diagnostic_signs = {
		Error = "✘", -- Cross mark
		Warn = "⚠", -- Exclamation mark in a triangle
		Hint = "➤", -- Arrow pointing right
		Info = "ℹ", -- Information symbol
	}

    -- Enhanced diagnostic configuration for better visibility
    vim.diagnostic.config({
        virtual_text = true,  -- Show diagnostics inline with code
        signs = {
            text = {
                [vim.diagnostic.severity.ERROR] = diagnostic_signs.Error,
                [vim.diagnostic.severity.WARN] = diagnostic_signs.Warn,
                [vim.diagnostic.severity.INFO] = diagnostic_signs.Info,
                [vim.diagnostic.severity.HINT] = diagnostic_signs.Hint,
            },
        },
        float = {
            border = "rounded",
            source = "always",
            header = "",
            prefix = "",
        },
        severity_sort = true,  -- Sort diagnostics by severity
        update_in_insert = false,  -- Don't update diagnostics in insert mode
    })

	local capabilities = require("cmp_nvim_lsp").default_capabilities()

	-- Lua
	lspconfig.lua_ls.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
					disable = { "missing-parameters", "missing-fields" },
				},
				workspace = {
					library = {
						vim.fn.expand("$VIMRUNTIME/lua"),
						vim.fn.expand("$XDG_CONFIG_HOME") .. "/nvim/lua",
					},
				},
			},
		},
	})

	--C/C++
	lspconfig.clangd.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		cmd = {
			 "clangd",
             "--background-index",
             "--suggest-missing-includes",
             "--clang-tidy",
             "--header-insertion=iwyu",
             "--completion-style=detailed",
             "--function-arg-placeholders",
             "--fallback-style=llvm"
		},
        init_options = {
            clangdFileStatus = true,
            usePlaceholders = true,
            completeUnimported = true,
            semanticHighlighting = true,
        },
	})

	-- JSON
	lspconfig.jsonls.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		filetypes = { "json", "jsonc" },
	})

	-- Python
	lspconfig.pyright.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		settings = {
			pyright = {
				disableOrganizeImports = false,
				analysis = {
					useLibraryCodeForTypes = true,
					autoSearchPaths = true,
					diagnosticMode = "workspace",
					autoImportCompletions = true,
				},
			},
		},
	})

	-- TypeScript
	lspconfig.ts_ls.setup({
		on_attach = on_attach,
		capabilities = capabilities,
		filetypes = { "typescript" },
		root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", ".git"),
	})

	-- Bash
	lspconfig.bashls.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		filetypes = { "sh" },
	})

	-- Solidity
	lspconfig.solidity.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		filetypes = { "solidity" },
	})

	-- Emmet
	lspconfig.emmet_ls.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		filetypes = {
			"html",
			"typescriptreact",
			"javascriptreact",
			"javascript",
			"css",
			"sass",
			"scss",
			"less",
			"svelte",
			"vue",
		},
		init_options = {
			html = {
				options = {
					["bem.enabled"] = true,
				},
			},
		},
	})

	-- Docker
	lspconfig.dockerls.setup({
		capabilities = capabilities,
		on_attach = on_attach,
	})

	-- External formatters and linters
	local luacheck = require("efmls-configs.linters.luacheck")
	local stylua = require("efmls-configs.formatters.stylua")
	local flake8 = require("efmls-configs.linters.flake8")
	local black = require("efmls-configs.formatters.black")
	local eslint_d = require("efmls-configs.linters.eslint_d")
	local prettierd = require("efmls-configs.formatters.prettier_d")
	local fixjson = require("efmls-configs.formatters.fixjson")
	local shellcheck = require("efmls-configs.linters.shellcheck")
	local shfmt = require("efmls-configs.formatters.shfmt")
	local alex = require("efmls-configs.linters.alex")
	local hadolint = require("efmls-configs.linters.hadolint")
	local solhint = require("efmls-configs.linters.solhint")
	local clang_format = require("efmls-configs.formatters.clang_format")

	-- Configure EFM server with CS50-friendly settings
	lspconfig.efm.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		filetypes = {
			"lua",
			"python",
			"json",
			"jsonc",
			"sh",
			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
			"svelte",
			"vue",
			"markdown",
			"docker",
			"solidity",
			"html",
			"css",
            "c",
            "cpp",
            "h",
            "hpp",
		},
		init_options = {
			documentFormatting = true,
			documentRangeFormatting = true,
			hover = true,
			documentSymbol = true,
			codeAction = true,
			completion = true,
		},
		settings = {
			languages = {
				lua = { luacheck, stylua },
				python = { flake8, black },
				typescript = { eslint_d, prettierd },
				json = { eslint_d, fixjson },
				jsonc = { eslint_d, fixjson },
				sh = { shellcheck, shfmt },
				javascript = { eslint_d, prettierd },
				javascriptreact = { eslint_d, prettierd },
				typescriptreact = { eslint_d, prettierd },
				svelte = { eslint_d, prettierd },
				vue = { eslint_d, prettierd },
				markdown = { alex, prettierd },
				docker = { hadolint, prettierd },
				solidity = { solhint },
				html = { eslint_d, prettierd },
				css = { eslint_d, prettierd },
                c = { clang_format },
                cpp = { clang_format },
			},
		},
	})
    
    -- A useful keymap for showing diagnostics in a float window
    vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { noremap=true, silent=true, desc = "Show diagnostic at cursor" })
    
    -- Also add a keymap to navigate between diagnostics
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { noremap=true, silent=true, desc = "Previous diagnostic" })
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { noremap=true, silent=true, desc = "Next diagnostic" })
end

return {
	"neovim/nvim-lspconfig",
	config = config,
	lazy = false,
	dependencies = {
		"windwp/nvim-autopairs",
		"williamboman/mason.nvim",
		"creativenull/efmls-configs-nvim",
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-nvim-lsp",
	},
}
