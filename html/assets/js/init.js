$(document).ready(function() {
	function resetCard() {
		$('#id-card')
			.removeClass('card-driver card-weapon card-hunt card-boat card-police card-aviation');

		$('#name').text('');
		$('#dob').text('');
		$('#height').text('');
		$('#signature').text('');
		$('#sex').text('');
		$('#licenses').html('');
		$('#profile').show();
	}

	function getSexLabel(sex, locale) {
		sex = (sex || '').toLowerCase();

		if (locale && locale.sex && locale.sex[sex]) {
			return locale.sex[sex];
		}

		return sex === 'm' ? 'Masculino' : 'Feminino';
	}

	function setCardType(type) {
		switch(type) {
			case 'driver':
				$('#id-card').addClass('card-driver');
				break;

			case 'weapon':
				$('#id-card').addClass('card-weapon');
				break;

			case 'hunt':
				$('#id-card').addClass('card-hunt');
				break;

			case 'boat':
				$('#id-card').addClass('card-boat');
				break;

			case 'police':
				$('#id-card').addClass('card-police');
				break;

			case 'aviation':
				$('#id-card').addClass('card-aviation');
				break;
		}
	}

	function addLicenses(type, licenseData, labels) {
		$('#licenses').html('');

		if (!licenseData) return;

		Object.keys(licenseData).forEach(function(key) {
			var lic = licenseData[key].type;
			var label = '';

			if (type === 'driver') {
				if (lic === 'drive_bike') label = labels.drive_bike || 'Mota';
				else if (lic === 'drive') label = labels.drive || 'Ligeiros';
				else if (lic === 'drive_truck') label = labels.drive_truck || 'Pesados';
			}

			if (type === 'aviation') {
				if (lic === 'plane') label = labels.plane || 'Avião';
				else if (lic === 'helicopter') label = labels.helicopter || 'Helicóptero';
				else if (lic === 'aviation_theory') label = labels.aviation_theory || 'Teórico Aviação';
			}

			if (type === 'weapon' && lic === 'weapon') label = labels.weapon || 'Porte de Arma';
			if (type === 'hunt' && lic === 'hunt') label = labels.hunt || 'Caça';
			if (type === 'boat' && lic === 'boat') label = labels.boat || 'Barco';
			if (type === 'police' && lic === 'police') label = labels.police || 'Polícia';

			if (label !== '') {
				$('#licenses').append('<p>' + label + '</p>');
			}
		});
	}

	window.addEventListener('message', function(event) {
		var data = event.data;

		if (data.action === 'open') {
			var type = data.type;
			var payload = data.array;
			var userData = payload['user'][0];
			var licenseData = payload['licenses'];
			var labels = payload['labels'] || {};
			var locale = payload['locale'] || {};
			var sex = (userData.sex || '').toLowerCase();

			resetCard();

			$('#name').text(userData.firstname + ' ' + userData.lastname);
			$('#dob').text(userData.dateofbirth || '');
			$('#height').text(userData.height ? userData.height + ' cm' : '');
			$('#signature').text(userData.firstname + ' ' + userData.lastname);
			$('#sex').text(getSexLabel(sex, locale));

			if (sex === 'm') {
				$('#profile').attr('src', 'assets/images/male.png');
			} else {
				$('#profile').attr('src', 'assets/images/female.png');
			}

			setCardType(type);
			addLicenses(type, licenseData, labels);

			$('#id-card').show();
		}

		if (data.action === 'close') {
			resetCard();
			$('#id-card').hide();
		}
	});
});
