--[[

    💬 Export from AFU Squad
    🐌 @Copyright Danyouknowme x Txrxx x Hex

    ☕ Thanks For Coffee Tips  💳 Buy token at awayfromus.dev

]] Libs = Libs or {}

local __rid = 0
local __waitng = {}
---@param eventName string อีเว้นที่ต้องการเรียกไปที่เซิฟเวอร์
---@vararg any ... 
---@return any ...
function Libs.AwaitTriggerServerEvent(eventName, ...)
    local id <const> = __rid + 1
    __rid += 1
    TriggerServerEvent("__afulibs_await_tse", eventName, id, ...)

    local promise = promise:new()
    __waitng[id] = function(response, ...)
        response = { response, ... }
        __waitng[id] = nil
        if promise then
            return promise:resolve(response)
        end
    end
    return table.unpack(Citizen.Await(promise))
end

RegisterNetEvent("__afulibs_res_tse", function(id, ...)
    local cb = __waitng[id]
    return cb and cb(...)
end)