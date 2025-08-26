package com.alumni.management.system.dto;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;


import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name="FEED_BACK")
@Getter
@Setter
public class FeedBackDTO extends BaseDTO {

	@Column(name="FEED_BACK",length = 2000)
	private String feedBack;
	
}
