local open = false

RegisterNetEvent('jsfour-idcard:open')
AddEventHandler('jsfour-idcard:open', function(data, type)
	open = true

	SendNUIMessage({
		action = 'open',
		array = data,
		type = type
	})
end)

CreateThread(function()
	while true do
		local sleep = 500

		if open then
			sleep = 0

			if IsControlJustReleased(0, 322) or IsControlJustReleased(0, 177) then
				SendNUIMessage({
					action = 'close'
				})

				open = false
			end
		end

		Wait(sleep)
	end
end)
