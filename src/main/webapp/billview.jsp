<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
try {
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
	if (session.getAttribute("name") == null) {
		response.sendRedirect("login.jsp");
	} else {
	}
} catch (Exception ex) {
	out.println(ex);
}
%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<link
	href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">
<script
	src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/adddataform.css">
<link rel="stylesheet" type="text/css" href="css/adddatafrm1.css">
<link rel="stylesheet" type="text/css" href="css/table.css">
<title>Generate Bill</title>

<style>
body {
	background: linear-gradient(0deg, rgba(115, 245, 158, 0.2502043053549545)
		0%, rgba(171, 227, 255, 0.8608485630580357) 100%);
	background-position: center center;
	background-repeat: no-repeat;
	background-attachment: fixed;
	background-size: cover;
}

label {
	margin: 0;
	font: normal normal normal 14px/1 'Material-Design-Iconic-Font';
	font-size: 18px;
	position: relative;
	top: 10px;
}
</style>


</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<a href="#" class="navbar-brand"> <img
			src="img/dentalrecordsicon-small.png" height="40" width="40"
			alt="DentalRecordManagementSystem">
		</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item active"><a class="nav-link"
					href="mainMenuAdmin.jsp"> Home <span class="sr-only">(current)</span></a></li>
				<li class="nav-item active"><a class="nav-link"
					href="generatedBills.jsp"> Billing History <span class="sr-only">(current)</span></a></li>
					<li class="nav-item active"><a class="nav-link"
					href="billview.jsp"> Create Bill <span class="sr-only">(current)</span></a></li>
			</ul>
		</div>
	</nav>

	<section>
		<div class="container">

			<div class="w-100">

				<form id="formId" action="billview" class="w-100 d-flex">

					<input type="hidden" id="status" name="status" value="${status}">
					<label for="birthday">From</label> <input type="date" id="idFrom"
						class="mx-3 px-2 border rounded" name="fromDate"
						value="${fromDate}" onchange="onDateChange()"> <label
						for="birthday">To</label> <input type="date" id="idTo"
						class="mx-3 w-25 px-2 border rounded" name="toDate"
						value="${toDate}" onchange="onDateChange(true)"> <input
						id="col1Id" type="text" class="mx-3 w-25 px-2 border rounded"
						name="col1" value="${col1}" placeholder="Search here...">

								<select name="paymentStatus" id="paymentStatus" style="font-family: Poppins-Regular" required>
								<option value="">Select Status</option>
									<option value="paid" >Paid</option>
									<option value="pending" >Pending </option> 
									</select>
								<input style="font: normal normal normal 14px/1 'Material-Design-Iconic-Font'; font-size: 18px;" id="idSubmit" type="submit" class="btn btn-info mx-2"
						${(empty fromDate and not empty toDate) or (not empty fromDate and empty toDate) ? "disabled" : ""}>
					<button style="font: normal normal normal 14px/1 'Material-Design-Iconic-Font'; font-size: 18px;" id="clearBtn" type="button" class="btn btn-secondary mx-3">Clear</button>
				</form>
			</div>

			<form>
				<table class="table mt-4 borderless-right">
					<tr class="borderless">
						<th scope="col">Bill ID</th>
						<th scope="col">Name</th>
						<th scope="col">Date of Bill</th>
						<td scope="col" class="borderless">
							<div class="form-check">
								<input class="form-check-input" id="selectAll" type="checkbox" />
								<label style="font-size: 16px;"class="form-check-label" for="selectAll">select all</label>
							</div>
						</td>
					</tr>
					<c:if test="${not empty list}">
						<c:forEach items="${list}" var="element">
							<tr class="borderless" scope="row">
								<td>${element.idbillHistory}</td>
								<td>${element.customerName}</td>
								<td>${element.billingDate}</td>
								<td class="borderless"><input
									value="${element.idbillHistory}" name="includeList"
									type="checkbox" /></td>
							</tr>
						</c:forEach>
					</c:if>

					<c:if test="${empty list}">
						<tr class="borderless">
							<td colspan="3">Your search criteria does not have matching
								records</td>
						</tr>
					</c:if>
				</table>
				
				<div class="container w-100 text-center">
					<button style="font: normal normal normal 14px/1 'Material-Design-Iconic-Font'; font-size: 18px;" type="submit" class="btn btn-info mt-3 w-50">Send
						Email to selected customers</button>
				</div>
				

			</form>
		</div>

	</section>

	<script type="text/javascript">
		function clear() {
			document.getElementById('idFrom').value = "";
			document.getElementById('idTo').value = "";
			document.getElementById('col1Id').value = "";
			document.getElementById('formId').submit();
		}
		function onDateChange() {
			let fromEl = document.getElementById('idFrom');
			let toEl = document.getElementById('idTo');
			let submitEl = document.getElementById('idSubmit');
			let onlyOneIsFilled = (fromEl.value && !toEl.value)
					|| (!fromEl.value && toEl.value);
			let bothAreEmpty = !fromEl.value && !toEl.value;
			let bothFilled = fromEl.value && toEl.value;
			let validComination = bothFilled
					&& new Date(fromEl.value).getTime() <= new Date(toEl.value)
							.getTime()
			submitEl.disabled = (!fromEl.value || !toEl.value || new Date(
					fromEl.value).getTime() > new Date(toEl.value).getTime());
			submitEl.disabled = onlyOneIsFilled
					|| (bothFilled && !validComination);
		}
		document.addEventListener("DOMContentLoaded", function() {
			document.getElementById("idFrom").addEventListener('change',
					onDateChange);
			document.getElementById("idTo").addEventListener('change',
					onDateChange);
			document.getElementById("clearBtn")
					.addEventListener('click', clear);
			document.getElementById("selectAll").addEventListener(
					'change',
					function() {
						let includeList = document
								.getElementsByName("includeList");
						for ( var i in includeList) {
							includeList[i].checked = this.checked;
						}
					});
		});
	</script>

	<!-- Copyright Section-->
	<div class="copyright py-4 text-center text-white">
		<div class="container">
			<small>Copyright &copy; FYP-22-S2-20 2022</small>
		</div>
	</div>

	<!-- Bootstrap core JS-->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<!-- Core theme JS-->
	<script src="js/scripts.js"></script>
	<script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>
	<script src="vendor/jquery/jquery.min.js"></script>
	<!-- jquery CDN -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

	<!-- JS -->
	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="js/main.js"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<link rel="stylesheet" href="alert/dist/sweetalert.css">
	<script type="text/javascript">
	
		console.log("status: " + document.getElementById("status").value);
		var status = document.getElementById("status").value;
		if (status == "success") {
			swal("Success", 
				"Successfully sent bill(s)!", 
				"success"
				);
		}
		
	</script>
	
</body>
</html>