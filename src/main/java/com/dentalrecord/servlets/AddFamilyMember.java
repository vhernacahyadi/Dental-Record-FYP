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
 * Servlet implementation class addFamilyMember
 */
@WebServlet("/AddFamilyMember")
public class AddFamilyMember extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddFamilyMember() {
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
		int familyMemberId = Integer.parseInt(request.getParameter("addFamilyBtn"));
		int clinicId = Integer.parseInt(request.getParameter("clinicId"));
		int patientId = Integer.parseInt(request.getParameter("patientId"));
		
		Connection conn = null;
		RequestDispatcher dispatcher = null;
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dentalrecord?useSSL=false","root","passwordroot");
			PreparedStatement pst = conn.prepareStatement("insert into familymember values (?,?,?) ");
			pst.setInt(1, patientId);
			pst.setInt(2, familyMemberId);
			pst.setInt(3, clinicId);
			
			int rowCount = pst.executeUpdate();
			
			pst.setInt(1, familyMemberId);
			pst.setInt(2, patientId);
			pst.setInt(3, clinicId);
			
			int rowCount2 = pst.executeUpdate();
			
			dispatcher = request.getRequestDispatcher("ViewPatientFamilyMembers.jsp?id=" + patientId);
			
			if(rowCount > 0 && rowCount2 > 0) {
				request.setAttribute("status", "success");
			}
			else {
				request.setAttribute("status", "failed");
			}
			
			//response.sendRedirect("ViewPatientFamilyMembers.jsp?id=" + patientId);
			dispatcher.forward(request, response);
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			try {
				conn.close();
			} catch (SQLException e) {
				//TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

}
