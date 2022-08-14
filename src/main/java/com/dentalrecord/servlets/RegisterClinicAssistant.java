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
@WebServlet("/registerAssistant")
public class RegisterClinicAssistant extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterClinicAssistant() {
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
		String asstName = request.getParameter("name");
		String asstEmail = request.getParameter("email");
		String asstAddress = request.getParameter("address");
		String asstMobile = request.getParameter("contact");
		String asstDob = request.getParameter("dob");
		String asstIcnum = request.getParameter("icnum");
		Connection conn = null;
		RequestDispatcher dispatcher = null;
		HttpSession session = request.getSession();
		int clinicId;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dentalrecord?useSSL=false","root","passwordroot");
			clinicId = (int)session.getAttribute("clinicId");
			PreparedStatement pst3 = conn.prepareStatement("SELECT * from clinics where clinicId = ?");
			pst3.setInt(1,clinicId );
			ResultSet rs = pst3.executeQuery();
			
			if(rs.next()) {
				PreparedStatement pst2 = conn.prepareStatement("INSERT INTO users(username,useremail,clinicName,clinicAddress,clinicNumber,clinicId,accessLevel) values(?,?,?,?,?,?,3) ");
				PreparedStatement pst = conn.prepareStatement("INSERT INTO assistant(name,dateOfBirth,icnum,mobileNo,address,email,clinicId) values(?,?,?,?,?,?,?) ");
				pst.setString(1, asstName);
				pst.setString(2, asstDob);
				pst.setString(3, asstIcnum);
				pst.setString(4, asstMobile);
				pst.setString(5, asstAddress);
				pst.setString(6, asstEmail);
				pst.setInt(7, clinicId);
				pst2.setString(1, asstName);
				pst2.setString(2, asstEmail);
				pst2.setString(3, rs.getString("clinicName"));
				pst2.setString(4, rs.getString("clinicAddress"));
				pst2.setInt(5, rs.getInt("clinicNo"));
				pst2.setInt(6, rs.getInt("clinicId"));
				pst2.executeUpdate();
				pst.executeUpdate();
				
				request.setAttribute("status", "success");
				dispatcher = request.getRequestDispatcher("addAssistant.jsp");
			} else {
				request.setAttribute("status", "failed");
				dispatcher = request.getRequestDispatcher("addAssistant.jsp");
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
