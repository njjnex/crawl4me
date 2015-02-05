function removeResultTable() {
		var tbl = document.getElementById("resultTable");
		if (tbl) tbl.parentNode.removeChild(tbl);
	}
	function removeResultConsole() {
		var console = document.getElementById("consoleBody");
		console.innerHTML = "<p>Scanning output console...</p>"
		
	}
	function createResultTable(result) {
		var resultDiv = document.getElementById("resultTableDiv");		
		var table = document.createElement("table");						
		table.setAttribute("class","table table-striped");				
		table.setAttribute("id","resultTable");
		resultDiv.appendChild(table);
		var tableHeader = table.createTHead();
		var row = tableHeader.insertRow(0);
		
		var cell = row.insertCell();
		cell.innerHTML = "#";
		for ( var key in result) {
			var cell = row.insertCell();
			cell.innerHTML = key;
		}
	}

	function addResultRow(result, returnedResultCount) {
		var table = document.getElementById("resultTable");
		if(!table) var table = createResultTable(result);
		var row = table.insertRow(-1);
		var cell = row.insertCell(-1);
		cell.innerHTML = returnedResultCount;

		for ( var key in result) {
			cell = row.insertCell(-1);
			cell.innerHTML = result[key];
		}
	}

	function consoleOutput(result){
		var console = document.getElementById("consoleBody");
		var p = document.createElement(p);
		p.innerHTML = "- " + result + "<br>";
		console.appendChild(p);	
	}
		
	function createScanButton(){
		
		if(document.getElementById("legalAlert")) document.getElementById("legalAlert").remove();
		var buttonDiv = document.getElementById("scanStarter");
		if(document.getElementById("scanButton")) document.getElementById("scanButton").remove();
		if(!document.getElementById("scanButton")) var button = document.createElement("button");
		button.setAttribute("class","btn btn-outline btn-lg ");
		button.setAttribute("id","scanButton");
		button.setAttribute("onclick","newScan();");
		button.innerHTML = "Start scan";
		buttonDiv.appendChild(button);
	}
	function createNewScanButton(){
		var button = document.getElementById("scanButton");
		button.innerHTML = "New scan";
		button.setAttribute("class","btn btn-lg btn-warning");
		button.setAttribute("onclick","clearLastScan();");
	}
	function clearLastScan(){
		createScanButton();
		returnedResultCount = 0;
			
		
	}
	function emailShowMe(){
		var footer = document.getElementById("showEmail");
		footer.innerHTML = "njjnex@gmail.com";

	}
	function emailShow(){
		var footer = document.getElementById("footer");
		var email = document.createTextNode("njjnex@gmail.com");
		footer.appendChild(email);

	}