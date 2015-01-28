function generateId() {
		var text = "";
		var possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

		for (var i = 0; i < 5; i++)
			text += possible
					.charAt(Math.floor(Math.random() * possible.length));

		return text;
	}

	function saveTemplate() {
		$.ajax({
			type : "post",
			url : "/saveState/" + generateId(),
			cache : false,
			contentType : "application/json",
			data : JSON.stringify(createRequestMap()),
			success : function(data) {
				scanTemplate(data)
			},
			error : function() {
				alert('Error while request..');
			}
		});
	}

	function scanTemplate(data) {
		var divTemplate = document.getElementById("saveTemplate");
		var button = document.getElementById("saveTemplateButton");
		button.setAttribute("class", "btn btn-success disabled");
		button.innerHTML = "Link to your scan:";
		
		var saveLink = document.getElementById("saveTemplateLink");
		var input = document.createElement("input");
		input.setAttribute("class", "form-control");
		saveLink.appendChild(input);
		input.setAttribute("value", "http://scrapingon.com/s" + data);
	}