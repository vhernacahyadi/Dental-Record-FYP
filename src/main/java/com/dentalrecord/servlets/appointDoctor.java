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
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class Update
 */
@WebServlet("/appointDoctor")
public class appointDoctor extends HttpServlet {
	private static final long serialVersionUID = 1L;
      
    /**
     * @see HttpServlet#HttpServlet()
     */
    public appointDoctor() {
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
		String dates = request.getParameter("dates");
		String times = request.getParameter("times");
		String Doctor = request.getParameter("Doctor");
		String custid = request.getParameter("custid");

		Connection conn = null;
		HttpSession session = request.getSession();
		PreparedStatement pst;
		RequestDispatcher dispatcher = null;
//		String clinicId = request.getParameter("clinicId");
		int clinicId;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dentalrecord?useSSL=false", "root", "passwordroot");
			clinicId = Integer.parseInt(session.getAttribute("clinicId").toString());
		
			pst = conn.prepareStatement("UPDATE appointment set docname=? WHERE appointmentid="+ id +" and clinicId="+clinicId);
			pst.setString(1, Doctor);
			pst.executeUpdate();	
			
			dispatcher = request.getRequestDispatcher("viewpatientinfo.jsp?id=" + custid + "&appid=" + id);
			
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
