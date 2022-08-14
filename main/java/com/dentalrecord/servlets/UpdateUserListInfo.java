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
@WebServlet("/UpdateUserListInfo")
public class UpdateUserListInfo extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateUserListInfo() {
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
		String uname = request.getParameter("name");
		String uemail = request.getParameter("email");
		String cName = request.getParameter("clinicName");
		String cAdd = request.getParameter("clinicAddress");
		String cNo = request.getParameter("clinicNumber");
		String cId= request.getParameter("clinicId");
		Connection conn = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dentalrecord?useSSL=false","root","passwordroot");
			PreparedStatement pst = conn.prepareStatement("UPDATE users set username=?,useremail=?,clinicName=?,clinicAddress=?,clinicNumber=?,clinicId=? WHERE iduserAccounts="+id);
			pst.setString(1, uname);
			pst.setString(2, uemail);
			pst.setString(3, cName);
			pst.setString(4, cAdd);
			pst.setString(5, cNo);
			pst.setString(6, cId);
			pst.executeUpdate();
			response.sendRedirect("userList.jsp");
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
