function test(input)

    local lunajson = require("lunajson")
    local decoded_input = lunajson.decode(input)

    local output = {}

    for i, line in pairs(decoded_input) do
        -- Zoek naar het patroon van een domein en IP-adres
        local domain, ip = string.match(line, "Andere server gevonden: ([%w%.%-]+). met IP: ([%d%.]+)")
        if domain and ip then
            table.insert(output, {domain = domain, ip = ip})
        end
    end
    if #output >0 then 
        return {{short="found", long=output}}
    end
    return {{short="not found", long=output}}
    
end

local lunajson = require("lunajson")

print(lunajson.encode(test('[ "Scan voltooid. Resultaten opgeslagen in scan_output.txt.", "Analyseren van scan-output...", "Andere server gevonden: alt4.aspmx.l.google.com. met IP: 173.194.202.26", "Andere server gevonden: aspmx.l.google.com. met IP: 173.194.79.27", "Andere server gevonden: alt1.aspmx.l.google.com. met IP: 142.250.150.27", "Andere server gevonden: alt2.aspmx.l.google.com. met IP: 74.125.200.26", "Andere server gevonden: alt3.aspmx.l.google.com. met IP: 142.250.157.26" ]')))