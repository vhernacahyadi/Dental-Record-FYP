<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Registration Form</title>
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

.form-title{
	width:100%;
	position:relative;
	right:50px;
	color:#91a5b7;
	font-family:Poppins-Regular;
	margin-top:10px 0;
}

</style>
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		 <img
			src="img/dentalrecordsicon-small.png" height="40" width="40"
			alt="DentalRecordManagementSystem">

		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item active"><a class="nav-link"
					href="login.jsp">Login <span class="sr-only">(current)</span></a></li>
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
						style="background-image: url(img/bg-02.jpg);">
						<span class="contact100-form-title-1"> Administrator Registration
							Form </span>
					</div>
					
					<form class="contact100-form validate-form" action="registerAdmin"
						method="post" id="register-form">
						<span class="form-title">Your Details</span>
						<p><b>Name:</b></p>
						<div class="wrap-input100 validate-input"
							data-validate="Name is required">
							<span class="label-input100"><i
								class="zmdi zmdi-account material-icons-name"></i></span> <input
								class="input100" type="text" name="name" id="name"> <span class="focus-input100"></span>
						</div>
						
						<p><b>Email:</b></p>
						<div class="wrap-input100 validate-input"
							data-validate="Valid email is required: ex@abc.xyz">
							<span class="label-input100"><i class="zmdi zmdi-email"></i></span>
							<input class="input100" type="email" name="email" id="email"> <span class="focus-input100"></span>
						</div>

						<p><b>Phone Number:</b></p>
						<div class="wrap-input100 validate-input"
							data-validate="Contact is required">
							<span class="label-input100"><i class="zmdi zmdi-phone"></i></span>
							<input class="input100" type="text" name="contact" id="contact"> <span
								class="focus-input100"></span>
						</div>
						
						<p><b>Password:</b></p>
						<div class="wrap-input100 validate-input"
							data-validate="Password is required">
							<span class="label-input100"><i class="zmdi zmdi-lock-outline"></i></span>
							<input class="input100" type="password" name="password" id="password"> <span
								class="focus-input100"></span>
						</div>
						
						<p><b>Re-enter Password:</b></p>
						<div class="wrap-input100 validate-input"
							data-validate="Please re-enter your password">
							<span class="label-input100"><i class="zmdi zmdi-lock-outline"></i></span>
							<input class="input100" type="password" name="re_pass" id="re_pass"> <span
								class="focus-input100"></span>
						</div>
						
						<span class="form-title">Clinic details</span>

						<p><b>Clinic Name:</b></p>
						<div class="wrap-input100 validate-input"
							data-validate="Clinic name is required">
							<span class="label-input100"><i class="zmdi zmdi-hospital"></i></span>
							<input class="input100" type="text" name="clinicName" id="clinicName"> <span
								class="focus-input100"></span>
						</div>

						<p><b>Clinic Address:</b></p>
						<div class="wrap-input100 validate-input"
							data-validate="Address is required">
							<span class="label-input100"><i class="zmdi zmdi-gps-dot"></i></span>
							<input class="input100" type="text" name="clinicAddress" id="clinicAddress"> <span
								class="focus-input100"></span>
						</div>

						<p><b>Clinic Number:</b></p>
						<div class="wrap-input100 validate-input"
							data-validate="Clinic contact number is required">
							<span class="label-input100"><i class="zmdi zmdi-phone"></i></span>
							<input class="input100" type="text" name="clinicContact" id="clinicContact"> <span
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
			swal("Congratulations", 
			"Application successfully submitted. We will get back to you in 3-5 working day(s).", 
			"success"
				).then((placeholder) => {
					window.location.href = "login.jsp";
				});
		}
	</script>
</body>
</html>
