<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%
try {
    response.setHeader("Cache-Control","no-cache");
    response.setHeader("Cache-Control","no-store");
    response.setHeader("Pragma","no-cache");
    response.setDateHeader ("Expires", 0);
    if (session.getAttribute("name")==null) {
        response.sendRedirect("login.jsp");
    }
    else {}
}
catch(Exception ex) {
    out.println(ex);
}
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Add Dentist</title>
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

<!-- Font Icon -->
<link rel="stylesheet"
	href="fonts/material-icon/css/material-design-iconic-font.min.css">
<style>
body {
	background: linear-gradient(0deg, rgba(115, 245, 158, 0.2502043053549545)
		0%, rgba(171, 227, 255, 0.8608485630580357) 100%);background-position: center center;
    background-repeat: no-repeat;
    background-attachment: fixed;
    background-size: cover;
}
</style>
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<a href="mainMenuAdmin.jsp" class="navbar-brand"> <img
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
					href="vieweditpatient.jsp?id=<%=request.getParameter("id")%>">Back</a></li>
			</ul>
		</div>
	</nav>
	
	<section>
		<div class="main">
			<div class="container-contact100">
				<div class="wrap-contact100">
					<div class="contact100-form-title"
						style="background-image: url(img/bg-01.jpg);">
						<span class="contact100-form-title-1"> Add Historical Record
							Form </span>
					</div>

					<form class="contact100-form validate-form" action="AddHistoricalRecord"
						method="post" id="register-form">
						<input type="hidden" id="custid" name="custid" value="<%=request.getParameter("id") %>">
						<input type="hidden" id="status" value="<%=request.getAttribute("status")%>">
						
						<p><b>Medical History:</b></p>
						<div class="wrap-input100 validate-input"
							data-validate="Medical record is required">
							<span class="label-input100"><i
								class="zmdi zmdi-account material-icons-name"></i></span> <input
								class="input100" type="text" name="history" id="history"
								placeholder="Enter medical record"> <span class="focus-input100"></span>
						</div>
						
						<p><b>Medical History Date:</b></p>
						<div class="wrap-input100 validate-input"
							data-validate="Medical record date is required">
							<span class="label-input100"><i class="zmdi zmdi-calendar"></i></span>
							<input class="input100" type="date" name="historyDate" id="historyDate"
								placeholder="Enter Date"> <span
								class="focus-input100"></span>
						</div>
						
						<p><b>Medical History Description:</b></p>
						<div class="wrap-input100 validate-input"
							data-validate="Description for medical record is required">
							<span class="label-input100"><i
								class="zmdi zmdi-account-box-mail"></i></span> <input class="input100"
								type="text" name="description" id="description"
								placeholder="Enter medical record description"> <span
								class="focus-input100"></span>
						</div>
									
						<div class="container-contact100-form-btn">
							<button class="contact100-form-btn btn-update">
								<span> Submit <i class="fa fa-long-arrow-right m-l-7"
									aria-hidden="true"></i>
								</span>
							</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</section>


	<!-- JS -->
	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="js/main.js"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<link rel="stylesheet" href="alert/dist/sweetalert.css">
	<script type="text/javascript">
	var id = document.getElementById("custid").value;
	var status = document.getElementById("status").value;
	console.log(status);
	if (status == "success") {
		swal("Success", 
			"Successfully added historical record.", 
			"success"
			).then((placeholder) => {
				window.location.href = "vieweditpatient.jsp?id=" + id;
			});
	}
	else if(status == "error"){
		swal("Sorry","An error occured when trying to add historical record.","error");
	}
</script>
</body>
</html>