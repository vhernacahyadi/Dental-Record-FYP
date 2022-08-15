package com.dentalrecord.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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
@WebServlet("/UpdateAccountDetails")
public class UpdateAccountDetails extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateAccountDetails() {
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
		String pw = request.getParameter("password");
		RequestDispatcher dispatcher=null;
		Connection conn = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dentalrecord?useSSL=false","root","passwordroot");
			PreparedStatement pst = conn.prepareStatement("SELECT * from users where iduserAccounts=?");
			pst.setString(1, id);
			
			
			ResultSet rs = pst.executeQuery();
			
			if(rs.next()) {
				
				if(rs.getInt("accessLevel") == 1) {
					PreparedStatement pst2 = conn.prepareStatement("UPDATE users set username=?,password=?,useremail=? WHERE iduserAccounts="+id);
					pst2.setString(1, uname);
					pst2.setString(2, pw);
					pst2.setString(3, uemail);
					pst2.executeUpdate();
					dispatcher = request.getRequestDispatcher("mainMenuAdmin.jsp");
					response.sendRedirect("mainMenuAdmin.jsp");
				} else if(rs.getInt("accessLevel") == 2) {
					PreparedStatement pst2 = conn.prepareStatement("UPDATE users set username=?,password=?,useremail=? WHERE iduserAccounts="+id);
					pst2.setString(1, uname);
					pst2.setString(2, pw);
					pst2.setString(3, uemail);
					pst2.executeUpdate();
					dispatcher = request.getRequestDispatcher("mainMenuDentist.jsp");
					response.sendRedirect("mainMenuDentist.jsp");
				}else if(rs.getInt("accessLevel") == 3) {
					PreparedStatement pst2 = conn.prepareStatement("UPDATE users set username=?,password=?,useremail=? WHERE iduserAccounts="+id);
					pst2.setString(1, uname);
					pst2.setString(2, pw);
					pst2.setString(3, uemail);
					pst2.executeUpdate();
					dispatcher = request.getRequestDispatcher("mainMenuAssit.jsp");
					response.sendRedirect("mainMenuAssit.jsp");
				}else if(rs.getInt("accessLevel") == 4) {
					PreparedStatement pst2 = conn.prepareStatement("UPDATE users set username=?,password=?,useremail=? WHERE iduserAccounts="+id);
					pst2.setString(1, uname);
					pst2.setString(2, pw);
					pst2.setString(3, uemail);
					pst2.executeUpdate();
					dispatcher = request.getRequestDispatcher("mainMenuPatient.jsp");
					response.sendRedirect("mainMenuPatient.jsp");
				}else if(rs.getInt("accessLevel") == 5) {
					PreparedStatement pst2 = conn.prepareStatement("UPDATE users set username=?,password=?,useremail=? WHERE iduserAccounts="+id);
					pst2.setString(1, uname);
					pst2.setString(2, pw);
					pst2.setString(3, uemail);
					pst2.executeUpdate();
					dispatcher = request.getRequestDispatcher("mainMenuSAdmin.jsp");
					response.sendRedirect("mainMenuSAdmin.jsp");
				}else {
					request.setAttribute("status", "failed");
					dispatcher = request.getRequestDispatcher("login.jsp");
			}
		}
		else {
			request.setAttribute("status", "failed");
			dispatcher = request.getRequestDispatcher("login.jsp");
		}
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
