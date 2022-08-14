package com.dentalrecord.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


/**
 * Servlet implementation class Login
 */
@WebServlet("/login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Login() {
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
		String uemail = request.getParameter("username");
		String upwd = request.getParameter("password");
		HttpSession session = request.getSession();
		RequestDispatcher dispatcher=null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dentalrecord?useSSL=false","root","passwordroot");
			PreparedStatement pst = conn.prepareStatement("SELECT * from users where useremail = ? and password =?",ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
			pst.setString(1, uemail);
			pst.setString(2, upwd);
			
			ResultSet rs = pst.executeQuery();
			rs.beforeFirst();
			if(rs.next()) {
				if(rs.getInt("accessLevel") == 1) {
					session.setAttribute("name",rs.getString("useremail"));
					session.setAttribute("id",rs.getString("iduserAccounts"));
					session.setAttribute("accesslevel",rs.getString("accessLevel"));
					session.setAttribute("clinicId",rs.getInt("clinicId"));
					dispatcher = request.getRequestDispatcher("mainMenuAdmin.jsp");
					response.sendRedirect("mainMenuAdmin.jsp");
				}
				else if(rs.getInt("accessLevel")== 2) {
					session.setAttribute("name",rs.getString("username"));
					session.setAttribute("id",rs.getString("iduserAccounts"));
					session.setAttribute("accesslevel",rs.getString("accessLevel"));
					session.setAttribute("clinicId",rs.getString("clinicId"));
					dispatcher = request.getRequestDispatcher("mainMenuDentist.jsp");
					response.sendRedirect("mainMenuDentist.jsp");
				}
				else if(rs.getInt("accessLevel")== 3) {
					session.setAttribute("name",rs.getString("username"));
					session.setAttribute("id",rs.getString("iduserAccounts"));
					session.setAttribute("accesslevel",rs.getString("accessLevel"));
					session.setAttribute("clinicId",rs.getString("clinicId"));
					dispatcher = request.getRequestDispatcher("mainMenuAssit.jsp");
					response.sendRedirect("mainMenuAssit.jsp");
				}
				else if(rs.getInt("accessLevel")== 4) {
					session.setAttribute("name",rs.getString("username"));
					session.setAttribute("id",rs.getString("iduserAccounts"));
					session.setAttribute("accesslevel",rs.getString("accessLevel"));
					session.setAttribute("clinicId",rs.getString("clinicId"));
					dispatcher = request.getRequestDispatcher("mainMenuPatient.jsp");
					response.sendRedirect("mainMenuPatient.jsp");
				}
				else if(rs.getInt("accessLevel")== 5) {
					session.setAttribute("name",rs.getString("username"));
					session.setAttribute("id",rs.getString("iduserAccounts"));
					session.setAttribute("accesslevel",rs.getString("accessLevel"));
					dispatcher = request.getRequestDispatcher("mainMenuSAdmin.jsp");
					response.sendRedirect("mainMenuSAdmin.jsp");
				}
				else {
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
		catch(Exception e){
			e.printStackTrace();
		}
	}

}
