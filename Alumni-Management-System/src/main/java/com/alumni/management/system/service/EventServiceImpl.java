package com.alumni.management.system.service;

import java.util.List;
import java.util.logging.Logger;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.alumni.management.system.dao.EventDAOInt;
import com.alumni.management.system.dto.EventDTO;
import com.alumni.management.system.exception.DuplicateRecordException;



@Service
public class EventServiceImpl implements EventServiceInt {

	private static Logger log = Logger.getLogger(EventServiceImpl.class.getName());

	@Autowired
	private EventDAOInt dao;

	
	@Override
	@Transactional
	public long add(EventDTO dto) throws DuplicateRecordException {
		log.info("EventServiceImpl Add method start");
		EventDTO existDTO = dao.findByTitle(dto.getTitle());
		if (existDTO != null)
			throw new DuplicateRecordException("Title Already Exist");
		long pk = dao.add(dto);
		log.info("EventServiceImpl Add method end");
		return pk;
	}

	@Override
	@Transactional
	public void delete(EventDTO dto) {
		log.info("EventServiceImpl Delete method start");
		dao.delete(dto);
		log.info("EventServiceImpl Delete method end");

	}

	@Override
	@Transactional
	public EventDTO findBypk(long pk) {
		log.info("EventServiceImpl findBypk method start");
		EventDTO dto = dao.findBypk(pk);
		log.info("EventServiceImpl findBypk method end");
		return dto;
	}

	@Override
	@Transactional
	public EventDTO findByTitle(String title) {
		log.info("EventServiceImpl findByEventName method start");
		EventDTO dto = dao.findByTitle(title);
		log.info("EventServiceImpl findByEventName method end");
		return dto;
	}

	@Override
	@Transactional
	public void update(EventDTO dto) throws DuplicateRecordException {
		log.info("EventServiceImpl update method start");
		EventDTO existDTO = dao.findByTitle(dto.getTitle());
		if (existDTO != null && dto.getId() != existDTO.getId())
			throw new DuplicateRecordException("Title Already Exist");
		dao.update(dto);
		log.info("EventServiceImpl update method end");
	}

	@Override
	@Transactional
	public List<EventDTO> list() {
		log.info("EventServiceImpl list method start");
		List<EventDTO> list = dao.list();
		log.info("EventServiceImpl list method end");
		return list;
	}

	@Override
	@Transactional
	public List<EventDTO> list(int pageNo, int pageSize) {
		log.info("EventServiceImpl list method start");
		List<EventDTO> list = dao.list(pageNo, pageSize);
		log.info("EventServiceImpl list method end");
		return list;
	}

	@Override
	@Transactional
	public List<EventDTO> search(EventDTO dto) {
		log.info("EventServiceImpl search method start");
		List<EventDTO> list = dao.search(dto);
		log.info("EventServiceImpl search method end");
		return list;
	}

	@Override
	@Transactional
	public List<EventDTO> search(EventDTO dto, int pageNo, int pageSize) {
		log.info("EventServiceImpl search method start");
		List<EventDTO> list = dao.search(dto, pageNo, pageSize);
		log.info("EventServiceImpl search method end");
		return list;
	}

	
}
