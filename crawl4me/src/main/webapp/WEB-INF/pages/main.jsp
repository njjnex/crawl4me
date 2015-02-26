<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html ng-app="formModule">
<head>
<%@include file="../pages/header.jsp"%>
<script src="${pageContext.request.contextPath}/resources/web/angular/controller/angularForm.js"></script>

<div class="jumper" id="crawler"></div>
<div class="section type-1 big splash" id="crawlerPage" ng-controller="FormCtrl">
	<div class="container">
					<tabset justified="true"> <tab
						heading="Basic HTML scrapper" data-ng-click="htmlCrawler()"></tab> <tab
						heading="JavaScript scrapper" data-ng-click="javaScriptCrawler()"></tab>
					</tabset>
					<div class="section-headlines">
						<!--    <h1>Free online web scraper.</h1>  -->
					</div>

					<!-- Registration data alert -->
					<c:if test="${resultString ne null}">
						<script type="text/javascript">
							resultPopUp();
						</script>
					</c:if>
					<!-- End registration data alert -->

					<!-- Scan form -->
					<div name="scan-form">


						<form>
							<div class="form-group col-lg-12">
								<label>URL to scan <a href="#"
									class="icon-info-sign pull-right"
									tooltip-html-unsafe="{{urlTip}}" tooltip-trigger="focus"></a>
								</label> <input type="url" name="url" id="url" ng-model="urlData"
									class="form-control" data-validate="required,url" ng-change="setLinks()">
							</div>
						</form>
						
						<!-- collapse links -->
						<div class="form-group col-lg-12">
							<div id="pageDetails">
								<label>Crawl data from links <a href="#"
									class="icon-info-sign pull-right"
									tooltip-html-unsafe="{{regexTip}}" tooltip-trigger="focus"></a>
								</label>
								<div class="btn-group btn-toggle">
									<button class="btn btn-default  active" data-toggle="collapse"
										data-target="#collapsibleLink">Only this page</button>
									<button class="btn btn-default" data-toggle="collapse"
										data-target="#collapsibleLink">Custom format</button>
								</div>
								<div class="well collapse" id="collapsibleLink">
									<div class="panel panel-default">
										<div class="panel-heading">
											<h4 class="panel-title">Links from - {{urlData}}</h4>
										</div>
										<div class="panel-body"
											style="max-height: 300px;">
											<div id="linksTable" simple-grid="gridLinksConfig"></div>
										</div>
									</div>
								</div>
							</div>
						</div>

						<!-- collapse data -->
						<div class="form-group col-lg-12">
							<div id="pageDetails">
								<label>Extract data <a href="#"
									class="icon-info-sign pull-right"
									tooltip-html-unsafe="{{regexTip}}" tooltip-trigger="focus"></a>
								</label>
								
									<div class="panel panel-default">
										<div class="panel-heading">
											<h4 class="panel-title">Specify which data should be
												extracted.</h4>
										</div>
										<div class="panel-body" style="max-height: 250px; overflow-y: scroll; ">
											<div id="linksTable" simple-grid="gridRulesConfig"></div>
											<button type="button" class="btn btn-sm btn-success" ng-click="addRulesRow()">Add row</button>
										</div>
									</div>
								</div>
							</div>

						</div>

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


							<div id="scanStarter"><button class="btn btn-default btn-lg" id="scanButton" type="button" onclick="return newScan();">Scrap it.</button></div>
						</div>
					</div>


					<!-- End scan form -->

				</div>
		</div>

</div>
<%@include file="../pages/footer.jsp"%>


<script type="text/javascript">
	$.verify
			.addRules({
				divRule : {
					regex : /^[<]\w{1,}\W\w{1,}[=]["][a-z\sA-Z-0-9]{1,30}["][>]\W{0,1}\w{0,6}\W{0,1}$/i,
					message : "Please provide correct tag ex: <div id='my_tag'>, or tag with selector ex: <div id='my_tag'>{first} also check the examples."
				}
			});
		
</script>
</body>
</html>
