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
<meta charset="ISO-8859-1">
<title>Insert title here</title>
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
<link rel="stylesheet" href="alert/dist/sweetalert.css">
<style>
body {
	background: linear-gradient(0deg, rgba(115, 245, 158, 0.2502043053549545)
		0%, rgba(171, 227, 255, 0.8608485630580357) 100%);
	background-position: center center;
	background-repeat: no-repeat;
	background-attachment: fixed;
	background-size: cover;
}

ul{
	background-color:white;
}

li{
	padding:10px;
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
					href="mainMenuAssit.jsp">Home <span class="sr-only">(current)</span></a></li>
			</ul>
		</div>
	</nav>

	

	<div class="container">
		<div class="row">
			<!-- Table of materials -->
			<div class="col-8">
				<h2 class="reg-font">Material List</h2>
				<div id="pagination-container" class="row" style="width:90%;">
			<%
			Connection con;
			Statement stmt;
			ResultSet rs;

			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dentalrecord?useSSL=false", "root", "passwordroot");
				stmt = con.createStatement();
				String sql = "select * from inventory where clinicId = " + session.getAttribute("clinicId");
				rs = stmt.executeQuery(sql);
				
				while (rs.next()) {
				%>
					<table border="1" class="table" id="inventory-table">
						<tr>
							<th style="width: 10%;">Item ID</th>
							<th style="width: 40%;">Name</th>
							<th style="width: 10%;">Inventory qty</th>
							<th style="width: 20%;">Qty to be used</th>
						</tr>
					<%
					do {
					%>
						<tr class="inventory-row">
							<td><%=rs.getInt(1)%></td>
							<td><%=rs.getString(2)%></td>
							<td><%=rs.getInt(4)%></td>
							<td class="d-flex">
								<button class="minus btn-info px-2"> - </button>
								<p class="mx-2">0</p>
								<button class="add btn-info px-2"> + </button>
							</td>
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

				<button type="button" class="btn btn-primary" id="clickme">Save Changes</button>
			</div>
			
			<!-- List -->
			<div class="col-4">
				<h2 class="reg-font">Added Items</h2>
				<div class="container my-3">
					<ul id="material-list"></ul>
				</div>
				<button type="button" class="btn btn-primary" id="submit-btn" disabled>Submit</button>
			</div>
		</div>
		
		<input type="hidden" id="appid" value=<%=request.getParameter("appid")%>>
		<input type="hidden" id="userid" value=<%=request.getParameter("id")%>>
		<input type="hidden" id="status" name="status" value=<%=request.getAttribute("status")%>>
					
	</div>
	
	
	<!-- JQuery CDN -->
	<script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>
	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="js/main.js"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script>
		let qtyArray = [];
		let itemNameArray = [];
		let itemIdArray = [];
		let apptId;
		let userId;
		
		$(document).ready(function(){

			//add the value of text when + button is clicked
			let addButtons = $(".add");
			for(i = 0; i < addButtons.length; i++){
				addButtons[i].addEventListener('click', function(){
					
					let inventoryQty = parseInt(this.parentElement.previousElementSibling.innerHTML);
					console.log(inventoryQty);
					if(parseInt(this.previousElementSibling.textContent) < inventoryQty)
						this.previousElementSibling.textContent = parseInt(this.previousElementSibling.textContent) + 1;
				});
			}
			
			//subtract the value of text when - button is clicked
			let minusButtons = $(".minus");
			for(i = 0; i < minusButtons.length; i++){
				minusButtons[i].addEventListener('click', function(){
					//console.log(this.nextElementSibling);
					if(parseInt(this.nextElementSibling.textContent) >= 1)
						this.nextElementSibling.textContent = parseInt(this.nextElementSibling.textContent) - 1;
				});
			}
			
			//send message to controller using AJAX
			const sendMessage = () =>{
				qtyArray = [];
				itemNameArray = [];
				itemIdArray = [];
				
				let divs = $("p");
				//store material ids and names to arrays, to be sent to to the controller
				for(i = 0; i < divs.length; i++){
					if(parseInt(divs[i].textContent) > 0){
						qtyArray.push(divs[i].textContent);
						let itemId = divs[i].parentElement.parentElement.firstElementChild.innerHTML;
						let itemName = divs[i].parentElement.parentElement.firstElementChild.nextElementSibling.innerHTML;
						
						itemNameArray.push(itemName);
						itemIdArray.push(itemId);
					}
				}
				
				apptId = $("#appid").val();
				userId = $("#userid").val();
				
				$("#material-list").empty();
				for(i = 0; i < qtyArray.length; i++){
					$("#material-list").append('<li>' + itemNameArray[i] + ', qty: ' + qtyArray[i] + ' </li>')
				}
				
				$("#material-list").addClass("border");
				$("#material-list").addClass("border-info")
				
				if(qtyArray.length > 0)
					$("#submit-btn").prop('disabled', false);
				else
					$("#submit-btn").prop('disabled', true);
				
			}
			
			$("#clickme").on("click", sendMessage);
			
			$("#submit-btn").on("click", function(){
				$.ajax({
					type:"POST",
					url:"MaterialUsed",
					data:{
						appid:apptId,
						userid:userId,
						quantity:qtyArray,
						itemIds:itemIdArray
					}
				}).done(function(){
					swal({
						title: "Success",
						text: "Materials Added!",
						icon: "success",
					})
					.then((willUpdate) => {
						if (willUpdate) {
							window.location.href="viewpatientinfo.jsp?id=" + userId + "&appid=" + apptId;
						}
					});
					
				})
			});
			
		});
		
	</script>
</body>
</html>