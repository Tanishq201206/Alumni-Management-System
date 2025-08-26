package com.alumni.management.system.form;

import javax.persistence.Column;
import javax.validation.constraints.NotEmpty;

import org.springframework.web.multipart.MultipartFile;

import com.alumni.management.system.dto.ApplyJobDTO;
import com.alumni.management.system.dto.BaseDTO;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ApplyJobForm extends BaseForm {
	
	@NotEmpty(message = "Candidate Name is required")
	private String name;
	
	@NotEmpty(message = "Email is required")
	private String email;
	
	@NotEmpty(message = "Contact No is required")
	private String contactNo;
	
	private MultipartFile file;
	
	private long jobId;
	
	private String jobName;
	

	@Override
	public BaseDTO getDTO() {
	    ApplyJobDTO bean = new ApplyJobDTO();
	    bean.setId(id);
	    bean.setName(name);            // <-- add this line
	    bean.setEmail(email);
	    bean.setContactNo(contactNo);
	    bean.setJobId(jobId);
	    bean.setJobName(jobName);
	    return bean;
	}

	@Override
	public void populate(BaseDTO bDto) {
		ApplyJobDTO  bean=(ApplyJobDTO)bDto;
		id=bean.getId();
		email=bean.getEmail();
		contactNo=bean.getContactNo();
		name=bean.getName();
		jobId=bean.getJobId();
		jobName=bean.getJobName();
	}

}
