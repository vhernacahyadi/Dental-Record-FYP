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
@WebServlet("/bookappointment")
public class bookappointment extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public bookappointment() {
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
		String service = request.getParameter("service");
		String dob = request.getParameter("date");
		String timeslot = request.getParameter("timeslot");
		String docname = "Pending";		//placeholder value - just put here for now
		int clinicId = Integer.parseInt(request.getParameter("clinicId"));
		RequestDispatcher dispatcher = null;
		Connection conn = null;
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dentalrecord?useSSL=false","root","passwordroot");
			PreparedStatement pst = conn.prepareStatement("INSERT INTO appointment (custid, docname, services, date, apptime, clinicId) values (?,?,?,?,?,?)");
			pst.setString(1, id);
			pst.setString(2, docname);
			pst.setString(3, service);
			pst.setString(4, dob);
			pst.setString(5, timeslot);
			pst.setInt(6, clinicId);

			int rowcount = pst.executeUpdate();
			
			dispatcher = request.getRequestDispatcher("patientBookAppointment.jsp?id=" + id);
			
			if(rowcount > 0) {
				request.setAttribute("status", "success");
			}
			else {
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
