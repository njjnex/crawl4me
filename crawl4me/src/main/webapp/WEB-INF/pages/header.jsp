  <%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
	
	
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Scrap data online in one click. HTML page crawler provides standart and advanced settings depends on your needs." />
	<meta name="keywords" content="web crawler, web crawlers, java web crawler, free web crawler, online web crawler, amazon crawler, ebay crawler, web scraping, scrap a website, scraping website, internet spider, crawl website" />
	<meta name="robots" content="index, follow">
	<meta name="revisit-after" content="3 month">
	    
    <title>ScrapingOn free online data scraping.</title>
    
    <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/web/favicon.ico" />
    
    <!-- Stylesheets -->
    <link type="text/css" href="${pageContext.request.contextPath}/resources/web/css/bootstrap.min.css" rel="stylesheet">
    <link href='http://fonts.googleapis.com/css?family=Roboto:400,400italic,700,700italic,500italic,500,300italic,300'
        rel='stylesheet' type='text/css'>
    <link type="text/css" href="${pageContext.request.contextPath}/resources/web/icons/font-awesome/css/font-awesome.css" rel="stylesheet">
    <link type="text/css" href="${pageContext.request.contextPath}/resources/web/icons/rondo/style.css" rel="stylesheet">
    <link type="text/css" href="${pageContext.request.contextPath}/resources/web/css/style.css" rel="stylesheet">
   	
   	<!-- JS import -->
   	<!-- Verify.js (with Notify.js included) -->
	<script src="${pageContext.request.contextPath}/resources/js/jquery-2.1.3.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/web/js/bootstrap.min.js"></script>
        
    <script src="${pageContext.request.contextPath}/resources/web/angular/lib/angular.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/ui-bootstrap-tpls-0.12.0.min.js"></script>
	
	<script	src="${pageContext.request.contextPath}/resources/js/switcher.js"></script>
      		
	<script	src="${pageContext.request.contextPath}/resources/js/sockjs-0.3.4.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/stomp.js"></script>
		<script src="${pageContext.request.contextPath}/resources/bootstrap/bootstrap/js/popover.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/templateSaver.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/stompConnection.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/bPopup.js"></script>
	
	<script type="text/javascript"> var disqus_identifier = 'scrapingon'; </script>
	
	
	<!-- DataTables -->
<script type="text/javascript" charset="utf8" src="${pageContext.request.contextPath}/resources/web/js/simple-grid.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/web/css/simple-grid.css">
<script type="text/ng-template" id="simple-grid.html" src="${pageContext.request.contextPath}/resources/web/angular/lib/simple-grid.html"></script>
	
	<!-- Google Analytics -->
	<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-59209796-1', 'auto');
  ga('send', 'pageview');

</script>

<!-- Yandex.Metrika counter -->
<script type="text/javascript">
(function (d, w, c) {
    (w[c] = w[c] || []).push(function() {
        try {
            w.yaCounter28342396 = new Ya.Metrika({id:28342396,
                    webvisor:true,
                    clickmap:true,
                    trackLinks:true,
                    accurateTrackBounce:true});
        } catch(e) { }
    });

    var n = d.getElementsByTagName("script")[0],
        s = d.createElement("script"),
        f = function () { n.parentNode.insertBefore(s, n); };
    s.type = "text/javascript";
    s.async = true;
    s.src = (d.location.protocol == "https:" ? "https:" : "http:") + "//mc.yandex.ru/metrika/watch.js";

    if (w.opera == "[object Opera]") {
        d.addEventListener("DOMContentLoaded", f, false);
    } else { f(); }
})(document, window, "yandex_metrika_callbacks");
</script>
<noscript><div><img src="//mc.yandex.ru/watch/28342396" style="position:absolute; left:-9999px;" alt="" /></div></noscript>
<!-- /Yandex.Metrika counter -->
	
	<%        
    response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setDateHeader("Expires", -1);
%>
	
