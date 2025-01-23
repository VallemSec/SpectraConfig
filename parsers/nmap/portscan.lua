function(input)

    local lunajson = require("lunajson")
    local decoded_input = lunajson.decode(lunajson.decode(input)[1])

    local output = {}
    for ip, protocols in pairs(decoded_input) do
        for protocol, ports in pairs(protocols) do
            for port, name in pairs(ports) do
                table.insert(output, {short = port, long = table.concat({name.name, ip, port, protocol}, ",")})
            end
        end
    end

    return lunajson.encode(output)
end
