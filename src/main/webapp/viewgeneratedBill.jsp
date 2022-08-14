<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>View/Edit Bill</title>
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

#deleteForm {
	padding: 0;
	position: absolute;
	bottom:0.45%;
	left: 55%;
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
					href="mainMenuAdmin.jsp"> Home <span class="sr-only">(current)</span></a></li>
				<li class="nav-item active"><a class="nav-link"
					href="generatedBills.jsp"> Billing History <span
						class="sr-only">(current)</span></a></li>
				<li class="nav-item active"><a class="nav-link"
					href="billview.jsp"> Send Bill <span class="sr-only">(current)</span></a></li>
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
		String sql = "select * from billHistory where idbillHistory=" + id;
		rs = stmt.executeQuery(sql);

		while (rs.next()) {
	%>
	<section>
		<div class="main">
			<div class="container-contact100">
				<div class="wrap-contact100">
					<div class="contact100-form-title"
						style="background-image: url(img/bg-01.jpg);">
						<span class="contact100-form-title-1"> Bill Details </span>
					</div>
					<form class="contact100-form validate-form" action="markAsPaid"
						method="post" id="paidForm">
						<div class="hiddeninfo">
							<label for="name"><i
								class="zmdi zmdi-account material-icons-name"></i></label> <input
								type="text" name="id" id="id" value=<%=rs.getString(1)%> />
						</div>
						<div class="hiddeninfo">
							<label for="name"><i
								class="zmdi zmdi-account material-icons-name"></i></label> <input
								type="text" name="paymentstatus" id="paymentstatus" value=<%=rs.getString(14)%> />
						</div>
						
						<p><b>Name:</b></p>
						<div class="wrap-input100 validate-input">
							<span class="label-input100"><i
								class="zmdi zmdi-account material-icons-name"></i></span> <input
								class="input100" type="text" disabled name="name" id="name"
								value="<%=rs.getString(2)%>"> <span
								class="focus-input100"></span>
						</div>

						<p><b>Address:</b></p>
						<div class="wrap-input100 validate-input">
							<span class="label-input100"><i class="zmdi zmdi-gps-dot"></i></span>
							<input class="input100" type="text" disabled name="address" id="address"
								value="<%=rs.getString(3)%>"> <span
								class="focus-input100"></span>
						</div>

						<p><b>Phone Number:</b></p>
						<div class="wrap-input100 validate-input">
							<span class="label-input100"><i class="zmdi zmdi-phone"></i></span>
							<input class="input100" type="text" disabled name="contact" id="contact"
								value=<%=rs.getString(4)%>> <span
								class="focus-input100"></span>
						</div>

						<p><b>Email:</b></p>
						<div class="wrap-input100 validate-input">
							<span class="label-input100"><i
								class="zmdi zmdi-email"></i></span> <input class="input100"
								type="text" disabled name="email" id="email"
								value="<%=rs.getString(5)%>"> <span
								class="focus-input100"></span>
						</div>

						<div class="wrap-input100 validate-input">
						<p><b>Billing date:</b></p>
							<span class="label-input100"><i
								class="zmdi zmdi-calendar-check"></i></span> <input class="input100"
								type="text" disabled name="billingDate" id="billingDate"
								value="<%=rs.getString(6)%>"> <span
								class="focus-input100"></span>
						</div>
						<div class="wrap-input100 validate-input">
						<p><b>Billing time:</b></p>
							<span class="label-input100"><i
								class="zmdi zmdi-time"></i></span> <input class="input100"
								type="text" disabled name="billingTime" id="billingTime"
								value="<%=rs.getString(7)%>"> <span
								class="focus-input100"></span>
						</div>
						<div class="wrap-input100 validate-input">
						<p><b>Dental Services:</b></p>
							<span class="label-input100"><i
								class="zmdi zmdi-wrench"></i></span> <input class="input100"
								type="text" disabled name="services" id="services"
								value="<%=rs.getString(8)%>"> <span
								class="focus-input100"></span>
						</div>
						<div class="wrap-input100 validate-input">
						<p><b>Medicare ID Number:</b></p>
							<span class="label-input100"><i
								class="zmdi zmdi-accounts-list-alt"></i></span> <input class="input100"
								type="text" disabled name="medicareNo" id="medicareNo"
								value="<%=rs.getString(10)%>"> <span
								class="focus-input100"></span>
						</div>
						<div class="wrap-input100 validate-input">
						<p><b>Medicare Expiry Date:</b></p>
							<span class="label-input100"><i
								class="zmdi zmdi-calendar-close"></i></span> <input class="input100"
								type="text" disabled name="medExp" id="medExp"
								value="<%=rs.getString(11)%>"> <span
								class="focus-input100"></span>
						</div>
						<div class="wrap-input100 validate-input">
						<p><b>Total Cost:</b></p>
							<span class="label-input100"><i
								class="zmdi zmdi-money"></i></span> <input class="input100"
								type="text" disabled name="totalCost" id="totalCost"
								value="<%=rs.getString(9)%>"> <span
								class="focus-input100"></span>
						</div>
						<div class="wrap-input100 validate-input">
						<p><b>Discounted Cost (If medicare is applied)</b></p>
							<span class="label-input100"><i
								class="zmdi zmdi-money"></i></span> <input class="input100"
								type="text" disabled name="discountedCost" id="discountedCost"
								value="<%=rs.getString(12	)%>"> <span
								class="focus-input100"></span>
						</div>
						<div class="container-contact100-form-btn">
							<button class="btn-danger" id="markBtn">
								<span>Mark Bill as PAID</span>
							</button>
						</div>
					</form>
					<form class="contact100-form validate-form" action="deleteBill"
						method="post" id="deleteForm">

						<div class="hiddeninfo">
							<label for="name"><i
								class="zmdi zmdi-account material-icons-name"></i></label> <input
								type="text" name="id" id="id" value=<%=rs.getString(1)%> />
						</div>

						<div class="container-contact100-form-btn">
							<button class="btn-danger" id="deleteBtn">
								<span> Delete Bill Record </span>
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
	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="js/main.js"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<link rel="stylesheet" href="alert/dist/sweetalert.css">
	<script type="text/javascript">
	document.getElementById("deleteBtn").addEventListener('click', function(e){
		e.preventDefault();
		let deleteForm = document.getElementById("deleteForm");
		swal({
            title: "Warning!",
            text: "Are you sure you want to delete this bill record?", 
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
	

	if(document.getElementById("paymentstatus").value == "Paid"){
		document.getElementById("markBtn").style.display = "none";
	}
	
	document.getElementById("markBtn").addEventListener('click', function(e){
		e.preventDefault();
		let paidForm = document.getElementById("paidForm");
		swal({
            title: "Warning!",
            text: "Are you sure you want to mark this bill as paid?", 
            icon: "warning",
            buttons: true,
            dangerMode: true,
        })
        .then((willPaid) => {
	        if (willPaid) {
	          paidForm.submit();
	        }
	     });
	});
	</script>
</body>
</html>
