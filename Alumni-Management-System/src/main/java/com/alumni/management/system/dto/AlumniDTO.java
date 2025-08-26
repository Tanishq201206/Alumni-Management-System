package com.alumni.management.system.dto;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name="ALUMNI")
@Getter
@Setter
public class AlumniDTO extends BaseDTO {
	

	@Column(name="Name",length = 225)
	private String name;
	
	@Column(name="Gender",length = 225)
	private String gender;
	
	@Temporal(TemporalType.DATE)
	@Column(name="DOB")
	private Date dob;
	
	@Column(name="EMAIL_ID",length = 225)
	private String email;
	
	@Column(name="CONTACT_NO",length = 225)
	private String contactNo;
	
	@Column(name="COURSE_NAME",length = 225)
	private String courseName;
	
	@Column(name="OCCUPATION",length = 225)
	private String occupation;
	
	@Column(name="ADDRESS",length = 225)
	private String address;
	
	@Column(name="REGION",length = 225)
	private String region;
	
	@Column(name="Message",length = 225)
	private String message;
	
	@Column(name="PASSWORD",length = 225)
	private String password;
	
	@Transient
	private String confirmPassword;
	

}
