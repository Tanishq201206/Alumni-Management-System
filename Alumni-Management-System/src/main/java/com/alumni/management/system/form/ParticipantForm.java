package com.alumni.management.system.form;


import com.alumni.management.system.dto.BaseDTO;
import com.alumni.management.system.dto.ParticipantDTO;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ParticipantForm extends BaseForm {

	private String name;
	
	private long eventId;
	
	private String eventName;
	
	private String contactNo;
	
	private long userId;
	
	@Override
	public BaseDTO getDTO() {
		ParticipantDTO bean=new ParticipantDTO();
		bean.setId(id);
		bean.setName(name);
	    bean.setEventId(eventId); 
		bean.setEventName(eventName);
		bean.setContactNo(contactNo);
		bean.setUserId(userId);
		return bean;
	}

	@Override
	public void populate(BaseDTO bDto) {
		
	}

}