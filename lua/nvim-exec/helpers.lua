local as_comment = function(xs)
    local code = {}
    for i, line in ipairs(xs) do
        code[i] = "// " .. line
    end
    return code
end

local without_empty_lines = function(xs)
    return vim.tbl_filter(function(item)
        return item ~= ""
    end, xs)
end

return {
    as_comment = as_comment,
    without_empty_lines = without_empty_lines,
}
