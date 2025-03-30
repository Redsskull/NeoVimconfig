return {
  {
    "nvim-lspconfig",
    keys = {
      -- Add CS50-specific keybindings
      { "<F5>", function()
        -- Save the file
        vim.cmd("write")
        -- Get the file name without extension
        local file = vim.fn.expand("%:r")
        -- Open a terminal and compile with the CS50 library
        vim.cmd("split term://gcc -Wall -Werror -std=c11 -o " .. file .. " " .. file .. ".c ~/cs50/lib/cs50.c -lm && ./" .. file)
      end, desc = "Compile and run with CS50 lib" },
      
      { "<F6>", function()
        -- Save the file
        vim.cmd("write")
        -- Get the file name without extension
        local file = vim.fn.expand("%:r")
        -- Use make (with the Makefile we created)
        vim.cmd("split term://cd ~/cs50 && make PROG=" .. file)
      end, desc = "Compile using CS50 Makefile" },
      
      { "<F7>", function()
        -- Check the code with CS50's style50 tool (if installed)
        vim.cmd("write")
        vim.cmd("split term://style50 " .. vim.fn.expand("%"))
      end, desc = "Check style with style50" },
      
      -- Added this key mapping as part of the nvim-lspconfig plugin
      { "<leader>cs", function()
        -- Ask for filename
        local file = vim.fn.input("New CS50 file name (without .c): ")
        if file ~= "" then
          -- Create new file from template
          vim.cmd("edit " .. file .. ".c")
          vim.cmd("0read ~/.config/nvim/templates/cs50.c")
          vim.cmd("normal! G")
        end
      end, desc = "Create new CS50 C file" },
    },
  },
}
