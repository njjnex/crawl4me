/**
 *  Open Websocket connection and subscribe/unsubscribe to the topics
 */
var stompClient = null;
var connected = false;
var returnedResultCount = 0;
var resultFounded = 0;

	function connect() {
		
		/*var socket = new SockJS('http://scrapingon-me2by.rhcloud.com:8000/crawler');*/
		var socket = new SockJS('/crawler');
		stompClient = Stomp.over(socket);
		stompClient.connect({}, function(frame) {
			console.log('Connected: ' + frame);
			connected = true;
								
			stompClient.subscribe('/user/topic/console', function(logOut) {
				var resultLog = JSON.parse(logOut.body);
				consoleOutput(resultLog.result);
			});
			stompClient.subscribe('/user/topic/result', function(resultOut) {
				console.log(resultOut.body);
				var result = JSON.parse(resultOut.body);
				console.log("result" + result);
				returnedResultCount = resultFounded;
				if (returnedResultCount == 0) {
					createResultTable(result);
					console.log("Create result table");
				}
				
				resultFounded = addResultRow(result, returnedResultCount);
				
			});
		});
	}
	function disconnect() {
		stompClient.disconnect();
		setConnected(false);
		console.log("Disconnected");
	}
	
	function getAngularScope(){
		// get Angular scope from the known DOM element
		e = document.getElementById('crawlerPage');
		scope = angular.element(e).scope();
		console.log(e + " ----- " + scope);
		// update the model with a wrap in $apply(fn) which will refresh the view for us
		
		return scope;
	}
	
	function newScan() {
		
		
				
		createNewScanButton();
		removeResultConsole();
		removeResultTable();
		window.location.replace("#scanning-result");
		console.log("data from connector " + JSON.stringify(angular.element(scope.sendPageData())[0]));
		if(!connected){
			connect();
			setTimeout(function(){stompClient.send("/app/crawler", {}, JSON.stringify(angular.element(getAngularScope().sendPageData()))[0])}, 2000);
		}else{
			stompClient.send("/app/crawler", {}, JSON.stringify(angular.element(getAngularScope().sendPageData())[0]));
		}
		
	}

function createRequestMap(){
		
		var url = document.getElementById('url').value;
		var regex = document.getElementById('regex').value;
		
		var domRuleName1 = document.getElementById('domRuleName1').value;
		var domRuleName2 = document.getElementById('domRuleName2').value;
		var domRuleValue1 = document.getElementById('domRuleValue1').value;
		var domRuleValue2 = document.getElementById('domRuleValue2').value;
		if(domRuleName3) var domRuleName3 = document.getElementById('domRuleName3').value;
		if(domRuleName4) var domRuleName4 = document.getElementById('domRuleName4').value;
		if(domRuleValue3) var domRuleValue3 = document.getElementById('domRuleValue3').value;
		if(domRuleValue4) var domRuleValue4 = document.getElementById('domRuleValue4').value;

		var requestMap = {};
		requestMap["url"] = url;
		requestMap["regex"] = regex;
		
		var domRules = [];
		requestMap["domRules"] = domRules;
		
		var domRule1 = {};
		var domRule2 = {};
		var domRule3 = {};
		var domRule4 = {};
	
			domRule1["ruleNumber"] = 1;
			domRule1["key"] = domRuleName1;
			domRule1["value"] = domRuleValue1;
			domRules.push(domRule1);
		if(domRuleName2){
			domRule2["ruleNumber"] = 2;
			domRule2["key"] = domRuleName2;
			domRule2["value"] = domRuleValue2;
			domRules.push(domRule2);
		}	
		if(domRuleName3){	
			domRule3["ruleNumber"] = 3;
			domRule3["key"] = domRuleName3;
			domRule3["value"] = domRuleValue3;
			domRules.push(domRule3);
		}
		if(domRuleName4){
			domRule4["ruleNumber"] = 4;
			domRule4["key"] = domRuleName4;
			domRule4["value"] = domRuleValue4;
			domRules.push(domRule4);
		}	
						
		return requestMap;
}
