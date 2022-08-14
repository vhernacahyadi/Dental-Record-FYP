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
<title>View/Edit Inventory</title>
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

#delete-form {
	padding:0;
	position:absolute;
	bottom:0.7%;
	left:55%;
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
				<li class="nav-item active"><a class="nav-link"
					href="mainMenuAssit.jsp">Home <span class="sr-only">(current)</span></a></li>
				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
					role="button" data-toggle="dropdown" aria-haspopup="true"
					aria-expanded="false"> ASSISTANT </a>
					<div class="dropdown-menu" aria-labelledby="navbarDropdown">
						<a class="dropdown-item" href="addInventory.jsp">Add Item</a> <a
							class="dropdown-item" href="inventorylist.jsp">Inventory List</a>
					</div></li>
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
		String sql = "select * from inventory where itemid=" + id;
		rs = stmt.executeQuery(sql);

		while (rs.next()) {
	%>
	<section>
		<div class="main">
			<div class="container-contact100">
				<div class="wrap-contact100">
					<div class="contact100-form-title"
						style="background-image: url(img/bg-01.jpg);">
						<span class="contact100-form-title-1"> Item Details </span>
					</div>

					<form class="contact100-form validate-form" action="updateInvent"
						method="post" id="register-form">
						<input type="hidden" id="status" name="status" value=<%=request.getAttribute("status")%>>
			
						<div class="hiddeninfo">
							<label for="name"><i
								class="zmdi zmdi-account material-icons-name"></i></label> <input
								type="text" name="id" id="id" value=<%=rs.getString(1)%> />
						</div>

						<p><b>Item Name:</b></p>
						<div class="wrap-input100 validate-input"
							data-validate="Item Name is required">
							<span class="label-input100"><i class="zmdi zmdi-format-align-left"></i></span> <input
								class="input100" type="text" name="itemname" id="itemname"
								value=<%=rs.getString(2)%>> <span class="focus-input100"></span>
						</div>

						<p><b>Item Status:</b></p>
						<div class="wrap-input100 validate-input"
							data-validate="Item status is required">
							<span class="label-input100"><i class="zmdi zmdi-time-interval"></i></span>
							<input class="input100" type="itemstatus" name="itemstatus"
								id="itemstatus" value=<%=rs.getString(3)%>> <span
								class="focus-input100"></span>
						</div>

						<p><b>Item Quantity:</b></p>
						<div class="wrap-input100 validate-input"
							data-validate="Item quantity is required">
							<span class="label-input100"><i class="zmdi zmdi-collection-item-9-plus"></i></span>
							<input class="input100" type="text" name="itemqty" id="itemqty"
								value=<%=rs.getString(4)%>> <span class="focus-input100"></span>
						</div>

						<p><b>Item Expiry Date:</b></p>
						<div class="wrap-input100 validate-input"
							data-validate="Date of Birth is required">
							<span class="label-input100"><i class="zmdi zmdi-calendar"></i></span>
							<input class="input100" type="date" name="itemexpdate"
								id="itemexpdate" value=<%=rs.getString(5)%>> <span
								class="focus-input100"></span>
						</div>

						<div class="container-contact100-form-btn">
							<button class="contact100-form-btn btn-updateInvent">
								<span> Update </span>
							</button>
						</div>
					</form>
					<form method="post" action="delete"
						class="contact100-form validate-form small-form"
						id="delete-form">
						<div class="hiddeninfo">
							<label for="name"> <i
								class="zmdi zmdi-account material-icons-name"></i></label> <input
								type="text" name="id" id="id" value=<%=rs.getString(1)%> />
						</div>
						<div class="container-contact100-form-btn">
							<button class="btn-danger">
								<span> Delete </span>
							</button>
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

	<!-- JS -->
	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="js/main.js"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<link rel="stylesheet" href="alert/dist/sweetalert.css">
	
	<script>
		function hideFunction() {
			var hiddenInformation = document
					.getElementsByClassName("hiddeninfo");
			for (var i = 0; i < hiddenInformation.length; i++) {
				hiddenInformation[i].style.display = 'none';
			}
		}
		
		var status = document.getElementById("status").value;
		if (status == "success") {
			swal("Success", 
				"Material information successfully updated.", 
				"success"
				).then((placeholder) => {
					window.location.href = "inventorylist.jsp";
				});
		}
	</script>
	
</body>
</html>
