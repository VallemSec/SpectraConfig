function (input)
    local lunajson = require("lunajson")
    local decoded_input = lunajson.decode(input)

    local output = {}

    for i, line in pairs(decoded_input) do
        if #line > 0 then  -- Ensure the line is not empty
            table.insert(output, {short = "examplescan", long = line .. "? now with a questionmark"})
        end
    end

    return output
end