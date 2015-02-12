/**
 *  Open Websocket connection and subscribe/unsubscribe to the topics
 */
var stompClient = null;
var returnedResultCount = 0;

	function connect() {
		
		/*var socket = new SockJS('http://scrapingon-me2by.rhcloud.com:8000/crawler');*/
		var socket = new SockJS('/crawler');
		stompClient = Stomp.over(socket);
		stompClient.connect({}, function(frame) {
			console.log('Connected: ' + frame);
								
			stompClient.subscribe('/user/topic/console', function(logOut) {
				var resultLog = JSON.parse(logOut.body);
				consoleOutput(resultLog.result);
			});
			stompClient.subscribe('/user/topic/result', function(resultOut) {
				console.log(resultOut.body);
				var result = JSON.parse(resultOut.body);
				returnedResultCount++;
				if (returnedResultCount == 1) {
					createResultTable(result);
					console.log("Create result table");
				}
				addResultRow(result, returnedResultCount);

			});
		});
	}
	function disconnect() {
		stompClient.disconnect();
		setConnected(false);
		console.log("Disconnected");
	}
	function newScan() {
		createNewScanButton();
		removeResultConsole();
		removeResultTable();
		window.location.replace("#jump4");
		stompClient.send("/app/crawler", {}, JSON.stringify(createRequestMap()));
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
