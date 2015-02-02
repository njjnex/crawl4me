/**
 *  Open Websocket connection and subscribe/unsubscribe to the topics
 */
var stompClient = null;
var returnedResultCount = 0;

	function connect() {
		
		var socket = new SockJS('http://scrapingon-me2by.rhcloud.com:8000/crawler');
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

	