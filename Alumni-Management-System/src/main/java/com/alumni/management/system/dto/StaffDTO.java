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
@Table(name="STAFF")
@Getter
@Setter
public class StaffDTO extends BaseDTO{

	
	@Column(name="Name",length = 225)
	private String name;
	
	@Column(name="QUALIFICATION",length = 755)
	private String qualification;
	
	@Temporal(TemporalType.DATE)
	@Column(name="DOB")
	private Date dob;
	
	@Column(name="ADDRESS",length = 755)
	private String address;
	
	@Temporal(TemporalType.DATE)
	@Column(name="JOIN_DATE")
	private Date joinDate;
	
	@Column(name="DESIGNATION",length = 755)
	private String designation;
	
	@Column(name="CONTACT_NO",length = 755)
	private String contactNo;
	
	@Column(name="EAMIL",length = 755)
	private String email;
	
	@Column(name="PASSWORD",length = 755)
	private String password;
	
	@Transient
	private String confirmPassword;
	
	
	
	
	
}
