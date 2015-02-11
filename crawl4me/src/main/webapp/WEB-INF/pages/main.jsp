﻿<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
   <!--  <meta charset="utf-8"> -->
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/web/favicon.ico" />
    <title>ScrapingOn free online data scraping.</title>
    <!-- Stylesheets -->
    <link type="text/css" href="${pageContext.request.contextPath}/resources/web/css/bootstrap.css" rel="stylesheet">
    <link href='http://fonts.googleapis.com/css?family=Roboto:400,400italic,700,700italic,500italic,500,300italic,300'
        rel='stylesheet' type='text/css'>
    <link type="text/css" href="${pageContext.request.contextPath}/resources/web/icons/font-awesome/css/font-awesome.css" rel="stylesheet">
    <link type="text/css" href="${pageContext.request.contextPath}/resources/web/icons/rondo/style.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/web/css/jquery.fancybox.css" rel="stylesheet" type="text/css" />
    <link type="text/css" href="${pageContext.request.contextPath}/resources/web/css/style.css" rel="stylesheet">
   	
   	<!-- JS import -->
   	
   	<script src="${pageContext.request.contextPath}/resources/js/jquery-2.1.3.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/web/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/web/js/jquery.smooth-scroll.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/web/js/jquery.mixitup.min.js"></script>
   
    <script src="${pageContext.request.contextPath}/resources/web/js/modernizr.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/resources/web/js/jquery.fancybox.pack.js" type="text/javascript"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/web/js/custom.js"></script>
    
    <script src="${pageContext.request.contextPath}/resources/bootstrap/bootstrap/js/alert.js"></script>
   		
	<script	src="${pageContext.request.contextPath}/resources/js/sockjs-0.3.4.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/stomp.js"></script>
	
	<script src="${pageContext.request.contextPath}/resources/js/userMessages.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/templateSaver.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/stompConnection.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/bPopup.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/buttonsCreator.js"></script>
	
	<!-- Google Analytics -->
	<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-59209796-1', 'auto');
  ga('send', 'pageview');

