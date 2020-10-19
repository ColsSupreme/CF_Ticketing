CF = nil
TicketIP = {0,}
Citizen.CreateThread(function()
	while CF == nil do 
        Citizen.Wait(0)
        TriggerEvent('cf:getSharedObject', function(obj) CF = obj end)
    end
    
end)
ABT = false

RegisterCommand("ticket",function(source, args,raw)
        _source = source
        ABT = false   
        local amount = tonumber(args[2])
        local person = tonumber(args[1])
        local personticket = person
            for k,v in ipairs(TicketIP) do
                if TicketIP[k] == person then
                    
                    ABT = true
                end
            end
            
            if ABT == true then
                CF.ShowNotification(_source,"~r~This person is alredy being ticketed")
            else
                
                table.insert(TicketIP,person)
                if person == nil then
                    CF.ShowNotification(_source,"~r~You need to enter who you are ticketing and how much, it must be their id")
                    for k,v in ipairs(TicketIP) do  
                        if TicketIP[k] == _source then 
                            table.remove(TicketIP,k)
                            ABT = false
                        end
                    end
                elseif amount == nil or amount <= 0 or amount >= 12001 then
                    CF.ShowNotification(_source,"~r~You need to enter the amount to ticket, minimum fine is 1$ max is $12000")
                    for k,v in ipairs(TicketIP) do  
                        if TicketIP[k] == _source then 
                            table.remove(TicketIP,k)
                            ABT = false
                        end
                    end
                else    
                    CF.ShowNotification(_source,"You have given a ticket of ~r~" .. amount .. "$ ~c~~w~ to" .. GetPlayerName(person)) 
                    CF.ShowNotification(person,"You have been ticketed ~r~" .. amount .. "$ ~c~~w~ press ~r~ E ~w~ to sign and ~r~ F ~w~ to not sign. You were given this ticket by " .. GetPlayerName(_source))
                    TriggerClientEvent("RequestTicket",person,_source ,person, amount)
                end
                
            end
            
        
    end)

RegisterNetEvent("Signed")
AddEventHandler("Signed", function(_source ,person, amount)
    local Revipient = exports.essentialmode:getPlayerFromId(person)
    local Target = exports.essentialmode:getPlayerFromId(_source)
    CF.ShowNotification(person,"~g~They signed the ticket have a nice day")
    if Target.getMoney() >= amount then
        Target.removeMoney(amount)
        local leocut = amount/10
        Revipient.addMoney(leocut)
        CF.ShowNotification(person,"~g~You have made " ..leocut .. "$ from this ticket" )
        CF.ShowNotification(_source,"~r~You have paid " ..amount .. "$ from this ticket" )
        exports.logs:discord(":warning: **" ..GetPlayerName(_source) .." (" .. _source .. ")** has been ticketed ".. amount .. "$ by **" .. GetPlayerName(person) .."(".. person ..")**" ,"banking")
        exports.logs:discord(":warning: **" ..GetPlayerName(_source) .." (" .. _source .. ")** has been ticketed ".. amount .. "$ by **" .. GetPlayerName(person) .."(".. person ..")**" ,"leoactions")
    elseif Target.getBank() >= amount then
        
        Target.removeBank(amount)
        local leocut = amount/10
        Revipient.addMoney(leocut)
        CF.ShowNotification(_source,"~r~You have paid " ..amount .. "$ from this ticket" )
        CF.ShowNotification(person,"~g~You have made " ..leocut .. "$ from this ticket" )
        exports.logs:discord(":warning: **" ..GetPlayerName(_source) .." (" .. _source .. ")** has been ticketed ".. amount .. "$ by **" .. GetPlayerName(person) .."(".. person ..")**" ,"banking")
        exports.logs:discord(":warning: **" ..GetPlayerName(_source) .." (" .. _source .. ")** has been ticketed ".. amount .. "$ by **" .. GetPlayerName(person) .."(".. person ..")**" ,"leoactions")
    else
        CF.ShowNotification(person,"~r~They cannot afford the ticket")
        CF.ShowNotification(_source,"~r~You cannot afford the ticket")
    end
    local personticket = {person,_source}
    for k,v in ipairs(TicketIP) do  
        if TicketIP[k] == _source then 
            table.remove(TicketIP,k)
            ABT = false
        end
    end
end)


RegisterNetEvent("Refuse")
AddEventHandler("Refuse", function(_source ,person, amount)
    CF.ShowNotification(person,"~r~They Refuse signed the ticket take them to jail.")
    local personticket = {person,_source}
    for k,v in ipairs(TicketIP) do
        if TicketIP[k] == _source then
            
            table.remove(TicketIP,k)
            ABT = false
        end
    end
end)


RegisterCommand("Clearticket", function(source, args,raw)
    person = args[1]
    if person == nil then
        CF.ShowNotification(_source,"~r~You need to enter who you are ticketing and how much, it must be their id")
    else
        for k,v in ipairs(TicketIP) do
            if TicketIP[k] == person then
                table.remove(TicketIP,k)
                CF.ShowNotification(_source,"~r~Pending ticket removed")
            else
                CF.ShowNotification(_source,"~r~This person dose not have a ticket")
            end
        end
    end
end)