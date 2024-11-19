### Synchronize
Client Usage
```lua
AFULibs = exports['afu.libs']:Initial()

resultOfPlus = AFULibs.AwaitTriggerServerEvent("EventPlusNumber", 1, 2)
print(resultOfPlus) -- 3
```
Server Usage
```lua
AFULibs = exports['afu.libs']:Initial()

AFULibs.RegisterAsyncServerEvent("EventPlusNumber", function(source, num1, num2)
    return num1 + num2
end)
```

### Replicate Data (WIP)
1. Example Create ReplicateData
```lua
---@server-side-supported
---@client-side-supported

AFULibs = exports['afu.libs']:Initial()
---@comment กำหนด data ที่จะสร้าง
local data = {
    name = "John",
    age = 20
}
---@comment กำหนด key ของ ReplicateData ที่จะสร้าง
local key = "example_person"

---@comment สร้าง ReplicateData จาก data ที่กำหนด โดยต้องกำหนด key ให้ตรงกับที่ใช้ในการเรียกใช้งาน
data, err = AFULibs.ReplicateData.Create(key, data)
if err then
    print(err)
end
```
2. Example Get ReplicateData
```lua
---@server-side-supported
---@client-side-supported
---@comment ดึงข้อมูลจาก ReplicateData ที่สร้างไว้
local rpData = AFULibs.ReplicateData.Get(key)
print(rpData.name) -- John
print(rpData.age) -- 20
```