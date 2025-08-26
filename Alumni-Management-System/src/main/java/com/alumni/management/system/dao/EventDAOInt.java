package com.alumni.management.system.dao;

import java.util.List;

import com.alumni.management.system.dto.EventDTO;



public interface EventDAOInt {

	public long add(EventDTO dto);
	
	public void delete(EventDTO dto);
	
	public EventDTO findBypk(long pk);
	
	public EventDTO findByTitle(String title);
	
	public void update(EventDTO dto);
	
	public List<EventDTO> list();
	
	public List<EventDTO>list(int pageNo,int pageSize);
	
	public List<EventDTO> search(EventDTO dto);
	
	public List<EventDTO> search(EventDTO dto,int pageNo,int pageSize);
	
	
}
