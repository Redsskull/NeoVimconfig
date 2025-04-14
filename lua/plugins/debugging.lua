return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"nvim-telescope/telescope-dap.nvim",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		-- === Adapter Setup: codelldb via Mason ===
		local mason_path = vim.fn.stdpath("data") .. "/mason"
		local codelldb_path = mason_path .. "/packages/codelldb/extension/adapter/codelldb"

		dap.adapters.codelldb = {
			type = "server",
			port = "${port}",
			executable = {
				command = codelldb_path,
				args = { "--port", "${port}" },
			},
		}

		-- === DAP Configurations ===
		dap.configurations.c = {
			{
				name = "Launch C Program",
				type = "codelldb",
				request = "launch",
				program = function()
					local filename = vim.fn.expand("%:t:r")
					local executable = vim.fn.getcwd() .. "/" .. filename
					if vim.fn.filereadable(executable) ~= 1 then
						executable = vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end
					return vim.fn.expand(executable)
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
				args = function()
					local args_string = vim.fn.input("Arguments: ")
					return vim.split(args_string, " ")
				end,
			},
		}

		-- Also apply to C++
		dap.configurations.cpp = dap.configurations.c

		-- === DAP UI Setup ===
		dapui.setup()

		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated["dapui_config"] = function() end

		dap.listeners.before.event_exited["dapui_config"] = function() end

		-- === Keymaps ===
		vim.keymap.set("n", "<F5>", dap.continue, { desc = "DAP: Start/Continue" })
		vim.keymap.set("n", "<F6>", dap.toggle_breakpoint, { desc = "DAP: Toggle Breakpoint" })
		vim.keymap.set("n", "<F10>", dap.step_over, { desc = "DAP: Step Over" })
		vim.keymap.set("n", "<F11>", dap.step_into, { desc = "DAP: Step Into" })
		vim.keymap.set("n", "<F12>", dap.step_out, { desc = "DAP: Step Out" })

		-- Optional: Telescope DAP integration
		require("telescope").load_extension("dap")
		vim.keymap.set("n", "<leader>dc", "<cmd>Telescope dap commands<cr>", { desc = "DAP: Commands" })
		vim.keymap.set("n", "<leader>db", "<cmd>Telescope dap list_breakpoints<cr>", { desc = "DAP: List Breakpoints" })
		vim.keymap.set("n", "<leader>df", "<cmd>Telescope dap frames<cr>", { desc = "DAP: Stack Frames" })
		vim.keymap.set("n", "<leader>dv", "<cmd>Telescope dap variables<cr>", { desc = "DAP: Variables" })
	end,
}
