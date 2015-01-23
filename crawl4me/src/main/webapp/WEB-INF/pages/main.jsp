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
					<a href="#"><img class="logo"
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
								class="w-nav-link menu-li" href="#questions">Need help?</a> <a
								class="w-nav-link menu-li" href="#portfolio">How To</a> <a
								class="w-nav-link menu-li" href="#contact">Log in</a> </nav>
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
									<label>Name${i}</label> <input type="text"
										name="domRuleName${i}" id="domRuleName${i}"
										class="form-control" value="${domRule.key}">
								</div>
								<div class="col-sm-6">
									<label>Value${i}</label> <input type="text"
										name="domRuleValue${i}" id="domRuleValue${i}"
										class="form-control" value="${domRule.value}">
								</div>

							</c:forEach>


							<div class="input-group" id="saveTemplate">

								<sec:authorize var="loggedIn" access="isAuthenticated()" />
								<c:choose>
									<c:when test="${loggedIn}">
										<span class="input-group-btn">
											<button class="btn btn-info" id="saveTemplateButton"
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
												<button class="btn btn-info disabled"
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
							div class="price"> or &lt;p id="itemName">. See <a href="#howTo">How To</a>
								for examples.</p>
							

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
				<h1 class="about-heading">
					Result
				</h1>
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
    <div class="well">
        <h4>Need help or have questions? We will answer as soon as possible.</h4>
    <div class="input-group">
        <input type="text" id="userComment"
											class="form-control input-sm chat-input"
											placeholder="Write your message here..." />
	    <span class="input-group-btn" onclick="addComment()">     
            <a href="${pageContext.request.contextPath}/postMessage"
											class="btn btn-primary btn-sm"><span
												class="glyphicon glyphicon-comment"></span> Live message</a>
        </span>
    </div>
    <hr data-brackets-id="12673">
    <ul data-brackets-id="12674" id="sortable"
										class="list-unstyled ui-sortable">
        <strong class="pull-left primary-font">James</strong>
        <small class="pull-right text-muted">
           <span class="glyphicon glyphicon-time"></span>7 mins ago</small>
        </br>
        <li class="ui-state-default">Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. </li>
        </br>
         <strong class="pull-left primary-font">Taylor</strong>
        <small class="pull-right text-muted">
           <span class="glyphicon glyphicon-time"></span>14 mins ago</small>
        </br>
        <li class="ui-state-default">Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</li>
        
    </ul>
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
									elementum tristique. Duis cursus, mi quis viverra ornare, eros
									dolor interdum nulla, ut commodo diam libero vitae erat. Aenean
									faucibus nibh et justo cursus id rutrum lorem imperdiet. Nunc
									ut sem vitae risus tristique posuere.</p>
							</div>
							<div class="w-col w-col-3">
<!-- 								<div class="hi-icon-wrap hi-icon-effect-5 hi-icon-effect-5a"> -->
<!-- 									<a href="#set-1" class="hi-icon hi-icon-mobile">Mobile</a> -->
<!-- 								</div> -->
								<h4 class="our-process-sys">PLAN</h4>
								<p class="process-paragraph">Lorem ipsum dolor sit amet,
									consectetur adipiscing elit. Suspendisse varius enim in eros
									elementum tristique. Duis cursus, mi quis viverra ornare, eros
									dolor interdum nulla, ut commodo diam libero vitae erat. Aenean
									faucibus nibh et justo cursus id rutrum lorem imperdiet. Nunc
									ut sem vitae risus tristique posuere.</p>
							</div>
							<div class="w-col w-col-3">
<!-- 								<div class="hi-icon-wrap hi-icon-effect-5 hi-icon-effect-5a"> -->
<!-- 									<a href="#set-1" class="hi-icon hi-icon-screen">Desktop</a> -->
<!-- 								</div> -->
								<h4 class="our-process-sys">DESIGN</h4>
								<p class="process-paragraph">Lorem ipsum dolor sit amet,
									consectetur adipiscing elit. Suspendisse varius enim in eros
									elementum tristique. Duis cursus, mi quis viverra ornare, eros
									dolor interdum nulla, ut commodo diam libero vitae erat. Aenean
									faucibus nibh et justo cursus id rutrum lorem imperdiet. Nunc
									ut sem vitae risus tristique posuere.</p>
							</div>
							<div class="w-col w-col-3">
