package com.alumni.management.system.dao;

import java.util.List;

import com.alumni.management.system.dto.ParticipantDTO;



public interface ParticipantDAOInt {

	public long add(ParticipantDTO dto);
	
	public void delete(ParticipantDTO dto);
	
	public ParticipantDTO findBypk(long pk);
	
	public ParticipantDTO findByName(String name);
	
	public void update(ParticipantDTO dto);
	
	public List<ParticipantDTO> list();
	
	public List<ParticipantDTO>list(int pageNo,int pageSize);
	
	public List<ParticipantDTO> search(ParticipantDTO dto);
	
	public List<ParticipantDTO> search(ParticipantDTO dto,int pageNo,int pageSize);
	
	void deleteByEventId(long eventId);
	
	boolean existsByEventIdAndUserId(long eventId, long userId);
	ParticipantDTO findByEventIdAndUserId(long eventId, long userId);

	
	
}
