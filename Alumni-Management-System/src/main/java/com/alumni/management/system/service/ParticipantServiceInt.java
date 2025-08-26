package com.alumni.management.system.service;

import java.util.List;

import com.alumni.management.system.dto.ParticipantDTO;
import com.alumni.management.system.exception.DuplicateRecordException;



public interface ParticipantServiceInt {

	public long add(ParticipantDTO dto) throws DuplicateRecordException;

	public void delete(ParticipantDTO dto);

	public ParticipantDTO findBypk(long pk);

	public ParticipantDTO findByName(String name);

	public void update(ParticipantDTO dto) throws DuplicateRecordException;

	public List<ParticipantDTO> list();

	public List<ParticipantDTO> list(int pageNo, int pageSize);

	public List<ParticipantDTO> search(ParticipantDTO dto);

	public List<ParticipantDTO> search(ParticipantDTO dto, int pageNo, int pageSize);
	
	void deleteByEventId(long eventId);
	
	boolean existsByEventIdAndUserId(long eventId, long userId);

    ParticipantDTO findByEventIdAndUserId(long eventId, long userId);

}
