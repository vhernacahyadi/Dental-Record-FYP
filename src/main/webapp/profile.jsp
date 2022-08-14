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
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>Patient Details</title>

<!-- Font Icon -->
<link rel="stylesheet"
	href="fonts/material-icon/css/material-design-iconic-font.min.css">

<!-- Main css -->
<link rel="stylesheet" href="css/style.css">

<style>
.button {
	background: #6dabe4;
	border: none;
	color: white;
	width: 130px;
	padding: 15px 32px;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 16px;
	margin: 4px 2px;
	cursor: pointer;
	border-radius: 8px;
	transition:0.3s ease;
}

.button:hover {
	background: #4292dc;
	color: white;
}

.delete{
	background:#c95f68;
	transition: 0.3 ease;
}

.delete:hover{
	background:#cc3f4b;
}
</style>
</head>
<body onload="hideFunction()">
	<%
	Connection con;
	Statement stmt;
	ResultSet rs;
	String id = request.getParameter("id");
	try {
		Class.forName("com.mysql.cj.jdbc.Driver");
		con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dentalrecord?useSSL=false", "root", "passwordroot");
		stmt = con.createStatement();
		String sql = "select * from customer where idcustomer=" + id;
		rs = stmt.executeQuery(sql);

		while (rs.next()) {
	%>
	<div class="main">

		<!-- Sign up form -->
		<section class="signup">
			<div class="container">
				<div class="signup-content">
					<div class="signup-form">
						<button class="button" id="backBtn">Back</button>
						<h2 class="form-title">Patient details</h2>

						<form method="post" action="update" class="register-form"
							id="register-form">
							<div class="hiddeninfo">
								<label for="name"><i
									class="zmdi zmdi-account material-icons-name"></i></label> <input
									type="text" name="id" id="id" value=<%=rs.getString(1)%> />
							</div>
							<div class="form-group">
								<label for="name"><i
									class="zmdi zmdi-account material-icons-name"></i></label> <input
									type="text" name="name" id="name" value=<%=rs.getString(2)%> />
							</div>
							<div class="form-group">
								<label for="email"><i class="zmdi zmdi-email"></i></label> <input
									type="email" name="email" id="email" value=<%=rs.getString(7)%> />
							</div>
							<div class="form-group">
								<label for="contact"><i class="zmdi zmdi-phone"></i></label>
								<input type="text" name="contact" id="contact"
									value=<%=rs.getString(6)%> />
							</div>
							<div class="form-group">
								<label for="address"><i class="zmdi zmdi-gps-dot"></i></label>
								<input type="text" name="address" id="address"
									value=<%=rs.getString(3)%> />
							</div>
							<div class="form-group">
								<label for="dob"><i class="zmdi zmdi-calendar"></i></label>
								<input type="date" name="dob" id="dob"
									value=<%=rs.getString(4)%> />
							</div>
							<div class="form-group">
								<label for="icnum"><i class="zmdi zmdi-account-box-mail"></i></label>
								<input type="text" name="icnum" id="icnum"
									value=<%=rs.getString(5)%> />
							</div>
							<div class="form-group form-button">
								<input type="submit" name="signup" id="signup"
									class="form-submit button" value="Update" />
							</div>
						</form>
						<form method="post" action="delete" class="register-form"
							id="register-form">
							<div class="hiddeninfo">
								<label for="name"> <i
									class="zmdi zmdi-account material-icons-name"></i></label> <input
									type="text" name="id" id="id" value=<%=rs.getString(1)%> />
							</div>
							<div class="form-group form-button">
								<input type="submit" name="signup" id="signup"
									class="form-submit button delete" value="Delete" />
							</div>
						</form>
					</div>


					<div class="signup-image">
						<figure>
							<img src="images/signup-image.jpg" alt="sing up image">
						</figure>
					</div>
				</div>
			</div>
		</section>
	</div>
	<%
	} ;
	con.close();
	} catch (Exception e) {
	System.out.println(e.getMessage());
	e.getStackTrace();
	}
	%>
	<!-- JS -->
	<script>
		function hideFunction() {
			var hiddenInformation = document
					.getElementsByClassName("hiddeninfo");
			for (var i = 0; i < hiddenInformation.length; i++) {
				hiddenInformation[i].style.display = 'none';
			}
		}
	</script>
	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="js/main.js"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<link rel="stylesheet" href="alert/dist/sweetalert.css">
	<script type="text/javascript">		
		var backBtn = document.getElementById("backBtn");
		backBtn.addEventListener('click', function() {
			location.href = "mainMenuAdmin.jsp";
		});
	</script>

</body>
<!-- This templates was made by Colorlib (https://colorlib.com) -->
</html>