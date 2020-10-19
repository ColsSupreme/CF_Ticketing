sign = nil

CF = nil

status = nil
Citizen.CreateThread(function()
	while CF == nil do 
        Citizen.Wait(0)
        TriggerEvent('cf:getSharedObject', function(obj) CF = obj end)
    end
    
end)


queue = {}
function Ticket(_source,Target,amount)
    local source = _source
    status = nil
    local name = GetPlayerName(GetPlayerFromServerId(source))
    if status == nil then
        Citizen.CreateThread(function() 
            while status == nil do 
                Citizen.Wait(0)
                --print(GetPlayerName(GetPlayerFromServerId(-1)))
                if (IsControlJustReleased(0,51)) then -- On E Press
                    status = true
                    TriggerServerEvent("Signed", _source,Target,amount)
                end
                if (IsControlJustReleased(0,23)) then -- On F Press
                    status = false
                    TriggerServerEvent("Refuse", _source,Target,amount)

                end
            end
    end)
end
end



RegisterNetEvent("RequestTicket")
AddEventHandler("RequestTicket", function(Target, _source,amount)
    print(amount .. " Amount")
    Ticket(_source,Target,amount)
end)


RegisterNetEvent("Ticketdone")
AddEventHandler("Ticketdone", function(Target, _source,amount)
    status = nil
end)