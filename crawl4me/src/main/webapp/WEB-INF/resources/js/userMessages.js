	function postMessage() {
		$.ajax({
			type : "post",
			url : "/postMessage",
			cache : false,
			contentType : "application/json",
			data : JSON.stringify(document.getElementById("message").value),
			success : function(data) {
				console.log(data);
				if(data != null)createPost(data);
			},
			error : function() {
				alert('Error while posting message');
			}
		});
	}
	function createPost(data){
	    var messageBoard = document.getElementById("messageBoard");
		messageBoard.innerHTML = null;
		 for (var i=0;i<data.length;i++) {
	                
	        var author = data[i].author;
            var date = data[i].date;
            var text = data[i].text;
           
            var messagePost = document.createElement("div");
            messagePost.setAttribute("class","media");
            
            var aMedia = document.createElement("a");
            aMedia.setAttribute("class","pull-left");
            aMedia.setAttribute("href","#");
            messagePost.appendChild(aMedia);
            
            var aImage = document.createElement("img");
            aImage.setAttribute("class","media-object");
            aImage.setAttribute("src","../resources/web/img/template.png");
            aMedia.appendChild(aImage);
            
            var messageBody = document.createElement("div");
            messageBody.setAttribute("class","media-body");
            messagePost.appendChild(messageBody);

            var authorElement = document.createElement("h4");
            authorElement.setAttribute("class", "media-heading");
            authorElement.innerHTML = author;
            

            var dateElement = document.createElement("small");
            dateElement.innerHTML = date;
            authorElement.appendChild(dateElement);
            messageBody.appendChild(authorElement);
            
            var content = document.createTextNode(JSON.parse(text));
            messageBody.appendChild(content);
                   
            
            messageBoard.appendChild(messagePost);
		 }
  }