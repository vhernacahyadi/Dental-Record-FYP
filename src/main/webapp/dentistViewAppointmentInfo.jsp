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
<!-- Font Icon -->
<link rel="stylesheet"
	href="fonts/material-icon/css/material-design-iconic-font.min.css">
<style>
body {
	background :linear-gradient(0deg, rgba(115,245,158,0.2502043053549545) 0%, rgba(171,227,255,0.8608485630580357) 100%);
	background-position: center center;
    background-repeat: no-repeat;
    background-attachment: fixed;
    background-size: cover;
}

p{
	width:100%;
}

p.title{
	font-size:20px;
	position:relative;
	right: 50px;
	margin-bottom: 10px;
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
					href="mainMenuDentist.jsp">Home <span class="sr-only">(current)</span></a></li>
			</ul>
		</div>
	</nav>

	
	<%
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dentalrecord?useSSL=false", "root", "passwordroot");
	Statement stmt;
	ResultSet rs;
	String id = request.getParameter("id");
	try {
		Class.forName("com.mysql.cj.jdbc.Driver");
		stmt = con.createStatement();
		String sql = "select * from customer where email in (select useremail from users where iduserAccounts=" + id + ");";
		
		rs = stmt.executeQuery(sql);

		while (rs.next()) {
			
			
	%>
	<section>
		<div class="main">
			<div class="container-contact100">
				<div class="wrap-contact100">
					<div class="contact100-form-title"
						style="background-image: url(img/bg-01.jpg);">
						<span class="contact100-form-title-1"> Patient and Appointment Details </span>
					</div>

					<form class="contact100-form validate-form" action="appointDoctor"
						method="post" id="appointDoctor">
						
						<input type="hidden" id="status" value="<%=request.getAttribute("status")%>">
						
						<p><b>Name:</b></p>
						<div class="wrap-input100 validate-input"
							data-validate="Name is required">
							<span class="label-input100"><i
								class="zmdi zmdi-account material-icons-name"></i></span> <input
								class="input100" readonly type="text" name="name" id="name"
								value=<%=rs.getString(2)%> > 
								<span class="focus-input100"></span>
						</div>

						<p><b>Email:</b></p>
						<div class="wrap-input100 validate-input"
							data-validate="Valid email is required: ex@abc.xyz">
							<span class="label-input100"><i class="zmdi zmdi-email"></i></span>
							<input class="input100" readonly type="email" name="email" id="email"
								value=<%=rs.getString(7)%> > 
								<span class="focus-input100"></span>
						</div>

						<p><b>Phone Number:</b></p>
						<div class="wrap-input100 validate-input"
							data-validate="Contact is required">
							<span class="label-input100"><i class="zmdi zmdi-phone"></i></span>
							<input class="input100" readonly type="text" name="contact" id="contact"
								value=<%=rs.getString(6)%> >
							<span class="focus-input100"></span>
						</div>
						
						<%
						Statement stat = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
						String data;
						String id2 = request.getParameter("appid");

						data = "select appointmentid, date, apptime, custid, docname, services from appointment where appointmentid = "+ id2;
						ResultSet rsss = stat.executeQuery(data);
						rsss.beforeFirst();

						while (rsss.next()) {
						%>
						 <input type="hidden" name="id" id="id" value=<%=rsss.getString(1)%> />
						 <input	type="hidden" name="custid" id="custid" value=<%=rsss.getString(4)%> />
						
						<p class="title"><b>Appointment Details</b></p>
						
						<p><b>Appointment Date:</b></p>
						<div class="wrap-input100 validate-input"
							data-validate="Address is required">
							<span class="label-input100"><i class="zmdi zmdi-calendar-alt"></i></span>
							<input class="input100" readonly type="text" name="dates" id="dates"
								value="<%=rsss.getString(2)%>" >
							<span class="focus-input100"></span>
						</div>
						
						<p><b>Appointment time slot:</b></p>
						<div class="wrap-input100 validate-input"
							data-validate="Address is required">
							<span class="label-input100"><i class="zmdi zmdi-time"></i></span>
							<input class="input100" readonly type="text" name="times" id="times"
								value="<%=rsss.getString(3)%>" >
							<span class="focus-input100"></span>
						</div>
						
						<p><b>Appointment service:</b></p>
						<div class="wrap-input100 validate-input"
							data-validate="Address is required">
							<span class="label-input100"><i class="zmdi zmdi-hospital-alt"></i></span>
							<input class="input100" readonly type="text" name="times" id="times"
								value="<%=rsss.getString(6)%>" >
							<span class="focus-input100"></span>
						</div>
						
						<p class="mb-4"><b>Assigned doctor: </b><%=rsss.getString(5) %></p>
						<%
						};

						String dataMats = "select itemname from inventory where itemid in (select materialsid from materialsused where appointmentid = " + id2 + ")";
						ResultSet rsMats = stat.executeQuery(dataMats);
						rsMats.beforeFirst();

						while (rsMats.next()) {
						%>
						<p><b>Materials used:</b></p>
							<%
							do{
								%>
								<p><%=rsMats.getString(1)%></p>
								
								<%
							}while (rsMats.next());
							%>
						<%
						}
						%>
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
	
</body>
</html>
