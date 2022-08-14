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
<title>View/Edit Clinic Assistant</title>
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
<link rel="stylesheet" href="alert/dist/sweetalert.css">
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

#deleteForm {
	padding:0;
	position:absolute;
	bottom:0.6%;
	left: 55%;
}

</style>
</head>
<body onload="hideFunction()">
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<a href="#" class="navbar-brand"> <img src="img/dentalrecordsicon-small.png"
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
					href="mainMenuAdmin.jsp">Home <span class="sr-only">(current)</span></a></li>
				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
					role="button" data-toggle="dropdown" aria-haspopup="true"
					aria-expanded="false"> CLINIC ASSISTANT </a>
					<div class="dropdown-menu" aria-labelledby="navbarDropdown">
						<a class="dropdown-item" href="addAssistant.jsp">Add Clinic
							Assistant</a> <a class="dropdown-item" href="assistantList.jsp">Clinic
							Assistant List</a>
					</div></li>
			</ul>
		</div>
	</nav>

	<%
	Connection con;
	Statement stmt, stmt2;
	ResultSet rs;
	String id = request.getParameter("id");
	String sql="";
	String userId;
	try {
		Class.forName("com.mysql.cj.jdbc.Driver");
		con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dentalrecord?useSSL=false", "root", "passwordroot");
		stmt = con.createStatement();
		
		stmt2 = con.createStatement();
		
		String userQuery = "select iduserAccounts from users where useremail in (select email from assistant where idassistant = " + id+ ")";
		ResultSet rs2 = stmt2.executeQuery(userQuery);
		
		if(rs2.next()){
			userId = String.valueOf(rs2.getInt(1));
		}
		
		
		if((int)session.getAttribute("clinicId")==1)
			sql = "select * from assistant where idassistant=" + id;
		else if((int)session.getAttribute("clinicId")==2)
			sql = "select * from assistant2 where idassistant2=" + id;
		rs = stmt.executeQuery(sql);
		while (rs.next()) {
	%>
	<section>
		<div class="main">
			<div class="container-contact100">
				<div class="wrap-contact100">
					<div class="contact100-form-title"
						style="background-image: url(img/bg-01.jpg);">
						<span class="contact100-form-title-1"> Clinic Assistant Details </span>
					</div>

					<form class="contact100-form validate-form" action="updateAssistant"
						method="post" id="register-form">

						<div class="hiddeninfo">
							<label for="name"><i
								class="zmdi zmdi-account material-icons-name"></i></label> <input
								type="text" name="id" id="id" value=<%=rs.getString(1)%> />
						</div>
						
						<div class="hiddeninfo">
							<label for="name"><i
								class="zmdi zmdi-account material-icons-name"></i></label> <input
								type="text" name="userid" id="userid" value=<%=rs2.getString(1)%> />
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

						<p><b>IC Number:</b></p>
						<div class="wrap-input100 validate-input"
							data-validate="IC Number is required">
							<span class="label-input100"><i
								class="zmdi zmdi-account-box-mail"></i></span> <input class="input100"
								type="text" name="icnum" id="icnum" value=<%=rs.getString(4)%>
								> <span
								class="focus-input100"></span>
						</div>
						
						<p><b>Date Of Birth:</b></p>
						<div class="wrap-input100 validate-input"
							data-validate="Date of Birth is required">
							<span class="label-input100"><i class="zmdi zmdi-calendar"></i></span>
							<input class="input100" type="date" name="dob" id="dob"
								value="<%=rs.getString(3)%>" >
							<span class="focus-input100"></span>
						</div>
					
						<p><b>Email:</b></p>
						<div class="wrap-input100 validate-input"
							data-validate="Valid email is required: ex@abc.xyz">
							<span class="label-input100"><i class="zmdi zmdi-email"></i></span>
							<input class="input100" type="email" name="email" id="email"
								value=<%=rs.getString(7)%> > <span
								class="focus-input100"></span>
						</div>
						
						<p><b>Phone Number:</b></p>
						<div class="wrap-input100 validate-input"
							data-validate="Contact is required">
							<span class="label-input100"><i class="zmdi zmdi-phone"></i></span>
							<input class="input100" type="text" name="contact" id="contact"
								value=<%=rs.getString(5)%> >
							<span class="focus-input100"></span>
						</div>

						<p><b>Address:</b></p>
						<div class="wrap-input100 validate-input"
							data-validate="Address is required">
							<span class="label-input100"><i class="zmdi zmdi-gps-dot"></i></span>
							<input class="input100" type="text" name="address" id="address"
								value="<%=rs.getString(6)%>" >
							<span class="focus-input100"></span>
						</div>

						<div class="container-contact100-form-btn">
							<button class="contact100-form-btn btn-update" id="updateBtn">
								<span> Update </span>
							</button>
						</div>
					</form>
					<form method="post" action="deleteAssistant"
						class="contact100-form validate-form small-form" id="deleteForm">
						<div class="hiddeninfo">
							<label for="name"> <i
								class="zmdi zmdi-account material-icons-name"></i></label> <input
								type="text" name="id" id="id" value=<%=rs.getString(1)%> />
						</div>
						<div class="container-contact100-form-btn">
							<button class="btn-danger" id="deleteBtn">
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
			var hiddenInformation = document
					.getElementsByClassName("hiddeninfo");
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
