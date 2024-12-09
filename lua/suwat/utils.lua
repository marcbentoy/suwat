local M = {}

local journal_dir = vim.fn.expand("~/personal/journal")

M.is_in_journal = function(filepath)
    local base_filename = vim.fn.fnamemodify(filepath, ":t")
    local expected_journal_filename = journal_dir .. "/" .. base_filename
    return expected_journal_filename == filepath
end


--- Parses a journal filename to a date table of { year, month, day} format
---@param filename any
---@return table
M.parse_date = function(filename)
    local date = {}
    for d in string.gmatch(filename, "([^-]+)") do
        table.insert(date, d)
    end
    return date
end

M.get_new_date = function(date, days)
    local adjusted = date + (days * 24 * 60 * 60)
    return os.date(nil, adjusted)
end

return M
