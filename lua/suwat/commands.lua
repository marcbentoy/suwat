local M = {}

M.open_journal = function()
    local date = os.date("%Y-%m-%d")
    local journal_path = string.format("~/personal/journal/%s.md", date)

    -- create directory if it doesn't exist
    vim.fn.system({ "mkdir", "-p", vim.fn.fnamemodify(journal_path, ":h") })

    -- open the journal file
    vim.cmd(string.format("edit %s", journal_path))
end

M.setup = function()
    -- define custom commands
    vim.api.nvim_create_user_command(
        "OpenJournal",
        M.open_journal,
        { desc = "Open today's journal baby" }
    )
end

M.insert_timestamp = function()
    local timestamp = os.date("%H:%M:%S")
    vim.api.nvim_put({ string.format("[%s]", timestamp) }, "c", true, true)
end

return M
