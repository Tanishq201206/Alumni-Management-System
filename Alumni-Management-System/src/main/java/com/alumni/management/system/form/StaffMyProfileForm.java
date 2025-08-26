package com.alumni.management.system.form;
import javax.validation.constraints.NotEmpty;

import com.alumni.management.system.dto.AdminDTO;
import com.alumni.management.system.dto.AlumniDTO;
import com.alumni.management.system.dto.BaseDTO;
import com.alumni.management.system.dto.StaffDTO;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class StaffMyProfileForm extends BaseForm {

	@NotEmpty(message = "Name is required")
	private String name;
	
	@NotEmpty(message = "Email Id is required")
	private String email;
	
	@NotEmpty(message = "Contact No is required")
	private String contactNo;
	
	
	public BaseDTO getDTO() {
		StaffDTO entity = new StaffDTO();
		entity.setName(name);
		entity.setContactNo(contactNo);
		entity.setEmail(email);
		return entity;
	}

	
	public void populate(BaseDTO bDto) {
		StaffDTO entity = (StaffDTO) bDto;
		name = entity.getName();
		contactNo=entity.getContactNo();
		email=entity.getEmail();
	}

	

}
