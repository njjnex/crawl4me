var app = angular.module('formModule', ['ui.bootstrap', 'simpleGrid' ], function($locationProvider){
	$locationProvider.html5Mode({
		  enabled: true,
		  requireBase: false
		});
});

app
		.controller(
				'FormCtrl',
				function($scope, $http, $location) {
					
					$scope.init = function () {
					    if ($location.path() == "/") {
					    	console.log(" default location: " + $location.path());
					    	$scope.explorePage("htmlDefault");
					    } 
					    if ($location.path().lastIndexOf("/z", 2) === 0) {
					    	console.log("template location: " + $location.path());
					    	$scope.explorePage("template/" + $location.path());
					    }
					    if ($location.path().lastIndexOf("/j", 2) === 0) {
					    	console.log("template location: " + $location.path());
					    	$scope.javaScriptCrawler();
					    	$scope.explorePage("template/" + $location.path());
					    }
					}
					
					$scope.urlData = "http://www.skagen.com/gb/en/men/new-arrivals/jewelry.html";
										
					$scope.urlTip = 'Enter http adress starting point for spider.';
					$scope.regexTip = 'Link rules shows scrapper from which pages data should be extracted. To specify this rules you can use special symbols. Look for examples in <a href="howTo">How To.</a>';
					$scope.paramTip = 'For Parameter Name you can choose any name. It will describe the value what you are looking in the page. Find in the html source page tags in which looking value placed and copy-paste it into <i>Looking between specific tag:</i> field. It should looks like: &lt;div class="price"&gt; or &lt;p id="itemName"&gt;. See <a href="howTo">How To</a> for examples.'

					
					$scope.myPageData = {};
					$scope.urlPath = $location.path();
					
					
					$scope.explorePage = function(postUrl) {
						console.log("location: " + $location.path());
						console.log($scope.urlData)
						connect();
						$http({
							'url' : postUrl,
							'method' : 'POST',
							'headers' : {
								'Content-Type' : 'application/json'
							},
							'data' : $scope.urlData
						}).success(function(data) {
							console.log(data)
							$scope.myPageData = data
							$scope.pageLinks = data.links;
							$scope.domRules = data.domRules;
							$scope.pageTitle = data.title;
							$scope.urlData = data.url;
							
						});
					}
					
						$scope.setLinks = function(){
							$scope.pageLinks[1].linkHref = $scope.urlData + "/.*";
							$scope.pageLinks[2].linkHref = $scope.urlData + "/.*.html";
							$scope.pageLinks[3].linkHref = $scope.urlData + "/.{5}[a-z]?\w=\d.html";
						}
										
						$scope.gridLinksConfig = {
							// should return your data (an array)
							getData : function() {
								return $scope.pageLinks;
								
							},

							options : {
								columns : [ {
									"field" : "linkHref",
									"required" : true,
									"title" : "Link"
								},
								{
									"field" : "linkText",
									"required" : true,
									"disabled" : false,
									"title" : "Description"
								} ],
								showEditButton : true,
								editRequested : function(row) {
									console.log('edit request:', row);
								},
								rowDeleted : function(row) {
									console.log('deleted:', row);
								},
								cellFocused : function(row, column) {
									console.log('focused:', row, column);
								},
								rowSelected : function(row) {
									console.log('selected:', row);
								},
								orderBy : 'timesFounded',
								// reverseOrder: false,
								editable : true, // true is the default - set
								// here manually to true to
								// make it easier to bind to
								// in the demo html
								disabled : false,
								perRowEditModeEnabled : false,
								allowMultiSelect : true,
								pageSize : 200,
								pageNum : 0,
								dynamicColumns : true
							}
						};
					
					
						$scope.gridRulesConfig = {
							// should return your data (an array)
							getData : function() {
								return $scope.domRules;
							},

							options : {
								columns : [ {
									"field" : "key",
									"required" : true,
									"title" : "Name it"
								}, /*{
									"field" : "selector",
									"required" : true,
									"inputType" : "select",
									"options" : [ {
										value : 0,
										title : 'Tag'
									}, {
										value : 1,
										title : 'First tag in page'
									}, {
										value : 2,
										title : 'Last tag in page'
									},
									{
										value : 3,
										title : 'Autodect by text'
									} ],
									formatter : function(item) {
										return item.title;
									},
									select : function(item) {
										return item.value;
									},
									"title" : "Extract from"
								}, */{
									"field" : "value",
									"required" : true,
									"title" : "Value"
								},

								],
								showEditButton : false,
								orderBy : 'key',
								// reverseOrder: false,
								editable : true, // true is the default - set
								// here manually to true to
								// make it easier to bind to
								// in the demo html
								disabled : false,
								perRowEditModeEnabled : false,
								allowMultiSelect : false,
								pageSize : 10,
								pageNum : 0,
								dynamicColumns : true
							}
						};
					$scope.sendPageData = function() {
						var pageData = {};
						var activeLinks = [];
						for (var i = 0; i < $scope.pageLinks.length; i++) {
							if ($scope.pageLinks[i].included)
								activeLinks.push($scope.pageLinks[i])
						}

						pageData['id'] = null;
						pageData['url'] = $scope.urlData;
						pageData['title'] = $scope.pageTitle;
					
						pageData['links'] = $scope.pageLinks;

						pageData['domRules'] = $scope.domRules;

						console.log("data from angular  "
								+ JSON.stringify(pageData));

						return pageData;

					}
					
					$scope.addRulesRow = function () {
		                var data = $scope.gridRulesConfig.getData();
		                console.log(data);
		                data.push(
		                    {
		                        $added: true,
		                        $editable: true
		                    }
		                );
		                $scope.gridRulesConfig.options.pageNum = Math.floor(data.length / $scope.gridRulesConfig.options.pageSize);
		            };
					          
		            $scope.javaScriptCrawler = function() {
		            	window.location.href = "http://localhost:8080/JavaScriptCrawler";
		            };
		            $scope.htmlCrawler = function() {
		            	window.location.href = "http://localhost:8080/";
		            };
		            
		            $scope.init();
		            
				});
