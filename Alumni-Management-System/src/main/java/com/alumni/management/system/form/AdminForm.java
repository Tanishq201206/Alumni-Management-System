package com.alumni.management.system.form;

import javax.validation.constraints.NotEmpty;

import com.alumni.management.system.dto.AdminDTO;
import com.alumni.management.system.dto.BaseDTO;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AdminForm extends BaseForm {

	@NotEmpty(message = "Name is required")
	private String name;
	
	@NotEmpty(message = "Email id is required")
	private String email;
	
	@NotEmpty(message = "ContactNo is required")
	private String contactNo;
	
	@NotEmpty(message = "Password is required")
	private String password;
	
	@NotEmpty(message = "Confirm Password is required")
	private String confirmPassword;
	
	

	@Override
	public BaseDTO getDTO() {
		AdminDTO bean=new AdminDTO();
		bean.setId(id);
		bean.setName(name);
		bean.setEmail(email);
		bean.setPassword(password);
		bean.setContactNo(contactNo);
	
		return bean;
	}
	@Override
	public void populate(BaseDTO baseBean) {
		AdminDTO bean=(AdminDTO)baseBean;
		id=bean.getId();
		name=bean.getName();
		email=bean.getEmail();
		password=bean.getPassword();
		contactNo=bean.getContactNo();
		
	}
}
