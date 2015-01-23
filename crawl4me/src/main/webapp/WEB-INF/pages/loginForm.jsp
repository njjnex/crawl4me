<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<title>Вход</title>

<!-- Bootstrap-validator-->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/bootstrap/bootstrap-validator/css/bootstrapValidator.min.css" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/bootstrap/bootstrap-validator/js/bootstrapValidator.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/bootstrap/bootstrap-validator/js/language/ru_RU.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/validationUser.js"
	type="text/javascript"></script>
<!-- End bootstrap-validator -->
<link href="${pageContext.request.contextPath}/resources/css/login.css"
	rel="stylesheet">
<script
	src="${pageContext.request.contextPath}/resources/js/validationSignIn.js"></script>

<body>
<div class="error"><p class="text-center">${error}</p></div>
	<div class="container">
		<form class="form-signin" role="form" id="login" name="login-form"
			class="login-form" action="<c:url value='j_spring_security_check'/>"
			method="post">
			<h3 class="form-signin-heading">Вход для пользователей</h3>
			<div class="form-group">
				<label for="inputUsername" class="sr-only">Имя пользователя</label>
				<input name="j_username" id="j_username" type="text"
					id="inputUsername" class="form-control"
					placeholder="Имя пользователя" required autofocus>
			</div>
			<div class="form-group">
				<label for="inputPassword" class="sr-only">Пароль</label> <input
					name="j_password" id="j_password" type="password"
					id="inputPassword" class="form-control" placeholder="Пароль"
					required>
			</div>
			<div class="form-group">
				<button class="btn btn-lg btn-primary btn-block" type="submit">Войти</button>
			</div>
			<br>
			<h3 class="form-signin-heading">Новый пользователь?</h3>
			<button class="btn btn-lg btn-info btn-block"
				onclick="window.location.href='${pageContext.request.contextPath}/newUser.html'">Регистрация</button>
		</form>
	</div>

</body>
