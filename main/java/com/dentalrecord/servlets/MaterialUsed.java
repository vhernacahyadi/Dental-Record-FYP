package com.dentalrecord.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class MaterialUsed
 */
@WebServlet("/MaterialUsed")
public class MaterialUsed extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MaterialUsed() {
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
		String[] itemIdArray = request.getParameterValues("itemIds[]");
		String[] qtyArray = request.getParameterValues("quantity[]");
		String appid = request.getParameter("appid");
		String userid = request.getParameter("userid");
		Connection conn = null;
		RequestDispatcher dispatcher = null;
		ResultSet rs = null;
		Statement stmt = null;
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dentalrecord?useSSL=false","root","passwordroot");
			PreparedStatement pst = conn.prepareStatement("insert into materialsused values (?,?,?)");
			
			stmt = conn.createStatement();
			
			String sql = "select itemid, itemqty from inventory where itemid in(";
			
			int rowCount = 0;
			
			for(int i = 0; i < itemIdArray.length; i++) {
				//System.out.println(itemIdArray[i] + ": " + qtyArray[i]);
				pst.setInt(1, Integer.valueOf(appid));
				pst.setInt(2, Integer.valueOf(itemIdArray[i]));
				pst.setInt(3, Integer.valueOf(qtyArray[i]));
				
				rowCount += pst.executeUpdate();
				
				sql += itemIdArray[i];
				if(i < itemIdArray.length-1) {
					sql += ",";
				}
			}
			
			sql += ");";
			
			rs = stmt.executeQuery(sql);
			
			int rowCount2 = 0;
			while(rs.next()) {
				int itemId = rs.getInt(1);
				int formerQty = rs.getInt(2);
				int currQty;
				
				for(int j = 0; j < itemIdArray.length; j++) {
					if(Integer.valueOf(itemIdArray[j]) == itemId) {
						currQty = formerQty - Integer.valueOf(qtyArray[j]);
						PreparedStatement pst2 = conn.prepareStatement("update inventory set itemqty = ? where itemid = ?" );
						pst2.setInt(1, currQty);
						pst2.setInt(2, itemId);
						rowCount2 += pst2.executeUpdate();
					}
				}
				
			}
			
			if(rowCount == itemIdArray.length && rowCount2== itemIdArray.length) {
				request.setAttribute("status", "success");
			}
			else {
				request.setAttribute("status", "error");
			}
			
			dispatcher = request.getRequestDispatcher("viewpatientinfo.jsp?id=" + userid + "&appid=" + appid);
			
			dispatcher.forward(request, response);
		}
		catch (Exception e){
			e.printStackTrace();
		}
		finally {
			try {
				conn.close();
			}
			catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		
	}

}
