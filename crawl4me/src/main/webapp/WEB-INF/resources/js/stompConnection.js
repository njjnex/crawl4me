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
		/*console.log("data from connector " + JSON.stringify(angular.element(getAngularScope().sendPageData())[0]));*/
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
function createNewScanButton() {
	var button = document.getElementById("scanButton");
	button.innerHTML = "Clear result and start new scan.";
	button.setAttribute("class", "btn btn-lg btn-warning");
	button.setAttribute("onclick", "clearLastScan();");
}
function clearLastScan() {
	createScanButton();
	returnedResultCount = 0;
	resultFounded = 0;
}

function emailShow() {
	var footer = document.getElementById("emailMe");
	footer.innerHTML = "njjnex@gmail.com";
}
