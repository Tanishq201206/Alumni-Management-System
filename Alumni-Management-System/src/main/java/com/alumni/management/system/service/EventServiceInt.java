package com.alumni.management.system.service;

import java.util.List;

import com.alumni.management.system.dto.EventDTO;
import com.alumni.management.system.exception.DuplicateRecordException;



public interface EventServiceInt {

	public long add(EventDTO dto) throws DuplicateRecordException;

	public void delete(EventDTO dto);

	public EventDTO findBypk(long pk);

	public EventDTO findByTitle(String title);

	public void update(EventDTO dto) throws DuplicateRecordException;

	public List<EventDTO> list();

	public List<EventDTO> list(int pageNo, int pageSize);

	public List<EventDTO> search(EventDTO dto);

	public List<EventDTO> search(EventDTO dto, int pageNo, int pageSize);


}
