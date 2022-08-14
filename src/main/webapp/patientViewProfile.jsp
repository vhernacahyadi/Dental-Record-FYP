<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%
try {
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
	if (session.getAttribute("name") == null) {
		response.sendRedirect("login.jsp");
	} else {
	}
} catch (Exception ex) {
	out.println(ex);
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>Patient View Details</title>
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

#showPasswordBox {
	display: inline-block;
	width: 200px;
}

.wrap-contact100 {
	position: relative;
	bottom: 50px;
}

.p-content {
	color: black;
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
					href="mainMenuPatient.jsp">Home <span class="sr-only">(current)</span></a></li>
			</ul>
		</div>
	</nav>

	<%
	try {
		Connection con;
		Statement stmt;
		ResultSet rs;
		String id = request.getParameter("id");
		Class.forName("com.mysql.cj.jdbc.Driver");
		con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dentalrecord?useSSL=false", "root", "passwordroot");
		PreparedStatement sql = con.prepareStatement(
		"select * from customer where email IN (select useremail from users where iduserAccounts = ?);");
		sql.setString(1, id);
		rs = sql.executeQuery();
		while (rs.next()) {
	%>
	<section>
		<div class="main">
			<div class="container-contact100">
				<div class="wrap-contact100">
					<div class="contact100-form-title"
						style="background-image: url(img/bg-01.jpg);">
						<span class="contact100-form-title-1"> Your Details </span>
					</div>

					<form class="contact100-form validate-form" action="#"
						method="post" class="register-form" id="register-form">

						<div class="hiddeninfo">
							<label for="name"><i
								class="zmdi zmdi-account material-icons-name"></i></label> <input
								type="text" name="id" id="id" value=<%=rs.getString(1)%> />
						</div>

						<p>
							<b>Name:</b>
						</p>
						<div class="wrap-input100 validate-input"
							data-validate="Valid email is required: ex@abc.xyz">
							<span class="label-input100"><i class="zmdi zmdi-account material-icons-name"></i></span>
							<input class="input100" type="email" name="email" id="email"
								value=<%=rs.getString(2)%> disabled> <span
								class="focus-input100"></span>
						</div>
						
						<p>
							<b>IC Number:</b>
						</p>
						<div class="wrap-input100 validate-input"
							data-validate="Password is required">
							<span class="label-input100"><i
								class="zmdi zmdi-account-box-mail"></i></span> <input class="input100"
								type="text" name="icNum" id="icNum" value="<%=rs.getString(5)%>"
								disabled> <span class="focus-input100"></span>
						</div>

						<p>
							<b>Email:</b>
						</p>
						<div class="wrap-input100 validate-input"
							data-validate="Valid email is required: ex@abc.xyz">
							<span class="label-input100"><i class="zmdi zmdi-email"></i></span>
							<input class="input100" type="email" name="email" id="email"
								value=<%=rs.getString(7)%> disabled> <span
								class="focus-input100"></span>
						</div>

						<p>
							<b>Address:</b>
						</p>
						<div class="wrap-input100 validate-input"
							data-validate="Password is required">
							<span class="label-input100"><i
								class="zmdi zmdi-gps-dot"></i></span> <input class="input100"
								type="text" name="address" id="address"
								value="<%=rs.getString(3)%>" disabled> <span
								class="focus-input100"></span>
						</div>

						<p>
							<b>Password:</b>
						</p>
						<div class="wrap-input100 validate-input"
							data-validate="Password is required">
							<span class="label-input100"><i
								class="zmdi zmdi-lock-outline"></i></span> <input class="input100"
								type="text" name="mobileNo" id="mobileNo"
								value="<%=rs.getString(6)%>" disabled> <span
								class="focus-input100"></span>
						</div>

						<!-- Family Members -->
						<div class="mt-3 mb-3" style="width: 100%">
							<p class="fam-title">
								<b>Family Members:</b>
							</p>
							<div id="pagination-container" style="width: 100%;">
								<%
								Statement stmt2;
								ResultSet rs2;
								try {
									stmt2 = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
									String sql2 = "select idcustomer, name from customer where idcustomer IN ( select familymemberId from familymember where patientId = "
									+ rs.getString(1) + ") order by idcustomer";

									rs2 = stmt2.executeQuery(sql2);
									if (rs2.next() != true) {
								%>
								<p class="p-content">No family members found.</p>
								<%
								} else {
								rs2.beforeFirst();
								while (rs2.next()) {
								%>
								<table border="1" class="table table-sm" id="family-table">
									<tr>
										<th style="width: 25%;">Patient ID</th>
										<th style="width: 75%;">Name</th>
									</tr>
									<%
									do {
									%>
									<tr class="family-row">
										<td><%=rs2.getString(1)%></td>
										<td><%=rs2.getString(2)%></td>
									</tr>
									<%
									} while (rs2.next());
									} ;
									%>
								</table>

								<%
								}
								%>
								<p class="fam-title">
									<b>Historical Records:</b>
								</p>
								<%
								String idQuery = "select idcustomer from customer where email in (select useremail from users where iduserAccounts = "
										+ id + ")";
								rs2 = stmt2.executeQuery(idQuery);
								if (rs2.next()) {
									id = String.valueOf(rs2.getInt(1));
								}

								sql2 = "select history, historyDate, description from historicalrecords where idcustomer =" + id;
								rs2 = stmt2.executeQuery(sql2);
								if (rs2.next() != true) {
								%>
								<p class="p-content">No historical records.</p>
								<%
								} else {
								rs2.beforeFirst();
								while (rs2.next()) {
								%>
								<table border="1" class="table table-sm" id="patient-table">
									<tr>
										<th style="width: 20%;">History</th>
										<th style="width: 20%;">Date</th>
										<th style="width: 50%;">Description</th>
									</tr>
									<%
									do {
									%>
									<tr class="patient-row">
										<td><%=rs2.getString(1)%></td>
										<td><%=rs2.getString(2)%></td>
										<td><%=rs2.getString(3)%></td>
									</tr>
									<%
									} while (rs2.next());
									%>
								</table>
							</div>
							<%
							}
							}

							con.close();

							} catch (Exception e) {
							System.out.println(e.getMessage());
							e.getStackTrace();
							}
							%>

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
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script>
		$("document")
				.ready(
						function() {
							$("#pagination-container").after(
									'<div id="pages" class="mb-2"></div>');
							var rowsShown = 5;
							var rowsTotal = $("#patient-table tbody tr.patient-row").length;
							var numPages = rowsTotal / rowsShown;

							for (let i = 0; i < numPages; i++) {
								pageNo = i + 1;
								$("#pages").append(
										'<a href="#record-heading" rel="' + i + '">'
												+ pageNo + '</a>');
							}

							$("#patient-table tbody tr.patient-row").hide();
							$("#patient-table tbody tr.patient-row").slice(0,
									rowsShown).show();
							$("#pages a:first").addClass("active");
							$("#pages a")
								.bind(
									'click',
									function() {
										$("#pages a").removeClass("active");
										$(this).addClass("active");
										let currPage = $(this).attr("rel");
										let startItem = currPage * rowsShown;
										let endItem = startItem + rowsShown;
										$("#patient-table tbody tr.patient-row").css("opacity", "0.0").hide().slice(startItem,endItem).css("display","table-row").animate({opacity : 1}, 300);

									});
						});
	</script>
	<script>
		function hideFunction() {
			var hiddenInformation = document
					.getElementsByClassName("hiddeninfo");
			for (var i = 0; i < hiddenInformation.length; i++) {
				hiddenInformation[i].style.display = 'none';
			}
		}
	</script>

</body>
</html>
