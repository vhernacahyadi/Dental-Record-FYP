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
 * Servlet implementation class RegistrationServlet
 */
@WebServlet("/addItem")
public class AddInventory extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddInventory() {
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
		String itemname = request.getParameter("itemname");
		String itemstatus = request.getParameter("itemstatus");
		String itemqty = request.getParameter("itemqty");
		String itemexpdate = request.getParameter("itemexpdate");
		int clinicId = Integer.parseInt(request.getParameter("clinicId"));
		
		Connection conn = null;
		RequestDispatcher dispatcher = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dentalrecord?useSSL=false","root","passwordroot");
			PreparedStatement pst = conn.prepareStatement("INSERT INTO inventory(itemname,itemstatus,itemqty,itemexpdate, clinicId) values(?,?,?,?,?) ");
			pst.setString(1, itemname);
			pst.setString(2, itemstatus);
			pst.setString(3, itemqty);
			pst.setString(4, itemexpdate);
			pst.setInt(5, clinicId);
			int rowCount = pst.executeUpdate();
			dispatcher = request.getRequestDispatcher("inventorylist.jsp");
			if(rowCount>0) {
				request.setAttribute("status", "success");
			}
			else{
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
