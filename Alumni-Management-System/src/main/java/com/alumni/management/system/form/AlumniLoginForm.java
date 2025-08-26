package com.alumni.management.system.form;

import javax.validation.constraints.NotEmpty;

import com.alumni.management.system.dto.AdminDTO;
import com.alumni.management.system.dto.AlumniDTO;
import com.alumni.management.system.dto.BaseDTO;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AlumniLoginForm extends BaseForm {

	@NotEmpty(message = "Email Id is required")
	private String email;
	@NotEmpty(message = "Password is required")
	private String password;
	

	@Override
	public BaseDTO getDTO() {
		AlumniDTO bean=new AlumniDTO();
		bean.setEmail(email);
		bean.setPassword(password);
		return bean;
	}

	@Override
	public void populate(BaseDTO bdto) {
		AlumniDTO entity=(AlumniDTO) bdto;
		email=entity.getEmail();
		password=entity.getPassword();
	}

}
