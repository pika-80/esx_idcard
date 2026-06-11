local function Notify(src, title, description, notifyType)
	TriggerClientEvent('ox_lib:notify', src, {
		title = title,
		description = description,
		type = notifyType or 'info',
		duration = 3000
	})
end

local function HasRequiredLicense(cardType, licenses)
	if cardType == nil then
		return true
	end

	local cfg = Config.CardTypes[cardType]
	if not cfg then
		return true
	end

	for i = 1, #licenses do
		for _, requiredType in ipairs(cfg.required) do
			if licenses[i].type == requiredType then
				return true
			end
		end
	end

	return false
end

RegisterServerEvent('jsfour-idcard:open')
AddEventHandler('jsfour-idcard:open', function(ID, targetID, cardType)
	local xPlayer = ESX.GetPlayerFromId(ID)
	local xTarget = ESX.GetPlayerFromId(targetID)

	if not xPlayer or not xTarget then return end

	local identifier = xPlayer.identifier
	local targetSource = xTarget.source

	MySQL.query(
		'SELECT firstname, lastname, dateofbirth, sex, height FROM users WHERE identifier = @identifier',
		{ ['@identifier'] = identifier },
		function(user)
			if not user or not user[1] then return end

			MySQL.query(
				'SELECT type FROM user_licenses WHERE owner = @identifier',
				{ ['@identifier'] = identifier },
				function(licenses)
					licenses = licenses or {}

					if not HasRequiredLicense(cardType, licenses) then
						Notify(
							targetSource,
							Config.Locale.noLicenseTitle,
							Config.Locale.noLicense,
							'error'
						)
						return
					end

					TriggerClientEvent('jsfour-idcard:open', targetSource, {
						user = user,
						licenses = licenses,
						labels = Config.LicenseLabels,
						locale = Config.Locale
					}, cardType)
				end
			)
		end
	)
end)
