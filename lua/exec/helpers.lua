local as_comment = function(xs)
    local code = {}
    for i, line in ipairs(xs) do
        code[i] = "// " .. line
    end
    return code
end

return {
    as_comment = as_comment,
}
