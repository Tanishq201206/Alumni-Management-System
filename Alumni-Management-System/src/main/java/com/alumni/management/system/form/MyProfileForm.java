package com.alumni.management.system.form;
import javax.validation.constraints.NotEmpty;

import com.alumni.management.system.dto.AdminDTO;
import com.alumni.management.system.dto.BaseDTO;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MyProfileForm extends BaseForm {

	@NotEmpty(message = "Name is required")
	private String name;
	
	@NotEmpty(message = "Email Id is required")
	private String email;
	
	@NotEmpty(message = "Contact No is required")
	private String contactNo;
	
	
	
	
	public BaseDTO getDTO() {
		AdminDTO entity = new AdminDTO();
		entity.setName(name);
		entity.setContactNo(contactNo);
		entity.setEmail(email);
		return entity;
	}

	
	public void populate(BaseDTO bDto) {
		AdminDTO entity = (AdminDTO) bDto;
		name = entity.getName();
		contactNo=entity.getContactNo();
		email=entity.getEmail();
	}

	

}