</script>
	
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
                        <li class="active"><a href="#jump0">Home</a></li>
                        <li><a href="#jump1">How To</a></li>
                        <li><a href="#jump4">Result</a></li>
                        <li><a href="#jump6">Messages</a></li>
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
                        <li class="active"><a href="#jump0" data-toggle="collapse" data-target=".navbar-responsive-collapse">
                            Home</a></li>
                       <li><a href="#jump1" data-toggle="collapse" data-target=".navbar-responsive-collapse">
                            How to</a></li>
                        <li><a href="#jump4" data-toggle="collapse" data-target=".navbar-responsive-collapse">
                            Result</a></li>
                        <li><a href="#jump6" data-toggle="collapse" data-target=".navbar-responsive-collapse">
                            Messages</a></li>
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
    <div class="jumper" id="jump0">
    </div>
    <div class="section type-1 big splash" id="crawlerPage">
        <div class="splash-cover">
        </div>
        <div class="container">
            <div class="splash-block">
                <div class="centered">
                    <div class="container">
                        <div class="section-headlines">
                            <h2>
                                Free online web scraper.</h2>                            
                        </div>
                        
                 <!-- Registration data alert -->
                       <c:if test="${resultString ne null}">
							<script type="text/javascript">resultPopUp(); 
							</script>	
  						</c:if>
  				 <!-- End registration data alert -->
  				 
  				 <!-- Scan form -->
  				 	<div name="scan-form">
						<div class="col-md-6">
							<div class="form-group col-lg-12">
								<label>URL to scan</label> <input type="url" name="url" id="url"
									class="form-control" value="${template.url}">
							</div>

							<div class="form-group col-lg-12">
								<label>URL Regex</label> <input type="text" name="regex" id="regex"
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
									<label>Parameter name ${i}:</label> <input type="text"
										name='domRuleName${i}' id="domRuleName${i}"
										class="form-control" value='${domRule.key}'>
								</div>
								<div class="col-sm-6">
									<label>Looking beetween specific tag:</label> <input
										type="text" name='domRuleValue${i}' id='domRuleValue${i}'
										class="form-control" value='${domRule.value}'>
								</div>

							</c:forEach>


							<div class="input-group" id="saveTemplate">

								<sec:authorize var="loggedIn" access="isAuthenticated()" />
								<c:choose>
									<c:when test="${loggedIn}">
									<p id="textTemplate">
											You are able to save and share scan settings.
										</p>
									<div class="col-sm-6">
										<span class="input-group-btn" id="saveTemplateLink">
											<button class="btn btn-outline" id="saveTemplateButton"
												onclick="saveTemplate();" value="Add scan">Save this
												settings</button>
										</span>
									</div>	
									</c:when>
									<c:otherwise>
									<p id="textTemplate">
											<a href="#" onclick="loginMe();">Please
												log in</a> if you want save and share this settings.
										</p>
										<div class="col-sm-6">
											<span class="input-group-btn">
												<button class="btn btn-outline disabled"
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
							<p>Enter valid http adress starting point for spider.
								After scanning this page all links to other pages that matches
								URL Regex rule will be extracted and scanned.</p>
							<br>
							<p>
								URL regex rule shous scrapper from which pages data should be
								extracted. To specify this rule you can use special symbols.
								Look for examples in <a href="#jump1">How To.</a><br> <br>
							</p>
							<p>For Parameter Name you can choose any name. It will describe the
								value what you are looking in the page.</p>
							Find in the html source page tags in which looking value placed and copy-paste it into <i>Looking between specific tag:</i> field. It should looks like:	
								&lt;div class="price"&gt; or &lt;p id="itemName"&gt;. See <a href="#jump1">How
								To</a> for examples.
							</p>


							<!-- Alert block -->

							<div class="alert alert-default alert-dismissible fade in"
								role="alert" id="legalAlert">

								<h4>Legal issues.</h4>
								<p>Web scraping may be against the terms of use of some
									websites.</p>
								<p>
									<button type="button" class="btn btn-outline btn-lg"
										data-dismiss="alert" aria-label="Close" onclick="connect();">I
										got it. Let's start!</button>

								</p>
							</div>
						</div>
						<!-- End Alert -->

					</div>
  				 	<!-- End scan form -->	
                    </div>
                </div>
            </div>
        </div>
    </div>
    </div>
    <div id="jump1" class="jumper">
    </div>
    <div class="section type-2">
        <div class="container">
            <div class="section-headlines">
                <h3>
                    ScrapingOn.com free online web scraping.</h3>
                <div>
                     Data crawling as easy as never before. Extract and organise data in one click. It can be useful in many cases:
                </div>
            </div>
            <div class="row">
                <div class="col-lg-6 features">
                    <div class="media">
                        <i class=" icon-shopping-cart pull-left animated bounce"></i>
                        <div class="media-body">
                            <h3>
                                E-commerce</h3>
                            <div>
                                Extracting products and prices from catalogs, web resources.</div>
                        </div>
                    </div>
                    <br class="gap-30" />
                    <div class="media">
                        <i class=" icon-bar-chart pull-left animated bounce"></i>
                        <div class="media-body">
                            <h3>
                                Data import</h3>
                            <div>
                                Crawl user or companies data including emails, names, phones and other.</div>
                        </div>
                    </div>
                    <br class="gap-30" />
                    <div class="media">
                        <i class=" icon-search pull-left animated bounce"></i>
                        <div class="media-body">
                            <h3>
                                Market resarch</h3>
                            <div>
                                Spider can crawl data from jobs sites, media portals, financial markets.</div>
                        </div>
                    </div>
                    <div class="visible-xs visible-sm">
                        <br class="gap-30" />
                        <hr class="gap-divider" />
                        <br class="gap-30" />
                    </div>
                </div>
                <div class="col-lg-6 features">
                    <div class="panel-group" id="accordion">
                        
                        <div class="panel">
                            <div class="panel-heading">
                                <h3 class="panel-title">
                                    <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
                                        E-commerce scraping data example. <i class="icon-plus"></i><i class="icon-minus"></i></a>
                                </h3>
                            </div>
                            <div id="collapseOne" class="panel-collapse collapse">
                                <div class="panel-body">
                                    <b>Task:</b> crawl jewelry name and price from E-shop page: <mark> http://www.skagen.com/gb/en/men/new-arrivals/jewelry.html</mark>
                                   	<br />
                                    <br />
                                    <b>Steps:</b> start crawling URL will be as link below, now let's add regex rule. As we want to scraping data about all products in this category it will be: <mark>http://www.skagen.com/gb/en/men/new-arrivals/jewelry.html.*</mark> we discover it when visit any product link and look at the URL. Then open HTML page as source and quikly find tags where product name placed:<mark> &lt;h1 class="product-title"&gt;</mark> and for price:<mark> &lt;div class="product-price col-md-5"&gt;</mark> - just copy-paste it to the <i>Looking beetween specific tag:</i> field.
                                    <br />
                                    <br />
                                    <b>Problem:</b> when we start scan results will appear two times. Examine console and find that every crawled product has two links <mark>....pdpskj0604p.html?referer=productlisting</mark> and <mark>....pdpskj0604p.html?referer=productlisting#</mark> with hash sign at the end. 
                                    <br />
                                    <br /> 
                                    <b>Solution:</b> to make scrapper visit only one link we will change URL Regex rule. Let's crawl data only from <mark>....pdpskj0604p.html?referer=productlisting</mark> looks like page for that matter we need to add <mark>g</mark> to the end of our <i>URL regex</i>, it will show to crawler that anly pages that ends with letter <mark>g</mark> should be scanned. So we will got <mark>http://www.skagen.com/gb/en/men/new-arrivals/.*g</mark> for URL Regex.
                                    <br />
                                    <br />
                                    <b>Link with settings:</b> <a href="http://scrapingon.com/sKWQVc">http://scrapingon.com/sKWQVc</a>
                                </div>
                            </div>
                        </div>
                        <div class="panel">
                            <div class="panel-heading">
                                <h3 class="panel-title">
                                    <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo">
                                    	Data scraping example. <i class="icon-plus"></i><i class="icon-minus">
                                        </i></a>
                                </h3>
                            </div>
                            <div id="collapseTwo" class="panel-collapse collapse">
                                <div class="panel-body">
                                    <b>Task:</b> get schools URLs from: <mark> http://www.ncaa.com/schools/a</mark> wich starts from <b>a</b> letter and no longer than 20 symbols.
                                   	<br />
                                    <br />
                                    <b>Steps:</b> copy-paste link to the <b>URL to scan</b> and <b>URL Regex</b> fields. At the end of regex add <mark>.{2,20}</mark> hats mean that any symbol must be found from 2 to 20 times.So you will get <mark>http://www.ncaa.com/schools/a.{2,20}</mark>. After that find tags in HTML code with data. Copy-paste it to the other fields.  
                                    <br />
                                    <br />
                                    <b>Problem:</b> no problems... 
                                    <br />
                                    <br /> 
                                    <b>Link with settings:</b> <a href="http://scrapingon.com/svp58x">http://scrapingon.com/svp58x</a>
                                </div>
                            </div>
                        </div>
                        <div class="panel">
                            <div class="panel-heading">
                                <h3 class="panel-title">
                                    <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion"
                                        href="#collapseThree">Crawl data from real estate agency example. <i class="icon-plus"></i><i class="icon-minus">
                                        </i></a>
                                </h3>
                            </div>
                            <div id="collapseThree" class="panel-collapse collapse">
                                <div class="panel-body">
                                    <b>Task:</b> crawl islands prices from: <mark> http://www.caribbeanislandbrokers.com</mark>
                                   	<br />
                                    <br />
                                    <b>Steps:</b> visit site and open first island in the list copy-paste URL <mark>http://www.caribbeanislandbrokers.com/islands-for-sale/Manta-Caye</mark> as we want parce all islands the start crawling <i>URL to scan</i> will be <mark> http://www.caribbeanislandbrokers.com/islands-for-sale</mark> and <i>URL Regex</i> <mark>http://www.caribbeanislandbrokers.com/islands-for-sale.*</mark>. Open island page as HTML (Right-click on a web page to open the right-click context menu and select Page Source) and find <i>Manta Caye</i> text in the content. This text is placed in <mark>&lt;h2&gt;</mark> tags copy-paste it into <i>Looking beetween specific tag:</i> field. At the next line we can see price also placed in <mark>&lt;h2&gt;</mark> tags copy-paste into <i>Looking beetween specific tag:</i> second Parameter name.
                                    <br />
                                    <br />
                                    <b>Problem:</b> how crawled will detects where is name tag and where is price tag as there bouth placed between <mark>&lt;h2&gt;</mark> tags.
                                    <br />
                                    <br /> 
                                    <b>Solution:</b> to show crawler from with tags scrap data we can add selectors to the end of tag <i>{first}</i> or <i>{last}</i>. So in the <i>Looking beetween specific tag:</i> for first parameter <i>Name</i> we will have <mark>&lt;h2&gt;{first}</mark> and <mark>&lt;h2&gt;{last}</mark> for the second. When we will start scan we can see that not unique results appear as pages like <mark>http://www.caribbeanislandbrokers.com/islands-for-sale/Manta-Caye/image-3927</mark> also proceeded to avoid this simple add <mark>\D</mark> at the end of <i>URL Regex</i> it will crawler to scan only pages that ends with letters (not digists).
                                    <br />
                                    <br />
                                    <b>Link with settings:</b> <a href="http://scrapingon.com/shZv2U">http://scrapingon.com/shZv2U</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="visible-xs visible-sm">
                        <br class="gap-30" />
                        <hr class="gap-divider" />
                        <br class="gap-30" />
                    </div>
                </div>
            </div>
            <br>
            <br>
            <br>
            <div class="row">
                <div class="col-lg-6 features">
                    <h3>
                        About scraper 1.1 version:</h3>
                    <div class="skills">
                        <p>Start right now:</p>
                      <ul>
                      		<li>No registration, crawler is ready to go!</li>
                      		<li>User FAQ with live examles</li>
                       		<li>No limit scraped url's per one user.</li>
                       		<li>Multithreading crawler.</li>
                       </ul>
                       <p>Data managment:</p>
                       <ul>		
                       		<li>Live-time result preview.</li>
                       		<li>Data table for searched result.</li>
                       		<li>Two parameters availibles for data searching and extracing.</li>
                       		<li>Free one step registration</li>
                       		<li>Save and share crawling settings (for registred users).</li>
                       		<li>Up to 50 results per one crawling.</li>
                       	</ul>
                       	<p>Got what you need:</p>
                       	<ul>	
                       		<li>Live support including to help users create rules to scan specified resource.</li>
                       		<li>If you need more functionality please Contact us and we will add what you need.</li>
                        </ul>
                        <hr>
                        <p>Whats new:</p>
                       	<ul>	
                       		<li>Supports selectors syntax {first} and {last} ex: &lt;h2&gt;{first}. See real estate example.</li>
                       		<li>Performance upgrades.</li>
                        </ul>
                       
                    </div>
                </div>
                <div class="col-lg-6 features">
                    <h3>How To</h3>
                    <p><strong>Start crawling with ScrapingOn.com step-by-steb:</strong><br>
                    <ol>
                    	<li>Read Legal issues and click I got it. Let's start button</li>
                    	<li>Enter crawling resource in URL to scan and chose wich page should be examined by filling URL Regex rule field</li>
                    	<li>Choose wich data you want to scrap from pages. Open page as HTML code view and find between wich tags your data placed after copy paste tag for the first parameter and do the same for the second parameter.</li>
                    	<li>Click Scan button and scraping will start so you can able to see console log and result table with crawled result.</li>
                    </ol>
                    <p><strong>Having some problems with you scraping.</strong><br>
                        If you cannot scrap some resource please contact us via email or live message in the site. We will solve your problem and create link for your scan settings. Provide your message with link to site for crawling and specify data wich you want to extract.
                    </p>
                    <p><strong>Want more functions.</strong><br>
                        Please contact us and we will include more functionaluty to web scrapper according to your needs.
                    </p>
                   
                </div>
            </div>
        </div>
    
  <div id="jump4" class="jumper">
    </div>
    <div class="section type-3">
        <div class="container">
            <div class="section-headlines">
                <h4>
                    Scraping result</h4>
                <div id="resultHeader">
                    <h3>Real time data scraping process.</h3> 
                </div>
            </div>
            
            <div class="col-md-7">
						<div class="panel panel-success" id="tablePanel">
							<div class="panel-heading"><h4>Result table</h4></div>
							<div class="panel-body" id="resultTableDiv">
								<table class="table table-striped" id="resultTable"><thead><tr><td>#</td><td>Name</td><td>Price</td></tr><tr><td>1</td><td>Agnethe Silver-Tone Grey Crystal Pearl Ring</td><td>£39.00</td></tr><tr><td>2</td><td>Katrine Rose-Gold-Tone Heart Pendant Necklace</td><td>£35.00</td></tr><tr><td>3</td><td>Katrine Rose-Gold-Tone Heart Pendant Necklace</td><td>£89.00</td></tr><tr><td>4</td><td>Ditte Silver-Tone Round Pendant Necklace</td><td>£45.00</td></tr><tr><td>5</td><td>Katrine Silver-Tone Heart Pendant Necklace</td><td>£59.00</td></tr><tr><td>6</td><td>Katrine Silver-Tone Pendant Necklace</td><td>£39.00</td></tr><tr><td>7</td><td>Katrine Rose-Gold-Tone Pendant Necklace</td><td>£49.00</td></tr><tr><td>8</td><td>Krinsen Silver-Tone Ring</td><td>£49.00</td></tr></thead></table>
							</div>
						</div>
					</div>

					<div class="col-md-5">
						<div class="panel panel-success" id="console">
							<div class="panel-heading" id="consoleHeading"><h4>Console output</h4></div>
							<div class="panel-body" id="consoleBody">
								<p>Scanning output console...</p>
								- Started scanning: 13:57:03 28-01-2015<br><p>- Found page: http://www.example.com/katrine-silver-tone-heart-pendant-necklace-pdpskj0604p.html?referer=productlisting<br></p><p>- Found page: http://www.example.com/katrine-silver-tone-pendant-necklace-pdpskj0602p.html?referer=productlisting<br></p><p>- Found page: http://www.example.com/katrine-rose-gold-tone-pendant-necklace-pdpskj0603p.html?referer=productlisting<br></p><p>- Found page: http://www.example.com/krinsen-silver-tone-ring-pdpskj0600p.html?referer=productlisting<br></p><p>- Found page: http://www.example.com/ditte-rose-gold-tone-round-pendant-necklace-pdpskj0557p.html?referer=productlisting<br></p><p>- Finished: 13:57:06 28-01-2015<br>
							</div>
						</div>
					</div>
            
            
        </div>
        <!--end:.container-->
    </div>
  
  
     <div id="jump6" class="jumper">
       <div class="section type-1 section-contact">
        <div class="container" id="contacts">
            <div class="section-headlines">
                <h4>Messages</h4>
            </div>
         
                <div class="col-sm-8" id="disqusId">
                 	<div id="disqus_thread"></div>
   							 <script type="text/javascript">
        							/* * * CONFIGURATION VARIABLES: EDIT BEFORE PASTING INTO YOUR WEBPAGE * * */
        							var disqus_shortname = 'scrapingoncom'; // required: replace example with your forum shortname

        							/* * * DON'T EDIT BELOW THIS LINE * * */
						        	(function() {
						            var dsq = document.createElement('script'); dsq.type = 'text/javascript'; dsq.async = true;
						            dsq.src = '//' + disqus_shortname + '.disqus.com/embed.js';
						            (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq);
						        })();
						    </script>
    						<noscript>Please enable JavaScript to view the <a href="https://disqus.com/?ref_noscript">comments powered by Disqus.</a></noscript>
             	</div>   
         </div>
        </div>
   </div>
   
    <!-- <footer class="footer">
        <div class="container">
            <div class="row">
                <div class="col-lg-12" id="footer">
                    http://www.scrapingon.com &copy; 2015 - <a href="http://www.scrapingon.com">
                        ScrapingOn.</a>  Show <a onclick="emailShow();">email</a>.	
                </div>
         -->
        		<!-- Pop up Login -->
						<div id="loginMePopUp">
						<a class="b-close">x<a/>
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
					<a class="b-close">x<a/>
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
  			  		  		       				
  <!--   </footer> -->
  		
  		<script type="text/javascript">
			$('#legalAlert').on('closed.bs.alert', function() {
				setTimeout(createScanButton, 2000);
			})
				
			/* postMessage(); */
	
			</script>
</body>
</html>
