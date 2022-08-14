package com.dentalrecord.servlets;

import java.io.IOException;
import java.io.PrintWriter;
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
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class RegistrationServlet
 */
@WebServlet("/register")
public class RegistrationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegistrationServlet() {
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
		String uname = request.getParameter("name");
		String uemail = request.getParameter("email");
		String address = request.getParameter("address");
		String umobile = request.getParameter("contact");
		String dob = request.getParameter("dob");
		String icnum = request.getParameter("icnum");
		Connection conn = null;
		RequestDispatcher dispatcher = null;
		HttpSession session = request.getSession();
		PreparedStatement pst;
		PreparedStatement pst2;
		PreparedStatement pst3;


		int clinicId;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dentalrecord?useSSL=false","root","passwordroot");
				clinicId = (int)session.getAttribute("clinicId");
				pst3 = conn.prepareStatement("SELECT * from clinics where clinicId = ?");
				pst3.setInt(1,clinicId );
				ResultSet rs = pst3.executeQuery();
				
				if(rs.next()) {
					pst2 = conn.prepareStatement("INSERT INTO users(useremail,username,clinicName,clinicAddress,clinicNumber,clinicId,accessLevel) values(?,?,?,?,?,?,4) ");
					pst = conn.prepareStatement("INSERT INTO customer(address,DOB,ICNumber,mobileNo,email,clinicId,name) values(?,?,?,?,?,?,?) ");
					
					pst.setString(1, address);
					pst.setString(2, dob);
					pst.setString(3, icnum);
					pst.setString(4, umobile);
					pst.setString(5, uemail);
					pst.setInt(6, clinicId);
					pst.setString(7, uname);
					pst2.setString(1, uemail);
					pst2.setString(2, uname);
					pst2.setString(3, rs.getString("clinicName"));
					pst2.setString(4, rs.getString("clinicAddress"));
					pst2.setInt(5, rs.getInt("clinicNo"));
					pst2.setInt(6, rs.getInt("clinicId"));
					pst2.executeUpdate();
					pst.executeUpdate();
					request.setAttribute("status", "success");
					dispatcher = request.getRequestDispatcher("addPatient.jsp");
					
			} else {
				request.setAttribute("status", "failed");
				dispatcher = request.getRequestDispatcher("addPatient.jsp");
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
