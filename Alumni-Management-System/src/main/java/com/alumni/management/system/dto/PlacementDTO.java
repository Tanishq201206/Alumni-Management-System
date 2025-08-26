package com.alumni.management.system.dto;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name="Placement")
@Getter
@Setter
public class PlacementDTO extends BaseDTO {
	
	
		@Column(name="name",length = 225)
		private String name;
		
		@Column(name="Company_name",length = 225)
		private String companyName;
		
		@Column(name="Job_Package",length = 225)
		private String jobPackage;
		
		@Column(name="Location")
		private String location;

		@Temporal(TemporalType.DATE)
		@Column(name="placement_Date")
		private Date date;
		
		@Column(name="Post",length = 225)
		private String post;
		
		@Column(name="Image",columnDefinition ="LONGBLOB")
		private byte[] image;
		
		
}
