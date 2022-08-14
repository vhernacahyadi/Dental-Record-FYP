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
 * Servlet implementation class Update
 */
@WebServlet("/updateInvent")
public class UpdateInventory extends HttpServlet {
	private static final long serialVersionUID = 1L;
      
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateInventory() {
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
		String itemname = request.getParameter("itemname");
		String itemstatus = request.getParameter("itemstatus");
		String itemqty = request.getParameter("itemqty");
		String itemexpdate = request.getParameter("itemexpdate");
		Connection conn = null;
		RequestDispatcher dispatcher = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dentalrecord?useSSL=false","root","passwordroot");
			PreparedStatement pst = conn.prepareStatement("UPDATE inventory set itemname=?,itemstatus=?,itemqty=?,itemexpdate=? WHERE itemid="+id);
			pst.setString(1, itemname);
			pst.setString(2, itemstatus);
			pst.setString(3, itemqty);
			pst.setString(4, itemexpdate);
			int rowcount = pst.executeUpdate();
			
			dispatcher = request.getRequestDispatcher("vieweditinventory.jsp?id=" + id);
			
			if(rowcount > 0) {
				request.setAttribute("status", "success");
			}
			else{
				request.setAttribute("status", "failed");
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



	