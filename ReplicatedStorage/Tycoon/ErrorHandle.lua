local module = {

    errorHandle = function(part, attribute, whatType, message, isError)
        
        --[[----------------------------------------------------
            isError:
            Set the message to an Error or a Warn
        ----------------------------------------------------]]--
        isError = isError == true and "Error:" or "Warn: "
        

        --[[----------------------------------------------------
            Print the main error of the handle
        ----------------------------------------------------]]--
        warn(isError, part, "attribute " .. whatType .. " \"" .. attribute .. "\" expected, got", part:GetAttribute(attribute) == nil or "" and "nil" or type(part:GetAttribute(attribute)))


        --[[----------------------------------------------------
            Print a hint for code
        ----------------------------------------------------]]--
        if message == nil then return end

        if type(message) == "table" then

            for _, msg in pairs(message) do
                warn("       -", msg)
            end

        else

            warn("       -", message)

        end

    end
    
}

return module
