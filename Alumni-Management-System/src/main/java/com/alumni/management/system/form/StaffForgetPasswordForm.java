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
public class StaffForgetPasswordForm extends BaseForm {

	@NotEmpty(message = "Email Id is required")
	private String email;

	@Override
	public BaseDTO getDTO() {
		StaffDTO dto = new StaffDTO();
		dto.setEmail(email);
		return dto;
	}

	@Override
	public void populate(BaseDTO bDto) {
		
	}

}
