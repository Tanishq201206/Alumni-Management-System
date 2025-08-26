package com.alumni.management.system.form;


import javax.validation.constraints.NotEmpty;

import com.alumni.management.system.dto.BaseDTO;
import com.alumni.management.system.dto.FeedBackDTO;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class FeedBackForm extends BaseForm{
	
	@NotEmpty(message ="FeedBack is required")
	private String feedBack;

	@Override
	public BaseDTO getDTO() {
		FeedBackDTO bean=new FeedBackDTO();
		bean.setId(id);
		bean.setFeedBack(feedBack);
		return bean;
	}

	@Override
	public void populate(BaseDTO bDto) {
		FeedBackDTO bean=(FeedBackDTO)bDto;
		bean.setId(id);
		bean.setFeedBack(feedBack);
	}

}
