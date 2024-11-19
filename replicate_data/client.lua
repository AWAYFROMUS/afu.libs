--[[

    💬 Export from AFU Squad
    🐌 @Copyright Danyouknowme x Txrxx x Hex

    ☕ Thanks For Coffee Tips  💳 Buy token at awayfromus.dev

]] Libs = Libs or {} Libs.ReplicateData = Libs.ReplicateData or {}

Libs.ReplicateData.isInitialized = promise:new()
local __internal_replicate_data = {
    data = {}
}

RegisterNetEvent("__afulibs_replicate_data:sync", function(key, stateBagkey, data)
    __internal_replicate_data.data[key] = data
    AddStateBagChangeHandler(stateBagkey, "global", function(_, key, value)
        __internal_replicate_data.data[key] = value
        Logger.info(("replicate data ^2%s^7 updated"):format(key))
    end)
    Libs.Logger.info(("replicate data ^2%s^7 synced"):format(key))
end)

---@param key string ชื่อของข้อมูล
---@return ReplicateClass|nil replicateData, error|string|nil
function Libs.ReplicateData.Get(key)
    if __internal_replicate_data.data[key] then
        return __internal_replicate_data.data[key]
    end
    return nil
end

Libs.ReplicateData.isInitialized:resolve()