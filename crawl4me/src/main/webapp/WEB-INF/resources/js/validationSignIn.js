$(document).ready(function() {
	$('.form-signin').bootstrapValidator({
		// To use feedback icons, ensure that you use Bootstrap v3.1.0 or later
		feedbackIcons : {
			valid : 'glyphicon glyphicon-ok',
			invalid : 'glyphicon glyphicon-remove',
			validating : 'glyphicon glyphicon-refresh'
		},
		fields : {
			j_username : {
				validators : {
					notEmpty : {
						message : 'Введите логин'
					},
					stringLength : {
						min : 4,
						max : 12,
						message : 'Длинна логина не мeнее четырех символов'
					},
					regexp : {
						regexp : /^[a-zA-Z0-9-а-яА-Я]+$/,
						message : 'Логин дожен сожердать буквы или цифры'
					},
				}
			},

			j_password : {
				validators : {
					notEmpty : {
						message : 'Введите пароль'
					},
					stringLength : {
						min : 4,
						message : 'Длинна пароля не мeнее четырех символов'
					},
					regexp : {
						regexp : /^[a-zA-Z0-9-а-яА-Я]+$/,
						message : 'Недопустимые символы'
					}
				}
			}
		}
	});
});