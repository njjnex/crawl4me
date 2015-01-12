$(document).ready(function() {
	$('.form-horizontal').bootstrapValidator({
		// To use feedback icons, ensure that you use Bootstrap v3.1.0 or later
		feedbackIcons : {
			valid : 'glyphicon glyphicon-ok',
			invalid : 'glyphicon glyphicon-remove',
			validating : 'glyphicon glyphicon-refresh'
		},
		fields : {
			username : {
				message : 'The username is not valid',
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
					different : {
						field : 'password',
						message : 'Имя пользователя и пароль должны отличаться'
					}
				}
			},
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
					different : {
						field : 'username',
						message : 'Имя пользователя и пароль должны отличаться'
					},
					stringLength : {
						min : 4,
						message : 'Длинна пароля не мeнее четырех символов'
					},
				}
			},
			confirmPassword : {
				validators : {
					identical : {
						field : 'password',
						message : 'Пароли не совпадают'
					}
				}
			},
			age : {
				validators : {
					notEmpty : {
						message : 'Укажите возраст'
					},
				}
			},
			terms : {
				validators : {
					notEmpty : {
						message : 'Вы должны принять правила сервиса.'
					},
				}
			},
			gender : {
				validators : {
					notEmpty : {
						message : 'Укажите свой пол'
					}
				}
			}
		}
	});
});
