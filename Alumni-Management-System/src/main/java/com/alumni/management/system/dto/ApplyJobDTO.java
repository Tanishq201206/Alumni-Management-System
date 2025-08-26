package com.alumni.management.system.dto;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name="ApplyJob")
@Getter
@Setter
public class ApplyJobDTO extends BaseDTO {
	
	@Column(name="Name",length = 225)
	private String name;
	@Column(name="Email",length = 225)
	private String email;
	@Column(name="ContactNo",length = 225)
	private String contactNo;
	@Column(name="Resume_File",columnDefinition = "LONGBLOB")
	private byte[] file;
	
	@Column(name="JOB_ID")
	private long jobId;
	@Column(name="JOB_NAME",length = 225)
	private String jobName;
	
	@ManyToOne
	@JoinColumn(name="JOB",nullable = false)
	private JobDTO job;
	

}
