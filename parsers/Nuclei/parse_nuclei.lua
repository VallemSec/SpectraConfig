local lunajson = require("lunajson")

function parse_nuclei_output(input)
    local output = {
        scanner_name = "Nuclei",
        results = {}

    }

    -- Process each JSONL line
    for line in input:gmatch("[^\r\n]+") do
        -- Attempt to decode JSON, skip invalid lines
        local status, decoded_input = pcall(lunajson.decode, line)
        if not status then
            -- Skip the line and optionally print a warning
            print("Warning: Skipping invalid JSON line")
        else
            -- Extract fields with fallbacks
            local host = decoded_input.host or decoded_input.ip or "N/A"
            local port = decoded_input.port or "N/A"
            local protocol = decoded_input.scheme or "N/A"
            local name = decoded_input.info and decoded_input.info.name or "Unknown"
            local severity = decoded_input.info and decoded_input.info.severity or "info"
            local extracted = decoded_input["extracted-results"] and table.concat(decoded_input["extracted-results"], ">

            -- Create the short description (sanitize name to avoid special characters)
               local long = string.format(
                "Host: %s, Port: %s, Protocol: %s, Name: %s, Extracted: %s",
                host, port, protocol, name, extracted
            )

            -- Prepare results
            local pass_results = {host}
            table.insert(output.results, {
                short = short,
                long = long,
                pass_results = pass_results
            })
        end
    end

    return output
end

-- Read input from stdin
local input = io.stdin:read("*all")
local results = parse_nuclei_output(input)

-- Output results as JSON
local output_str = lunajson.encode(results)
print(output_str)     
