package com.dentalrecord.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class UpdateAccountDetails
 */
@WebServlet("/adminApprove")
public class AdminApproval extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminApproval() {
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
		String id = request.getParameter("id");
		String adminName = request.getParameter("name");
		String adminPw = request.getParameter("password");
		String adminEmail = request.getParameter("email");
		String adminContact = request.getParameter("mobileNo");
		String cName = request.getParameter("clinicName");
		String cAddress = request.getParameter("clinicAddress");
		String cContact = request.getParameter("clinicContact");
		String status = "Approved";
		String clinicChoice = request.getParameter("clinicChoice");
		int accessLevel = 1;
		int clinicId = 0;
		Connection conn = null;
		RequestDispatcher dispatcher = null;
		ResultSet rs = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dentalrecord?useSSL=false","root","passwordroot");
			
			PreparedStatement pst4 = conn.prepareStatement("SELECT * from clinics where clinicName=?");
			pst4.setString(1,clinicChoice);
			rs = pst4.executeQuery();
			while(rs.next()) {
				clinicId = rs.getInt("clinicId");
			}
			
			PreparedStatement pst = conn.prepareStatement("INSERT INTO users(username,password,accessLevel,useremail,clinicName,clinicAddress,clinicNumber,clinicId) values(?,?,?,?,?,?,?,?)");
			PreparedStatement pst2 = conn.prepareStatement("DELETE FROM adminapproval WHERE idapproval="+id);
			PreparedStatement pst3 = conn.prepareStatement("INSERT INTO adminapphistory(name,mobileNo,password,email,clinicName,clinicAddress,clinicContact,status) values(?,?,?,?,?,?,?,?)");
			
			pst.setString(1, adminName);
			pst.setString(2, adminPw);
			pst.setInt(3, accessLevel);
			pst.setString(4, adminEmail);
			pst.setString(5, cName);
			pst.setString(6, cAddress);
			pst.setString(7, cContact);
			pst.setInt(8, clinicId);
			
			pst3.setString(1, adminName);
			pst3.setString(2, adminContact);
			pst3.setString(3, adminPw);
			pst3.setString(4, adminEmail);
			pst3.setString(5, cName);
			pst3.setString(6, cAddress);
			pst3.setString(7, cContact);
			pst3.setString(8, status);
			
			pst.executeUpdate();
			pst2.executeUpdate();
			pst3.executeUpdate();
			
			dispatcher = request.getRequestDispatcher("adminRequestInfo.jsp");
			request.setAttribute("status", "success");
			dispatcher.forward(request, response);
		}
			
		catch(IllegalStateException ignore) {
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
