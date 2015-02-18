var app = angular.module('formModule', [ 'ui.bootstrap', 'simpleGrid' ]);
app
		.controller(
				'FormCtrl',
				function($scope, $http) {
					$scope.urlTip = 'Enter valid http adress starting point for spider. After scanning this page all links to other pages that matches URL Regex rule will be extracted and scanned.';
					$scope.regexTip = 'URL regex rule shous scrapper from which pages data should be extracted. To specify this rule you can use special symbols. Look for examples in <a href="howTo">How To.</a>';
					$scope.parameterTip = 'Any name you wish. It will describe the value what you are looking in the page.';
					$scope.valueTip = 'For Parameter Name you can choose any name. It will describe the value what you are looking in the page. Find in the html source page tags in which looking value placed and copy-paste it into <i>Looking between specific tag:</i> field. It should looks like: &lt;div class="price"&gt; or &lt;p id="itemName"&gt;. See <a href="howTo">How To</a> for examples.'

					$scope.urlData = "http://www.bel.biz";
					$scope.myPageData = {};

					$scope.explorePage = function() {
						console.log($scope.urlData)
						connect();
						$http({
							'url' : 'urlTest',
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
							$scope.resultLinks();
							$scope.resultRules();

						});
					}
					$scope.resultLinks = function() {
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
								/*
								 * { "field": "linkRegex", "required": true,
								 * "title": "Regex" },
								 */
								{
									"field" : "timesFounded",
									"required" : true,
									"disabled" : true,
									"title" : "Times founded"
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
						}
					};
					$scope.resultRules = function() {
						$scope.gridRulesConfig = {
							// should return your data (an array)
							getData : function() {
								return $scope.domRules;
							},

							options : {
								columns : [ {
									"field" : "key",
									"required" : true,
									"title" : "Name"
								}, 
								{
									"field" : "selector",
									"required" : true,
									"$options": [
								                {
								                    "value": "selector",
								                    "title": "Selector"
								                },
								                {
								                    "value": "selector",
								                    "title": "selector"
								                }
								            ],
								            
									"title" : "Selector"
								},
								{
									"field" : "value",
									"required" : true,
									"title" : "Value"
								},
								
								],
								showEditButton : true,
								orderBy : 'key',
								// reverseOrder: false,
								editable : true, // true is the default - set
								// here manually to true to
								// make it easier to bind to
								// in the demo html
								disabled : false,
								perRowEditModeEnabled : true,
								allowMultiSelect : true,
								pageSize : 5,
								pageNum : 0,
								dynamicColumns : true
							}
						}
					};
					$scope.sendPageData = function(){
						var pageData = {};
						var activeLinks= [];
						for(var i=0; i < $scope.pageLinks.length; i++){
							if ($scope.pageLinks[i].included) activeLinks.push($scope.pageLinks[i])
						}
					
					pageData['id'] = null;	
					pageData['url'] = $scope.urlData;
					pageData['title'] = $scope.pageTitle;
					
					var links = [];
					pageData['links'] = activeLinks;
					
					var domRules = [];
					pageData["domRules"] = domRules;
					
					pageData['domRules'] = $scope.domRules;
									
					console.log("data from angular  " + JSON.stringify(pageData));
														
					return pageData;
										
					}
					
					
				});
