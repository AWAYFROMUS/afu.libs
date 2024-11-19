--[[

    💬 Export from AFU Squad
    🐌 @Copyright Danyouknowme x Txrxx x Hex

    ☕ Thanks For Coffee Tips  💳 Buy token at awayfromus.dev

]]
Libs = Libs or {}
Libs.Logger = Libs.Logger or {}


local print = print

function Libs.Logger.GetTime()
    ---@comment server side
    if IsDuplicityVersion() then
        return os.date("[%Y-%m-%d %H:%M:%S]")
    end
    local year , month , day , hour , minute , second = GetLocalTime()
    return ("[%04d-%02d-%02d %02d:%02d:%02d]"):format(year , month , day , hour , minute , second)
end

function Libs.Logger.info(...)
    print(Libs.Logger.GetTime() .. "[^2info^7] ", ...)
end

function Libs.Logger.debug(...)
    print(Libs.Logger.GetTime() .. "[^5debug^7] ", ...)
end

function Libs.Logger.error(...)
    print(Libs.Logger.GetTime() .. "[^1error^7] ", ...)
end

function Libs.Logger.warning(...)
    print(Libs.Logger.GetTime() .. "[^3warning^7] ", ...)
end

function Libs.Logger.success(...)
    print(Libs.Logger.GetTime() .. "[^6success^7] ", ...)
end
