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
@WebServlet("/update")
public class UpdateInfo extends HttpServlet {
	private static final long serialVersionUID = 1L;
      
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateInfo() {
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
		String id = request.getParameter("userid");		
		String uname = request.getParameter("name");
		String uemail = request.getParameter("email");
		String address = request.getParameter("address");
		String umobile = request.getParameter("contact");
		String dob = request.getParameter("dob");
		String icnum = request.getParameter("icnum");
		Connection conn = null;
		HttpSession session = request.getSession();
		PreparedStatement pst;
		RequestDispatcher dispatcher = null;
//		String clinicId = request.getParameter("clinicId");
		int clinicId;
		PreparedStatement pst3;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dentalrecord?useSSL=false","root","passwordroot");
			clinicId = (int)session.getAttribute("clinicId");
			pst3 = conn.prepareStatement("SELECT * from users where clinicId = ? and iduserAccounts = ?");
			pst3.setString(2,id );
			pst3.setInt(1,clinicId );
			ResultSet rs = pst3.executeQuery();
			
			if(rs.next()) {
				pst = conn.prepareStatement("UPDATE customer set address=?,DOB=?,ICNumber=?,mobileNo=? WHERE email='"+ rs.getString("useremail") +"' and clinicId="+clinicId);
				
				PreparedStatement pst2 = conn.prepareStatement("UPDATE users set username=?, useremail=? WHERE useremail='"+ rs.getString("useremail") +"' and clinicId ="+clinicId);
				
				pst2.setString(1, uname);
				pst2.setString(2, uemail);
				pst.setString(1, address);
				pst.setString(2, dob);
				pst.setString(3, icnum);
				pst.setString(4, umobile);	
				pst2.executeUpdate();
				pst.executeUpdate();				
				dispatcher = request.getRequestDispatcher("mainMenuAdmin.jsp");
		} else {
			request.setAttribute("status", "failed");
			dispatcher = request.getRequestDispatcher("mainMenuAdmin.jsp");
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
