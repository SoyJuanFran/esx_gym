local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX = nil
local PlayerData              = {}
local training = false
local membership = false
local Licenses                = {}
local cancelar = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
		PlayerData = ESX.GetPlayerData()
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)


RegisterNetEvent('esx_gym:loadLicenses')
AddEventHandler('esx_gym:loadLicenses', function (licenses)
  for i = 1, #licenses, 1 do
    Licenses[licenses[i].type] = true
  end
  
  if Licenses['gym'] ~= nil then
		membership = true
	else
		membership = false
	end

end)


function OpenBuyLicenseMenu (zone)
  ESX.UI.Menu.CloseAll()

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'shop_license',
    {
      title = ('Comprar Carnet de GYM'),
      elements = {
        { label = ('Si') .. ' ($' .. 800 .. ')', value = 'yes' },
        { label = ('No'), value = 'no' },
      }
    },
    function (data, menu)
      if data.current.value == 'yes' then
        TriggerServerEvent('esx_gym:buyLicense')
      end

      menu.close()
    end,
    function (data, menu)
      menu.close()
    end
  )
end

function hintToDisplay(text)
	SetTextComponentFormat("STRING")
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

local blips = {
	{title="Gym", colour=7, id=311, x = -1201.2257, y = -1568.8670, z = 4.6101},
	{title="Gym", colour=7, id=311, x = -57.66, y = -1283.42, z = 30.91},
	{title="Gym", colour=7, id=311, x = 1561.91, y = 3524.03, z = 35.91},
	{title="Gym", colour=7, id=311, x = -382.41, y = 6049.68, z = 31.46}
}
	
Citizen.CreateThread(function()

	for _, info in pairs(blips) do
		info.blip = AddBlipForCoord(info.x, info.y, info.z)
		SetBlipSprite(info.blip, info.id)
		SetBlipDisplay(info.blip, 4)
		SetBlipScale(info.blip, 1.0)
		SetBlipColour(info.blip, info.colour)
		SetBlipAsShortRange(info.blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(info.title)
		EndTextCommandSetBlipName(info.blip)
	end
end)

RegisterNetEvent('esx_gym:useBandage')
AddEventHandler('esx_gym:useBandage', function()
	local playerPed = GetPlayerPed(-1)
	local maxHealth = GetEntityMaxHealth(playerPed)
	local health = GetEntityHealth(playerPed)
	local newHealth = math.min(maxHealth , math.floor(health + maxHealth/3))

	SetEntityHealth(playerPed, newHealth)
	--SetEntityHealth(playerPed, maxHealth) -- Give them full health by one bandage
	
	ESX.ShowNotification("Has usado bendas")
end)
-- LOCATION (START)
--pesas
local arms = {
    {x = -1202.9837,y = -1565.1718,z = 4.6115},
	{x = 1562.05,y = 3526.42,z = 35.91},
	{x = -61.87,y = -1282.31,z = 30.91},
	{x = -857.8,y = -14.18,z = 40.55} -- marco dangelo
}
-- sentadillas
local pushup = {
    {x = -1198.41,y = -1566.36,z = 4.6115},
	{x = 1555.5,y = 3522.44,z = 35.6115},
	{x = -59.18,y = -1287.76,z = 30.91},
	{x = -381.61,y = 6045.64,z = 31.45}
}

local yoga = {
    {x = -1204.7958,y = -1560.1906,z = 4.6115},
	{x = 1575.94,y = 3525.35,z = 35.6115},
	{x = -56.3,y = -1278.87,z = 29.23},
	{x = -373.27,y = 6042.41,z = 31.48},
	{x = -374.33,y = 6046.27,z = 31.48},
	{x = -857.56,y = -18.57,z = 40.55} -- marco dangelo
	
}

-- abdominales
local situps = {
    {x = -1206.1055,y = -1565.1589,z = 4.6115},
	{x = 1567.07,y = 3522.13,z = 35.61},
	{x = -60.84,y = -1279.13,z = 30.91},
	{x = -379.14,y = 6047.37,z = 31.48}
}

local gym = {
    {x = -1195.6551,y = -1577.7689,z = 4.6115},
	{x = 1571.03,y = 3525.05,z = 35.61},
	{x = -53.43,y = -1289.6,z = 30.91},
	{x = -375.51,y = 6052.13,z = 31.45}
}
--levantarse
local chins = {
    {x = -1200.1284,y = -1570.9903,z = 4.6115},
	{x = 1562.95,y = 3522.68,z = 35.61},
	{x = 1571.37,y = 3531.29,z = 35.61},
	{x = -59.15,y = -1285.01,z = 30.91},
	{x = -376.0,y = 6041.55,z = 31.49},
	{x = -374.73,y = 6040.2,z = 31.49}
}



Citizen.CreateThread(function()
    while true do
        local letSleep = true

        for k in pairs(gym) do
		
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, gym[k].x, gym[k].y, gym[k].z)
			if dist < 15 then
			letSleep = false
			DrawMarker(22, gym[k].x, gym[k].y, gym[k].z, 0, 0, 0, 0, 0, 0, 0.301, 0.301, 0.3001, 51, 255, 255, 200, 0, 0, 0, 0)
            if dist <= 0.5 then
				hintToDisplay('Pulsa ~INPUT_CONTEXT~ para abrir el menu del gym')
				
				if IsControlJustPressed(0, Keys['E']) then
				    if Licenses['gym'] ~= nil then
						OpenGymMenu()
								else
						OpenBuyLicenseMenu()
					end
				end			
            end
        end
        end
		if letSleep then
			Citizen.Wait(1000)
		end
		Citizen.Wait(1)
    end
end)

