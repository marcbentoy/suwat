local M = {}

M.setup = function()
    -- map <leader>jd to to open the today's journal
    vim.keymap.set("n", "<leader>jd", function()
        require("suwat.commands").open_today_journal()
    end, { desc = "Open today's journal baby" })

    -- map <leader>jw to to open the today's journal
    vim.keymap.set("n", "<leader>jw", function()
        require("suwat.commands").open_today_journal_wezterm()
    end, { desc = "Open today's journal in new wezterm tab" })

    vim.keymap.set("n", "<leader>jt", function()
        require("suwat.commands").insert_timestamp()
    end, { desc = "Insert current time baby" })
    vim.keymap.set("i", ";lkj", function()
        require("suwat.commands").insert_timestamp()
    end, { desc = "Insert current time baby" })

    vim.keymap.set("n", "<leader>j[", function()
        require("suwat.commands").open_previous_journal()
    end, { desc = "Open previous journal" })

    vim.keymap.set("n", "<leader>j]", function()
        require("suwat.commands").open_next_journal()
    end, { desc = "Open next journal" })

    vim.keymap.set("n", "<leader>jx", function()
        require("suwat.commands").test_command()
    end, { desc = "For testing some commands" })
end

return M
