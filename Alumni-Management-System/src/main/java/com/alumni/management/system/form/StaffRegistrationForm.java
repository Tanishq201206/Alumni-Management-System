package com.alumni.management.system.form;


import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;
import javax.validation.constraints.NotEmpty;

import com.alumni.management.system.dto.AlumniDTO;
import com.alumni.management.system.dto.BaseDTO;
import com.alumni.management.system.dto.StaffDTO;
import com.alumni.management.system.util.DataUtility;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class StaffRegistrationForm extends BaseForm {

	@NotEmpty(message = "Name is required")
	private String name;
	
	@NotEmpty(message = "Qualification is required")
	private String qualification;
	
	@NotEmpty(message = "Date of birth is required")
	private String dob;
	
	@NotEmpty(message = "Address is required")
	private String address;
	
	@NotEmpty(message = "Joining Date is required")
	private String joinDate;
	
	@NotEmpty(message = "Designation is required")
	private String designation;
	
	@NotEmpty(message = "Contact No is required")
	private String contactNo;
	
	@NotEmpty(message = "Email is required")
	private String email;
	
	@NotEmpty(message = "Password is required")
	private String password;
	
	@NotEmpty(message = "Confirm Password is required")
	private String confirmPassword;	
	
	
	

	@Override
	public BaseDTO getDTO() {
		StaffDTO bean=new StaffDTO();
		bean.setId(id);
		bean.setName(name);
		bean.setQualification(qualification);
		bean.setEmail(email);
		bean.setPassword(password);
		bean.setContactNo(contactNo);
		bean.setDob(DataUtility.getDate(dob));
		bean.setAddress(address);
		bean.setJoinDate(DataUtility.getDate(joinDate));
		bean.setDesignation(designation);
		bean.setPassword(password);
		bean.setConfirmPassword(confirmPassword);
		
		return bean;
	}
	@Override
	public void populate(BaseDTO baseBean) {
		StaffDTO bean=(StaffDTO)baseBean;
		id=bean.getId();
		name=bean.getName();
		qualification=bean.getQualification();
		email=bean.getEmail();
		password=bean.getPassword();
		contactNo=bean.getContactNo();
		dob=DataUtility.getDateString(bean.getDob());
		address=bean.getAddress();
		joinDate=DataUtility.getDateString(bean.getJoinDate());
		designation=bean.getDesignation();
		password=bean.getPassword();
		confirmPassword=bean.getConfirmPassword();
		
	}
}
