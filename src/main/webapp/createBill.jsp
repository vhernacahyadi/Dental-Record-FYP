<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
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
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>View/Edit Applicant</title>
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
	background: linear-gradient(0deg, rgba(115, 245, 204, 0.2726132689403886)
		0%, rgba(64, 163, 172, 0.4490838571756828) 100%);
	background-position: center center;
	background-repeat: no-repeat;
	background-attachment: fixed;
	background-size: cover;
}

.form-title {
	position: relative;
	right: 50px;
	color: #91a5b7;
	font-family: Poppins-Regular;
	margin-top: 10px;
}

#reject-form {
	padding: 0;
	position: absolute;
	top: 88.6%;
	left: 55%;
}

.bill label {
	text-align: left;
	display: inline-block;
}

.form-check input {
	border-bottom: 1px solid black;
}

table, tr, th, td {
	border: none;
}

.head {
	font-size: 20px;
}
</style>
</head>
<body onload="hideFunction()">
	<input type="hidden" id="status"
		value="<%=request.getAttribute("status")%>">
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
					href="mainMenuAssit.jsp">Home <span class="sr-only">(current)</span></a></li>
				<li class="nav-item active"><a class="nav-link"
					href="mainMenuAssit.jsp">Back</a></li>
			</ul>
		</div>
	</nav>

	<%
	Connection con;
	Statement stmt;
	Statement stmt2;
	ResultSet rs;
	ResultSet rs2;
	String id = request.getParameter("id");
	try {
		Class.forName("com.mysql.cj.jdbc.Driver");
		con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dentalrecord?useSSL=false", "root", "passwordroot");
		stmt = con.createStatement();
		stmt2 = con.createStatement();
		String sql = "select * from dentalServices";
		rs = stmt.executeQuery(sql);
		while (rs.next()) {
	%>

	<section>
		<div class="main">
			<div class="container-contact100">
				<div class="wrap-contact100">
					<div class="contact100-form-title"
						style="background-image: url(img/bg-01.jpg);">
						<span class="contact100-form-title-1"> Dental Services </span>
					</div>
					<%
					do {
					%>

					<form class="bill p-2" action="createBill" method="post"
						id="register-form">
						<table class="table table-borderless">
							<tr class="table-borderless">
								<th style="width: 45%; border-top: 0;"
									class="table-light table-borderless text-info">Dental
									Procedure</th>
								<th style="width: 10%; border-top: 0;"
									class="table-light table-borderless text-info">Prices(SGD)</th>
								<th style="width: 45%; border-top: 0;"
									class="table-light table-borderless text-info"></th>
							</tr>
							<tr class="table-borderless">
								<td class="table-borderless"><input type="checkbox"
									name="services" value="1"> <label for="svc1"> <%=rs.getString(2)%></label>
								</td>
								<td><label for="svc1">$<%=rs.getString(3)%></label></td>
								<td></td>
							</tr>
							<%
							rs.next();
							%>
							<tr class="table-borderless">
								<td class="table-borderless" style="border-top: 0;"><input
									type="checkbox" name="services" value="2"> <label
									for="svc2"> <%=rs.getString(2)%></label></td>
								<td style="border-top: 0;"><label for="svc2"> $<%=rs.getString(3)%></label>
								</td>
								<td style="border-top: 0;">
									<div class="form-check">
										<label class="form-check-label">Enter unit amount:</label> <input
											size="5" type="text" name="amt1" id="amt1" value="0"
											placeholder="1">
									</div>
								</td>
							</tr>
							<%
							rs.next();
							%>
							<tr class="table-borderless">
								<td class="table-borderless" style="border-top: 0;"><input
									type="checkbox" name="services" value="3"> <label
									for="svc3"> <%=rs.getString(2)%></label></td>
								<td style="border-top: 0;"><label for="svc3">$<%=rs.getString(3)%></label>
								</td>
								<td style="border-top: 0;">
									<div class="form-check">
										<label>Number extracted:</label> <input size="5" type="text"
											name="amt2" id="amt2" value="0" placeholder="1">
									</div>
								</td>
							</tr>
							<%
							rs.next();
							%>
							<tr class="table-borderless">
								<td class="table-borderless" style="border-top: 0;"><input
									type="checkbox" name="services" value="4"> <label
									for="svc4"> <%=rs.getString(2)%></label></td>
								<td style="border-top: 0;"><label for="svc4">$<%=rs.getString(3)%></label>
								</td>
								<td style="border-top: 0;">
									<div class="form-check">
										<label>Number treated:</label> &emsp;<input size="5"
											type="text" name="amt3" id="amt3" value="0" placeholder="1">
									</div>
								</td>
							</tr>
							<%
							rs.next();
							%>
							<tr class="table-borderless">
								<td class="table-borderless" style="border-top: 0;"><input
									type="checkbox" name="services" value="5"> <label
									for="svc5"> <%=rs.getString(2)%></label></td>
								<td style="border-top: 0;"><label for="svc5">$<%=rs.getString(3)%></label>
								</td>
								<td style="border-top: 0;"></td>
							</tr>
							<%
							rs.next();
							%>
							<tr class="table-borderless">
								<td class="table-borderless" style="border-top: 0;"><input
									type="checkbox" name="services" value="6"> <label
									for="svc6"> <%=rs.getString(2)%></label></td>
								<td style="border-top: 0;"><label for="svc6">$<%=rs.getString(3)%></label>
								</td>
								<td style="border-top: 0;">
									<div class="form-check">
										<label>Number treated:</label> &emsp;<input size="5"
											type="text" name="amt3" id="amt3" value="0" placeholder="1">
									</div>
								</td>
							</tr>
							<%
							rs.next();
							%>
							<tr class="table-borderless">
								<td class="table-borderless" style="border-top: 0;"><input
									type="checkbox" name="services" value="7"> <label
									for="svc7"> <%=rs.getString(2)%></label></td>
								<td style="border-top: 0;"><label for="svc7">$<%=rs.getString(3)%></label>
								</td>
								<td style="border-top: 0;"></td>
							</tr>
							<%
							rs.next();
							%>
							<tr class="table-borderless">
								<td class="table-borderless" style="border-top: 0;"><input
									type="checkbox" name="services" value="8"> <label
									for="svc8"> <%=rs.getString(2)%></label></td>
								<td style="border-top: 0;"><label for="svc8">$<%=rs.getString(3)%></label>
								</td>
								<td style="border-top: 0;">
									<div class="form-check">
										<label>Number treated:</label> &emsp;<input size="5"
											type="text" name="amt4" id="amt4" value="0" placeholder="1">
									</div>
								</td>
							</tr>
							<%
							rs.next();
							%>
							<tr class="table-borderless">
								<td class="table-borderless" style="border-top: 0;"><input
									type="checkbox" name="services" value="9"> <label
									for="svc9"> <%=rs.getString(2)%></label></td>
								<td style="border-top: 0;"><label for="svc9">$<%=rs.getString(3)%></label>
								</td>
								<td style="border-top: 0;"></td>
							</tr>
							<%
							rs.next();
							%>
							<tr class="table-borderless">
								<td class="table-borderless" style="border-top: 0;"><input
									type="checkbox" name="services" value="10"> <label
									for="svc10"> <%=rs.getString(2)%></label></td>
								<td style="border-top: 0;"><label for="svc10">$<%=rs.getString(3)%></label>
								</td>
								<td style="border-top: 0;"></td>
							</tr>
							<%
							rs.next();
							%>
							<tr class="table-borderless">
								<td class="table-borderless" style="border-top: 0;"><input
									type="checkbox" name="services" value="11"> <label
									for="svc11"> <%=rs.getString(2)%></label></td>
								<td style="border-top: 0;"><label for="svc11"> $<%=rs.getString(3)%></label>
								</td>
								<td style="border-top: 0;">
									<div class="form-check">
										<label>Number treated:</label> &emsp;<input size="5"
											type="text" name="amt5" id="amt5" value="0" placeholder="1">
									</div>
								</td>
							</tr>
							<%
							rs.next();
							%>
							<tr class="table-borderless">
								<td style="border-top: 0;" class="table-borderless"><input
									type="checkbox" name="services" value="12"> <label
									for="svc12"> <%=rs.getString(2)%></label></td>
								<td style="border-top: 0;"><label for="svc12"></label></td>
								<td style="border-top: 0;">
									<div class="form-check">
										<label>Enter cost:</label> &emsp;&emsp;&emsp; <input size="5"
											type="text" name="amt6" id="amt6" value="0">
									</div>
								</td>
							</tr>
						</table>

						<p class="head">
							<b>Patient Details</b>
						</p>
						<div class="container px-5">
							<p>
								<b>Name:</b>
							</p>
							<div class="wrap-input100 validate-input"
								data-validate="Name is required">
								<span class="label-input100"><i
									class="zmdi zmdi-account material-icons-name"></i></span> <input
									class="input100" type="text" name="name" id="name"> <span class="focus-input100"></span>
							</div>
							<p>
								<b>Address:</b>
							</p>
							<div class="wrap-input100 validate-input"
								data-validate="Address is required">
								<span class="label-input100"><i class="zmdi zmdi-gps-dot"></i></span>
								<input class="input100" type="text" name="address" id="address"> <span
									class="focus-input100"></span>
							</div>
							<p>
								<b>Contact:</b>
							</p>
							<div class="wrap-input100 validate-input"
								data-validate="Contact is required">
								<span class="label-input100"><i class="zmdi zmdi-phone"></i></span>
								<input class="input100" type="text" name="contact" id="contact"> <span
									class="focus-input100"></span>
							</div>
							<p>
								<b>Email:</b>
							</p>
							<div class="wrap-input100 validate-input"
								data-validate="Valid email is required: ex@abc.xyz">
								<span class="label-input100"><i class="zmdi zmdi-email"></i></span>
								<input class="input100" type="email" name="email" id="email"> <span class="focus-input100"></span>
							</div>
						</div>

						<p class="head">
							<b>Medicare Details(If any)</b>
						</p>
						<div class="container px-5">
							<p>
								<b>Medicare ID Number:</b>
							</p>
							<div class="wrap-input100 validate-input">
								<span class="label-input100"><i
									class="zmdi zmdi-account material-icons-name"></i></span> <input
									class="input100" type="text" name="medNo" id="medNo"> <span
									class="focus-input100"></span>
							</div>
							<p>
								<b>Medicare Expiry Date:</b>
							</p>
							<div class="wrap-input100 validate-input">
								<span class="label-input100"><i
									class="zmdi zmdi-calendar"></i></span> <input class="input100"
									type="date" name="medExp" id="medExp" /> <span
									class="focus-input100"></span>
							</div>
							<input class="contact100-form-btn btn-update my-3" type="submit"
								value="Submit">
						</div>
					</form>
				</div>
			</div>
		</div>
	</section>
	<%
	} while (rs.next());
	}
	con.close();
	} catch (Exception e) {
	System.out.println(e.getMessage());
	e.getStackTrace();
	}
	%>

	<!-- JS -->
	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="js/main.js"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<link rel="stylesheet" href="alert/dist/sweetalert.css">
	<script type="text/javascript">
	
		var status = document.getElementById("status").value;
		if (status == "success") {
			swal("Success", 
				"Successfully added bill!", 
				"success"
				).then((placeholder) => {
					window.location.href = "mainMenuAssit.jsp";
				});
		}
		else if (status == "failed") {
			swal("Error", 
					"Error adding bill. Please try again.", 
					"error"
					);
			}
	</script>
	<script>
		function hideFunction() {
			var hiddenInformation = document
					.getElementsByClassName("hiddeninfo");
			for (var i = 0; i < hiddenInformation.length; i++) {
				hiddenInformation[i].style.display = 'none';
			}
		}
		$('medExp').datepicker({
			minDate : 0
			});
	</script>
	<script>
	function hideFunction() {
		var hiddenInformation = document
				.getElementsByClassName("hiddeninfo");
		for (var i = 0; i < hiddenInformation.length; i++) {
			hiddenInformation[i].style.display = 'none';
		}
	}
	let datepicker = document.getElementById("medExp");
	let currDate = new Date();
	currDate = new Date(currDate.setDate(currDate.getDate() + 1)).toISOString().split('T')[0];
	datepicker.setAttribute("min", currDate);
</script>
</body>
</html>
