-- auto-format on save
local lsp_fmt_group = vim.api.nvim_create_augroup("LspFormattingGroup", {})
vim.api.nvim_create_autocmd("BufWritePre", {
	group = lsp_fmt_group,
	callback = function()
		local buf = vim.api.nvim_get_current_buf()
		local ft = vim.api.nvim_get_option_value("filetype", { buf = buf })

		-- For C/C++ files, prefer clangd over efm
		if ft == "c" or ft == "cpp" then
			local clangd = vim.lsp.get_clients({ bufnr = buf, name = "clangd" })
			if not vim.tbl_isempty(clangd) then
				vim.lsp.buf.format({ bufnr = buf, name = "clangd", async = false })
				return
			end
		end

		-- For other filetypes, use efm
		local efm = vim.lsp.get_clients({ bufnr = buf, name = "efm" })
		if not vim.tbl_isempty(efm) then
			vim.lsp.buf.format({ bufnr = buf, name = "efm", async = false })
		end
	end,
})