Citizen.CreateThread(function()
    while true do
        local letSleep = true

        for k in pairs(arms) do

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, arms[k].x, arms[k].y, arms[k].z)
		if dist < 15 then
			letSleep = false
			DrawMarker(21, arms[k].x, arms[k].y, arms[k].z, 0, 0, 0, 0, 0, 0, 0.301, 0.301, 0.3001, 0, 255, 50, 200, 0, 0, 0, 0)
            if dist <= 0.5 then
				hintToDisplay('Pulsa ~INPUT_CONTEXT~ para ejecitar tus Brazos')
				
				if IsControlJustPressed(0, Keys['E']) then
					if training == false then
					
						TriggerServerEvent('esx_gym:checkChip')
						ESX.ShowNotification("Preparando el ejercicio...")
						Citizen.Wait(1000)					
					
						if membership == true then
						cancelar = true
							local playerPed = GetPlayerPed(-1)
							local number = tonumber(string.format("%." .. 2 .. "f", math.random(1,5)/math.random(1,10)))
							TaskStartScenarioInPlace(playerPed, "world_human_muscle_free_weights", 0, true)
							Citizen.Wait(30000)
							ClearPedTasksImmediately(playerPed)
							ESX.ShowNotification("Necesitas descansar 60 segundos antes de hacer otro ejercicio.")
							
							 exports["adictos-skills"]:UpdateSkill("Fuerza", number)
							 ESX.ShowNotification("Has aumentado un " ..number.."% tu fuerza")
							cancelar = false
							training = true
							Citizen.Wait(1000)
							descanso()
						elseif membership == false then
							ESX.ShowNotification("Necesitas ser miembro del gym para hacer ejercicio")
						end
					elseif training == true then
						ESX.ShowNotification("Necesitas descansar...")						
						end
					end			
				end
			end
        end
		if letSleep then
			Citizen.Wait(1000)
		end
		Citizen.Wait(1)
    end
end)

Citizen.CreateThread(function()
    while true do
       local letSleep = true

        for k in pairs(chins) do

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, chins[k].x, chins[k].y, chins[k].z)
			if dist < 15 then
			letSleep = false
			DrawMarker(21, chins[k].x, chins[k].y, chins[k].z, 0, 0, 0, 0, 0, 0, 0.301, 0.301, 0.3001, 0, 255, 50, 200, 0, 0, 0, 0)
            if dist <= 0.5 then
				hintToDisplay('Pulsa ~INPUT_CONTEXT~ para hacer dominadas')
				
				if IsControlJustPressed(0, Keys['E']) then
					if training == false then
					
						TriggerServerEvent('esx_gym:checkChip')
						ESX.ShowNotification("Preparando el ejercicio...")
						Citizen.Wait(1000)					
					
						if membership == true then
						cancelar = true
							local playerPed = GetPlayerPed(-1)
							local number = tonumber(string.format("%." .. 2 .. "f", math.random(1,5)/math.random(1,10)))
							TaskStartScenarioInPlace(playerPed, "prop_human_muscle_chin_ups", 0, true)
							Citizen.Wait(30000)
							ClearPedTasksImmediately(playerPed)
							ESX.ShowNotification("Necesitas descansar 60 segundos antes de hacer otro ejercicio.")
							cancelar = false
							 exports["adictos-skills"]:UpdateSkill("Fuerza", number)
							ESX.ShowNotification("Has aumentado un " ..number.."% tu fuerza")
							training = true
							
							Citizen.Wait(1000)
							descanso()
						elseif membership == false then
							ESX.ShowNotification("Necesitas ser miembro del gym para hacer ejercicio")
						end
					elseif training == true then
						ESX.ShowNotification("Necesitas descansar...")
						end
					end			
				end
			end
        end
		if letSleep then
			Citizen.Wait(1000)
		end
		Citizen.Wait(1)
    end
