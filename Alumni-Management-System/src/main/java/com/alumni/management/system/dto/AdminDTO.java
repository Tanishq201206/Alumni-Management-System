package com.alumni.management.system.dto;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name="ADMIN")
@Getter
@Setter
public class AdminDTO  extends BaseDTO {
	
	@Column(name="Name",length = 225)
	private String name;
	
	@Column(name="EMAIL",length = 225)
	private String email;
	
	@Column(name="ContactNo",length = 225)
	private String contactNo;
	
	@Column(name="Password",length = 225)
	private String password;
	
	@Transient
	private String confirmPassword;
	
	
	
	
	
}
