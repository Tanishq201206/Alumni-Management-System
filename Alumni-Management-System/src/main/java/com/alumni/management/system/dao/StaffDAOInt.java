package com.alumni.management.system.dao;

import java.util.List;

import com.alumni.management.system.dto.StaffDTO;



public interface StaffDAOInt {

	public long add(StaffDTO dto);
	
	public void delete(StaffDTO dto);
	
	public StaffDTO findBypk(long pk);
	
	public StaffDTO findByEmail(String email);
	
	public void update(StaffDTO dto);
	
	public List<StaffDTO> list();
	
	public List<StaffDTO>list(int pageNo,int pageSize);
	
	public List<StaffDTO> search(StaffDTO dto);
	
	public List<StaffDTO> search(StaffDTO dto,int pageNo,int pageSize);
	
	public StaffDTO authentication(StaffDTO dto);
	
}
