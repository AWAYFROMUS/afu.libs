#### Synchronize
Client
```lua
AFULibs = exports['afu.libs']:Initial()

resultOfPlus = AFULibs.AwaitTriggerServerEvent("eventName", 1, 2)
print(resultOfPlus) -- 3
```
Server
```lua
AFULibs = exports['afu.libs']:Initial()

AFULibs.RegisterAsyncServerEvent("EventPlusNumber", function(source, num1, num2)
    return num1 + num2
end)
```
