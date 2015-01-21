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

<title>Insert title here</title>

<script
	src="${pageContext.request.contextPath}/resources/js/sockjs-0.3.4.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/stomp.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/stompConnection.js"></script>

</head>
<script type="text/javascript">
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

				$('#result').html("Template saved as " + data);
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
		button.innerHTML = "Saved as:";
	
		var input = document.createElement("input");
		input.setAttribute("class", "form-control");
		divTemplate.appendChild(input);
		input.setAttribute("value", "http://crawl4me.net/" + data);

	}
</script>
<body>
	<div class="container-fluid">
		<section class="container">
		<div class="container-page">
			<div name="scan-form">
				<div class="col-md-6">
					<h3 class="dark-grey">Scan</h3>

					<div class="form-group col-lg-12">
						<label>URL</label> <input type="url" name="url" id="url"
							class="form-control" value="www.me2.by">
					</div>

					<div class="form-group col-lg-12">
						<label>Regex</label> <input type="text" name="regex" id="regex"
							class="form-control" value="www.me2.by/.*">
					</div>

					<div class="col-sm-6">
						<label>Name1</label> <input type="text" name="domRuleName1"
							id="domRuleName1" class="form-control" value="Title">
					</div>

					<div class="col-sm-6">
						<label>Value1</label> <input type="text" name="domRuleValue1"
							id="domRuleValue1" class="form-control" value="title">
					</div>
					<div class="col-sm-6">
						<label>Name2</label> <input type="text" name="domRuleName2"
							id="domRuleName2" class="form-control" value="">
					</div>

					<div class="col-sm-6">
						<label>Value2</label> <input type="text" name="domRuleValue2"
							id="domRuleValue2" class="form-control" value="">
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

					<button class="btn btn-primary" onclick="newScan();"
						value="Add scan">New scan</button>
					<br><br>
					<div class="input-group" id="saveTemplate">
						<span class="input-group-btn">
							<button class="btn btn-primary" id="saveTemplateButton"
								onclick="saveTemplate();" value="Add scan">Save this
								scan</button>
						</span>
						<!-- <input type="text" class="form-control"
						placeholder="Search for..."> -->
					</div>
				</div>
			</div>
		</div>
		</section>
	</div>
	<br>
	<br>
	<div class="col-md-6">
		<div class="table-responsive" id="resultTable"></div>
	</div>

	<div class="col-md-6">
		<div class="panel panel-primary" id="console">
			<div class="panel-heading">Console output</div>
			<div class="panel-body" id="console"></div>
		</div>
	</div>




	<script type="text/javascript">
		connect();
	</script>
</body>
</html>