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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Family Member List</title>
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

#patient-table tr.patient-row , #add-family-table tr.add-family-row{
	display: none;
}

#pages, #fam-pages {
	padding: 10px;
	text-align: right;
}

#pages a,  #fam-pages a {
	color: white;
	background-color: #2a6670;
	margin: 5px 10px;
	padding: 5px;
	text-decoration: none;
}

#pages a.active,  #fam-pages a.active {
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

section{
	width:100%;
	display:flex;
	
}

div{
	display:inline-block;
}

.fam-title{
	font-size: 30px;
}

p.subtitle{
	padding:20px;
	background-color:white;
	text-align:center;
	box-shadow:0 0 10px rgb(0 0 0/0.2);
	
}

</style>
</head>

<body>
	<!-- Navbar -->
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
					href="vieweditpatient.jsp?id=<%=request.getParameter("id")%>">Back</a></li>
			</ul>
		</div>
	</nav>
	
	<!-- Content -->
	<section>
		<div class=" ml-5 w-50">
			<p class="fam-title">Family Members:</p>
			<div id="pagination-container" style="width:90%;">
				<%
				Connection con;
				Statement stmt;
				ResultSet rs;
				String id = request.getParameter("id");
				try {
					Class.forName("com.mysql.cj.jdbc.Driver");
					con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dentalrecord?useSSL=false", "root", "passwordroot");
					stmt = con.createStatement();
					String sql = "select idcustomer, name from customer where idcustomer IN ( select familymemberId from familymember where patientId = " + id + ") order by idcustomer";
					rs = stmt.executeQuery(sql);
					System.out.println("id:" + id);
					while (rs.next()) {
					%>
						<table border="1" class="table" id="patient-table">
							<tr>
								<th style="width: 20%;">Patient ID</th>
								<th style="width: 80%;">Name</th>
							</tr>
						<%
						do {
						%>
							<tr class="patient-row">
								<td><%=rs.getString(1)%></td>
								<td><%=rs.getString(2)%></td>
							</tr>
						<%
						} while (rs.next());
					};
					con.close();
				} catch (Exception e) {
					System.out.println(e.getMessage());
					e.getStackTrace();
				}
				%>
				</table>
			</div>
		</div>
		
		<div class="w-50">
			<p class="fam-title">Add Family Members:</p>
			<form action="AddFamilyMember" method="post" id="add-family-form">
				<div id="add-pagination-container" style="width:90%;">
					<%
						try {
							Statement stats = null;
							ResultSet rss = null;
							
							//id = session.getAttribute("id").toString();
							String clinicId = session.getAttribute("clinicId").toString();
	
							int customerid = 0;
							Class.forName("com.mysql.cj.jdbc.Driver");
							Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dentalrecord?useSSL=false", "root",
							"passwordroot");
							stats = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
							String query = request.getParameter("search");
							String data;
	
							data = "select idcustomer, name, mobileNo from customer where clinicId = " + clinicId + " and (idcustomer != " + id + " and idcustomer NOT IN (select familymemberId from familymember where patientId = " + id + "))";
							System.out.println(data);
							rss = stats.executeQuery(data);
	
			
						%>
						<input type="hidden" id="status" value="<%=request.getAttribute("status")%>">
						<input type="hidden" id="clinicId" name="clinicId" value=<%=session.getAttribute("clinicId")%>>
						<input type="hidden" id="patientId" name="patientId" value=<%=request.getParameter("id") %>>
						<%
						rss.beforeFirst();
	
						while (rss.next()) {
						%>
	
						<table border="1" class="table" id="add-family-table">
							<tr>
								<th style="width:20%;">Patient ID</th>
								<th style="width:50%;">Name</th>
								<th style="width:20%;">Contact No</th>
								<th style="width:10%;">Action</th>
							</tr>
							<%
							do {
							%>
	
							<tr class="add-family-row">
								<td><%=rss.getInt(1)%></td>
								<td><%=rss.getString(2)%></td>
								<td><%=rss.getString(3)%></td>
								<td><button class="add-family-btn" type="submit" name="addFamilyBtn" value=<%=rss.getInt(1)%>>Add</button></td>
							</tr>
	
							<%
							} while (rss.next());
						}
						conn.close();
	
						} catch (Exception e) {
							System.out.println(e.getMessage());
							e.getStackTrace();
						}
						%>
					</table>
				</div>
			</form>
		</div>
	</section>
	
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="js/main.js"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<link rel="stylesheet" href="alert/dist/sweetalert.css">
	<script>
		$("document").ready(function(){
			$("#pagination-container").after('<div id="pages" class="w-50"></div>');
			$("#add-pagination-container").after('<div id="fam-pages" class="w-50"></div>');
			var rowsShown = 5;
			var rowsTotal = $("#patient-table tbody tr.patient-row").length;
			var addFamRowsTotal =  $("#add-family-table tbody tr.add-family-row").length;
			var numPages = rowsTotal/rowsShown;
			var famNumPages = addFamRowsTotal/rowsShown;
			
			if(numPages > 0){
				for(let i = 0; i < numPages; i++){
					pageNo = i + 1;
					$("#pages").append('<a href="#" rel="' + i + '">' + pageNo + '</a>');
				}
			}
			else{
				$("#pages").append('<p class="subtitle">No family member.</p>')
			}
			
			if(famNumPages > 0){
				for(let i = 0; i < numPages; i++){
					pageNo = i + 1;
					$("#fam-pages").append('<a href="#" rel="' + i + '">' + pageNo + '</a>');
				}
			}
			else{
				$("#fam-pages").append('<p class="subtitle">No more patients.</p>');
			}
			
			for(let i = 0; i < numPages; i++){
				
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
			
			$("#add-family-table tbody tr.add-family-row").hide();
			$("#add-family-table tbody tr.add-family-row").slice(0, rowsShown).show();
			$("#fam-pages a:first").addClass("active");
			$("#fam-pages a").bind('click', function(){
				$("#fam-pages a").removeClass("active");
				$(this).addClass("active");
				let currPage = $(this).attr("rel");
				let startItem = currPage * rowsShown;
				let endItem = startItem + rowsShown;
				
				$("#add-family-table tbody tr.add-family-row").css("opacity", "0.0").hide().slice(startItem, endItem).css("display", "table-row").animate({opacity:1}, 300);
				
			});
			
			var status = document.getElementById("status").value;
			console.log(status);
			if(status == "success")
			{
				swal("Success","Family member added!","success");
			}
			else if(status == "error"){
				swal("Sorry","An error occured when trying to add family member.","error");
			}
		});
	</script>
</body>
</html>