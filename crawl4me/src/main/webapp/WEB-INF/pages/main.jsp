<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html ng-app="formModule">
<head>
<%@include file="../pages/header.jsp"%>

<script
	src="${pageContext.request.contextPath}/resources/web/angular/controller/angularForm.js"></script>

<div class="jumper" id="crawler"></div>
<div class="section type-1 big splash" id="crawlerPage"
	ng-controller="FormCtrl">
	<form name="crawler_form" novalidate ng-submit="startCrawler()">
	<div class="section-headlines" id="freescrap">

		<h1>Free online scraper</h1>

		<div class="row" id=rowscrap">
			<div class="col-md-11">
				<div class="panel with-nav-tabs panel-default" id="panelurl">
					<div class="panel-heading" id="panelurltabs">
						<ul class="nav nav-tabs" id="paneltabs">
							<li class="active"><a
								href="${pageContext.request.contextPath}/"
								data-ng-click="htmlCrawler()" data-toggle="tab">Basic HTML
									scrapper</a></li>
							<li><a
								href="${pageContext.request.contextPath}/JavaScriptCrawler"
								data-ng-click="javaScriptCrawler()" data-toggle="tab">JavaScript
									scrapper</a></li>
						</ul>
					</div>
					<div class="panel-body">
						<div class="tab-content">
							<div class="tab-pane fade in active" id="tab1default">

								<!-- <div class="form-group col-md-7 col-md-offset-2"> --> 
								<div class="form-group">
									<label for="inputEmail3" class="col-sm-2 control-label" id="urltoscan">URL to scan <a href="#" 
									    class="icon-info-sign pull-right"
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
							<div class="tab-pane fade" id="tab2default">Default 2</div>
							<div class="tab-pane fade" id="tab3default">Default 3</div>

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



			<!-- collapse links -->
			<!-- <div class="row"> -->
			<div class="form-group col-lg-8">
				<div id="pageDetails">
					<label>Crawl data from links <a href="#"
						class="icon-info-sign pull-right"
						tooltip-html-unsafe="{{regexTip}}" tooltip-trigger="focus"></a>
					</label>
					<div class="btn-group btn-toggle">
						<button class="btn btn-outline  " data-toggle="collapse"
							type="button" data-target="#collapsibleLink">Only this
							page</button>
						<button class="btn btn-outline" data-toggle="collapse"
							type="button" data-target="#collapsibleLink">Custom
							format</button>
					</div>
					<div class="well collapse" id="collapsibleLink">
						<div class="panel panel-default">
							<div class="panel-heading">
								<h4 class="panel-title">Links from - {{urlData}}</h4>
							</div>
							<div class="panel-body" style="max-height: 300px;">
								<div id="linksTable" simple-grid="gridLinksConfig"></div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="form-group col-lg-4" id="textintable">
				<p>CSS свойство text-align указывает, каким образом будет
					выравниваться строчное содержимое (текст, изображения) по
					горизонтали, внутри родительского элемента контейнера (блок, ячейка
					таблицы, поле ввода формы).</p>
			</div>
			<!-- </div> -->
			<!-- collapse data -->
			<div class="row">
				<div class="form-group col-lg-8">
					<div id="pageDetails">
						<label>Extract data <a href="#"
							class="icon-info-sign pull-right"
							tooltip-html-unsafe="{{paramTip}}" tooltip-trigger="focus"></a>
						</label>

						<div class="panel panel-default">
							<div class="panel-heading">
								<h4 class="panel-title">Specify which data should be
									extracted.</h4>
							</div>
							<div class="panel-body"
								style="max-height: 250px; overflow-y: scroll;">
								<div id="linksTable" simple-grid="gridRulesConfig"></div>
								<button type="button" class="btn btn-sm  btn-outline"
									ng-click="addRulesRow()">Add row</button>
							</div>
						</div>
					</div>
				</div>
				<div class="form-group col-lg-4" id="textintable">
					<p>Для общего понимания давайте рассмотрим небольшую теорию о
						том, как браузер получает веб-страницы и что такое веб-сервер.</p>
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
								<button class="btn btn-outline btn-xs" id="saveTemplateButton"
									type="button" onclick="return saveTemplate();" value="Add scan">Save
									this settings</button>
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
								<button class="btn btn-outline disabled" id="saveTemplateButton"
									onclick="saveTemplate();" value="Add scan">Save
									settings</button>
							</span>



						</div>
					</c:otherwise>
				</c:choose>
				<div class="row">
					<div class="form-group col-md-3 .col-md-offset-3">
						<div id="scanStarter">
							<button class="btn btn-outline btn-lg" id="scanButton"
								type="submit" ng-disabled="crawler_form.$invalid">Scrap
								it.</button>
						</div>
					</div>
				</div>
			</div>

		</div>


		<!-- End scan form -->

	</div>
	</form>
</div>

</div>
<%@include file="../pages/footer.jsp"%>
</body>

</html>


