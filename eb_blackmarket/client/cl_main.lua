ped = false

CreateThread(function()

    while true do

        if not ped then
            ped = true

            RequestModel(GetHashKey('a_m_m_soucent_01')) -- Ændre PED type her    https://docs.fivem.net/docs/game-references/ped-models/
            while not HasModelLoaded(GetHashKey('a_m_m_soucent_01')) do -- Ændre PED type her    https://docs.fivem.net/docs/game-references/ped-models/
                Wait(1)
            end

            ped = CreatePed(4, GetHashKey('a_m_m_soucent_01'), 383.2785, -2659.7417, 5.0006, 356.8210, false, true)  -- Ændre PED type og lokation her https://docs.fivem.net/docs/game-references/ped-models/
            FreezeEntityPosition(ped, true)
            SetEntityInvincible(ped, true)
            SetBlockingOfNonTemporaryEvents(ped, true)
        end
        Wait(100)

    end 
    
end)

exports.ox_target:addSphereZone({

    coords = vec3(383.2785, -2659.7417, 6.0006), -- Ændre target lokation her
    radius = 1,
    debug = drawZones,

    options = {

        {
            name = 'blackmarket_script',
            event = 'eb:show_menu',
            icon = 'fa-solid fa-person',
            label = 'Tilgå Black Market', -- Ændre target tekst her
            canInteract = function(entity, distance, coords, name)
                return true
            end
        },

    }

})

AddEventHandler('eb:show_menu', function()

    lib.registerContext({

        id = 'open_black_market',
        title = 'Black Market',

        options = {

            {
                title = 'Pistol',
                description = '1.000.000 DKK',
                icon = 'gun',

                onSelect = function()

                    local input = lib.inputDialog('Black Market', {
                        {type = 'input', label = 'Antal', description = 'antal du ønsker af den valgte gendstand', required = true}
                    })

                    local item = 'weapon_pistol'
                    local amount = tonumber(input[1])
                    local price = 1000000

                    TriggerServerEvent('give_item', item, amount, price)

                end,
            },

            {
                title = 'Skudsikkervest',
                description = '50.000 DKK',
                icon = 'vest',

                onSelect = function()

                    local input = lib.inputDialog('Black Market', {
                        {type = 'input', label = 'Antal', description = 'antal du ønsker af den valgte gendstand', required = true}
                    })

                    local item = 'bulletproofvest'
                    local amount = tonumber(input[1])
                    local price = 50000

                    TriggerServerEvent('give_item', item, amount, price)

                end,
            },

            --[[

            {
                title = 'Brød', -- Title på item her
                description = '10 DKK', -- Beskrivelse af item her
                icon = 'burger', -- Icon på item her    https://fontawesome.com/

                onSelect = function()

                    local input = lib.inputDialog('Black Market', {
                        {type = 'input', label = 'Antal', description = 'antal du ønsker af den valgte gendstand', required = true}
                    })

                    local item = 'bread' -- Spawnkode på item her
                    local amount = tonumber(input[1])
                    local price = 10 -- Pris på item her

                    TriggerServerEvent('give_item', item, amount, price)

                end,
            },

            ]]--

        }

    })

    lib.showContext('open_black_market')

end)

RegisterNetEvent('eb:need_money')
AddEventHandler('eb:need_money', function() 

    TriggerEvent('ox_lib:notify', {type = 'error', description = 'Du mangler penge!' })
    
end)

RegisterNetEvent('eb:need_space')
AddEventHandler('eb:need_space', function() 

    TriggerEvent('ox_lib:notify', {type = 'error', description = 'Du mangler plads!' })
    
end)

