/**
 *  Open Websocket connection and subscribe/unsubscribe to the topics
 */
var stompClient = null;
var connected = false;
var valuesLength = 0;
var resultFounded = 0;

	function connect() {
		
		var socket = new SockJS('http://scrapingon-me2by.rhcloud.com:8000/crawler');
		/*var socket = new SockJS('/crawler');*/
		stompClient = Stomp.over(socket);
		stompClient.connect({}, function(frame) {
			console.log('Connected localhost');
			connected = true;
								
			stompClient.subscribe('/user/topic/console', function(logOut) {
				var resultLog = JSON.parse(logOut.body);
				consoleOutput(resultLog.result);
			});
			stompClient.subscribe('/user/topic/result', function(resultOut) {
				var result = JSON.parse(resultOut.body);
				
				if (resultFounded == 0) {
					
					createResultTable(result);
				}
				
				resultFounded = addResultRow(result, resultFounded);
				
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
		// update the model with a wrap in $apply(fn) which will refresh the view for us
		
		return scope;
	}
	
	function newScan() {
				
		resultFounded = 0;
		removeResultConsole();
		removeResultTable();
		window.location.replace("#scanning-result");
	
		if(!connected){
			connect();
			setTimeout(function(){stompClient.send("/app/crawler", {}, JSON.stringify(angular.element(getAngularScope().sendPageData()))[0])}, 2000);
		}else{
			stompClient.send("/app/crawler", {}, JSON.stringify(angular.element(getAngularScope().sendPageData())[0]));
		}
		
	}

function createScanButton() {

	if (document.getElementById("scanButton")){
		var button = document.getElementById("scanButton");
		button.setAttribute("class", "btn btn-lg btn-default");
		button.setAttribute("onclick", "return newScan();");
		button.innerHTML = "Scrap it.";
	}
}


function emailShow() {
	var footer = document.getElementById("emailMe");
	footer.innerHTML = "njjnex@gmail.com";
}

function removeResultTable() {
	var tbl = document.getElementById("resultTable");
	if (tbl) tbl.innerHTML = "";
}
function removeResultConsole() {
	var console = document.getElementById("consoleBody");
	console.innerHTML = "<p>Scanning output console...</p><p>Connecting....</p>"

}

function createResultTable(result) {
	resultFounded++;
	var table = document.getElementById("resultTable");
	var tableHeader = table.createTHead();
	var row = tableHeader.insertRow(0);

	var cell = row.insertCell();
	cell.innerHTML = "#";

	for (var i = 0; i < result.length; i++) {
		var cell = row.insertCell();
		cell.innerHTML = result[i].key;
	}
}

function addResultRow(result, resultFounded) {
	
	if(result[0].values.length >= result[1].values.length){
		valuesLength = result[0].values.length;
	}else{
		valuesLength = result[1].values.length;
	}
	
	for (var i = 0; i < valuesLength; i++) {
		resultFounded++
		var table = document.getElementById("resultTable");
		if (!table)
			var table = createResultTable(result);
		var row = table.insertRow(-1);
		var cell = row.insertCell(-1);
		cell.innerHTML = resultFounded-1;

		for (var k = 0; k < result.length; k++) {
			cell = row.insertCell(-1);
			cell.innerHTML = result[k].values[i];
		}
	}
return resultFounded;
}

function consoleOutput(result) {
	var console = document.getElementById("consoleBody");
	var p = document.createElement(p);
	p.innerHTML = "- " + result + "<br>";
	console.appendChild(p);
}