</head>
<body >
<%@ page
		import="org.springframework.security.core.context.SecurityContextHolder"%>
	<%
		String aUser = SecurityContextHolder.getContext()
				.getAuthentication().getName();
	%>
	<c:set var="activeUser" value="<%=aUser%>" scope="session" />
    <header class="header" id="jump">
        <nav class="navbar navbar-default navbar-fixed-top" role="navigation">
            <div class="container">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-responsive-collapse">
                        <span class="sr-only">Toggle navigation</span> <span class="icon-bar"></span><span
                            class="icon-bar"></span><span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="http://scrapingon.com">
                        <img src="${pageContext.request.contextPath}/resources/web/img/logo2.png" alt="Scparingon.com" /></a>
                </div>
                <div class="collapse navbar-collapse hidden-xs">
                    <ul class="nav navbar-nav navbar-right">
                        <li class="active"><a href="#crawler" onclick="window.location.href='${pageContext.request.contextPath}/#'">Home</a></li>
                        <li><a href="#scanning-result" onclick="window.location.href='${pageContext.request.contextPath}/#scanning-result'">Result</a></li>
                        <li><a href="#messages" onclick="window.location.href='${pageContext.request.contextPath}/#messages'">Messages</a></li>
                         <li><a href="${pageContext.request.contextPath}/howTo" onclick="window.location.href='${pageContext.request.contextPath}/howTo'">How To</a></li>
                        <sec:authorize access="authenticated" var="authenticated" /> 
					    <c:choose>
						 	<c:when test="${!authenticated}">
								<li><a href="#" id="logIn" onclick="loginMe();">Log in</a></li>

							</c:when>
							<c:otherwise>
								<li><a href="/logout" onclick="window.location.href='${pageContext.request.contextPath}/logout'">Log
									out - <strong> ${activeUser}</strong></a></li>
							</c:otherwise>
						</c:choose> 
                   </ul>
                </div>
                <!-- /.navbar-collapse -->
                <div class="collapse navbar-responsive-collapse">
                    <ul class="nav navbar-nav">
                        <li class="active"><a href="#crawler" data-toggle="collapse" data-target=".navbar-responsive-collapse">
                            Home</a></li>
                        <li><a href="#jump4" data-toggle="collapse" data-target=".navbar-responsive-collapse">
                            Result</a></li>
                        <li><a href="#jump6" data-toggle="collapse" data-target=".navbar-responsive-collapse">
                            Messages</a></li>
                            <li><a href="${pageContext.request.contextPath}/howTo" onclick="window.location.href='${pageContext.request.contextPath}/howTo'">How To</a></li>
                        <sec:authorize access="authenticated" var="authenticated" /> 
					    <c:choose>
						 	<c:when test="${!authenticated}">
								<li><a href=""
										id="logIn" onclick="loginMe();">Log in</a></li>

							</c:when>
							<c:otherwise>
								<a href="/logout" >Log
									out - <strong> ${activeUser}</strong></a>
							</c:otherwise>
						</c:choose>     
                    </ul>
                </div>
                <!-- /.navbar-responsive-collapse -->
            </div>
        </nav>
        <div id="resultPopUp">
					<a class="b-close">x</a>
						 <div class="col-md-12">
						   	<h2>${resultString}</h2>
						  
						</div>
  				</div>
    </header>
    <!-- Pop up Login -->
						<div id="loginMePopUp">
						<a class="b-close">x</a>
						    <div class="col-md-12">
						    	<form id="loginForm"
								action="${pageContext.request.contextPath}/<c:url value='j_spring_security_check'/>"
								method="post" novalidate="novalidate">
								
								<div class="form-group">
									<label for="username" class="control-label">Username</label> <input
										type="text" class="form-control" name="j_username"
										id="j_username" value="" required="true"
										title="Please enter you username" placeholder="Username">
									<span class="help-block"></span>
								</div>
								<div class="form-group">
									<label for="password" class="control-label">Password</label> <input
										type="password" class="form-control" name="j_password"
										id="j_password" value="" required="true"
										title="Please enter your password" placeholder="password">
									<span class="help-block"></span>
								</div>
								<div id="loginErrorMsg" class="alert alert-error hide">Wrong
									username or password</div>
								<br>
								<button type="submit" class="btn btn-outline btn-lg btn-block">Login</button>
								<br> <a href="#" class="btn btn-outline  btn-block"
									onclick="registerMe();">New user</a>
							</form>
						</div>
				</div>
				
				<!-- Popup register -->
				<div id="registerMePopUp">
					<a class="b-close">x</a>
						    <div class="col-md-12">
						   		<div class="row">
									<div class="col-md-12">
									
									<form id="registerMeForm"
										
										action="${pageContext.request.contextPath}/register"
										method="post">
										<div class="form-group">
											<label for="username" class="control-label">Username</label> <input
												type="text" class="form-control" name="username"
												id="username" required="true"
												title="Please enter you username" placeholder="Username">
											<span class="help-block"></span>
										</div>
										<div class="form-group">
											<label for="email">Email</label> 
											<input  class="form-control" required="true"
												name="email" id="email" title="Please enter correct email." type="email"
												placeholder="Email" > 
                						</div>
										<div class="form-group">
											<label for="password" class="control-label">Password</label> <input
												type="password" class="form-control" name="password"
												id="password" value="" required="true"
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
  				<!-- End register popUp -->
