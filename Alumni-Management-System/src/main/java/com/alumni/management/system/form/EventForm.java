package com.alumni.management.system.form;

import java.util.Date;

import javax.validation.constraints.NotEmpty;

import com.alumni.management.system.dto.BaseDTO;
import com.alumni.management.system.dto.EventDTO;
import com.alumni.management.system.util.DataUtility;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class EventForm extends BaseForm {
	
	@NotEmpty(message = "Title is required")
	private String title;
	
	@NotEmpty(message = "Location is required")
	private String location;
	
	@NotEmpty(message = "Event Date is required")
	private String eventDate;
	
	@NotEmpty(message = "Event Time is required")
	private String eventTime;
	
	@NotEmpty(message = "Description is required")
	private String description;
	
	@NotEmpty(message = "Status is required")
	private String status;
	

	@Override
	public BaseDTO getDTO() {
		EventDTO bean=new EventDTO();
		bean.setId(id);
		bean.setTitle(title);
		bean.setLocation(location);
		bean.setEventDate(DataUtility.getDate(eventDate));
		bean.setEventTime(eventTime);
		bean.setDescription(description);
		bean.setStatus(status);
		return bean;
	}

	@Override
	public void populate(BaseDTO bDto) {
		EventDTO bean=(EventDTO)bDto;
		id=bean.getId();
		title=bean.getTitle();
		location=bean.getLocation();
		eventDate=DataUtility.getDateString(bean.getEventDate());
		eventTime=bean.getEventTime();
		description=bean.getDescription();
		status=bean.getStatus();
	}

}
