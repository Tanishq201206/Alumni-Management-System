package com.alumni.management.system.dao;

import java.util.List;

import com.alumni.management.system.dto.AlumniDTO;



public interface AlumniDAOInt {

	public long add(AlumniDTO dto);
	
	public void delete(AlumniDTO dto);
	
	public AlumniDTO findBypk(long pk);
	
	public AlumniDTO findByEmail(String email);
	
	public void update(AlumniDTO dto);
	
	public List<AlumniDTO> list();
	
	public List<AlumniDTO>list(int pageNo,int pageSize);
	
	public List<AlumniDTO> search(AlumniDTO dto);
	
	public List<AlumniDTO> search(AlumniDTO dto,int pageNo,int pageSize);
	
	public AlumniDTO authentication(AlumniDTO dto);
	
}
