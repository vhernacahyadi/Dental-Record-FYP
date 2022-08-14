<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Dental Record Management System</title>
<link rel="stylesheet"
	href="fonts/material-icon/css/material-design-iconic-font.min.css">
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
<link rel="stylesheet" href="css/register.css" type="text/css" />
</head>

<style type="text/css">
body {
	background-image: url("img/login-hero.jpg");
	background-position: center center;
    background-repeat: no-repeat;
    background-attachment: fixed;
    background-size: cover;
    padding-top:40px;
}

.img-rounded {
	height: 100%;
	width: 100%;
}

h1 {
	color: white;
	text-align: center;
}

#emailMsg{
	position:relative;
	bottom:15px;
}

.errorMsg {
	color: red;
	visibility: hidden;
}
</style>

<body>	
	<div>
		<h1 style="text-shadow: 2px 2px 5px #edeae4; color:#0a393b;">
			<b>Dental Record Management System</b>
		</h1>
	</div>

	<input type="hidden" id="status"
		value="<%=request.getAttribute("status")%>">
	<!-- Sign in Form -->
	<div>
		<section class="sign-in">
			<div class="container">
				<div class="signin-content">
					<div class="signin-image">
						<figure>
							<img src="img/signin-image.jpg" alt="sign up image">
						</figure>
					</div>

					<div class="signin-form">
						<h2 class="form-title">Sign in</h2>

						<form method="post" action="login" class="register-form"
							id="login-form">
							
							<div class="form-group">
								<label for="password"> <i
									class="zmdi zmdi-account material-icons-name"></i>
								</label> <input type="text" name="username" id="username"
									placeholder="Your Email" required />
							</div>
							<div class="errorMsg" id="emailMsg">Please enter a valid
									email.</div>
							
							<div class="form-group">
								<label for="password"> <i class="zmdi zmdi-lock"></i>
								</label> <input type="password" name="password" id="password"
									placeholder="Password" required />
							</div>
							<div class="form-group form-button">
								<input type="submit" name="signin" id="signin"
									class="form-submit" value="Log in" />
							</div>						
						</form>
						<a href="adminRegistration.jsp">Applying as an Administrator?</a>
					</div>
					
				</div>
			</div>
		</section>
	</div>
	
	<script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>
	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="js/main.js"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<script type="text/javascript">
		var status = document.getElementById("status").value;
		if (status == "failed") {
			swal("Sorry", "Wrong Username/Password", "error");
		}

		//check if email is in correct format
		var fired = false;

		var emailText = document.getElementById("username");

		function checkEmail() {
			if (!fired) {
				fired = true;
				const format = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
				var emailInput = document.getElementById("username").value;
				var emailMsg = document.getElementById("emailMsg");

				console.log(emailText.value);

				if (!emailInput.match(format)) {
					emailMsg.style.visibility = "visible";
				} else {
					emailMsg.style.visibility = "hidden";
				}
			}
		}

		emailText.addEventListener("keyup", checkEmail);

		emailText.onkeyup = function() {
			fired = false;
		}
	</script>

</body>
</html>