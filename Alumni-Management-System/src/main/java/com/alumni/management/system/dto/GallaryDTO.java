package com.alumni.management.system.dto;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name="Gallary")
@Getter
@Setter
public class GallaryDTO extends BaseDTO {

	@Column(name="Event_Id")	
	private long eventId;
	
	@ManyToOne 
	@JoinColumn(name="Event",nullable = false)
	private EventDTO event;
	
	@Column(name="Event_Image",columnDefinition = "LONGBLOB")
	private byte[] image;
	
}
