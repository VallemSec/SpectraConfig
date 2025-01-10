function(input)
    local lunajson = require("lunajson")
    local stdout_lines = lunajson.decode(input)
    local parsed_output = {}

    for i, line in pairs(stdout_lines) do
        table.insert(parsed_output, {short=line, long="", pass_results={line}})
    end

    return parsed_output
end