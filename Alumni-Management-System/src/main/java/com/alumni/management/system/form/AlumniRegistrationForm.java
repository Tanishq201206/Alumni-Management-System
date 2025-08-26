package com.alumni.management.system.form;


import javax.validation.constraints.NotEmpty;

import com.alumni.management.system.dto.AlumniDTO;
import com.alumni.management.system.dto.BaseDTO;
import com.alumni.management.system.util.DataUtility;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AlumniRegistrationForm extends BaseForm {

	@NotEmpty(message = "Name is required")
	private String name;

	@NotEmpty(message = "Gender is required")
	private String gender;
	
	@NotEmpty(message = "Date of birth is required")
	private String dob;
	
	@NotEmpty(message = "Email is required")
	private String email;
	
	@NotEmpty(message = "Contact No is required")
	private String contactNo;
	
	@NotEmpty(message = "Course Name is required")
	private String courseName;
	
	@NotEmpty(message = "Occupation is required")
	private String occupation;
	
	@NotEmpty(message = "Address is required")
	private String address;
	
	@NotEmpty(message = "Region is required")
	private String region;
	
	@NotEmpty(message = "Message is required")
	private String message;
	
	@NotEmpty(message = "Password is required")
	private String password;
	
	@NotEmpty(message = "Confirm Password is required")
	private String confirmPassword;
	
	
	

	@Override
	public BaseDTO getDTO() {
		AlumniDTO bean=new AlumniDTO();
		bean.setId(id);
		bean.setName(name);
		bean.setGender(gender);
		bean.setEmail(email);
		bean.setPassword(password);
		bean.setContactNo(contactNo);
		bean.setDob(DataUtility.getDate(dob));
		bean.setCourseName(courseName);
		bean.setOccupation(occupation);
		bean.setAddress(address);
		bean.setRegion(region);
		bean.setMessage(message);
		bean.setPassword(password);
		bean.setConfirmPassword(confirmPassword);
		return bean;
	}
	@Override
	public void populate(BaseDTO baseBean) {
		AlumniDTO bean=(AlumniDTO)baseBean;
		id=bean.getId();
		name=bean.getName();
		gender=bean.getGender();
		email=bean.getEmail();
		password=bean.getPassword();
		contactNo=bean.getContactNo();
		dob=DataUtility.getDateString(bean.getDob());
		courseName=bean.getCourseName();
		occupation=bean.getOccupation();
		address=bean.getAddress();
		region=bean.getRegion();
		message=bean.getMessage();
		password=bean.getPassword();
		confirmPassword=bean.getConfirmPassword();
		
	}
}
