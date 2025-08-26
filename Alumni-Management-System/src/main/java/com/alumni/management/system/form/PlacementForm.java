package com.alumni.management.system.form;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotEmpty;

import org.springframework.web.multipart.MultipartFile;

import com.alumni.management.system.dto.BaseDTO;
import com.alumni.management.system.dto.PlacementDTO;
import com.alumni.management.system.util.DataUtility;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PlacementForm extends BaseForm {
	
	
	@NotEmpty(message = "Name is required")
	private String name;
	
	@NotEmpty(message = "Company Name is required")
	private String companyName;
	
	@NotEmpty(message = "Job Package is required")
	private String jobPackage;
	
	@NotEmpty(message = "Location is required")
	private String location;

	@NotEmpty(message = "Placement Date is required")
	private String date;
	
	@NotEmpty(message = "Designation is required")
	private String post;
	
	private MultipartFile image;

	@Override
	public BaseDTO getDTO() {
		PlacementDTO bean=new PlacementDTO();
		bean.setId(id);
		bean.setName(name);
		bean.setCompanyName(companyName);
		bean.setJobPackage(jobPackage);
		bean.setLocation(location);
		bean.setDate(DataUtility.getDate(date));
		bean.setPost(post);
		return bean;
	}

	@Override
	public void populate(BaseDTO bDto) {
		PlacementDTO bean=(PlacementDTO)bDto;
		id=bean.getId();
		name=bean.getName();
		companyName=bean.getCompanyName();
		jobPackage=bean.getJobPackage();
		location=bean.getLocation();
		date=DataUtility.getDateString(bean.getDate());
		post=bean.getPost();
		
	}

}
