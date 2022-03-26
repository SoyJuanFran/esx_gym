ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj
end)


AddEventHandler('esx:playerLoaded', function (source)
    LoadLicenses(source)
end)

function LoadLicenses (source)
  TriggerEvent('esx_license:getLicenses', source, function (licenses)
    TriggerClientEvent('esx_gym:loadLicenses', source, licenses)
  end)
end

RegisterServerEvent('esx_gym:buyLicense')
AddEventHandler('esx_gym:buyLicense', function ()
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(source)
local adicoins = 0

	
	adicoins = xPlayer.getAccount('bank').money
  if adicoins >= 800 then
		xPlayer.removeAccountMoney('bank', 800)

    TriggerEvent('esx_license:addLicense', _source, 'gym', function ()
      LoadLicenses(_source)
    end)
  else
    xPlayer.showNotification(_U('not_enough'))
  end
end)

RegisterServerEvent('esx_gym:checkChip')
AddEventHandler('esx_gym:checkChip', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local oneQuantity = xPlayer.getInventoryItem('gym_membership').count
	
	if oneQuantity > 0 then
		TriggerClientEvent('esx_gym:trueMembership', source) -- true
	else
		TriggerClientEvent('esx_gym:falseMembership', source) -- false
	end
end)

ESX.RegisterUsableItem('gym_bandage', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('gym_bandage', 1)	
	
	TriggerClientEvent('esx_gym:useBandage', source)
end)


RegisterServerEvent('esx_gym:buyProteinshake')
AddEventHandler('esx_gym:buyProteinshake', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local adicoins = 0

	
	adicoins = xPlayer.getAccount('bank').money
	
	if adicoins >= 40 then
		xPlayer.removeAccountMoney('bank', 40)
		
		xPlayer.addInventoryItem('protein_shake', 1)
		
		notification("Compraste un ~g~batido de proteinas")
	else
		notification("No tienes suficiente ~r~dinero")
	end	
end)

ESX.RegisterUsableItem('protein_shake', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('protein_shake', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 220000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, 'has bebido un ~g~batido de proteinas')

end)

RegisterServerEvent('esx_gym:buyWater')
AddEventHandler('esx_gym:buyWater', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local adicoins = 0

	
	adicoins = xPlayer.getAccount('bank').money
	if adicoins >= 20 then
		xPlayer.removeAccountMoney('bank', 20)
		
		xPlayer.addInventoryItem('water', 1)
		
		notification("has comprado ~g~agua")
	else
		notification("No tienes suficiente ~r~dinero")
	end		
end)

RegisterServerEvent('esx_gym:buySportlunch')
AddEventHandler('esx_gym:buySportlunch', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local adicoins = 0

	
	adicoins = xPlayer.getAccount('bank').money
	if adicoins >= 40 then
		xPlayer.removeAccountMoney('bank', 40)
		
		xPlayer.addInventoryItem('sportlunch', 1)
		
		notification("Has comprado una ~g~Barrita Energetica")
	else
		notification("No tienes suficiente ~r~dinero")
	end		
end)

ESX.RegisterUsableItem('sportlunch', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('sportlunch', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 200000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('esx:showNotification', source, 'Has comido una ~g~Barrita energetica')

end)

RegisterServerEvent('esx_gym:buyPowerade')
AddEventHandler('esx_gym:buyPowerade', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local adicoins = 0

	
	adicoins = xPlayer.getAccount('bank').money
	if adicoins >= 40 then
		xPlayer.removeAccountMoney('bank', 40)
		
		xPlayer.addInventoryItem('powerade', 1)
		
		notification("has comprado ~g~Bebida Deportiva")
	else
		notification("No tienes suficiente ~r~dinero")
	end		
end)

ESX.RegisterUsableItem('powerade', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('powerade', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 400000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, 'Has tomado una ~g~bebida energetica')

end)


function notification(text)
	TriggerClientEvent('esx:showNotification', source, text)
end
