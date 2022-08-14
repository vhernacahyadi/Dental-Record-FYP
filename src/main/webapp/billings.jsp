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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Billing Page</title>
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
<link rel="stylesheet" type="text/css" href="css/table.css">
<style>
body {
	background :linear-gradient(0deg, rgba(115,245,158,0.2502043053549545) 0%, rgba(171,227,255,0.8608485630580357) 100%);
	background-position: center center;
    background-repeat: no-repeat;
    background-attachment: fixed;
    background-size: cover;
}

#logout {
	width: 150px
}

.button {
	background: #6dabe4;
	border: none;
	color: white;
	padding: 15px 32px;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 16px;
	margin: 4px 2px;
	cursor: pointer;
	border-radius: 8px;
	transition: 0.3s
}

.button:hover {
	background: #4292dc;
	color: white;
}

.dropbtn {
	color: white;
	font-size: 16px;
	border: none;
	padding: 0;
	margin: 0;
	width: 160px;
	display: inline-block;
	text-align: center;
	cursor: pointer;
}

#avatar {
	width: 60px;
	height: 60px;
}

.dropdown {
	position: relative;
	display: inline-block;
}

.dropdown-content {
	transition: opacity 1s ease;
	opacity: 0;
	height: 0;
	overflow: hidden;
	position: absolute;
	background-color: #f1f1f1;
	min-width: 160px;
	box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
	z-index: 1;
	transition: 0.2s;
	text-align: center;
}

.dropdown-content a {
	color: #2c3e50;
	padding: 12px 16px;
	text-decoration: none;
	display: block;
	transition: 0.3s ease;
}

#logoutBtn:hover {
	color: red;
	cursor: pointer;
}

.dropdown-content a:hover {
	background-color: #ddd;
}

.dropdown:hover .dropdown-content {
	opacity: 1;
	height: auto;
}

.dashboard {
	height: 120px;
	box-shadow: 0 0px 8px 0 rgba(0, 0, 0, 0.2);
	border-radius: 10px;
	padding: 15px;
	margin:auto;
	margin-top:20px;
	margin-bottom:20px;
	background-color: white;
}

.dashboard-content p {
	color: #1fbf9a;
	font-size: 30px;
	margin: 0;
}

.dashboard-content .subtitle {
	color: #999;
	font-size: 15px;
}

#pagination-container p{
	color: #2a6670;
	font-size:20px;
}

#patient-table tr.patient-row {
	display: none;
}

#pages {
	padding: 10px;
	text-align: center;
}

#pages a {
	color: white;
	background-color:#2a6670;
	margin: 5px 10px;
	padding: 5px;
	text-decoration: none;
}

#pages a.active {
	color: white;
	background-color: #6ac4c0;
}


</style>
</head>

<body>
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
			<ul class="navbar-nav ml-auto" style="margin-right: 70px;">

				<li class="nav-item active"><a class="nav-link"
					href="mainMenuAdmin.jsp">Home <span class="sr-only">(current)</span></a>
				</li>
			</ul>
		</div>
	</nav>

	<section class="page-section portfolio" id="dashboard">
		<div class="container">
			<div class="dashboard">
				<div class="dashboard-content">
					<p class="subtitle">What would you like to do today?</p>
				</div>
			</div>
			
			<form action="" method="get" class="mb-3">
				<div>
					<a class="button btn-first" href="billview.jsp">Send Bill</a> 
					<a class="button" href="generatedBills.jsp">Bill History</a>
				</div>
			</form>
		</div>
	</section>

	<!-- Copyright Section-->
	<div class="copyright py-4 text-center text-white">
		<div class="container">
			<small>Copyright &copy; FYP-22-S2-20 2022</small>
		</div>
	</div>

	<!-- Bootstrap core JS-->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<!-- Core theme JS-->
	<script src="js/scripts.js"></script>
	<script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>
	<script src="vendor/jquery/jquery.min.js"></script>
	<!-- jquery CDN -->
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	
	<script src="js/main.js"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<link rel="stylesheet" href="alert/dist/sweetalert.css">
</body>
</html>
