package com.dentalrecord.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.text.SimpleDateFormat;  
import java.util.Date;  

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class RegistrationServlet
 */
@WebServlet("/createBill")
public class createBill extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public createBill() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//get all values from request sent from view
		String[] checkedServices = request.getParameterValues("services");
		Double amt1 = Double.parseDouble(request.getParameter("amt1"));
		Double amt2 = Double.parseDouble(request.getParameter("amt2"));
		Double amt3 = Double.parseDouble(request.getParameter("amt3"));
		Double amt4 = Double.parseDouble(request.getParameter("amt4"));
		Double amt5 = Double.parseDouble(request.getParameter("amt5"));
		Double amt6 = Double.parseDouble(request.getParameter("amt6"));
		String amount1 = request.getParameter("amt1");
		String amount2 = request.getParameter("amt2");
		String amount3 = request.getParameter("amt3");
		String amount4 = request.getParameter("amt4");
		String amount5 = request.getParameter("amt5");
		
		String name = request.getParameter("name");
		String contact = request.getParameter("contact");
		String address = request.getParameter("address");
		String email = request.getParameter("email");
		
		String medNo = request.getParameter("medNo");
		String medExp = request.getParameter("medExp");
		
		//set medicare info to null if patient do not have it
		if(medNo.equals("")) 
		{
			medNo = null;
			medExp = null;
		}
		
		Statement stat = null;
		ResultSet rs = null;
		Connection conn = null;
		RequestDispatcher dispatcher = null;
		List<String> serviceList = new ArrayList<String>();
		double totalCost=0.00;
		double discountedCost=0.00;
		String data;
		String service;
		HttpSession session = request.getSession();
		int clinicId;
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy/MM/dd");  
		SimpleDateFormat formatter2 = new SimpleDateFormat("HH:mm:ss");
		Date date = new Date();
		Date date2 = new Date();
		String currentDate = formatter.format(date);
		String currentTime = formatter2.format(date2);
		String status="Pending";
		
		try {
			
			clinicId = Integer.valueOf(session.getAttribute("clinicId").toString());
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dentalrecord?useSSL=false","root","passwordroot");
			stat = conn.createStatement();
			for(int i = 0; i<checkedServices.length;i++) {
				data = "SELECT serviceName,serviceCost FROM dentalServices WHERE iddentalServices="+checkedServices[i];
				rs = stat.executeQuery(data);
				while (rs.next()) {
					//calculate discounted cost for each service if the patient has Medicare
				switch(rs.getString(1)) {
				case "Dental Crowns":
					if(medNo =="" || medExp == "")
					{
						discountedCost = 0.00;
					}
					else if(medNo != "" && medExp != "")
					{
						discountedCost+= 0.75*(amt1*rs.getDouble(2));
					}
					else
					{
						discountedCost = 0.00;
					}
					totalCost+= amt1*rs.getDouble(2);
					service = amount1 +"x"+ (rs.getString(1));
					serviceList.add(service);
					break;
				case "Wisdom Tooth Removal":
					if(medNo =="" || medExp == "")
					{
						discountedCost = 0.00;
					}
					else if(medNo != "" && medExp != "")
					{
						discountedCost+= 0.75*(amt2*rs.getDouble(2));
					}
					else
					{
						discountedCost = 0.00;
					}
					totalCost+= amt2*rs.getDouble(2);
					service = amount2 +"x"+ (rs.getString(1));
					serviceList.add(service);
					break;
				case "Root Canal Treatment":
					if(medNo =="" || medExp == "")
					{
						discountedCost = 0.00;
					}
					else if(medNo != "" && medExp != "")
					{
						discountedCost+= 0.75*(amt3*rs.getDouble(2));
					}
					else
					{
						discountedCost = 0.00;
					}
					totalCost+= amt3*rs.getDouble(2);
					service = amount3 +"x"+ (rs.getString(1));
					serviceList.add(service);
					break;
				case "Dental Bonding":
					if(medNo =="" || medExp == "")
					{
						discountedCost = 0.00;
					}
					else if(medNo != "" && medExp != "")
					{
						discountedCost+= 0.75*(amt4*rs.getDouble(2));
					}
					else
					{
						discountedCost = 0.00;
					}
					totalCost+= amt4*rs.getDouble(2);
					service = amount4 +"x"+ (rs.getString(1));
					serviceList.add(service);
					break;
				case "Veneers":
					if(medNo =="" || medExp == "")
					{
						discountedCost = 0.00;
					}
					else if(medNo != "" && medExp != "")
					{
						discountedCost+= 0.75*(amt5*rs.getDouble(2));
					}
					else
					{
						discountedCost = 0.00;
					}
					totalCost+= amt5*rs.getDouble(2);
					service = amount5 +"x"+ (rs.getString(1));
					serviceList.add(service);
					break;
				case "Other(s)":
					if(medNo =="" || medExp == "")
					{
						discountedCost = 0.00;
					}
					else if(medNo != "" && medExp != "")
					{
						discountedCost+= (0.75*amt6);
					}
					else
					{
						discountedCost = 0.00;
					}
					totalCost+= amt6;
					serviceList.add(rs.getString(1));
					break;
				default:
					if(medNo =="" || medExp == "")
					{
						discountedCost = 0.00;
					}
					else if(medNo != "" && medExp != "" && medNo != null & medExp != null)
					{
						discountedCost+= 0.75*(rs.getDouble(2));
					}
					else
					{
						discountedCost = 0.00;
					}
					totalCost += rs.getDouble(2);
					serviceList.add(rs.getString(1));
				}
				
				}
			}
			String servicesList = serviceList.toString();
			
			//insert to database
			PreparedStatement pst = conn.prepareStatement("INSERT INTO billHistory(customerName,customerAddress,customerContactNo,email,billingDate,billingTime,services,totalCost,medicareNo,medicareExp,discountedCost,clinicId,status) values(?,?,?,?,?,?,?,?,?,?,?,?,?) ");
			pst.setString(1, name);
			pst.setString(2, address);
			pst.setString(3, contact);
			pst.setString(4, email);
			pst.setString(5, currentDate);
			pst.setString(6, currentTime);
			pst.setString(7,servicesList.substring(1, servicesList.length()-1));
			pst.setDouble(8, totalCost);
			pst.setString(9, medNo);
			pst.setString(10, medExp);
			pst.setDouble(11, discountedCost);
			pst.setInt(12, clinicId);
			pst.setString(13, status);
			int rowCount = pst.executeUpdate();
			dispatcher = request.getRequestDispatcher("createBill.jsp");
			if(rowCount>0) {
				request.setAttribute("status", "success");
			}
			else{
				request.setAttribute("status", "failed");
			}
			dispatcher.forward(request, response);
			
			
			response.sendRedirect("createBill.jsp");
		}
		
		catch(Exception e)
		{
			e.printStackTrace();
		}
		finally {
			try {
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
	}

}
