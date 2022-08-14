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
<title>Patient Home Page</title>
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
			<h3>
				<b>Dental Record Management System</b>
			</h3>
			<div class="dropdown">
				<button class="dropbtn">
					<img id="avatar" src="img/avatar.png" alt="Avatar"></img>
				</button>
				<div class="dropdown-content">
					<span id="sessionUsername">Logged in as: <%=session.getAttribute("name")%></span>
					<a href="account.jsp">Edit Profile</a> <a href="logout"
						id="logoutBtn">Sign out</a>
				</div>
			</div>

			<ul class="navbar-nav ml-auto" style="margin-right: 70px;">

				<li class="nav-item active"><a class="nav-link"
					href="mainMenuPatient.jsp">Home <span class="sr-only">(current)</span></a>
				</li>
			</ul>
		</div>
	</nav>

	<section class="page-section portfolio" id="dashboard">
		<div class="container">
			<div class="dashboard">
				<div class="dashboard-content">
					<p>
						Welcome,
						<%=session.getAttribute("name")%> !
					</p>
					<p class="subtitle">What would you like to do today?</p>
				</div>
			</div>
			
			<form action="" method="get" class="mb-3">
				<div>
					<a class="button btn-first" href=./records.jsp?id=<%=session.getAttribute("id")%>>View Past Appointments</a> 
					<a class="button" href=./patientViewProfile.jsp?id=<%=session.getAttribute("id")%>>View Profile</a>
					<a class="button" href=./patientBookAppointment.jsp?id=<%=session.getAttribute("id")%>>Book Appointment</a>
				</div>
			</form>
		</div>
	</section>

	
	
	<section>
		<div class="container">
			<div id="pagination-container">
				<p style="font-size: 20px">Upcoming Appointments:</p>
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

						data = "select appointmentid, docname, services, date, apptime from appointment where date > CURDATE() AND custid = "
							+ id + " AND clinicId = "+ clinicId +" order by date";
						rss = stats.executeQuery(data);

		
					%>
					<input type="hidden" id="status" value="error">
					<%
					
					rss.beforeFirst();

					while (rss.next()) {
					%>

					<table border="1" class="table" id="patient-table">
						<tr>
							<th style="width:10%;">Appointment ID</th>
							<th style="width:22%;">Doctor Name</th>
							<th style="width:22%;">Services</th>
							<th style="width:24%;">Date of Appointment</th>
							<th style="width:22%;">Time of Appointment</th>
						</tr>
						<%
						do {
						%>

						<tr class="patient-row">
							<td><%=rss.getInt(1)%></td>
							<td><%=rss.getString(2)%></td>
							<td><%=rss.getString(3)%></td>
							<td><%=rss.getString(4)%></td>
							<td><%=rss.getString(5)%></td>
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
	<script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>
	<script src="vendor/jquery/jquery.min.js"></script>
	<!-- jquery CDN -->
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script>
		$("document").ready(function(){
			$("#pagination-container").after('<div id="pages"></div>');
			var rowsShown = 7;
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
	
	
	<script src="js/main.js"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<link rel="stylesheet" href="alert/dist/sweetalert.css">
	
</body>
</html>
