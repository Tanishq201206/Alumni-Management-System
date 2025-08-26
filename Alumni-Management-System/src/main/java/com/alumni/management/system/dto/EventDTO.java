package com.alumni.management.system.dto;

import java.util.Date;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name="Event")
@Getter
@Setter
public class EventDTO extends BaseDTO {
	
	@Column(name="Title",length = 225)
	private String title;
	
	@Column(name="Location",length = 755)
	private String location;
	
	@Temporal(TemporalType.DATE)
	@Column(name="Event_Date")
	private Date eventDate;
	
	@Column(name="Event_Time")
	private String eventTime;
	
	@Column(name="Description",length = 755)
	private String description;
	
	@Column(name="Status",length = 755)
	private String status;
	
	@Column(name="adminId")
	private long adminId;
	@Column(name="alumniId",length = 755)
	private long alumniId;
	@Column(name="StaffId",length = 755)
	private long staffId;
	
	@OneToMany(cascade = CascadeType.ALL,fetch = FetchType.LAZY,mappedBy = "event")
	private Set<GallaryDTO> gallarys;
	
	@OneToMany(cascade = CascadeType.ALL,fetch = FetchType.LAZY,mappedBy = "event")
	private Set<ParticipantDTO> participants;
	

}
