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
<title>Add Assistant</title>
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

	<input type="hidden" id="status"
		value="<%=request.getAttribute("status")%>">
	<section>
		<div class="main">
			<div class="container-contact100">
				<div class="wrap-contact100">
					<div class="contact100-form-title"
						style="background-image: url(img/bg-01.jpg);">
						<span class="contact100-form-title-1"> Clinic Assistant Registration
							Form </span>
					</div>

					<form class="contact100-form validate-form" action="registerAssistant"
						method="post" id="register-form">

						<p><b>Name:</b></p>
						<div class="wrap-input100 validate-input"
							data-validate="Name is required">
							<span class="label-input100"><i
								class="zmdi zmdi-account material-icons-name"></i></span> <input
								class="input100" type="text" name="name" id="name"
								placeholder="Enter name"> <span class="focus-input100"></span>
						</div>
						
						<p><b>IC Number:</b></p>
						<div class="wrap-input100 validate-input"
							data-validate="IC Number is required">
							<span class="label-input100"><i
							class="zmdi zmdi-account-box-mail"></i></span> <input class="input100"
							type="text" name="icnum" id="icnum"
							placeholder="Enter IC Number"> <span
							class="focus-input100"></span>
						</div>
						
						<p><b>Date Of Birth:</b></p>
						<div class="wrap-input100 validate-input"
							data-validate="Date of Birth is required">
							<span class="label-input100"><i class="zmdi zmdi-calendar"></i></span>
							<input class="input100" type="date" name="dob" id="dob"
								placeholder="Enter Date of Birth"> <span
								class="focus-input100"></span>
						</div>
						
						<p><b>Email:</b></p>
						<div class="wrap-input100 validate-input"
							data-validate="Valid email is required: ex@abc.xyz">
							<span class="label-input100"><i class="zmdi zmdi-email"></i></span>
							<input class="input100" type="email" name="email" id="email"
								placeholder="Enter email"> <span class="focus-input100"></span>
						</div>
						
						<p><b>Phone Number:</b></p>
						<div class="wrap-input100 validate-input"
							data-validate="Contact is required">
							<span class="label-input100"><i class="zmdi zmdi-phone"></i></span>
							<input class="input100" type="text" name="contact" id="contact"
								placeholder="Enter contact number"> <span
								class="focus-input100"></span>
						</div>
						
						<p><b>Address:</b></p>
						<div class="wrap-input100 validate-input"
							data-validate="Address is required">
							<span class="label-input100"><i class="zmdi zmdi-gps-dot"></i></span>
							<input class="input100" type="text" name="address" id="address"
								placeholder="Enter Address"> <span
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
	
		var status = document.getElementById("status").value;
		if (status == "success") {
			swal("Success", 
				"Assistant successfully added.", 
				"success"
				).then((placeholder) => {
					window.location.href = "assistantList.jsp";
				});
		}
	</script>
</body>
</html>
