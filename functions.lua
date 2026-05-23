function S_Pointer(t_So, t_Offset, _bit)
    local function getRanges()
        local ranges = {}
        local t = gg.getRangesList('^/data/*.so*$')
        for i, v in pairs(t) do
            if v.type:sub(2, 2) == 'w' then
                table.insert(ranges, v)
            end
        end
        return ranges
    end
    local function Get_Address(N_So, Offset, ti_bit)
        local ti = gg.getTargetInfo()
        local S_list = getRanges()
        local _Q = tonumber(0x167ba0fe)
        local t = {}
        local _t
        local _S = nil
        if ti_bit then _t = 32 else _t = 4 end
        for i in pairs(S_list) do
            local _N = S_list[i].internalName:gsub('^.*/', '')
            if N_So[1] == _N and N_So[2] == S_list[i].state then
                _S = S_list[i]
                break
            end
        end
        if _S then
            t[#t + 1] = {}
            t[#t].address = _S.start + Offset[1]
            t[#t].flags = _t
            if #Offset ~= 1 then
                for i = 2, #Offset do
                    local S = gg.getValues(t)
                    t = {}
                    for _ in pairs(S) do
                        if not ti.x64 then
                            S[_].value = S[_].value & 0xFFFFFFFF
                        end
                        t[#t + 1] = {}
                        t[#t].address = S[_].value + Offset[i]
                        t[#t].flags = _t
                    end
                end
            end
            _S = t[#t].address
            print(string.char(231,190,164,58).._Q)
        end
        return _S
    end
    local _A = string.format('0x%X', Get_Address(t_So, t_Offset, _bit))
    return _A
end

functionData = {
    {t = {"libil2cpp.so", "Cd"}, tt = {0x447D0, 0xB8, 0x70, 0x50, 0xA0}, flags = 16, value = 0},
    {t = {"libil2cpp.so", "Cd"}, tt = {0x455D0, 0xB8, 0x10, 0x30, 0xA4}, flags = 16, value = 0},
    {t = {"libil2cpp.so", "Cd"}, tt = {0x455E0, 0xB8, 0x30, 0x30, 0x90}, flags = 4, value = 6},
    {t = {"libil2cpp.so", "Cd"}, tt = {0x455D0, 0xB8, 0x10, 0x30, 0xAC}, flags = 16, value = 0},
    {t = {"libil2cpp.so", "Cd"}, tt = {0x447D0, 0xB8, 0x70, 0x50, 0xB0}, flags = 16, value = 0},
    {t = {"libil2cpp.so", "Cd"}, tt = {0xDC8C8, 0xB8, 0xC0, 0x30, 0x94}, flags = 4, value = 6},
    {t = {"libil2cpp.so", "Cd"}, tt = {0x455D0, 0xB8, 0x10, 0x30, 0x84}, flags = 4, value = 10000},
    {t = {"libil2cpp.so", "Cd"}, tt = {0x4E538, 0x80, 0xB8, 0x1C0, 0xD8}, flags = 4, value = 580}
}
