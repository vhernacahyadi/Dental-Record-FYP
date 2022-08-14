package com.dentalrecord.servlets;

import java.sql.Timestamp;
import java.util.Date;

public class PaymentDetails {
	private long idbillHistory;
	private String customerName;
	private String billingDate;
	private String email;
	private String services;
	private String totalCost;
	private Float discountedCost;
	private String medicareNo;
	public PaymentDetails() {
		super();
	}
	
	public PaymentDetails(long idbillHistory, String customerName, String billingDate, String email, String services, String totalCost, Float discountedCost , String medicareNo) {
		super();
		this.idbillHistory = idbillHistory;
		this.customerName = customerName;
		this.billingDate = billingDate;
		this.email = email;
		this.services = services;
		this.totalCost = totalCost;
		this.discountedCost = discountedCost;
		this.medicareNo = medicareNo;
	}

	public long getidbillHistory() {
		return idbillHistory;
	}
	public void setidbillHistory(long idbillHistory) {
		this.idbillHistory = idbillHistory;
	}
	public String getcustomerName() {
		return customerName;
	}
	public void setcustomerName(String customerName) {
		this.customerName = customerName;
	}

	public String getbillingDate() {
		return billingDate;
	}

	public void setbillingDate(String billingDate) {
		this.billingDate = billingDate;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	
	public String getservices() {
		return services;
	}
	public void setservices(String services) {
		this.services = services;
	}
	
	public String gettotalCost() {
		return totalCost;
	}
	public void settotalCost(String totalCost) {
		this.totalCost = totalCost;
	}
	
	public Float getdiscountedCost() {
		return discountedCost;
	}
	public void setdiscountedCost(String discountedCost) {
		this.totalCost = discountedCost;
	}
	
	public String getmedicareNo() {
		return medicareNo;
	}
	public void setmedicareNo(String medicareNo) {
		this.medicareNo = medicareNo;
	}
}