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
	    	console.log(" default location: " + $location.path());
	    	$scope.explorePage("htmlDefault");
	    	
	    } 
	    if ($location.path() == "/JavaScriptCrawler") {
	    	console.log(" default location: " + $location.path());
	    	$scope.explorePage("jsDefault");
	    	
	    } 
	} 
	
	$scope.urlData = "http://www.ebay.com";
		
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
	
})
