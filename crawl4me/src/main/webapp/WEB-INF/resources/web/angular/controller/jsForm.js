var app = angular.module('jsModule', [ 'ui.bootstrap', 'simpleGrid' ],
		function($locationProvider) {
			$locationProvider.html5Mode({
				enabled : true,
				requireBase : false
			});
		});

app.controller('jsCtrl', function($scope, $http, $location) {
	
	$scope.init = function () {
	    if ($location.path() == "/") {
	    	$scope.explorePage("htmlDefault");
	    	
	    } 
	    if ($location.path() == "/JavaScriptCrawler") {
	    	$scope.explorePage("jsDefault");
	    }
	    if ($location.path().lastIndexOf("/z", 2) === 0) {
	    	$scope.explorePage("template/" + $location.path());
	    }
	    if ($location.path().lastIndexOf("/j", 2) === 0) {
	    	$scope.explorePage("template/" + $location.path());
	    }
	} 
	$scope.urlTip = 'Enter valid http adress starting point for spider. Page must contain input field where scraper will insert data for request.';
	$scope.searchTextTip = 'Text wich will be inserted and submited to the form.'
	$scope.valueTip = 'Specify wich data should be extracted by parameters. For Parameter Name you can choose any name. It will describe the value what you are looking in the page. Find in the html source page tags in which looking value placed and copy-paste it into <i>Looking between specific tag:</i> field. It should looks like: &lt;div class="price"&gt; or &lt;p id="itemName"&gt;. See <a href="howTo">How To</a> for examples.'
	$scope.paginatorTip = 'After scrap data from first page ScrapingOn is able to swith to another page for this you need to specify paginator rule. Just find in the end of the page link to the next pages (usually this link called "Next page" of something like this) copy-paste a class link to the rule to enable pagination. '
	
	$scope.urlData = "http://www.ebay.com";
		
	$scope.explorePage = function(postUrl) {
		connect();
		$http({
			'url' : postUrl,
			'method' : 'POST',
			'headers' : {
				'Content-Type' : 'application/json'
			},
			'data' : $scope.urlData
		}).success(function(data) {
			
			$scope.myPageData = data
			$scope.domRules = data.domRules;
			$scope.pageLinks = data.links;
			$scope.pageTitle = data.title;
			$scope.urlData = data.url;
			
			
		});
	}
	
	$scope.gridRulesConfig = {
			getData : function() {
				return $scope.domRules;
			},

			options : {
				columns : [ {
					"field" : "key",
					"required" : true,
					"title" : "Name it"
				},{
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
	
	$scope.paginatorConfig = {
			getData : function() {
				return $scope.pageLinks;
				
			},

			options : {
				columns : [ {
					"field" : "linkHref",
					"required" : true,
					"title" : "Paginator rule"
				},
				{
					"field" : "linkText",
					"required" : true,
					"disabled" : false,
					"title" : "Description"
				} ],
				showEditButton : true,
				editRequested : function(row) {
					
				},
				rowDeleted : function(row) {
					
				},
				cellFocused : function(row, column) {
					
				},
				rowSelected : function(row) {
					
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
	
	
	$scope.sendPageData = function() {
		var pageData = {};
		var activeLinks = [];
		for (var i = 0; i < $scope.pageLinks.length; i++) {
			if ($scope.pageLinks[i].included)
				activeLinks.push($scope.pageLinks[i])
		}

		pageData['id'] = null;
		pageData['url'] = $scope.urlData;
		pageData['searchPhrase'] = $scope.myPageData.searchPhrase;
		pageData['title'] = $scope.pageTitle;
	
		pageData['links'] = $scope.pageLinks;

		pageData['domRules'] = $scope.domRules;

		return pageData;

	}
	
	$scope.addRulesRow = function () {
        var data = $scope.gridRulesConfig.getData();
        data.push(
            {
                $added: true,
                $editable: true
            }
        );
        $scope.gridRulesConfig.options.pageNum = Math.floor(data.length / $scope.gridRulesConfig.options.pageSize);
    };
	
	
	 $scope.javaScriptCrawler = function() {
     	window.location.href = "/JavaScriptCrawler";
     };
     $scope.htmlCrawler = function() {
     	window.location.href = "/";
     };
	
	
	$scope.init();
	
})
