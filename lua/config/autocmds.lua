local lsp_fmt_group = vim.api.nvim_create_augroup("LspFormattingGroup", {})
vim.api.nvim_create_autocmd("BufWritePre", {
    group = lsp_fmt_group,
    callback = function()
        local buf = vim.api.nvim_get_current_buf()
        local ft = vim.api.nvim_get_option_value("filetype", { buf = buf })
        
        -- For C/C++ files, use clang-format with style50 settings
        if ft == "c" or ft == "cpp" or ft == "h" or ft == "hpp" then
            -- Try to use efm with clang-format first (which uses .clang-format file)
            local formatters = vim.lsp.get_clients({ bufnr = buf, name = "efm" })
            if not vim.tbl_isempty(formatters) then
                vim.lsp.buf.format({ 
                    bufnr = buf, 
                    name = "efm", 
                    async = false 
                })
                return
            end
            
            -- If no efm with clang-format, fall back to clangd
            local clangd = vim.lsp.get_clients({ bufnr = buf, name = "clangd" })
            if not vim.tbl_isempty(clangd) then
                vim.lsp.buf.format({ 
                    bufnr = buf, 
                    name = "clangd", 
                    async = false 
                })
                return
            end
        else
            -- For other filetypes, use efm
            local efm = vim.lsp.get_clients({ bufnr = buf, name = "efm" })
            if not vim.tbl_isempty(efm) then
                vim.lsp.buf.format({ bufnr = buf, name = "efm", async = false })
            end
        end
    end,
})

-- Add custom file type detection for CS50 header files
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
    pattern = "*.h",
    callback = function()
        vim.bo.filetype = "c"  -- Treat .h files as C files
    end
})
