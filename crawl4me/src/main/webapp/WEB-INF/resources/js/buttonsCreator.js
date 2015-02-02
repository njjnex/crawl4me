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

		var requestMap = {}
		requestMap["url"] = url;
		requestMap["regex"] = regex;
		var map = {}
		requestMap["domRules"] = map;
		map[domRuleName1] = domRuleValue1;
		if (domRuleName2 && domRuleValue2)
			map[domRuleName2] = domRuleValue2;
		if (domRuleName3 && domRuleValue3)
			map[domRuleName3] = domRuleValue3;
		if (domRuleName4 && domRuleValue4)
			map[domRuleName4] = domRuleValue4;
		
		return requestMap;
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