end)

Citizen.CreateThread(function()
    while true do
		local letSleep = true
        for k in pairs(pushup) do

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, pushup[k].x, pushup[k].y, pushup[k].z)
			
			if dist < 15 then
			letSleep = false
			DrawMarker(21, pushup[k].x, pushup[k].y, pushup[k].z, 0, 0, 0, 0, 0, 0, 0.301, 0.301, 0.3001, 0, 255, 50, 200, 0, 0, 0, 0)
				if dist <= 0.5 then
					hintToDisplay('Pulsa ~INPUT_CONTEXT~ para hacer flexiones')
					
					if IsControlJustPressed(0, Keys['E']) then
						if training == false then
						
							TriggerServerEvent('esx_gym:checkChip')
							ESX.ShowNotification("Preparando el ejercicio...")
							Citizen.Wait(1000)					
						
							if membership == true then	
								cancelar = true						
								local playerPed = GetPlayerPed(-1)
								local number = tonumber(string.format("%." .. 2 .. "f", math.random(1,5)/math.random(1,10)))
								TaskStartScenarioInPlace(playerPed, "world_human_push_ups", 0, true)
								Citizen.Wait(30000)
								cancelar = false
								ClearPedTasksImmediately(playerPed)
								ESX.ShowNotification("Necesitas descansar 60 segundos antes de hacer otro ejercicio.")
							
								 exports["adictos-skills"]:UpdateSkill("Fuerza", number)
								ESX.ShowNotification("Has aumentado un " ..number.."% tu fuerza")
								training = true
								
								Citizen.Wait(1000)
								descanso()
							elseif membership == false then
								ESX.ShowNotification("Necesitas ser miembro del gym para hacer ejercicio")
							end							
						elseif training == true then
							ESX.ShowNotification("Necesitas descansar...")
						end
					end			
				end
			end
        end
		if letSleep then
			Citizen.Wait(1000)
		end
		Citizen.Wait(1)
    end
end)

Citizen.CreateThread(function()
    while true do
		local letSleep = true
        for k in pairs(yoga) do
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, yoga[k].x, yoga[k].y, yoga[k].z)
			
			if dist < 15 then
			letSleep = false
			DrawMarker(21, yoga[k].x, yoga[k].y, yoga[k].z, 0, 0, 0, 0, 0, 0, 0.301, 0.301, 0.3001, 0, 255, 50, 200, 0, 0, 0, 0)
				if dist <= 0.5 then
					hintToDisplay('Pulsa ~INPUT_CONTEXT~ para hacer yoga')
					
					if IsControlJustPressed(0, Keys['E']) then
						if training == false then
						
							TriggerServerEvent('esx_gym:checkChip')
							ESX.ShowNotification("Preparando el ejercicio...")
							Citizen.Wait(1000)					
						
							if membership == true then	
								cancelar = true
								local playerPed = GetPlayerPed(-1)
								local number = tonumber(string.format("%." .. 2 .. "f", math.random(1,5)/math.random(1,10)))
								TaskStartScenarioInPlace(playerPed, "world_human_yoga", 0, true)
								Citizen.Wait(30000)
								ClearPedTasksImmediately(playerPed)
								ESX.ShowNotification("Necesitas descansar 60 segundos antes de hacer otro ejercicio.")
								cancelar = false
								exports["adictos-skills"]:UpdateSkill("Fuerza", number)
								ESX.ShowNotification("Has aumentado un " ..number.."% tu fuerza")
								training = true
								
								Citizen.Wait(1000)
								descanso()
							elseif membership == false then
								ESX.ShowNotification("Necesitas ser miembro del gym para hacer ejercicio")
							end
						elseif training == true then
							ESX.ShowNotification("Necesitas descansar...")
						end
					end			
				end
			end
        end
		if letSleep then
			Citizen.Wait(1000)
		end
		Citizen.Wait(1)
    end
