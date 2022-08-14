<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Add Item</title>
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
<link rel="stylesheet"
	href="fonts/material-icon/css/material-design-iconic-font.min.css">
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

p{
	width:100%;
}
</style>
</head>
<body>
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
					href="mainMenuAssit.jsp">Home <span class="sr-only">(current)</span></a></li>
				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
					role="button" data-toggle="dropdown" aria-haspopup="true"
					aria-expanded="false"> ASSISTANT </a>
					<div class="dropdown-menu" aria-labelledby="navbarDropdown">
						<a class="dropdown-item" href="inventorylist.jsp">Inventory List</a> 
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
						<span class="contact100-form-title-1"> Add Item </span>
					</div>

					<form class="contact100-form validate-form" action="addItem"
						method="post" id="register-form">
						
						<div class="hiddeninfo">
							<label for="clinicId"></label> 
								<input type="hidden" id="clinicId" name="clinicId" value="<%=session.getAttribute("clinicId") %>">
						</div>
						
						<p><b>Item Name:</b></p>
						<div class="wrap-input100 validate-input"
							data-validate="Item name is required">
							<span class="label-input100"><i class="zmdi zmdi-format-align-left"></i></span> 
							<input class="input100" type="text" name="itemname" id="itemname"
								placeholder="Enter item name"> <span class="focus-input100"></span>
						</div>

						<p><b>Item Status:</b></p>
						<div class="wrap-input100 validate-input"
							data-validate="Item status is required">
							<span class="label-input100"><i class="zmdi zmdi-time-interval"></i></span>
							<input class="input100" type="text" name="itemstatus" id="itemstatus"
								placeholder="Enter item status"> <span class="focus-input100"></span>
						</div>

						<p><b>Item Quantity:</b></p>
						<div class="wrap-input100 validate-input"
							data-validate="Item quantity is required">
							<span class="label-input100"><i class="zmdi zmdi-collection-item-9-plus"></i></span>
							<input class="input100" type="text" name="itemqty" id="itemqty"
								placeholder="Enter item quantity"> <span
								class="focus-input100"></span>
						</div>
						
						<p><b>Item Expiry Date:</b></p>
						<div class="wrap-input100 validate-input"
							data-validate="Expiry date is required">
							<span class="label-input100"><i class="zmdi zmdi-calendar-note"></i></span>
							<input class="input100" type="date" name="itemexpdate" id="itemexpdate"><span
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
		console.log(document.getElementById("clinicId").value);
		var status = document.getElementById("status").value;
		if (status == "success") {
			swal("Congratulations", "Account created succesfully", "success");
		}

	</script>
</body>
</html>
