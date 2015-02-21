function removeResultTable() {
	var tbl = document.getElementById("resultTable");
	if (tbl) tbl.innerHTML = "";
}
function removeResultConsole() {
	var console = document.getElementById("consoleBody");
	console.innerHTML = "<p>Scanning output console...</p><p>Connecting....</p>"

}

function createResultTable(result) {
			
	/*var resultDiv = document.getElementById("resultTableDiv");
	var table = document.createElement("table");
	table.setAttribute("class", "table table-striped");
	table.setAttribute("id", "resultTable");
	resultDiv.appendChild(table);*/
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

function addResultRow(result, returnedResultCount) {

	for (var i = 0; i < result[1].values.length; i++) {
		returnedResultCount++
		var table = document.getElementById("resultTable");
		if (!table)
			var table = createResultTable(result);
		var row = table.insertRow(-1);
		var cell = row.insertCell(-1);
		cell.innerHTML = returnedResultCount;

		for (var k = 0; k < result.length; k++) {
			cell = row.insertCell(-1);
			cell.innerHTML = result[k].values[i];
		}
	}
	return returnedResultCount;
}

function consoleOutput(result) {
	var console = document.getElementById("consoleBody");
	var p = document.createElement(p);
	p.innerHTML = "- " + result + "<br>";
	console.appendChild(p);
}