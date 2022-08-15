package com.dentalrecord.servlets;

import java.io.IOException;
import java.sql.Array;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Properties;
import java.util.stream.Collectors;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import com.dentalrecord.servlets.PaymentDetails;
import javax.mail.*;
import javax.mail.internet.*;

@WebServlet("/billview")
public class ViewBill extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private static final String HOST = "localhost";
	private static final String PORT = "3306";
	private static final String DATABASE_NAME = "dentalrecord";
	private static final String DATABASE_USER = "root";
	private static final String DATABASE_PASSWORD = "passwordroot";
	private static final String TABLE_NAME = "billhistory";
	private static final String DATE_COLUMN_NAME = "billingDate";
	private static final String OTHER_FILTER_COLUMN_NAME = "customerName";
	private static final String FROM_EMAIL = "dentalrecordsfyp@hotmail.com"; //dentalrecordsfyp@gmail.com
	private static final String FROM_EMAIL_PASSWORD = "DentalFYP1"; //DentalFYP1
	private static final EMAIL_CONFIGS fromEmailProvider = EMAIL_CONFIGS.HOTMAIL;
	private static final String DATE_FORMAT = "%Y-%m-%d";
	
	private boolean isEmailSent = false;

	private enum EMAIL_CONFIGS {
		GMAIL("GMAIL"), HOTMAIL("HOTMAIL");

		final String PROVIDER;

		EMAIL_CONFIGS(String PROVIDER) {
			this.PROVIDER = PROVIDER;
		}

		private void doSendMail(String fromEmail, String password, String subject, String body, String to) {
			Properties prop = this.getPropety(); // TLS
			Session session = Session.getInstance(prop, new javax.mail.Authenticator() {
				protected PasswordAuthentication getPasswordAuthentication() {
					return new PasswordAuthentication(fromEmail, password);
				}
			});
			try {
				Message message = new MimeMessage(session);
				message.setFrom(new InternetAddress(fromEmail));
				message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
				message.setSubject(subject);
				message.setContent(body, "text/html");
				Transport.send(message);
			} catch (MessagingException e) {
				throw new RuntimeException(e);
			}
		}

		public Properties getPropety() {
			Properties prop = new Properties();
			prop.put("mail.smtp.starttls.enable", "true");
			prop.put("mail.smtp.auth", "true");
			prop.put("mail.smtp.ssl.trust","*");
			prop.put("mail.smtp.port", "587");
			if (this.PROVIDER.equals("GMAIL")) {
				prop.put("mail.smtp.host", "smtp.gmail.com");
			} else if (this.PROVIDER.equals("HOTMAIL")) {
				prop.setProperty("mail.smtp.host", "smtp-mail.outlook.com");
			} else
				throw new RuntimeException("Supplied email provider is not supported");
			return prop;
		}

	}

