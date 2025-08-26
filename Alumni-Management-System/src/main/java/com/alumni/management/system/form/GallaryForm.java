package com.alumni.management.system.form;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotEmpty;

import org.springframework.web.multipart.MultipartFile;

import com.alumni.management.system.dto.BaseDTO;
import com.alumni.management.system.dto.GallaryDTO;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class GallaryForm extends BaseForm {
	
	@Min(value = 1,message = "Event Name is required")
	private long eventId;
	
	private MultipartFile image;
	

	@Override
	public BaseDTO getDTO() {
		GallaryDTO bean=new GallaryDTO();
		bean.setId(id);
		bean.setEventId(eventId);
		return bean;
	}

	@Override
	public void populate(BaseDTO bDto) {
		GallaryDTO bean=(GallaryDTO)bDto;
		id=bean.getId();
		eventId=bean.getEventId();	
	}

}
