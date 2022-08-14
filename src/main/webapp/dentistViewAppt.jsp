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
<title>Patient List</title>
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
	background: linear-gradient(0deg, rgba(115, 245, 158, 0.2502043053549545)
		0%, rgba(171, 227, 255, 0.8608485630580357) 100%);
	background-position: center center;
	background-repeat: no-repeat;
	background-attachment: fixed;
	background-size: cover;
}

.serchbar {
	width: 60%;
	height: 5%;
	margin-top: 2%;
	margin-left: 100px;
	margin-bottom: 0%;
}

.search {
	width: 40%;
	height: 40px;
	border-radius: 10px;
}

.text-center {
	color: grey;
	padding: 10px;
	margin-top: 0px;
}

input {
	text-align: center;
}

::-webkit-input-placeholder {
	text-align: center;
}

:-moz-placeholder {
	text-align: center;
}

.mybutton {
	display: inline;
}

#test {
	min-height: 500px;
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
	background-color: #2a6670;
	margin: 5px 10px;
	padding: 5px;
	text-decoration: none;
}

#pages a.active {
	color: white;
	background-color: #6ac4c0;
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
</style>
</head>

<body>
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<a href="mainMenuDentist.jsp" class="navbar-brand"> <img
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
			<h3>
				<b>Dental Record Management System</b>
			</h3>
			<div class="dropdown">
				<button class="dropbtn">
					<img id="avatar" src="img/avatar.png" alt="Avatar"></img>
				</button>
				<div class="dropdown-content">
					<span id="sessionUsername">Logged in as: <%=session.getAttribute("name")%></span>
					<a href="accountDentist.jsp"> View/Edit profile</a> <a href="logout"
						id="logoutBtn">Sign out</a>
				</div>
			</div>

			<ul class="navbar-nav ml-auto" style="margin-right: 70px;">

				<li class="nav-item active"><a class="nav-link"
					href="mainMenuDentist.jsp">Home <span class="sr-only">(current)</span></a>
				</li>

				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
					role="button" data-toggle="dropdown" aria-haspopup="true"
					aria-expanded="false"> DENTIST </a>
					<div class="dropdown-menu" aria-labelledby="navbarDropdown">
						<a class="dropdown-item" href="">Browse Appointment</a>
						<a class="dropdown-item" href="dentistRecords.jsp">Browse Record</a>
					</div>
				</li>
			</ul>
		</div>
	</nav>

	<div class="serchbar">
		<form action=" " method="post">
			<input class="search" type="text" name="search"
				placeholder="Search Here..." />
		</form>
	</div>
	<br>

	<section>
		<div class="container">
			<div id="pagination-container">
				<p>Upcoming Appointments:</p>
					<%
					try {
						Statement stats = null;
						ResultSet rss = null;
						
						String id = session.getAttribute("id").toString();
						String clinicId = session.getAttribute("clinicId").toString();

						int customerid = 0;
						Class.forName("com.mysql.cj.jdbc.Driver");
						Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dentalrecord?useSSL=false", "root",
						"passwordroot");
						stats = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
						String query = request.getParameter("search");
						String data;
						
						data = "select custid, appointmentid, docname, services, date, apptime from appointment where date > CURDATE() AND clinicId = "+ clinicId +" order by date";
						rss = stats.executeQuery(data);
						
		
					%>
					<input type="hidden" id="status" value="error">
					<%
					
					rss.beforeFirst();

					while (rss.next()) {
					%>

					<table border="1" class="table" id="patient-table">
						<tr>
							<th style="width:10%;">Customer ID</th>
							<th style="width:10%;">Appointment ID</th>
							<th style="width:17%;">Doctor Name</th>
							<th style="width:19%;">Services</th>
							<th style="width:17%;">Date of Appointment</th>
							<th style="width:17%;">Time of Appointment</th>
							<th style="width:10%;">Action</th>
						</tr>
						<%
						do {
						%>

						<tr class="patient-row">
							<td><%=rss.getInt(1)%></td>
							<td><%=rss.getInt(2)%></td>
							<td><%=rss.getString(3)%></td>
							<td><%=rss.getString(4)%></td>
							<td><%=rss.getString(5)%></td>
							<td><%=rss.getString(6)%></td>
							<td><a class="btn" href=./viewpatientinfo.jsp?id=<%=rss.getInt(1)%>>View</a></td>
						</tr>

						<%
						} while (rss.next());
					}
					con.close();

					} catch (Exception e) {
						System.out.println(e.getMessage());
						e.getStackTrace();
					}
					%>
				</table>
			</div>
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
	<!-- jquery CDN -->
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script>
		$("document").ready(function(){
			$("#pagination-container").after('<div id="pages"></div>');
			var rowsShown = 5;
			var rowsTotal = $("#patient-table tbody tr.patient-row").length;
			var numPages = rowsTotal/rowsShown;
			
			for(let i = 0; i < numPages; i++){
				pageNo = i + 1;
				$("#pages").append('<a href="#" rel="' + i + '">' + pageNo + '</a>');
			}
			
			$("#patient-table tbody tr.patient-row").hide();
			$("#patient-table tbody tr.patient-row").slice(0, rowsShown).show();
			$("#pages a:first").addClass("active");
			$("#pages a").bind('click', function(){
				$("#pages a").removeClass("active");
				$(this).addClass("active");
				let currPage = $(this).attr("rel");
				let startItem = currPage * rowsShown;
				let endItem = startItem + rowsShown;
				
				$("#patient-table tbody tr.patient-row").css("opacity", "0.0").hide().slice(startItem, endItem).css("display", "table-row").animate({opacity:1}, 300);
				
			});
		});
	</script>

	<script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>
	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="js/main.js"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<script>
		const logoutBtn = document.getElementById("logoutAnchor");
		const modalLogoutBtn = document.getElementById("modalLogout");
		const modal = document.getElementById("logoutModal");
		const closeBtn = document.getElementById("close");
		const dropdownContent = document.getElementsByClassName("dropdown-content");
		
		function recordNotFound() {
			document.getElementById("labelFound").innerText = "Record not found!";
		}

		var status = document.getElementById("status").value;
		console.log(status);
		if(status == "error")
		{
			swal("Sorry","No record(s) found!","error");
		}
		
		console.log(document.getElementById("logoutAnchor"));
		console.log(logoutBtn);
		modalLogoutBtn.addEventListener("click", (e) => {
		    window.location.href = 'login.jsp';
		});
		
		logoutBtn.addEventListener("click", function(){
			modal.style.visibility = "visible";
			console.log(dropdownContent[0])
			dropdownContent[0].opacity = 0;
		});
		
		closeBtn.addEventListener("click", function(){
			modal.style.visibility = "hidden";
		});
	
	</script>
</body>
</html>
