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
<title>Appointment List</title>
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
			<ul class="navbar-nav mr-auto">
				<li class="nav-item active"><a class="nav-link"
					href="mainMenuPatient.jsp">Home <span class="sr-only">(current)</span></a></li>
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
					<%
					try {
						Statement stats = null;
						ResultSet rss = null;
						String id = session.getAttribute("id").toString();

						
						int customerid = 0;
						Class.forName("com.mysql.cj.jdbc.Driver");
						Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dentalrecord?useSSL=false", "root",
						"passwordroot");
						stats = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
						String query = request.getParameter("search");
						String data;
						
						System.out.println(id);
						
						
						if (query != null) {
							data = "select appointmentid, docname, description, services, medicare, expdate, date from appointment where (docname like '%"
							+ query + "%' or description like '%" + query + "%' or date like '%" + query + "%') and custid = " + id
							+ "";
						} else
							data = "select appointmentid, docname, description, services, medicare, expdate, date from appointment where date < CURDATE() AND custid = "
							+ id + "";
						
						System.out.println("bro " + data);
						rss = stats.executeQuery(data);
						
						if (rss.next() != true) {
							data = "select appointmentid, docname, description, services, medicare, expdate, date from appointment where date < CURDATE() AND custid = "
							+ id + "";
							rss = stats.executeQuery(data);
					%>
					<input type="hidden" id="status" value="error">
					<%
					}
						
					rss.beforeFirst();

					while (rss.next()) {
					%>

					<table border="1" class="table" id="patient-table">
						<tr>
							<th style="width:5%;">Appointment ID</th>
							<th style="width:15%;">Doctor Name</th>
							<th style="width:20%;">Services</th>
							<th style="width:10%;">Date of Appointment</th>
						</tr>
						<%
						do {
						%>

						<tr class="patient-row">
							<td><%=rss.getInt(1)%></td>
							<td><%=rss.getString(2)%></td>
							<td><%=rss.getString(4)%></td>
							<td><%=rss.getString(7)%></td>
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

	<script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>
	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="js/main.js"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<script>
		var status = document.getElementById("status").value;
		console.log(status);
		if(status == "error")
		{
			swal("Sorry","No record(s) found!","error");
		}
		
		
	</script>
</body>
</html>
