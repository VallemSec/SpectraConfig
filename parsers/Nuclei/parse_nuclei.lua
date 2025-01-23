function(input)
    local lunajson = require("lunajson")
    local stdout_lines = lunajson.decode(input)
    local parsed_output = {}

    -- Process each input string
    for i, line in pairs(stdout_lines) do
        -- Attempt to decode JSON, skip invalid lines
        local status, decoded_input = pcall(lunajson.decode, line)
        if not status then
            -- Skip the line and optionally print a warning
            report_warning("Skipping invalid JSON line")
        else
            -- Extract fields with fallbacks
            local host = decoded_input.host or decoded_input.ip or "N/A"
            local port = decoded_input.port or "N/A"
            local protocol = decoded_input.scheme or "N/A"
            local name = decoded_input.info and decoded_input.info.name or "Unknown"
            local severity = decoded_input.info and decoded_input.info.severity or "info"
            local extracted = decoded_input["extracted-results"] and table.concat(decoded_input["extracted-results"], ", ")
            local matcher = decoded_input["matcher-name"]

            -- Create the short description (sanitize name to avoid special characters)
            local long = string.format(
                "Host: %s, Port: %s, Protocol: %s, Name: %s, Extracted: %s, Severity: %s, Matcher: %s",
                host, port, protocol, name, extracted, severity, matcher
            )
            local short = name

            -- Prepare results
            table.insert(parsed_output, {
                short = short,
                long = long
            })
        end
    end

    return lunajson.encode(parsed_output)
end
