<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  	<%@include file="../pages/header.jsp" %>
    
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
  				 	<form>
						<div class="col-md-6">
							<div class="form-group col-lg-12">
								<label>URL to scan</label> <input type="url" name="url" id="url"
									class="form-control" value="${template.url}" data-validate="required,url">
							</div>

							<div class="form-group col-lg-12">
								<label>URL Regex</label> <input type="text" name="regex" id="regex"
									class="form-control" value="${template.regex}" data-validate="required,url">
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
										class="form-control" value='${domRule.key}' data-validate="required">
								</div>
								<div class="col-sm-6">
									<label>Looking beetween specific tag:</label> <input
										type="text" name='domRuleValue${i}' id='domRuleValue${i}'
										class="form-control" value='${domRule.value}' data-validate="required,divRule">
								</div>

							</c:forEach>


							<div class="input-group" id="saveTemplate">

								<sec:authorize var="loggedIn" access="isAuthenticated()" />
								<c:choose>
									<c:when test="${1 eq 1}">
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
						</form>
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
    
    
  <div id="scanning-result" class="jumper">
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
  
  
     <div id="messages" class="jumper">
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
   
    		
  		<script type="text/javascript">
			$('#legalAlert').on('closed.bs.alert', function() {
				setTimeout(createScanButton, 2000);
			})
				
			$.verify.addRules({
				  divRule: {
				    regex: /^[<]\w{1,}\W\w{1,}[=]["][a-z\sA-Z-0-9]{1,30}["][>]\W{0,1}\w{0,6}\W{0,1}$/i,
				    message: "Please provide correct tag ex: <div id='my_tag'>, or tag with selector ex: <div id='my_tag'>{first} also check the examples."
				  }
				});
			
			</script>
</body>
</html>
