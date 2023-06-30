RegisterNetEvent('give_item', function(item, amount, price)

    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local total_price = amount * price

    if xPlayer.canCarryItem(item, amount) then

        if xPlayer.getAccount('bank').money >= total_price then


            xPlayer.removeAccountMoney('bank', total_price)
            xPlayer.addInventoryItem(item, amount)


        else
            TriggerClientEvent('eb:need_money', src, data)
        end

    else
        TriggerClientEvent('eb:need_space', src, data)
    end

end)