//{}=[ ]+
	private static boolean isEmpty(String str) {
		return str == null || "".equals(str.trim());
	}

	private List<PaymentDetails> queryData(String fromDate, String toDate, String col1, String paymentStatus, String clinicId, String... ids)
			throws ServletException {
		List<PaymentDetails> paymentDetails = new ArrayList<>();
		Connection conn;
		

		
		try {
			
			
			
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(
					"jdbc:mysql://" + HOST + ":" + PORT + "/" + DATABASE_NAME + "?useSSL=false", DATABASE_USER,
					DATABASE_PASSWORD);
			
			
			
			String query = "SELECT * from " + ViewBill.TABLE_NAME + " where 1=1 ";
			
			
			
			
			if (!ViewBill.isEmpty(fromDate) || !ViewBill.isEmpty(toDate))
				query += " AND DATE(" + DATE_COLUMN_NAME + ") <= STR_TO_DATE(?, '" + DATE_FORMAT + "') AND DATE("
						+ DATE_COLUMN_NAME + ") >= STR_TO_DATE(?, '" + DATE_FORMAT + "')"  ;
			
			if (!ViewBill.isEmpty(col1))
				query += " AND " + OTHER_FILTER_COLUMN_NAME + " LIKE '%" + col1 + "%' ";
			
			if (!ViewBill.isEmpty(paymentStatus))
				query += " AND status = '" + paymentStatus + "'" + " AND clinicId = " + clinicId;
			
			if (ids != null && ids.length > 0) {
				query += " AND idbillHistory IN (";
				query += String.join(",", ids);
				query += ") " ;
			}
			
			System.out.print(query);
			
			PreparedStatement pst = conn.prepareStatement(query + " AND clinicId = " + clinicId);
			int paramIndex = 1;
			if (!ViewBill.isEmpty(fromDate) || !ViewBill.isEmpty(toDate)) {
				pst.setString(paramIndex++, toDate);
				pst.setString(paramIndex++, fromDate);
			}
			

			ResultSet rs = pst.executeQuery();
			while (rs.next()) {
				paymentDetails.add(new PaymentDetails(rs.getLong("idbillHistory"), rs.getString("customerName"),
						 rs.getString("billingDate"), rs.getString("email"), rs.getString("services"), 
						 rs.getString("totalCost"),rs.getFloat("discountedCost"),rs.getString("medicareNo")));
						 		
			}
		} catch (Exception e) {
			throw new ServletException(e);
		}
		return paymentDetails;
	}

	public void sendMail(HttpServletRequest request, HttpServletResponse response, List<PaymentDetails> list)
			throws ServletException, IOException {
		
		try {
			
			for (PaymentDetails paymentDetails : list) {
				
				String title = "Bill for dental services ";		
				
				ArrayList<String> serviceArray = new ArrayList<String>();
				if(paymentDetails.getservices().contains(",")) {
					String temp[] = paymentDetails.getservices().split(",");
					
					for(String s: temp) {
						serviceArray.add(s);
					}
				}
				else {
					serviceArray.add(paymentDetails.getservices());
				}
				
				//Format the email to be sent to patient
				String body =
				"      <div style=\"background-color: rgba(185, 234, 240, 0.941); padding:10px\">\n"
				+ "        Dear " + paymentDetails.getcustomerName() + ", here is your bill of your appointment for your reference.<br>\n"
				+ "        Thank you for choosing us for your dental care.\n"
				+ "    </div>\n"
				+ "    <br/><br>"
				+ "	   <table border=\"0\" style=\"width:100%; border-collapse: collapse;\">\n"
				+ "        <tr style=\"border-top:1px solid #dddd\">\n"
				+ "            <td style=\"padding:10px\">Bill Date and time:</td>\n"
				+ "            <td style=\"padding:10px\">" + paymentDetails.getbillingDate()+ "</td>\n"
				+ "        </tr>\n"
				+ "        <tr style=\"border-top:1px solid #dddd\">\n"
				+ "            <td style=\"padding:10px\">Bill Id:</td>\n"
				+ "            <td style=\"padding:10px\">" + paymentDetails.getidbillHistory() + "</td>\n"
				+ "        </tr>\n"
				+ "        <tr style=\"border-top:1px solid #dddd\">\n"
				+ "            <td style=\"padding:10px\">Name of Patient:</td>\n"
				+ "            <td style=\"padding:10px\">"+ paymentDetails.getcustomerName() +"</td>\n"
				+ "        </tr>\n"
				+ "        <tr style=\"border-top:1px solid #dddd\">\n"
				+ "            <td style=\"padding:10px\">Services:</td>\n"
				+ "            <td style=\"padding:10px\">"+ serviceArray.get(0) +"</td>\n"
				+ "        </tr>\n";
		
				//insert list of services (if more than one service is done for an appointment)
				for(int i = 1; i < serviceArray.size(); i++) {
					body += " <tr>\n"
							+ "    <td style=\"padding:10px\"></td>\n"
							+ "    <td style=\"padding:10px\">" + serviceArray.get(i) + "</td>\n"
							+ "</tr>";
				}
				
				body += " <tr style=\"border-top:1px solid #aaaa\">\n"
				+ "            <td style=\"padding:10px\">Total Cost:</td>\n"
				+ "            <td style=\"padding:10px\">$" + paymentDetails.gettotalCost() + "</td>\n"
				+ "        </tr>\n";
				
				// insert discount and final cost if the patient has Medicare
				if(paymentDetails.getmedicareNo() != null)
				{
					body += " <tr>\n"
					+ "            <td style=\"padding:10px\">Medicare No:</td>\n"
					+ "            <td style=\"padding:10px\">" + paymentDetails.getmedicareNo() + "</td>\n"
					+ "        </tr>\n"
					+ "        <tr style=\"border-top:1px solid #aaaa\">\n"
					+ "            <td style=\"padding:10px\">Discount:</td>\n"
					+ "            <td style=\"padding:10px\">$" + (Float.valueOf(paymentDetails.gettotalCost()) - paymentDetails.getdiscountedCost()) + "</td>\n"
					+ "        </tr>\n"
					+ "        <tr  style=\"border-top:2px solid rgba(63, 63, 63, 0.667); border-bottom:2px solid rgba(63, 63, 63, 0.667)\">\n"
					+ "            <td style=\"padding:10px\">Final Cost:</td>\n"
					+ "            <td style=\"padding:10px\">$" + paymentDetails.getdiscountedCost() + "</td>\n"
					+ "        </tr>\n";
				}
				
				body += "</table>"
						+ "<br>\n"
						+ "<p style=\"color:rgba(67, 67, 67, 0.667); font-style: italic;\"> <b>Please make a payment within 24 hours after this email is sent</b>.</br> "
						+ " This is a system generated email. Please do not reply to this email.</p>\n";
				
				//send email
				fromEmailProvider.doSendMail(FROM_EMAIL, FROM_EMAIL_PASSWORD, title, body, paymentDetails.getEmail());
				isEmailSent = true;
				
				}
			}
		catch (Exception mex) {
			
			mex.printStackTrace();
		}
	}


	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();

		int clinicId1 = Integer.valueOf(session.getAttribute("clinicId").toString());
		
		String clinicId = Integer.toString(clinicId1);
		String paymentStatus = request.getParameter("paymentStatus");
		String fromDateStr = request.getParameter("fromDate");
		String toDateStr = request.getParameter("toDate");
		String col1 = request.getParameter("col1");
		String[] strings = request.getParameterValues("includeList");
		
		if (strings != null)
			this.sendMail(request, response, this.queryData(null, null, null, null, null, strings));
		request.setAttribute("fromDate", fromDateStr);
		request.setAttribute("toDate", toDateStr);
		request.setAttribute("col1", col1);
		request.setAttribute("paymentStatus", paymentStatus);
		request.setAttribute("clinicId", clinicId);
		request.setAttribute("list", queryData(fromDateStr, toDateStr, col1, paymentStatus, clinicId));
		
		
		if(isEmailSent)
			request.setAttribute("status", "success");
		
		request.getRequestDispatcher("/billview.jsp").forward(request, response);
	}
}
