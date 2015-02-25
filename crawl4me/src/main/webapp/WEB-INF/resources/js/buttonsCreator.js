

function createScanButton() {

	if (document.getElementById("legalAlert"))
		document.getElementById("legalAlert").remove();
	var buttonDiv = document.getElementById("scanStarter");
	if (document.getElementById("scanButton"))
		document.getElementById("scanButton").remove();
	if (!document.getElementById("scanButton"))
		var button = document.createElement("button");
	button.setAttribute("class", "btn btn-outline btn-lg ");
	button.setAttribute("id", "scanButton");
	button.setAttribute("type", "button");
	button.setAttribute("onclick", "return newScan();");
	button.innerHTML = "Scrap it.";
	buttonDiv.appendChild(button);
}
function createNewScanButton() {
	var button = document.getElementById("scanButton");
	button.innerHTML = "New scan";
	button.setAttribute("class", "btn btn-lg btn-warning");
	button.setAttribute("onclick", "clearLastScan();");
}
function clearLastScan() {
	createScanButton();
	returnedResultCount = 0;

}
function emailShowMe() {
	var footer = document.getElementById("showEmail");
	footer.innerHTML = "njjnex@gmail.com";

}
function emailShow() {
	var footer = document.getElementById("footer");
	var email = document.createTextNode("njjnex@gmail.com");
	footer.appendChild(email);

}