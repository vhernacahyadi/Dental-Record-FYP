<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>View/Edit Patient</title>
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
	background:linear-gradient(0deg, rgba(115,245,204,0.2726132689403886) 0%, rgba(64,163,172,0.4490838571756828) 100%);
	background-position: center center;
    background-repeat: no-repeat;
    background-attachment: fixed;
    background-size: cover;
}

#delete-form {
	padding:0;
	position:absolute;
	bottom:3.2%;
	left:55%;
}

</style>
</head>
<body onload="hideFunction()">
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
					href="mainMenuAdmin.jsp">Home <span class="sr-only">(current)</span></a></li>
				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
					role="button" data-toggle="dropdown" aria-haspopup="true"
					aria-expanded="false"> PATIENT </a>
					<div class="dropdown-menu" aria-labelledby="navbarDropdown">
						<a class="dropdown-item" href="addPatient.jsp">Add Patient</a> <a
							class="dropdown-item" href="mainMenuAdmin.jsp">Patient List</a>
					</div></li>
			</ul>
		</div>
	</nav>

	<%
	Connection con;
	Statement stmt,stmt2;
	ResultSet rs;
	String id = request.getParameter("id");
	String userId;
	try {
		Class.forName("com.mysql.cj.jdbc.Driver");
		con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dentalrecord?useSSL=false", "root", "passwordroot");
		stmt = con.createStatement();
		Statement stmtt = con.createStatement();
		
		String sqll = "select iduserAccounts from users where useremail in (select email from customer where idcustomer = " + id + ")";
		
		
		ResultSet rs2 = stmtt.executeQuery(sqll);
		
		if(rs2.next()){
			userId = String.valueOf(rs2.getInt(1));
		}
		
		String sql = "select * from customer where idcustomer=" + id;
		rs = stmt.executeQuery(sql);
		
		while (rs.next()) {
	%>
	<section>
		<div class="main">
			<div class="container-contact100">
				<div class="wrap-contact100">
					<div class="contact100-form-title"
						style="background-image: url(img/bg-01.jpg);">
						<span class="contact100-form-title-1"> Patient Details </span>
					</div>

					<form class="contact100-form validate-form" action="update"
						method="post" id="register-form">

						<div class="hiddeninfo">
							<label for="name"><i
								class="zmdi zmdi-account material-icons-name"></i></label> 
								<input
								type="text" name="id" id="id" value=<%=rs.getString(1)%> />
						</div>
						
						<div class="hiddeninfo">
							<label for="name"><i
								class="zmdi zmdi-account material-icons-name"></i></label> <input
								type="text" name="userid" id="userid" value=<%=rs2.getString(1)%> />
						</div>

						<p><b>Name:</b></p>
						<div class="wrap-input100 validate-input"
							data-validate="Name is required">
							<span class="label-input100"><i
								class="zmdi zmdi-account material-icons-name"></i></span> <input
								class="input100" type="text" name="name" id="name"
								value="<%=rs.getString(2)%>" > <span
								class="focus-input100"></span>
						</div>
						
						<p><b>IC Number:</b></p>
						<div class="wrap-input100 validate-input"
							data-validate="IC Number is required">
							<span class="label-input100"><i
								class="zmdi zmdi-account-box-mail"></i></span> <input class="input100"
								type="text" name="icnum" id="icnum" value=<%=rs.getString(5)%>
								> <span
								class="focus-input100"></span>
						</div>
						
						<p><b>Date Of Birth:</b></p>
						<div class="wrap-input100 validate-input"
							data-validate="Date of Birth is required">
							<span class="label-input100"><i class="zmdi zmdi-calendar"></i></span>
							<input class="input100" type="date" name="dob" id="dob"
								value=<%=rs.getString(4)%> >
							<span class="focus-input100"></span>
						</div>

						<p><b>Email:</b></p>
						<div class="wrap-input100 validate-input"
							data-validate="Valid email is required: ex@abc.xyz">
							<span class="label-input100"><i class="zmdi zmdi-email"></i></span>
							<input class="input100" type="email" name="email" id="email"
								value=<%=rs.getString(7)%> > <span
								class="focus-input100"></span>
						</div>

						<p><b>Phone Number:</b></p>
						<div class="wrap-input100 validate-input"
							data-validate="Contact is required">
							<span class="label-input100"><i class="zmdi zmdi-phone"></i></span>
							<input class="input100" type="text" name="contact" id="contact"
								value=<%=rs.getString(6)%> >
							<span class="focus-input100"></span>
						</div>

						<p><b>Address:</b></p>
						<div class="wrap-input100 validate-input"
							data-validate="Address is required">
							<span class="label-input100"><i class="zmdi zmdi-gps-dot"></i></span>
							<input class="input100" type="text" name="address" id="address"
								value="<%=rs.getString(3)%>" >
							<span class="focus-input100"></span>
						</div>
	
						<p style="display:block; width:100%;"><b>Family Members:</b></p><br>
						<div class="mb-4" style="width:100%;">
							
						<%
						stmt2 = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
						String familyQuery = "select idcustomer, name from customer where idcustomer IN ( select familymemberId from familymember where patientId = " + id + ") order by idcustomer";
						ResultSet rss = stmt2.executeQuery(familyQuery);
						if(rss.next() != true){
							%>
							<p> No family members found. </p>
							<% 
						}
						else{
							rss.beforeFirst();
							while (rss.next()) {
								%>
								<table border="1" class="table table-sm" id="family-table">
								<tr>
									<th style="width: 30%;">Customer ID</th>
									<th style="width: 70%;">Name</th>
								</tr>
								<%
								do {
								%>
									<tr class="family-row">
										<td><%=rss.getString(1)%></td>
										<td><%=rss.getString(2)%></td>
									</tr>
								<%
								} while (rss.next());	
								%>
								</table>
							
								<% 

							}
						}
						%>
						<a href=./ViewPatientFamilyMembers.jsp?id=<%=rs.getInt(1)%>>
							<button type="button" class="contact100-form-btn btn-other">Add Family Members</button>
						</a>
						<p id="record-heading" class="mt-3"><b>Historical Records:</b></p>
						<div id="pagination-container">
							
						<% 
						String historicalRecordsQuery = "select * from historicalrecords where idcustomer = " + id;
						rss = stmt2.executeQuery(historicalRecordsQuery);
						if(rss.next() != true){
							%>
							<p> No records found. </p>
							<% 
						}
						else{
							rss.beforeFirst();
							while (rss.next()) {
								%>
								<table border="1" class="table table-sm" id="patient-table">
								<tr>
									<th style="width: 30%;">History</th>
									<th style="width: 70%;">Description</th>
								</tr>
								<%
								do {
								%>
									<tr class="patient-row">
										<td><%=rss.getString(2)%></td>
										<td><%=rss.getString(4)%></td>
									</tr>
								<%
								} while (rss.next());	
								%>
								</table>
							</div>
								<% 

							}
						}
						%>
						<a href=createHistoricalRecords.jsp?id=<%=rs.getInt(1)%>>
							<button type="button" class="contact100-form-btn btn-other">Add Historical Records</button>
						</a>
						</div>
						
						
						<div class="container-contact100-form-btn mb-4">
							<button class="contact100-form-btn btn-update"id="updateBtn">
								<span> Update </span>
							</button>
						</div>
					</form>
					<form method="post" action="delete"
						class="contact100-form validate-form small-form" id="delete-form">
						<div class="hiddeninfo">
							<label for="name"> <i
								class="zmdi zmdi-account material-icons-name"></i></label> <input
								type="text" name="id" id="id" value=<%=rs.getString(1)%> />
						</div>
						<div class="container-contact100-form-btn">
							<button class="btn-danger" id="deleteBtn">
								<span> Delete </span>
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
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script>
		$("document").ready(function(){
			$("#pagination-container").after('<div id="pages" class="mb-2"></div>');
			var rowsShown = 7;
			var rowsTotal = $("#patient-table tbody tr.patient-row").length;
			var numPages = rowsTotal/rowsShown;
			
			if(rowsTotal > 0){
				$("#delete-form").css("bottom", "2.3%");
			}
			
			for(let i = 0; i < numPages; i++){
				pageNo = i + 1;
				$("#pages").append('<a href="#record-heading" rel="' + i + '">' + pageNo + '</a>');
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
			
			$(".add-family-btn").on('click', function(e){
				
				console.log(this.value);
			});
		});
	</script>
	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="js/main.js"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<link rel="stylesheet" href="alert/dist/sweetalert.css">
	
	<script>
		function hideFunction() {
			var hiddenInformation = document
					.getElementsByClassName("hiddeninfo");
			for (var i = 0; i < hiddenInformation.length; i++) {
				hiddenInformation[i].style.display = 'none';
			}
		}
		
		const deleteBtn = document.getElementById("deleteBtn");
		const updateBtn = document.getElementById("updateBtn");
		
		// Sweet Alert for deletion
		deleteBtn.addEventListener('click', function(e){
			e.preventDefault();
			let deleteForm = document.getElementById("deleteForm");
			swal({
	            title: "Warning!",
	            text: "Are you sure you want to delete this user?", 
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
		
		// Sweet Alert for update
		updateBtn.addEventListener('click', function(e){
			e.preventDefault();
			let updateForm = document.getElementById("register-form");
			swal({
				title: "Warning!",
				text: "Are you sure you want to update this user's information?",
				icon: "warning",
				buttons: true,
				dangerMode: true,
			})
			.then((willUpdate) => {
				if (willUpdate) {
					updateForm.submit();
				}
			});
		});
	</script>
	
</body>
</html>
