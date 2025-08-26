package com.alumni.management.system.form;

import javax.validation.constraints.NotEmpty;

import com.alumni.management.system.dto.BaseDTO;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class StaffChangePasswordForm extends BaseForm  {

	@NotEmpty(message = "Old Password is required")
	private String oldPassword;
	
	@NotEmpty(message = "Confirm Password is required")
	private String confirmPassword;
	
	@NotEmpty(message = "New Passeword is required")
	private String newPassword;

	

	@Override
	public BaseDTO getDTO() {
		return null;
	}

	@Override
	public void populate(BaseDTO bDto) {
	}
	
}
