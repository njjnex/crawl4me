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

<script src="${pageContext.request.contextPath}/resources/js/sockjs-0.3.4.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/stomp.js"></script>
<script type="text/javascript">
	var stompClient = null;
	function setConnected(connected) {
		document.getElementById('connect').disabled = connected;
		document.getElementById('disconnect').disabled = !connected;
		document.getElementById('conversationDiv').style.visibility = connected ? 'visible'
				: 'hidden';
		document.getElementById('response').innerHTML = '';
	}
	function connect() {
		var socket = new SockJS('/hello');
		stompClient = Stomp.over(socket);
		stompClient.connect({}, function(frame) {
			setConnected(true);
			console.log('Connected: ' + frame);
			stompClient.subscribe('/topic/greetings', function(greeting) {
				showGreeting(JSON.parse(greeting.body).content);
			});
		});
	}
	function disconnect() {
		stompClient.disconnect();
		setConnected(false);
		console.log("Disconnected");
	}
	function sendName() {
		var name = document.getElementById('name').value;
		stompClient.send("/app/hello", {}, JSON.stringify({
			'name' : name
		}));
	}
	function showGreeting(message) {
		var response = document.getElementById('response');
		var p = document.createElement('p');
		p.style.wordWrap = 'break-word';
		p.appendChild(document.createTextNode(message));
		response.appendChild(p);
	}
</script>

</head>
<script type="text/javascript">
	function madeAjaxCall() {
		$.ajax({
			type : "post",
			url : "http://localhost:8080/crawl4me/postMessage",
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
				$('#result').html(
						"Result" + ': ' + data.result[key] + "</br>Key:- "
								+ data[key]);

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
							class="form-control" value="http://www.21vek.by/tv/">
					</div>

					<div class="form-group col-lg-12">
						<label>Regex</label> <input type="text" name="regex" id="regex"
							class="form-control" value="http://www.21vek.by/tv/.*.html">
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

	<div id="result"></div>


	<div>
		<div>
			<button id="connect" onclick="connect();">Connect</button>
			<button id="disconnect" disabled="disabled" onclick="disconnect();">Disconnect</button>
		</div>
		<div id="conversationDiv">
			<label>What is your name?</label><input type="text" id="name" />
			<button id="sendName" onclick="sendName();">Send</button>
			<p id="response"></p>
		</div>
	</div>
</body>
</html>