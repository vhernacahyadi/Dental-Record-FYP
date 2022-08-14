<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>Patient Book Appointment</title>
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

.wrap-contact100 {
	position: relative;
	bottom: 50px;
}

#timeslot-container{
	display:none;
}

.timeslot-content{
	display:inline-block;
	border: 2px solid #3ba3a0;
	color: #37706f;
	padding:15px 20px;
	margin:5px;
	transition: 0.3s;
}
			
.timeslot-content:hover{
	cursor:pointer;
}

.timeslot-content span{
	font-family: Poppins-Regular;
}

.timeslot-active, .timeslot-content:hover{
	background-color: #3ba3a0;
	color:white;
}

p{
	width:100%;
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
		PreparedStatement sql = con.prepareStatement("select * from users where iduserAccounts =?");
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
						<span class="contact100-form-title-1"> Book Appointment </span>
					</div>

					<form class="contact100-form validate-form"
						action="bookappointment" method="post"
						class="bookAppointment-form" id="bookAppointment-form">

						<div class="hiddeninfo">
							<label for="clinicId"></label> 
								<input type="hidden" id="clinicId" name="clinicId" value="<%=session.getAttribute("clinicId") %>">
						</div>
						
						<div class="hiddeninfo">
							<label for="name"><i
								class="zmdi zmdi-account material-icons-name"></i></label> <input
								type="text" name="id" id="id" value=<%=rs.getString(1)%> />
						</div>

						<input type="hidden" id="status" value="<%=request.getAttribute("status")%>">

						<p><b>Service:</b></p>
						
						<%
						String pst3 = "select serviceName from dentalservices";
						Statement stats = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
						ResultSet rss = stats.executeQuery(pst3);
						
						rss.beforeFirst();
	
						while (rss.next()){
						%>
						<div class="validate-input mb-3">
							<span class="label-input100"><i style="position:relative;bottom:10px;"
								class="zmdi zmdi-assignment"></i></span>
								<select name="service" id="service" style="font-family: Poppins-Regular" required>
									<option value="">Select a service</option>
									<%
									do {
									%>
									<option value="<%=rss.getString(1)%>"><%=rss.getString(1)%></option>
									<%
									} while (rss.next());
								
						}
						%>
								</select> 		
							<span class="focus-input100"></span>
						</div>
						
						<p><b>Appointment Date:</b></p>		
						
						<div class="wrap-input100 validate-input">
							<span class="label-input100"><i class="zmdi zmdi-calendar"></i></span>
							<input class="input100" type="date" id="datepicker" size="60" name="date"
								placeholder="Select an appointment date">
							<span class="focus-input100"></span>
						</div>
						
						<span id="errorMsg1" style="color:red; font-family:Poppins-Regular"></span>
						
						<div class="validate-input" style="width:100%">
							<input type="hidden" name="timeslot" id="timeslot">
							<div id="timeslot-container">
								<p><b>Select a time slot:</b></p><br>
								<div class="timeslot-content">
									<span>09:00 am</span>
								</div>
								<div class="timeslot-content">
									<span>10:00 am</span>
								</div>
								<div class="timeslot-content">
									<span>11:00 am</span>
								</div>
								<div class="timeslot-content">
									<span>12:00 pm</span>
								</div>
								<div class="timeslot-content">
									<span>13:00 pm</span>
								</div>
								<div class="timeslot-content">
									<span>14:00 pm</span>
								</div>
								<div class="timeslot-content">
									<span>15:00 pm</span>
								</div>
								<div class="timeslot-content">
									<span>16:00 pm</span>
								</div>
								<div class="timeslot-content">
									<span>17:00 pm</span>
								</div>
								
							</div>
						</div>
							

						<div class="container-contact100-form-btn">
							<button class="contact100-form-btn btn-update" id="submit-btn">
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
	<%
	} ;
	con.close();
	} catch (Exception e) {
	System.out.println(e.getMessage());
	e.getStackTrace();
	}
	%>

	<!-- JS -->
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
		
		let timeslots = document.getElementsByClassName("timeslot-content");
		let container = document.getElementById("timeslot-container");
		let selectedTimeSlot = document.getElementById("timeslot");	
		let datepicker = document.getElementById("datepicker");
		let errorMsg = document.getElementById("errorMsg1");
		let submitBtn = document.getElementById("submit-btn");
		
		let selectedTime = timeslots[0];

		for(let i = 0; i < timeslots.length; i++){
			timeslots[i].addEventListener("click", function(){
				selectedTimeSlot.value = timeslots[i].getElementsByTagName("span")[0].textContent;
				timeslots[i].classList.toggle("timeslot-active");
				
				if(selectedTime != timeslots[i] && selectedTime.classList.contains("timeslot-active")){
					selectedTime.classList.toggle("timeslot-active");
				}
				
				if(errorMsg.textContent != ""){
					errorMsg.textContent = "";
					submitBtn.removeAttribute("disabled");
				}
				
				selectedTime = timeslots[i];
				console.log("hidden text val:" + selectedTimeSlot.value);
			});
		}

		let currDate = new Date();
		currDate = new Date(currDate.setDate(currDate.getDate() + 1)).toISOString().split('T')[0];
		datepicker.setAttribute("min", currDate);
		
		datepicker.addEventListener("change", function(){
			//check if user selects weekend
			var selectedDay = new Date(this.value).getUTCDay();
			if([6,0].includes(selectedDay)){
				errorMsg.textContent = "Cannot reserve on weekends.";
				submitBtn.setAttribute("disabled", true);
				container.style.display = "none";
			}
			else{
				errorMsg.textContent = "";
				submitBtn.removeAttribute("disabled");
				container.style.display = "block";
			}
		});
		
		submitBtn.addEventListener("click", function(){
			if(selectedTimeSlot.value == ""){
				submitBtn.setAttribute("disabled", true);
				errorMsg.textContent = "Please select a time slot."
			}
		})
		
		var status = document.getElementById("status").value;
		
		if(status == "success"){
			swal("Success!", "Successfully booked appointment.", "success")
				.then((placeholder) => {
					window.location.href = "mainMenuPatient.jsp";
				});
		}
		else if(status == "failed"){
			swal("Sorry","Failed to book appointment!","error");
		}
	</script>
	
</body>
</html>

</body>
</html>