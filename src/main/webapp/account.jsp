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
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>View/Edit Admin</title>
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
	background:linear-gradient(0deg, rgba(115,245,204,0.2726132689403886) 0%, rgba(64,163,172,0.4490838571756828) 100%);
	background-position: center center;
    background-repeat: no-repeat;
    background-attachment: fixed;
    background-size: cover;
}

#showPasswordBox {
	display: inline-block;
	width: 200px;
}
</style>
</head>
<body onload="hideFunction()">
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
				<li class="nav-item active"><a class="nav-link" id="home-btn"
					href="#" onclick="navigate()">Home <span class="sr-only">(current)</span></a></li>
			</ul>
		</div>
	</nav>

	<%
	Connection con;
	Statement stmt;
	ResultSet rs;
	String id = request.getParameter("id");
	try {
		Class.forName("com.mysql.cj.jdbc.Driver");
		con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dentalrecord?useSSL=false", "root", "passwordroot");
		stmt = con.createStatement();
		String sql = "select * from users where iduserAccounts=" + session.getAttribute("id");
		rs = stmt.executeQuery(sql);
		while (rs.next()) {
	%>
	<section>
		<div class="main">
			<div class="container-contact100">
				<div class="wrap-contact100">
					<div class="contact100-form-title"
						style="background-image: url(img/bg-01.jpg);">
						<span class="contact100-form-title-1"> Your Account Info </span>
					</div>

					<form class="contact100-form validate-form"
						action="UpdateAccountDetails" method="post" class="register-form"
						id="register-form" onsubmit="return checkPw();">

						<div class="hiddeninfo">
							<label for="name"><i
								class="zmdi zmdi-account material-icons-name"></i></label> <input
								type="text" name="id" id="id" value=<%=rs.getString(1)%> />
						</div>
						
						<div class="hiddeninfo">
							<label for="name"><i
								class="zmdi zmdi-account material-icons-name"></i></label> <input
								type="text" name="accesslevel" id="accesslevel" value=<%=session.getAttribute("accesslevel")%> />
						</div>

						<p><b>Name:</b></p>
						<div class="wrap-input100 validate-input"
							data-validate="Name is required">
							<span class="label-input100"><i
								class="zmdi zmdi-account material-icons-name"></i></span> <input
								class="input100" type="text" name="name" id="name"
								value=<%=rs.getString(2)%> placeholder="Enter name"> <span
								class="focus-input100"></span>
						</div>
						
						<p><b>Email:</b></p>
						<div class="wrap-input100 validate-input"
							data-validate="Valid email is required: ex@abc.xyz">
							<span class="label-input100"><i class="zmdi zmdi-email"></i></span>
							<input class="input100" type="email" name="email" id="email"
								value=<%=rs.getString(5)%> placeholder="Enter email"> <span
								class="focus-input100"></span>
						</div>

						<p><b>Password:</b></p>
						<div class="wrap-input100 validate-input"
							data-validate="Password is required">
							<span class="label-input100"><i
								class="zmdi zmdi-lock-outline"></i></span> <input class="input100"
								type="password" name="password" id="password"
								value=<%=rs.getString(3)%>> <span class="focus-input100"></span>
						</div>

						<div id="showPasswordBox">
							<input type="checkbox" onclick="showPassword()"
								style="clear: both;"> Show Password
						</div>

						
						<div class="wrap-input100 validate-input hiddeninfo"
							data-validate="Valid email is required: ex@abc.xyz"
							id="hiddenTextbox">
							<span class="label-input100"><i
								class="zmdi zmdi-lock-outline"></i></span> <input class="input100"
								type="password" name="confirm_password" id="confirm_password"
								placeholder="Repeat password" onkeyup='check();'>
						</div>
						<div class="hiddeninfo" id="hiddenMessage">
							<span id="message"></span>
						</div>

						<div class="container-contact100-form-btn">
							<button type="button" class="contact100-form-btn btn-update"
								onclick="updateParticulars()" class="form-submit button" id="revealBtn">Update
								particulars</button>
						</div>

						<div class="container-contact100-form-btn hiddeninfo"
							id="hiddenUpdateBtn">
							<input type="submit" name="signup" id="submit"
								class="contact100-form-btn btn-update" value="Confirm Update" />
						</div>
					</form>
				</div>
			</div>
		</div>
	</section>
	<%
	} ;
	con.close();
	} catch (Exception e) {
	System.out.println(e.getMessage());
	e.getStackTrace();
	}
	%>
	<input type="hidden" id="status"
		value="<%=request.getAttribute("status")%>">

	<!-- JS -->
	<script>
		function hideFunction() {
			var hiddenInformation = document
					.getElementsByClassName("hiddeninfo");
			for (var i = 0; i < hiddenInformation.length; i++) {
				hiddenInformation[i].style.display = 'none';
			}
		}
		function updateParticulars() {
			const x = document.getElementById("hiddenTextbox");
			const y = document.getElementById("hiddenUpdateBtn");
			const z = document.getElementById("hiddenMessage");
			
			document.getElementById("revealBtn").style.display = "none";
			
			if (x.style.display === "none") {
				x.style.display = "block";
			}
			if (y.style.display === "none") {
				y.style.display = "block";
			}
			if (z.style.display === "none") {
				z.style.display = "block";
			}
			document.getElementById('name').removeAttribute('disabled');
			document.getElementById('email').removeAttribute('disabled');
			document.getElementById('password').removeAttribute('disabled');
		}
	</script>
	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<script src="js/main.js"></script>
	<script>
		var check = function() {
			if (document.getElementById('password').value == document
					.getElementById('confirm_password').value) {
				document.getElementById('message').style.color = 'green';
				document.getElementById('message').innerHTML = 'matching';
			} else {
				document.getElementById('message').style.color = 'red';
				document.getElementById('message').innerHTML = 'not matching';
			}
		}
		function mouseoverPass(obj) {
			var obj = document.getElementById('password');
			obj.type = "text";
		}
		function mouseoutPass(obj) {
			var obj = document.getElementById('password');
			obj.type = "password";
		}
		function showPassword() {
			var x = document.getElementById("password");
			if (x.type === "password") {
				x.type = "text";
			} else {
				x.type = "password";
			}
		}

		var status = document.getElementById("status").value;
		if (status == "error") {
			swal("Sorry", "No record(s) found!", "error");
		}

		function checkPw() {
			var pw1 = document.getElementById("password").value;
			var pw2 = document.getElementById("confirm_password").value;
			if (pw1 == pw2) {
				return true;
			} else {
				swal("Sorry", "Password(s) do not match!", "error");
				return false;
			}
		}
		
		function navigate(){
			var homeBtn = document.getElementById("home-btn");
			var accesslevel = document.getElementById("accesslevel").value;
			
			if(accesslevel == 1){
				homeBtn.href = "mainMenuAdmin.jsp";
			}
			else if(accesslevel == 2){
				homeBtn.href = "mainMenuDentist.jsp";
			}
			else if(accesslevel == 3){
				homeBtn.href = "mainMenuAssit.jsp";
			}
			else if(accesslevel == 4){
				homeBtn.href = "mainMenuPatient.jsp";
			}
			else if(accesslevel == 5){
				homeBtn.href = "mainMenuSAdmin.jsp";
			}
		}

	</script>
</body>
</html>
