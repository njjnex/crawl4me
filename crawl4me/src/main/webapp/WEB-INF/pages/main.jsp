<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/jquery.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/json2.js"></script>
<!-- bootstrap -->
<link
	href="${pageContext.request.contextPath}/resources/bootstrap/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="${pageContext.request.contextPath}/resources/bootstrap/bootstrap/js/bootstrap.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/bootstrap/bootstrap/js/bootstrap-collapse.js"></script>
<!-- end bootstrap -->

<title>Insert title here</title>

<script
	src="${pageContext.request.contextPath}/resources/js/sockjs-0.3.4.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/stomp.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/stompConnection.js"></script>

</head>
<script type="text/javascript">
	function generateId() {
		var text = "";
		var possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

		for (var i = 0; i < 5; i++)
			text += possible
					.charAt(Math.floor(Math.random() * possible.length));

		return text;
	}

	function saveTemplate() {
		$.ajax({
			type : "post",
			url : "/saveState/" + generateId(),
			cache : false,
			contentType : "application/json",
			data : JSON.stringify(createRequestMap()),
			success : function(data) {
				scanTemplate(data)
			},
			error : function() {
				alert('Error while request..');
			}
		});
	}
	function postMessage() {
		$.ajax({
			type : "post",
			url : "/postMessage",
			cache : false,
			contentType : "application/json",
			data : JSON.stringify(document.getElementById("userComment").value),
			success : function(data) {
				console.log(data);
				if(data != null)createPost(data);
				
			},
			error : function() {
				alert('Error while rosting message');
			}
		});
	}
	function createPost(data){
		var well = document.getElementById("well");
        var messageBoard = document.getElementById("messageBoard");
		messageBoard.innerHTML = null;
		 for (var i=0;i<data.length;i++) {
	                
	        var author = data[i].author;
            var date = data[i].date;
            var text = data[i].text;

			
            
            var messagePost = document.createElement("ul");
            messagePost.setAttribute("class","list-unstyled ui-sortable");
            messagePost.setAttribute("id","messagePost");
               

            var authorElement = document.createElement("strong");
            authorElement.setAttribute("class", "list-unstyled ui-sortable");
            authorElement.innerHTML = author;
            messagePost.appendChild(authorElement);

            var dateElement = document.createElement("small");
            dateElement.setAttribute("class", "pull-right text-muted");
            dateElement.innerHTML = date;
            messagePost.appendChild(dateElement);

            var textElement = document.createElement("li");
            textElement.setAttribute("class", "ui-state-default");
            textElement.innerHTML = text;
            messagePost.appendChild(textElement);
            
            messageBoard.appendChild(messagePost);

         <%--   <ul data-brackets-id="12674" class="list-unstyled ui-sortable"
				id="messagePost">

				<strong class="pull-left primary-font" id="messageAuthor">${message.author}</strong>
				<small class="pull-right text-muted"> </span>${message.date}
				</small>
				</br>
				<li class="ui-state-default" id="messageText">${message.text}</li>
				</br>

			</ul>
		</c:forEach> --%>
            
		 }
		 well.appendChild(messageBoard);
   }
	

	
	function scanTemplate(data) {
		var divTemplate = document.getElementById("saveTemplate");
		var button = document.getElementById("saveTemplateButton");
		button.setAttribute("class", "btn btn-success disabled");
		button.innerHTML = "Link to your scan:";

		var input = document.createElement("input");
		input.setAttribute("class", "form-control");
		divTemplate.appendChild(input);
		input.setAttribute("value", "http://crawl4me.net/" + data);
	}
	
</script>

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/template/css/normal.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/template/css/style.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/template/css/animation.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/webfont/1.4.7/webfont.js"></script>
<script>
	if (/mobile/i.test(navigator.userAgent))
		document.documentElement.className += ' w-mobile';
