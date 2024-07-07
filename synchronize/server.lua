--[[

    💬 Export from AFU Squad
    🐌 @Copyright Danyouknowme x Txrxx x Hex

    ☕ Thanks For Coffee Tips  💳 Buy token at awayfromus.dev

]] Libs = Libs or {}

local pcall = pcall
local asyncEvents = {}

---@description ลงทะเบียน Async Server Event
---@param eventName string ชื่อ Event
---@param cb function ฟังก์ชันที่จะทำงานเมื่อถูกเรียกจาก Client
function Libs.RegisterAsyncServerEvent(eventName, cb)
    asyncEvents[eventName] = cb
    Modules.Logger.debug(("Registered Async Server Event ^5%s^7"):format(eventName))
end

---@param pass boolean
---@param result any
local function callbackResponse(pass, result, ...)
    if not pass then
        return false
    end

    return pass, result, { ... }
end

---@description รอรับ Event จาก Clients
RegisterNetEvent("__afulibs_await_tse", function(eventName, id, ...)
    local source = source
    local pass, firstResult, data = callbackResponse(pcall(asyncEvents[eventName], source, ...))
    if not pass then
        Modules.Logger.error(("Async Server Event ^1%s^7 failed with error: ^1%s^7"):format(eventName, result))
        return TriggerClientEvent("__afulibs_res_tse", source, id)
    end
    TriggerClientEvent("__afulibs_res_tse", source, id, firstResult, table.unpack(data))
end)