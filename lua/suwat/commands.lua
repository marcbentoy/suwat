local utils = require("suwat.utils")
local M = {}

local journal_dir = vim.fn.expand("~/personal/journal")

M.test_command = function()
    local date = os.date(nil)
    -- local time = os.time(date)
    local new_date = utils.get_new_date(date, 1)
    print("new date: " .. string.format("%s-%s-%s", new_date.year, new_date.month, new_date.day))
end

local function open_journal(date)
    local day = date[3]
    if day < 10 then
        day = "0" .. day
    end
    local filename = string.format("%s-%s-%s", date[1], date[2], day)
    local journal_path = string.format("%s/%s.md", journal_dir, filename)

    -- ensure the directory exists
    if vim.fn.isdirectory(journal_dir) == 0 then
        vim.fn.mkdir(journal_dir, "p")
    end

    -- open the journal file
    vim.cmd(string.format("edit %s", journal_path))
end

M.open_today_journal_wezterm = function()
    local date = os.date("%Y-%m-%d")

    local journal_path = string.format("%s/%s.md", journal_dir, date)

    -- ensure the directory exists
    if vim.fn.isdirectory(journal_dir) == 0 then
        vim.fn.mkdir(journal_dir, "p")
    end

    -- wezterm command
    local command = string.format(
        "wezterm cli spawn --cwd %s nvim %s",
        journal_dir, journal_path
    )

    -- execute command
    local result = os.execute(command)
    if result == 0 then
        print("Opened journal in new wezterm tab.")
    else
        print("Failed to perform wezterm command.")
    end
end

M.open_today_journal = function()
    local date = os.date("%Y-%m-%d")

    local journal_path = string.format("%s/%s.md", journal_dir, date)

    -- ensure the directory exists
    if vim.fn.isdirectory(journal_dir) == 0 then
        vim.fn.mkdir(journal_dir, "p")
    end

    vim.cmd(string.format("edit %s", journal_path))
end

-- TODO: simplify open next and prev journals
M.open_next_journal = function()
    local curr_filename = vim.api.nvim_buf_get_name(0)

    if (not utils.is_in_journal(curr_filename)) then
        print("file is not a journal")
        return
    end

    -- parse file name to date
    local curr_base = vim.fn.fnamemodify(curr_filename, ":t:r")
    local curr_date = utils.parse_date(curr_base)

    -- get next date
    local next_date = utils.get_new_date(curr_date, 1)

    local prev_filename = string.format("%s-%s-%s", next_date.year, next_date.month, next_date.day)
    local full_prev_filepath = string.format("%s/%s.md", journal_dir, prev_filename)

    -- check if previous journal file exist
    if vim.fn.filereadable(full_prev_filepath) ~= 1 then
        print("no next journal:" .. full_prev_filepath)
        return
    end

    -- open if exist
    open_journal(next_date)
end

M.open_previous_journal = function()
    local curr_filename = vim.api.nvim_buf_get_name(0)

    if (not utils.is_in_journal(curr_filename)) then
        print("file is not a journal")
        return
    end

    -- parse file name to date
    local curr_base = vim.fn.fnamemodify(curr_filename, ":t:r")
    local curr_date = {}
    for d in string.gmatch(curr_base, "([^-]+)") do
        table.insert(curr_date, d)
    end

    -- get previous date
    local prev_date = { curr_date[1], curr_date[2], curr_date[3] - 1 }

    local prev_day = prev_date[3]
    if prev_day < 10 then
        prev_day = "0" .. prev_date[3]
    end

    -- TODO: get prev month if day is 0
    -- TODO: get prev year if month is 0
    local prev_filename = string.format("%s-%s-%s", prev_date[1], prev_date[2], prev_day)
    local full_prev_filepath = string.format("%s/%s.md", journal_dir, prev_filename)

    -- check if previous journal file exist
    if vim.fn.filereadable(full_prev_filepath) ~= 1 then
        print("no previous journal:" .. full_prev_filepath)
        return
    end

    -- open if exist
    open_journal(prev_date)
end

-- TODO: journal calendar

M.setup = function()
    -- define custom commands
    vim.api.nvim_create_user_command(
        "OpenSuwat",
        M.open_today_journal,
        { desc = "Open today's journal baby" }
    )
end

M.insert_timestamp = function()
    local timestamp = os.date("%H:%M:%S")
    vim.api.nvim_put({ string.format("[%s]", timestamp) }, "c", true, true)
end

return M
