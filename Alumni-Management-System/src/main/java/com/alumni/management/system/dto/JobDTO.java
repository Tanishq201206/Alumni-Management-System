package com.alumni.management.system.dto;

import java.util.Date;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name="JOB")
@Getter
@Setter
public class JobDTO extends BaseDTO {

	@Column(name="Company_name",length = 755)
	private String companyName;
	
	@Column(name="location",length = 1500)
	private String location;
	
	@Column(name="Title",length = 755)
	private String title;
	
	@Column(name="qualification",length = 755)
	private String qualification;
	
	@Column(name="description",length = 2000)
	private String description;
	
	@Column(name="Skills",length = 755)
	private String skills;
	
	@Column(name="Job_Package",length = 755)
	private String jobPackage;
	
	@Column(name="Experience_Required",length = 755)
	private String experienceRequired;
	
	@Column(name="no_of_vaccancy",length = 755)
	private String noOfVaccancy;
	
	@Column(name="Reference_email",length = 755)
	private String referenceEmail;
	
	@Temporal(TemporalType.DATE)
	@Column(name="last_date")
	private Date lastDate;
	
	private long alumniId;
	
	@OneToMany(cascade = CascadeType.ALL,mappedBy = "job",fetch = FetchType.LAZY)
	private Set<ApplyJobDTO> applyJobs;
}
