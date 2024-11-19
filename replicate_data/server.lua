--[[

    💬 Export from AFU Squad
    🐌 @Copyright Danyouknowme x Txrxx x Hex

    ☕ Thanks For Coffee Tips  💳 Buy token at awayfromus.dev

]]
Libs = Libs or {}
Libs.ReplicateData = Libs.ReplicateData or {}
Libs.ReplicateData.isInitialized = promise.new()

local json = json
local tostring = tostring
local __internal_replicate_data = {
    replicateGlobalKey = tostring(os.time()),
    data = {}
}

function __internal_replicate_data.intialize()
    MySQL.rawExecute.await([[
        CREATE TABLE IF NOT EXISTS `afu_libs_replicate_data` (
            `key` varchar(255) NOT NULL,
            `data` longtext DEFAULT NULL,
            PRIMARY KEY (`key`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3
    ]])
end

function __internal_replicate_data.getFromSQL(key)
    local resp = MySQL.prepare.await("SELECT * from afu_libs_replicate_data WHERE `key` = ?", {
        key
    })
    if resp and resp.data then
        return json.decode(resp.data)
    end
    return nil
end

function __internal_replicate_data.syncData(key, data)
    __internal_replicate_data.saveToSql(key, data)
    __internal_replicate_data.data[key] = data
    local stateBagKey = ("%s%s"):format(__internal_replicate_data.replicateGlobalKey, key)
    GlobalState[stateBagKey ..  key] = data
    TriggerClientEvent("__afulibs_replicate_data:sync", -1, key, stateBagKey,  data)
end

function __internal_replicate_data.isKeyExists(key)
    if __internal_replicate_data.data[key] then
       return true
    end

    if __internal_replicate_data.getFromSQL(key) then
        return true
    end
    return false
end

function __internal_replicate_data.saveToSql(key, data)
    local resp = MySQL.prepare.await("INSERT INTO afu_libs_replicate_data (`key`, `data`) VALUES (?, ?) ON DUPLICATE KEY UPDATE `data` = ?", {
        key,
        json.encode(data),
        json.encode(data)
    })
    Libs.Logger.info(("saved replicate data of key %s to sql"):format(key))
end

__internal_replicate_data.intialize()

---@param key string ชื่อของข้อมูล
---@return ReplicateClass|nil replicateData, error|string|nil
function Libs.ReplicateData.Get(key)
    if __internal_replicate_data.data[key] == nil then
        local repDataFromSql = __internal_replicate_data.getFromSQL(key)
        if repDataFromSql then
            __internal_replicate_data.data[key] = repDataFromSql
            return __internal_replicate_data.data[key], false
        else
            return false, ("key %s not found"):format(key)
        end
    end
    return __internal_replicate_data.data[key], false
end

---@param key string ชื่อของข้อมูล
---@param data any ข้อมูลที่ต้องการเก็บ
---@return error|string|nil
function Libs.ReplicateData.Create(key, data)
    if __internal_replicate_data.isKeyExists(key) then
        return ("key %s already exists"):format(key)
    end
    __internal_replicate_data.syncData(key, data)
    return false
end

Libs.ReplicateData.isInitialized:resolve()