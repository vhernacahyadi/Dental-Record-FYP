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
<title>User details</title>
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
<link rel="stylesheet" href="alert/dist/sweetalert.css">
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

div.wrap-contact100{
	position:relative;
}

#deleteForm {
	padding:0;
	position:absolute;
	bottom: 0.7%;
	left: 55%;
}
</style>
</head>
<body onload="hideFunction()">
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<a href="mainMenuSAdmin.jsp" class="navbar-brand"> <img src="img/dentalrecordsicon-small.png"
			height="40" width="40" alt="DentalRecordManagementSystem">
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
					href="mainMenuSAdmin.jsp">Home</a></li>
					<li class="nav-item active"><a class="nav-link"
					href="userList.jsp">User List <span class="sr-only">(current)</span></a></li>
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
		String sql = "select * from users where iduserAccounts=" + id;
		rs = stmt.executeQuery(sql);

		while (rs.next()) {
	%>
	<section>
		<div class="main">
			<div class="container-contact100">
				<div class="wrap-contact100">
					<div class="contact100-form-title"
						style="background-image: url(img/bg-01.jpg);">
						<span class="contact100-form-title-1"> User Details </span>
					</div>
					<form class="contact100-form validate-form" action="UpdateUserListInfo"
						method="post" id="register-form">

						<div class="hiddeninfo">
							<label for="name"><i
								class="zmdi zmdi-account material-icons-name"></i></label> <input
								type="text" name="id" id="id" value=<%=rs.getString(1)%> />
						</div>

						<p><b>Name:</b></p>
						<div class="wrap-input100 validate-input"
							data-validate="Name is required">
							<span class="label-input100"><i
								class="zmdi zmdi-account material-icons-name"></i></span> <input
								class="input100" type="text" name="name" id="name" 
								value="<%=rs.getString(2)%>" > <span
								class="focus-input100"></span>
						</div>
						
						<div class="hiddeninfo">
							<label for="name"><i
								class="zmdi zmdi-account material-icons-name"></i></label> <input
								type="text" name="accesslevel" id="accesslevel" value=<%=rs.getString(4)%> />
						</div>

						<p><b>Email:</b></p>
						<div class="wrap-input100 validate-input"
							data-validate="Valid email is required: ex@abc.xyz">
							<span class="label-input100"><i class="zmdi zmdi-email"></i></span>
							<input class="input100" type="email" name="email" id="email" 
								value="<%=rs.getString(5)%>" > <span
								class="focus-input100"></span>
						</div>
						
						<p><b>Clinic ID:</b></p>
						<div class="wrap-input100 validate-input"
							data-validate="Valid email is required: ex@abc.xyz">
							<span class="label-input100"><i class="zmdi zmdi-assignment-o"></i></span>
							<input class="input100" type=text name="clinicId" id="clinicId" 
								value="<%=rs.getString(9)%>" > <span
								class="focus-input100"></span>
						</div>
						
						<p><b>Clinic Name:</b></p>
						<div class="wrap-input100 validate-input"
							data-validate="Valid email is required: ex@abc.xyz">
							<span class="label-input100"><i class="zmdi zmdi-hospital"></i></span>
							<input class="input100" type=text name="clinicName" id="clinicName" 
								value="<%=rs.getString(6)%>" > <span
								class="focus-input100"></span>
						</div>
						
						<p><b>Clinic Address:</b></p>
						<div class="wrap-input100 validate-input"
							data-validate="Valid email is required: ex@abc.xyz">
							<span class="label-input100"><i class="zmdi zmdi-gps-dot"></i></span>
							<input class="input100" type=text name="clinicAddress" id="clinicAddress" 
								value="<%=rs.getString(7)%>" > <span
								class="focus-input100"></span>
						</div>
						
						<p><b>Clinic Number:</b></p>
						<div class="wrap-input100 validate-input"
							data-validate="Valid email is required: ex@abc.xyz">
							<span class="label-input100"><i class="zmdi zmdi-phone"></i></span>
							<input class="input100" type=text name="clinicNumber" id="clinicNumber" 
								value="<%=rs.getString(8)%>" > <span
								class="focus-input100"></span>
						</div>
												
						<div class="container-contact100-form-btn">
							<button id="updateBtn" class="contact100-form-btn btn-update">
								<span>	Update </span>
							</button>
						</div>
					</form>
					<form class="contact100-form validate-form small-form" action="deleteUser"
						method="post" id="deleteForm">
						<div class="hiddeninfo">
							<label for="name"><i
								class="zmdi zmdi-account material-icons-name"></i></label> <input
								type="text" name="id" id="id" value=<%=rs.getString(1)%> />
						</div>
						<div class="container-contact100-form-btn">
							<button id="deleteBtn" class="btn-danger">
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
	<script>
		function hideFunction() {
			var hiddenInformation = document.getElementsByClassName("hiddeninfo");
			for (var i = 0; i < hiddenInformation.length; i++) {
				hiddenInformation[i].style.display = 'none';
			}
		}
	</script>
	<script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>
	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="js/main.js"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<script type="text/javascript">	
		const deleteBtn = document.getElementById("deleteBtn");
		const updateBtn = document.getElementById("updateBtn");
		
		// Sweet Alert for deletion
		deleteBtn.addEventListener('click', function(e){
			e.preventDefault();
			let deleteForm = document.getElementById("deleteForm");
			swal({
	            title: "Warning!",
	            text: "Are you sure you want to delete this user?", 
	            icon: "warning",
	            buttons: true,
	            dangerMode: true,
	        })
	        .then((willDelete) => {
		        if (willDelete) {
		          deleteForm.submit();
		        }
		     });
		});
		
		// Sweet Alert for update
		updateBtn.addEventListener('click', function(e){
			e.preventDefault();
			let updateForm = document.getElementById("register-form");
			swal({
				title: "Warning!",
				text: "Are you sure you want to update this user's information?",
				icon: "warning",
				buttons: true,
				dangerMode: true,
			})
			.then((willUpdate) => {
				if (willUpdate) {
					updateForm.submit();
				}
			});
		});
	</script>
</body>
</html>
