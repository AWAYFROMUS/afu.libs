--[[

    💬 Export from AFU Squad
    🐌 @Copyright Danyouknowme x Txrxx x Hex

    ☕ Thanks For Coffee Tips  💳 Buy token at awayfromus.dev
    
]]

exports("Initial", function(key)
    ---@comment wait for replicate data to be initialized
    if Libs.ReplicateData.isInitialized then
        Citizen.Await(Libs.ReplicateData.isInitialized)
    end
    return key and Libs[key] or Libs
end)