</script>
<link rel="shortcut icon" type="image/x-icon" href="favicon.ico">
<!--[if lt IE 9]><script src="https://cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7/html5shiv.min.js"></script><![endif]-->
</head>
<body>
	<%@ page
		import="org.springframework.security.core.context.SecurityContextHolder"%>
	<%
		String aUser = SecurityContextHolder.getContext()
				.getAuthentication().getName();
	%>
	<c:set var="activeUser" value="<%=aUser%>" scope="session" />

	<div class="fix-header" id="home">
		<div class="w-container">
			<div class="w-nav" data-collapse="medium" data-animation="default"
				data-duration="400"></div>
		</div>
	</div>
	<div class="fixed-header">
		<div class="w-container container">
			<div class="w-row">

				<!--///////////////////////////////////////////////////////
       // Logo section 
       //////////////////////////////////////////////////////////-->


				<div class="w-col w-col-3 logo">
					<a href="${pageContext.request.contextPath}/#"><img class="logo"
						src="${pageContext.request.contextPath}/resources/template/images/logo.png"
						alt="Elegance"></a>
				</div>

				<!--///////////////////////////////////////////////////////
       // End Logo section 
       //////////////////////////////////////////////////////////-->

				<div class="w-col w-col-9">

					<!--///////////////////////////////////////////////////////
       // Menu section 
       //////////////////////////////////////////////////////////-->


					<div class="w-nav navbar" data-collapse="medium"
						data-animation="default" data-duration="400" data-contain="1">
						<div class="w-container nav">
							<nav class="w-nav-menu nav-menu" role="navigation"> <a
								class="w-nav-link menu-li" href="#home">Home</a> <a
								class="w-nav-link menu-li" href="#result">Crawler Result</a> <a
								class="w-nav-link menu-li" href="#questions">How To |
								Questions</a> <sec:authorize access="authenticated"
								var="authenticated" /> <c:choose>
								<c:when test="${!authenticated}">
									<a class="w-nav-link menu-li" href="#logIn"
										onclick="$('#login').modal('show')">Log in</a>

								</c:when>
								<c:otherwise>
									<a class="w-nav-link menu-li"
										href="${pageContext.request.contextPath}/logout.html">Log
										out - ${activeUser}</a>

								</c:otherwise>
							</c:choose> </nav>
							<div class="w-nav-button">
								<div class="w-icon-nav-menu"></div>
							</div>
						</div>
					</div>


					<!--///////////////////////////////////////////////////////
       // End Menu section 
       //////////////////////////////////////////////////////////-->


				</div>
			</div>
		</div>
	</div>

	<!--///////////////////////////////////////////////////////
       //  Scanner section 
       //////////////////////////////////////////////////////////-->

	<div class="crawler">
		<div class="sp-slideshow">
		<c:if test="${resultString ne null}">
								<div class="alert alert-info alert-dismissible fade in" role="alert">
      <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      <h4>${resultString}</h4>
      
     
    </div>
  
							</c:if>
			<h2 class="scan-heading">Free online data crawler.</h2>
			<div class="container-fluid">
				<section class="container">
				<div class="container-page">
					<div name="scan-form">
						<div class="col-md-6">
							<div class="form-group col-lg-12">
								<label>URL to scan</label> <input type="url" name="url" id="url"
									class="form-control" value="${template.url}">
							</div>

							<div class="form-group col-lg-12">
								<label>Regex</label> <input type="text" name="regex" id="regex"
									class="form-control" value="${template.regex}">
							</div>
							<%
								int i = 0;
							%>
							<c:forEach var="domRule" items="${template.domRules}">
								<%
									i++;
										request.setAttribute("i", i);
								%>
								<div class="col-sm-6">
									<label>Parameter ${i}:</label> <input type="text"
										name="domRuleName${i}" id="domRuleName${i}"
										class="form-control" value="${domRule.key}">
								</div>
								<div class="col-sm-6">
									<label>Looking beetween specific tag:</label> <input
										type="text" name="domRuleValue${i}" id="domRuleValue${i}"
										class="form-control" value="${domRule.value}">
								</div>

							</c:forEach>


							<div class="input-group" id="saveTemplate">

								<sec:authorize var="loggedIn" access="isAuthenticated()" />
								<c:choose>
									<c:when test="${loggedIn}">
										<span class="input-group-btn">
											<button class="btn btn-default" id="saveTemplateButton"
												onclick="saveTemplate();" value="Add scan">Save
												settings</button>
										</span>
									</c:when>
									<c:otherwise>
										<p>
											<a href="${pageContext.request.contextPath}/login">Please
												log in</a> if you want to save and share this settings.
										</p>
										<div class="col-sm-6">
											<span class="input-group-btn">
												<button class="btn btn-default disabled"
													id="saveTemplateButton" onclick="saveTemplate();"
													value="Add scan">Save settings</button>
											</span>
										</div>
									</c:otherwise>
								</c:choose>

							</div>

						</div>

						<div class="col-md-6" id="scanStarter">
					
							
							<br>
							<p>Enter valid http adress from where scrapping will start.
								After scanning this page all links to other pages that matches
								URL Regex rule will be extracted and scanned.</p>
							<br>
							<p>
								This regex rule shous scrapper from which pages data should be
								extracted. To specify this rule you can use special symbols.
								Look for examples in <a href="#howTo">How To.</a><br> <br>
							</p>
							<p>For Name you can choose any name. It will describe the
								value what you are looking in the page.</p>
							div class="price"> or &lt;p id="itemName">. See <a href="#howTo">How
								To</a> for examples.
							</p>


							<!-- Alert block -->

							<div class="alert alert-warning alert-dismissible fade in"
								role="alert" id="legalAlert">

								<h4>Legal issues.</h4>
								<p>Web scraping may be against the terms of use of some
									websites.</p>
								<p>It really depends on a number of factors. These days, the
									legality of scraping is something that’s in flux – and you’ll
									certainly want to consult with a licensed attorney about your
									specific situation and your country law.</p>
								<p>
									<button type="button" class="btn btn-danger"
										data-dismiss="alert" aria-label="Close" onclick="connect();">I
										got it. Let's start!</button>

								</p>
							</div>
						</div>
						<!-- End Alert -->

					</div>
				</div>
			</div>
			</section>
		</div>
	</div>
	</div>

	<!--///////////////////////////////////////////////////////
       // End scanner section 
       //////////////////////////////////////////////////////////-->



	<!--///////////////////////////////////////////////////////
       // Result section 
       //////////////////////////////////////////////////////////-->


	<div class="result-parlex" id="result">
		<div class="w-container">
			<div class="wrap">
				<div class="about">
					<h1 class="about-heading">Result</h1>
					<div class="about-text">Here you will find your crawling
						result.</div>
					<div class="sepreater"></div>

					<div class="col-md-7">
						<div class="panel panel-success" id="tablePanel">
							<div class="panel-heading">Result table</div>
							<div class="panel-body" id="resultTableDiv"></div>
						</div>
					</div>

					<div class="col-md-5">
						<div class="panel panel-success" id="console">
							<div class="panel-heading">Console output</div>
							<div class="panel-body" id="consoleBody">
								<p>Scanning output console...</p>
							</div>
						</div>
					</div>
				</div>


				<img class="about-img"
					src="${pageContext.request.contextPath}/resources/template/images/about.png"
					alt="52de15aa5d3566c14300015e_about.png">
			</div>
		</div>
	</div>
	<!--///////////////////////////////////////////////////////
       // End result section 
       //////////////////////////////////////////////////////////-->


	<!--///////////////////////////////////////////////////////
       // How to section 
       //////////////////////////////////////////////////////////-->

	<div class="questions-parlex" id="questions">

		<div class="parlex2-back">
			<div class="w-container">
				<div class="wrap">
					<div class="process">
						<h1 class="our-process-heading">Questions / How TO</h1>
						<div class="sepreater"></div>


						<div class="container">
							<div class="col-lg-4 col-sm-6 text-center">
								<div class="well" id="well">
									<h5>Need help or have questions? We will answer as soon as
										possible.</h5>
									<div class="input-group">


										<c:choose>
											<c:when test="${!authenticated}">
												<input type="text" id="userComment"
													class="form-control input-sm chat-input"
													placeholder="Please log in to live  messages" />
												<span class="input-group-btn" onclick=""> <a
													class="btn btn-primary btn-sm disabled"><span
														class="glyphicon glyphicon-comment"></span> Post message</a></span>

											</c:when>
											<c:otherwise>
												<input type="text" id="userComment"
													class="form-control input-sm chat-input"
													placeholder="Your messase text here." />
												<span class="input-group-btn" onclick="postMessage();">
													<a class="btn btn-primary btn-sm"><span
														class="glyphicon glyphicon-comment"></span> Post message</a>
												</span>

											</c:otherwise>
										</c:choose>


									</div>
									<hr id="messageBoard">
									<%-- <c:forEach var="message" items="${messages}">
										<ul data-brackets-id="12674" class="list-unstyled ui-sortable"
											id="messagePost">

											<strong class="pull-left primary-font" id="messageAuthor">${message.author}</strong>
											<small class="pull-right text-muted"> </span>${message.date}
											</small>
											</br>
											<li class="ui-state-default" id="messageText">${message.text}</li>
											</br>

										</ul>
									</c:forEach> --%>
								</div>
							</div>


							<div class="process-text">
								<div class="process-text">Our process is straight forward,
									simple, &amp; successful.</div>
								<div class="w-row">
									<div class="w-col w-col-3">
										<!-- 								<div class="hi-icon-wrap hi-icon-effect-5 hi-icon-effect-5a"> -->
										<!-- 									<a href="#set-1" class="hi-icon hi-icon-locked">Security</a> -->
										<!-- 								</div> -->
										<h4 class="our-process-sys">BRAINSTORM</h4>
										<p class="process-paragraph">Lorem ipsum dolor sit amet,
											consectetur adipiscing elit. Suspendisse varius enim in eros
											elementum tristique. Duis cursus, mi quis viverra ornare,
											eros dolor interdum nulla, ut commodo diam libero vitae erat.
											Aenean faucibus nibh et justo cursus id rutrum lorem
											imperdiet. Nunc ut sem vitae risus tristique posuere.</p>
									</div>
									<div class="w-col w-col-3">
										<!-- 								<div class="hi-icon-wrap hi-icon-effect-5 hi-icon-effect-5a"> -->
										<!-- 									<a href="#set-1" class="hi-icon hi-icon-mobile">Mobile</a> -->
										<!-- 								</div> -->
										<h4 class="our-process-sys">PLAN</h4>
										<p class="process-paragraph">Lorem ipsum dolor sit amet,
											consectetur adipiscing elit. Suspendisse varius enim in eros
											elementum tristique. Duis cursus, mi quis viverra ornare,
											eros dolor interdum nulla, ut commodo diam libero vitae erat.
											Aenean faucibus nibh et justo cursus id rutrum lorem
											imperdiet. Nunc ut sem vitae risus tristique posuere.</p>
									</div>
									<div class="w-col w-col-3">
										<!-- 								<div class="hi-icon-wrap hi-icon-effect-5 hi-icon-effect-5a"> -->
										<!-- 									<a href="#set-1" class="hi-icon hi-icon-screen">Desktop</a> -->
										<!-- 								</div> -->
										<h4 class="our-process-sys">DESIGN</h4>
										<p class="process-paragraph">Lorem ipsum dolor sit amet,
											consectetur adipiscing elit. Suspendisse varius enim in eros
											elementum tristique. Duis cursus, mi quis viverra ornare,
											eros dolor interdum nulla, ut commodo diam libero vitae erat.
											Aenean faucibus nibh et justo cursus id rutrum lorem
											imperdiet. Nunc ut sem vitae risus tristique posuere.</p>
									</div>
									<div class="w-col w-col-3">
										<!-- 								<div class="hi-icon-wrap hi-icon-effect-5 hi-icon-effect-5a"> -->
										<!-- 									<a href="#set-1" class="hi-icon hi-icon-earth">Partners</a> -->
										<!-- 								</div> -->
										<h4 class="our-process-sys">DEVELOP</h4>
										<p class="process-paragraph">Lorem ipsum dolor sit amet,
											consectetur adipiscing elit. Suspendisse varius enim in eros
											elementum tristique. Duis cursus, mi quis viverra ornare,
											eros dolor interdum nulla, ut commodo diam libero vitae erat.
											Aenean faucibus nibh et justo cursus id rutrum lorem
											imperdiet. Nunc ut sem vitae risus tristique posuere.</p>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--///////////////////////////////////////////////////////
       // End How to section 
       //////////////////////////////////////////////////////////-->

	<!-- Modal Login-->
	<div class="modal fade" id="login" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-sm">
			<div class="modal-content">
				<div class="modal-header" id="loginHeader">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span><span class="sr-only">Close</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">Login</h4>
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="col-md-12">

							<form id="loginForm"
								action="${pageContext.request.contextPath}/<c:url value='j_spring_security_check'/>"
								method="post" novalidate="novalidate">
								<div class="form-group">
									<label for="username" class="control-label">Username</label> <input
										type="text" class="form-control" name="j_username"
										id="j_username" value="" required=""
										title="Please enter you username" placeholder="Username">
									<span class="help-block"></span>
								</div>
								<div class="form-group">
									<label for="password" class="control-label">Password</label> <input
										type="password" class="form-control" name="j_password"
										id="j_password" value="" required=""
										title="Please enter your password" placeholder="password">
									<span class="help-block"></span>
								</div>
								<div id="loginErrorMsg" class="alert alert-error hide">Wrong
									username or password</div>
								<br>
								<button type="submit" class="btn btn-success btn-block">Login</button>
								<br> <a href="#" class="btn btn-info btn-block"
									onclick="register();">New user</a>
							</form>

						</div>

					</div>
				</div>
			</div>
		</div>

		<!-- Register form -->

		<div class="modal fade" id="register" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-sm">
				<div class="modal-content">
					<div class="modal-header" id="loginHeader">
						<button type="button" class="close" data-dismiss="modal">
							<span aria-hidden="true">×</span><span class="sr-only">Close</span>
						</button>
						<h4 class="modal-title" id="myModalLabel">New user</h4>
					</div>
					<div class="modal-body">
						<div class="row">
							<div class="col-md-12">

								<form id="loginForm"
									action="${pageContext.request.contextPath}/register"
									method="post" novalidate="novalidate">
									<div class="form-group">
										<label for="username" class="control-label">Username</label> <input
											type="text" class="form-control" name="username"
											id="username" value="" required=""
											title="Please enter you username" placeholder="Username">
										<span class="help-block"></span>
									</div>
									<div class="form-group">
										<label for="username" class="control-label">Email</label> <input
											type="text" class="form-control" name="email" id="email"
											value="" required="" title="Please enter you username"
											placeholder="Email"> <span class="help-block"></span>
									</div>
									<div class="form-group">
										<label for="password" class="control-label">Password</label> <input
											type="password" class="form-control" name="password"
											id="password" value="" required=""
											title="Please enter your password" placeholder="password">
										<span class="help-block"></span>
									</div>
									<div id="loginErrorMsg" class="alert alert-error hide">Wrong
										username or password</div>
									<br>
									<button type="submit" class="btn btn-success btn-block">Register</button>
									<br>
								</form>

							</div>

						</div>
					</div>
				</div>
			</div>
		</div>



		<script type="text/javascript"
			src="${pageContext.request.contextPath}/resources/template/js/jquery.js"></script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/resources/template/js/normal.js"></script>

		<script
			src="${pageContext.request.contextPath}/resources/bootstrap/bootstrap/js/alert.js"></script>
		<script
			src="${pageContext.request.contextPath}/resources/bootstrap/bootstrap/js/modal.js"></script>

		<script type="text/javascript">
			$('#legalAlert').on('closed.bs.alert', function() {
				createScanButton();
			})


			function register(){
				$('#register').modal('show')
			}

			postMessage();
			
		</script>
		
</body>

</html>
