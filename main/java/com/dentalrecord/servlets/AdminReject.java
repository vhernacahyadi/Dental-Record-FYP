package com.dentalrecord.servlets;

import java.io.IOException;
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
 * Servlet implementation class UpdateAccountDetails
 */
@WebServlet("/adminReject")
public class AdminReject extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminReject() {
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
		String status = "Rejected";
		Connection conn = null;
		RequestDispatcher dispatcher = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dentalrecord?useSSL=false","root","passwordroot");
			PreparedStatement pst = conn.prepareStatement("DELETE FROM adminapproval WHERE idapproval="+id);
			PreparedStatement pst2 = conn.prepareStatement("INSERT INTO adminapphistory(name,mobileNo,password,email,clinicName,clinicAddress,clinicContact,status) values(?,?,?,?,?,?,?,?)");
			
			pst2.setString(1, adminName);
			pst2.setString(2, adminContact);
			pst2.setString(3, adminPw);
			pst2.setString(4, adminEmail);
			pst2.setString(5, cName);
			pst2.setString(6, cAddress);
			pst2.setString(7, cContact);
			pst2.setString(8, status);
			
			pst.executeUpdate();
			pst2.executeUpdate();

			dispatcher = request.getRequestDispatcher("adminRequestInfo.jsp");
			request.setAttribute("status", "failed");
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
