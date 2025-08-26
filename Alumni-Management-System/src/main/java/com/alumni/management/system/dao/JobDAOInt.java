package com.alumni.management.system.dao;

import java.util.List;

import com.alumni.management.system.dto.JobDTO;



public interface JobDAOInt {

	public long add(JobDTO dto);
	
	public void delete(JobDTO dto);
	
	public JobDTO findBypk(long pk);
	
	public JobDTO findByTitle(String title);
	
	public void update(JobDTO dto);
	
	public List<JobDTO> list();
	
	public List<JobDTO>list(int pageNo,int pageSize);
	
	public List<JobDTO> search(JobDTO dto);
	
	public List<JobDTO> search(JobDTO dto,int pageNo,int pageSize);
	
	
}
