package com.alumni.management.system.form;

import java.util.Date;

import javax.validation.constraints.NotEmpty;

import com.alumni.management.system.dto.BaseDTO;
import com.alumni.management.system.dto.JobDTO;
import com.alumni.management.system.util.DataUtility;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class JobForm extends BaseForm {

	@NotEmpty(message = "Company Name is required")
	private String companyName;

	@NotEmpty(message = "Location is required")
	private String location;

	@NotEmpty(message = "Title is required")
	private String title;

	@NotEmpty(message = "Qualification is required")
	private String qualification;

	@NotEmpty(message = "Description is required")
	private String description;

	@NotEmpty(message = " Required Skills is required")
	private String skills;

	@NotEmpty(message = "Package is required")
	private String jobPackage;

	@NotEmpty(message = "Experience Required is required")
	private String experienceRequired;

	@NotEmpty(message = "No of Vaccancy is required")
	private String noOfVaccancy;

	@NotEmpty(message = "Reference Email is required")
	private String referenceEmail;

	@NotEmpty(message = "Last Date is required")
	private String lastDate;

	@Override
	public BaseDTO getDTO() {
		JobDTO bean = new JobDTO();
		bean.setId(id);
		bean.setCompanyName(companyName);
		bean.setLocation(location);
		bean.setTitle(title);
		bean.setQualification(qualification);
		bean.setDescription(description);
		bean.setSkills(skills);
		bean.setJobPackage(jobPackage);
		bean.setExperienceRequired(experienceRequired);
		bean.setNoOfVaccancy(noOfVaccancy);
		bean.setReferenceEmail(referenceEmail);
		bean.setLastDate(DataUtility.getDate(lastDate));
		return bean;
	}

	@Override
	public void populate(BaseDTO bDto) {
		JobDTO bean = (JobDTO) bDto;
		id=bean.getId();
		companyName=bean.getCompanyName();
		location=bean.getLocation();
		title=bean.getTitle();
		qualification=bean.getQualification();
		description=bean.getDescription();
		skills=bean.getSkills();
		jobPackage=bean.getJobPackage();
		experienceRequired=bean.getExperienceRequired();
		noOfVaccancy=bean.getNoOfVaccancy();
		referenceEmail=bean.getReferenceEmail();
		lastDate=DataUtility.getDateString(bean.getLastDate());
	}

}
