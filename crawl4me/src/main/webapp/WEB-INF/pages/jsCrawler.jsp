<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html ng-app="jsModule">
<head>

<%@include file="../pages/header.jsp"%>
<meta name="description"
	content="Scrap data for free online just in one click. With JavaScript crawler you able to crawl dynamic web content." />
<title>JavaScript online web crawler for scraping dynamic web content.</title>
<script
	src="${pageContext.request.contextPath}/resources/web/angular/controller/jsForm.js"></script>

<div class="jumper" id="crawler"></div>
<div class="section type-1 big splash" id="crawlerPage"
	ng-controller="jsCtrl">
	<form name="crawler_form" novalidate ng-submit="startCrawler()">
		<div class="section-headlines" id="freescrap">

			<h1>JavaScript data scraping</h1>

			<div class="row" id=rowscrap">
				<div class="col-md-11 <!--  col-md-offset-0,5 -->">
					<div class="panel with-nav-tabs panel-default" id="panelurl">
						<div class="panel-heading" id="panelurltabs">
							<ul class="nav nav-tabs" id="paneltabs">
								<li><a href="${pageContext.request.contextPath}/"
									data-ng-click="htmlCrawler()" data-toggle="tab">Online website crawler</a></li>
								<li class="active"><a
									href="${pageContext.request.contextPath}/JavaScriptCrawler"
									data-ng-click="javaScriptCrawler()" data-toggle="tab">Online JavaScript crawler</a></li>

							</ul>
						</div>
						<div class="panel-body">
							<div class="tab-content">
								<div class="tab-pane fade in active" id="tab1default">
									<form class="form-horizontal" role="form">
										<!-- <div class="form-group col-md-7 col-md-offset-2"> -->
										<div class="form-group">
											<label for="inputEmail3" class="col-sm-2 control-label" id="urltoscan">Scrap website<a href="#" class="icon-info-sign pull-right"
												tooltip-html-unsafe="{{urlTip}}" tooltip-trigger="focus"></a>
											</label>
											<div class="col-sm-9">
												<input type="url" name="url" id="url" ng-model="urlData"
													class="form-control"
											ng-change="setLinks()" required/>
                                               <div class="error" id="urlError"
											        ng-show="crawler_form.url.$dirty && crawler_form.url.$invalid">
											      <small class="error" 
												    ng-show="crawler_form.url.$error.required"> URL is
												    required. 
											      </small> Please enter correct address.
										       </div>
											</div>
										</div>
								</div>
							</div>
						</div>
					</div>
				</div>

			</div>
		</div>
		<div class="container">



			<!-- Registration data alert -->
			<c:if test="${resultString ne null}">
				<script type="text/javascript">
					resultPopUp();
				</script>
			</c:if>
			<!-- End registration data alert -->

			<!-- Scan form -->
			<div name="scan-form">
				
					<div class="form-group col-lg-8">
						<label>Send text <a href="#"
							class="icon-info-sign pull-right"
							tooltip-html-unsafe="{{searchTextTip}}" tooltip-trigger="focus"></a>
						</label> <input type="text" name="searchPhrase" id="searchPhrase"
							ng-model="myPageData.searchPhrase" class="form-control"
							ng-change=""/>
							
					</div>
					<div class="form-group col-lg-4" id="textintable">
						<p>JavaScript crawler auto detects input form in the webpage and insert user text. Web data scraping process start after website will return our search result. </p>
					</div>
				

				<!-- collapse data -->
				<div class="form-group col-lg-8">
					<div id="pageDetails">
						<label>Extract data <a href="#"
							class="icon-info-sign pull-right"
							tooltip-html-unsafe="{{valueTip}}" tooltip-trigger="focus"></a>
						</label>

						<div class="panel panel-default">
							<div class="panel-heading">
								<h4 class="panel-title">Specify which data should be
									extracted.</h4>
							</div>
							<div class="panel-body"
								style="max-height: 250px; overflow-y: scroll;">
								<div id="linksTable" simple-grid="gridRulesConfig"></div>
								<button type="button" class="btn btn-sm btn-success"
									ng-click="addRulesRow()">Add row</button>
							</div>
						</div>
					</div>
				</div>
				<div class="form-group col-lg-4" id="textintable">
										<p>Data scraping services based on extracting data from HTML elements. First we must to find which web element contains data we want to scrap. Right click -> View Sourse on web page will open html document version and using CTRL+F we will find our scraped text. And copy-paste to ScrapingOn scraping field nearest web element that surrounds our text.<br> It looks like &lt;div class="price"&gt; or &lt;p id="item"&gt;<br> For scraping title of the page just print &lt;title&gt; in scraper value field. This way you can extract any data from websites - email, links, prices, news articles and more. The proccess of extracting data from a website will be shown in scrapper console. 
										   
										 </p>

				</div>
			

			<div class="form-group col-md-8">
				<div id="pageDetails">
					<label>Switch pages <a href="#"
						class="icon-info-sign pull-right"
						tooltip-html-unsafe="{{paginatorTip}}" tooltip-trigger="focus"></a>
					</label>
					<div class="btn-group btn-toggle">
						<button class="btn btn-default  active" data-toggle="collapse" type="button"
							data-target="#collapsibleLink">Off</button>
						<button class="btn btn-default" data-toggle="collapse" type="button"
							data-target="#collapsibleLink">On</button>
					</div>
					<div class="well collapse" id="collapsibleLink">
						<div class="panel panel-default">
							<div class="panel-heading">
								<h4 class="panel-title">Pagination rules for: - {{urlData}}</h4>
							</div>
							<div class="panel-body" style="max-height: 250px;">
								<div id="linksTable" simple-grid="paginatorConfig"></div>
							</div>
						</div>
					</div>
				</div>
				
			</div>
			<div class="form-group col-lg-4" id="textintable">
										<p> 
										    Crawler based on JavaScript returned result can auto switch to the next page after extracting data from the current web page. Just copy-paste paginator link which switches pages.  
									    </p>

				</div>
		</div>	
			<div class="col-md-11">
				<div class="input-group" id="saveTemplate">
					<sec:authorize var="loggedIn" access="isAuthenticated()" />
					<c:choose>
						<c:when test="${1 eq 1}">
							<p id="textTemplate">You are able to save and share scan
								settings.</p>
							<div class="col-sm-6">
								<span class="input-group-btn" id="saveTemplateLink">
									<button class="btn btn-outline" id="saveTemplateButton"
										type="button" onclick="return saveTemplate();"
										value="Add scan">Save this settings</button>
								</span>

							</div>
						</c:when>
						<c:otherwise>
							<p id="textTemplate">
								<a href="#" onclick="loginMe();">Please log in</a> if you want
								save and share this settings.
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


					<div class="form-group col-md-4 .col-md-offset-3">
						<div id="scanStarter">
							<button class="btn btn-outline btn-lg" id="scanButton"
								type="submit" ng-disabled="crawler_form.$invalid">Scrap
								it.</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</form>
</div>
<!-- End scan form -->
</div>
</div>

<%@include file="../pages/footer.jsp"%>