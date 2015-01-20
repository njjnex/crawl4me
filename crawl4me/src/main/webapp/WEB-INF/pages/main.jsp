<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/jquery.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/json2.js"></script>
<!-- bootstrap -->
<link
	href="${pageContext.request.contextPath}/resources/bootstrap/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="${pageContext.request.contextPath}/resources/bootstrap/bootstrap/js/bootstrap.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/bootstrap/bootstrap/js/bootstrap-collapse.js"></script>
<!-- end bootstrap -->
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script
	src="${pageContext.request.contextPath}/resources/js/sockjs-0.3.4.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/stomp.js"></script>
<script type="text/javascript">
	var stompClient = null;
	
	function connect() {
		var socket = new SockJS('/hello');
		stompClient = Stomp.over(socket);
		stompClient.connect({}, function(frame) {
			console.log('Connected: ' + frame);
			var returnedResultCount = 0;
			stompClient.subscribe('/topic/greetings', function(greeting) {
				console.log(greeting.body);
				var result = JSON.parse(greeting.body);
				returnedResultCount++;
				console.log(result.content  + " 2");
				if (returnedResultCount == 1) {
					createResultTable(result);
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
	function sendName() {
		
		removeResultTable();
		
		var url = document.getElementById('url').value;
		var regex = document.getElementById('regex').value;
		
		var domRuleName1 = document.getElementById('domRuleName1').value;
		var domRuleName2 = document.getElementById('domRuleName2').value;
		var domRuleValue1 = document.getElementById('domRuleValue1').value;
		var domRuleValue2 = document.getElementById('domRuleValue2').value;
		console.log(domRuleName1 +':' + domRuleValue1);
		
		var item = {}
		item ["url"] = url;
		item ["regex"] =regex;
		var map = {}
		item ["domRules"] = map;
		map [domRuleName1] = domRuleValue1;
		if(domRuleName2 && domRuleValue2) map [domRuleName2] = domRuleValue2;
		
		stompClient.send("/app/hello", {}, JSON.stringify(item));
	}

	function removeResultTable(){
		var tbl = document.getElementById("table");
        if(tbl) tbl.parentNode.removeChild(tbl);

	}
	function createResultTable(result) {
		var resultDiv = document.getElementById("resultTable");
		var table = document.createElement("table");
		table.setAttribute("class", "table table-striped, table-bordered");
		table.setAttribute("id", "table");
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
		var table = document.getElementById("table");
		var row = table.insertRow(-1);
		var cell = row.insertCell(-1);
		cell.innerHTML = returnedResultCount;

		for ( var key in result) {
			cell = row.insertCell(-1);
			cell.innerHTML = result[key];
		}
	}
</script>

</head>
<script type="text/javascript">
	function madeAjaxCall() {
		sendName();
		$.ajax({
			type : "post",
			url : "http://localhost:8080/postMessage",
			cache : false,
			data : 'url=' + $("#url").val() + "&regex=" + $("#regex").val()
					+ "&domRuleName1=" + $("#domRuleName1").val()
					+ "&domRuleValue1=" + $("#domRuleValue1").val()
					+ "&domRuleName2=" + $("#domRuleName2").val()
					+ "&domRuleValue2=" + $("#domRuleValue2").val(),
			success : function(data) {
				$('#result').html("");
				console.log(data);

				for ( var key in data) {
					console.log(key + ': ' + data[key]);
				}
				$('#result').html("Result </br>Key:- ");

			},
			error : function() {
				alert('Error while request..');
			}
		});
	}
</script>
<body>
	<div class="container-fluid">
		<section class="container">
		<div class="container-page">
			<div name="scan-form">
				<div class="col-md-6">
					<h3 class="dark-grey">Registration</h3>

					<div class="form-group col-lg-12">
						<label>URL</label> <input type="url" name="url" id="url"
							class="form-control" value="http://www.21vek.by/3d_glasses/samsung_ssgp51002.html">
					</div>

					<div class="form-group col-lg-12">
						<label>Regex</label> <input type="text" name="regex" id="regex"
							class="form-control" value="http://www.21vek.by/3d_glasses/samsung_ssgp51002.html">
					</div>

					<div class="col-sm-6">
						<label>Name1</label> <input type="text" name="domRuleName1"
							id="domRuleName1" class="form-control" value="Item">
					</div>

					<div class="col-sm-6">
						<label>Value1</label> <input type="text" name="domRuleValue1"
							id="domRuleValue1" class="form-control"
							value="div[class=content__header]">
					</div>
					<div class="col-sm-6">
						<label>Name2</label> <input type="text" name="domRuleName2"
							id="domRuleName2" class="form-control" value="Price">
					</div>

					<div class="col-sm-6">
						<label>Value2</label> <input type="text" name="domRuleValue2"
							id="domRuleValue2" class="form-control"
							value="span[itemprop=price]">
					</div>

				</div>

				<div class="col-md-6">
					<h3 class="dark-grey">Terms and Conditions</h3>
					<p>By clicking on "Register" you agree to The Company's' Terms
						and Conditions</p>
					<p>While rare, prices are subject to change based on exchange
						rate fluctuations - should such a fluctuation happen, we may
						request an additional payment. You have the option to request a
						full refund or to pay the new price. (Paragraph 13.5.8)</p>
					<p>Should there be an error in the description or pricing of a
						product, we will provide you with a full refund (Paragraph 13.5.6)
					</p>
					<p>Acceptance of an order by us is dependent on our suppliers
						ability to provide the product. (Paragraph 13.5.6)</p>

					<button class="btn btn-primary" onclick="madeAjaxCall();"
						value="Add scan">New scan</button>
				</div>
			</div>
		</div>
		</section>
	</div>

	<div class="col-md-6">
		<div class="table-responsive" id="resultTable"></div>
	</div>
		<script type="text/javascript">connect();</script>
</body>
</html>