end)

Citizen.CreateThread(function()
    while true do
        local letSleep = true
        for k in pairs(situps) do

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, situps[k].x, situps[k].y, situps[k].z)
			if dist < 15 then
			letSleep = false
			DrawMarker(21, situps[k].x, situps[k].y, situps[k].z, 0, 0, 0, 0, 0, 0, 0.301, 0.301, 0.3001, 0, 255, 50, 200, 0, 0, 0, 0)
            if dist <= 0.5 then
				hintToDisplay('Pulsa ~INPUT_CONTEXT~ para hacer abdominales')
				
				if IsControlJustPressed(0, Keys['E']) then
					if training == false then
						TriggerServerEvent('esx_gym:checkChip')
						ESX.ShowNotification("Preparando el ejercicio...")
						Citizen.Wait(1000)					
					
						if membership == true then	
							cancelar = true
							local playerPed = GetPlayerPed(-1)
							local number = tonumber(string.format("%." .. 2 .. "f", math.random(1,5)/math.random(1,10)))
							TaskStartScenarioInPlace(playerPed, "world_human_sit_ups", 0, true)
							Citizen.Wait(30000)
							cancelar = false
							ClearPedTasksImmediately(playerPed)
							ESX.ShowNotification("Necesitas descansar 60 segundos antes de hacer otro ejercicio.")
						
							exports["adictos-skills"]:UpdateSkill("Fuerza", number)
							ESX.ShowNotification("Has aumentado un " ..number.."% tu fuerza")
							
							training = true
							descanso()
						elseif membership == false then
							ESX.ShowNotification("Necesitas ser miembro del gym para hacer ejercicio")
						end
					elseif training == true then
						ESX.ShowNotification("Necesitas descansar...")
						
						end
					end			
				end
			end
        end
		if letSleep then
			Citizen.Wait(1000)
		end
		Citizen.Wait(1)
    end
end)

function descanso()
	Citizen.Wait(60000)
	training = false
	ESX.ShowNotification("Ya puedes hacer otro ejercicio")
end

function OpenGymMenu()
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'gym_menu',
        {
            title    = 'Gym',
            elements = {
				{label = 'Tienda', value = 'shop'},
				{label = 'Horario', value = 'hours'},
            }
        },
        function(data, menu)
            if data.current.value == 'shop' then
				OpenGymShopMenu()
            elseif data.current.value == 'hours' then
				ESX.UI.Menu.CloseAll()
				
				ESX.ShowNotification("Estamos abiertos 24 horas/ dia. Bienvenido!")
            end
        end,
        function(data, menu)
            menu.close()
        end
    )
end

function OpenGymShopMenu()
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'gym_shop_menu',
        {
            title    = 'Tienda del GYM',
            elements = {
				{label = 'Batido Proteinas ($40)', value = 'protein_shake'},
				{label = 'Agua($20)', value = 'water'},
				{label = 'Barrita Energetica ($40)', value = 'sportlunch'},
				{label = 'Bebida Deportiva ($40)', value = 'powerade'},
            }
        },
        function(data, menu)
            if data.current.value == 'protein_shake' then
				TriggerServerEvent('esx_gym:buyProteinshake')
            elseif data.current.value == 'water' then
				TriggerServerEvent('esx_gym:buyWater')
            elseif data.current.value == 'sportlunch' then
				TriggerServerEvent('esx_gym:buySportlunch')
            elseif data.current.value == 'powerade' then
				TriggerServerEvent('esx_gym:buyPowerade')
            end
        end,
        function(data, menu)
            menu.close()
        end
    )
end




Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if cancelar then
			DisableControlAction(0, 176, true) --enter
			DisableControlAction(0, 34, true) 
			DisableControlAction(0, 38, true) 
			DisableControlAction(0, 8, true) 
			DisableControlAction(0, 9, true) 
			DisableControlAction(0, 32, true) 
			DisableControlAction(0, 73, true) 
			DisableControlAction(0, 170, true) 
		else
			Citizen.Wait(500)
		end
	end
end)