$(document).ready(function() {
	$('.form').bootstrapValidator({
		// To use feedback icons, ensure that you use Bootstrap v3.1.0 or later
		/*feedbackIcons : {
			valid : 'glyphicon glyphicon-ok',
			invalid : 'glyphicon glyphicon-remove',
			validating : 'glyphicon glyphicon-refresh'
		},*/
		fields : {
			email : {
				validators : {
					notEmpty : {
						message : 'Введите email адрес'
					},
					emailAddress : {
						message : 'Введите корректный email адрес'
					}
				}
			},
			
			password : {
				validators : {
					notEmpty : {
						message : 'Введите пароль'
					},
					stringLength : {
						min : 4,
						message : 'Длинна пароля не мeнее четырех символов'
					}
				}
			}
		}
	});
});