<!-- 								<div class="hi-icon-wrap hi-icon-effect-5 hi-icon-effect-5a"> -->
<!-- 									<a href="#set-1" class="hi-icon hi-icon-earth">Partners</a> -->
<!-- 								</div> -->
								<h4 class="our-process-sys">DEVELOP</h4>
								<p class="process-paragraph">Lorem ipsum dolor sit amet,
									consectetur adipiscing elit. Suspendisse varius enim in eros
									elementum tristique. Duis cursus, mi quis viverra ornare, eros
									dolor interdum nulla, ut commodo diam libero vitae erat. Aenean
									faucibus nibh et justo cursus id rutrum lorem imperdiet. Nunc
									ut sem vitae risus tristique posuere.</p>
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
	<!--///////////////////////////////////////////////////////
       // Footer section 
       //////////////////////////////////////////////////////////-->

	<div class="footer-parlex">
		<div class="parlex9-back">
			<div class="w-container">
				<div class="wrap">
					<img class="footer-logo" src="images/footer-logo.png"
						alt="Elegance">
					<div class="footer-social">
						<div class="fotter-social-wrap">
							<a href="https://www.facebook.com/"><img
								class="fotter-social"
								src="${pageContext.request.contextPath}/resources/template/images/social/Facebook.png"
								alt="52dd249c929b601f5400054c_Facebook.png"></a> <a
								href="https://www.twitter.com/"><img class="fotter-social"
								src="${pageContext.request.contextPath}/resources/template/images/social/Twitter.png"
								alt="52dd24f2929b601f54000551_Twitter.png"></a> <a
								href="https://plus.google.com/"><img class="fotter-social"
								src="${pageContext.request.contextPath}/resources/template/images/social/Google-plus.png"
								alt="52dd26a55b54031d540005af_Google-plus.png"></a> <a
								href="https://www.blogger.com/"><img class="fotter-social"
								src="${pageContext.request.contextPath}/resources/template/images/social/Blogger.png"
								alt="52de52e7b6d2171f78000414_Blogger.png"></a> <a
								href="https://www.digg.com/"><img class="fotter-social"
								src="${pageContext.request.contextPath}/resources/template/images/social/Digg.png"
								alt="52de53174702a71e780003c3_Digg.png"></a> <a
								href="https://www.pinterest.com/"><img class="fotter-social"
								src="${pageContext.request.contextPath}/resources/template/images/social/Pinterest.png"
								alt="52de533c5d3566c1430003e9_Pinterest.png"></a> <a
								href="https://www.flicker.com/"><img class="fotter-social"
								src="${pageContext.request.contextPath}/resources/template/images/social/Flickr.png"
								alt="52de535f1b42bfc24300049e_Flickr.png"></a> <a
								href="https://www.vimeo.com/"><img class="fotter-social"
								src="${pageContext.request.contextPath}/resources/template/images/social/Vimeo.png"
								alt="52de537cb6d2171f7800041c_Vimeo.png"></a> <a
								href="https://www.myspace.com/"><img class="fotter-social"
								src="${pageContext.request.contextPath}/resources/template/images/social/Myspace.png"
								alt="52de53954702a71e780003c5_Myspace.png"></a> <a
								href="https://www.stumbleupon.com/"><img
								class="fotter-social"
								src="${pageContext.request.contextPath}/resources/template/images/social/Stumbleupn.png"
								alt="52de53c0b6d2171f7800041e_Stumbleupn.png"></a> <a
								href="https://www.tumblr.com/"><img class="fotter-social"
								src="${pageContext.request.contextPath}/resources/template/images/social/Tumblr.png"
								alt="52de54021b42bfc2430004a3_Tumblr.png"></a> <a
								href="https://www.youtube.com/"><img class="fotter-social"
								src="${pageContext.request.contextPath}/resources/template/images/social/Youtube.png"
								alt="52de54495d3566c14300040a_Youtube.png"></a>
						</div>
					</div>
					<div>
						<div class="fotter-text">
							<p class="fotter-quote">“ THE LIGHT WITHIN US BOWS TO THE
								LIGHT WITHIN YOU. ”</p>
							<p class="copyright-area">
								©2014 ELEGANCE. ALL RIGHTS RESERVED,TEMPLATE BY&nbsp;<a
									href="https://carinotech.com" title="Carino Technologies"
									target="_blank">CARINO TECHNOLOGIES</a>
							</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!--///////////////////////////////////////////////////////
       // End Footer section 
       //////////////////////////////////////////////////////////-->

	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/template/js/jquery.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/template/js/normal.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/template/js/jquery-1.10.2.min.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/template/js/carousels.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/template/js/slider-modernizr.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/template/js/classie.js"></script>

	<script
		src="${pageContext.request.contextPath}/resources/template/js/toucheffects.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/template/js/modernizr.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/template/js/animation.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/bootstrap/bootstrap/js/alert.js"></script>

	<script type="text/javascript">
		$('#legalAlert').on('closed.bs.alert', function() {
			createScanButton();
		})
	</script>
</body>

</html>
