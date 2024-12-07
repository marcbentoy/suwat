local M = {}

M.setup = function()
    -- map <leader>dj to to open the today's journal
    vim.keymap.set("n", "<leader>dj", function()
        require("suwat.commands").open_journal()
    end, { desc = "Open today's journal baby" })

    vim.keymap.set("n", "<leader>tj", function()
        require("suwat.commands").insert_timestamp()
    end, { desc = "Insert current time baby" })
end

return M
