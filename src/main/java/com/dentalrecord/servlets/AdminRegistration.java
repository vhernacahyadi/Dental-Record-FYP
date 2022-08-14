package com.dentalrecord.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class RegistrationServlet
 */
@WebServlet("/registerAdmin")
public class AdminRegistration extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminRegistration() {
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
		String adminName = request.getParameter("name");
		String adminMobile = request.getParameter("contact");
		String adminPw = request.getParameter("password");
		String adminEmail = request.getParameter("email");
		
		String clinicName= request.getParameter("clinicName");
		String clinicAddress = request.getParameter("clinicAddress");
		String clinicContactNo = request.getParameter("clinicContact");
		
		String status = "Pending";
		Connection conn = null;
		RequestDispatcher dispatcher = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dentalrecord?useSSL=false","root","passwordroot");
			PreparedStatement pst = conn.prepareStatement("INSERT INTO adminapproval(name,mobileNo,password,email,clinicName,clinicAddress,clinicContact,status) values(?,?,?,?,?,?,?,?) ");
			pst.setString(1, adminName);
			pst.setString(2, adminMobile);
			pst.setString(3, adminPw);
			pst.setString(4, adminEmail);
			pst.setString(5, clinicName);
			pst.setString(6, clinicAddress);
			pst.setString(7, clinicContactNo);
			pst.setString(8, status);
			int rowCount = pst.executeUpdate();
			
			dispatcher = request.getRequestDispatcher("adminRegistration.jsp");
			if(rowCount>0) {
				request.setAttribute("status", "success");
			}
			else{
				request.setAttribute("status", "failed");
			}
			dispatcher.forward(request, response);
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
