package com.alumni.management.system.service;

import java.sql.Blob;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Logger;

import javax.sql.rowset.serial.SerialException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.alumni.management.system.dao.GallaryDAOInt;
import com.alumni.management.system.dto.GallaryDTO;
import com.alumni.management.system.exception.DuplicateRecordException;



@Service
public class GallaryServiceImpl implements GallaryServiceInt {

	private static Logger log = Logger.getLogger(GallaryServiceImpl.class.getName());

	@Autowired
	private GallaryDAOInt dao;

	
	@Override
	@Transactional
	public long add(GallaryDTO dto) throws DuplicateRecordException {
		log.info("GallaryServiceImpl Add method start");
	
		long pk = dao.add(dto);
		log.info("GallaryServiceImpl Add method end");
		return pk;
	}

	@Override
	@Transactional
	public void delete(GallaryDTO dto) {
		log.info("GallaryServiceImpl Delete method start");
		dao.delete(dto);
		log.info("GallaryServiceImpl Delete method end");

	}

	@Override
	@Transactional
	public GallaryDTO findBypk(long pk) {
		log.info("GallaryServiceImpl findBypk method start");
		GallaryDTO dto = dao.findBypk(pk);
		log.info("GallaryServiceImpl findBypk method end");
		return dto;
	}

	@Override
	@Transactional
	public GallaryDTO findByTitle(String title) {
		log.info("GallaryServiceImpl findByGallaryName method start");
		GallaryDTO dto = dao.findByTitle(title);
		log.info("GallaryServiceImpl findByGallaryName method end");
		return dto;
	}

	@Override
	@Transactional
	public void update(GallaryDTO dto) throws DuplicateRecordException {
		log.info("GallaryServiceImpl update method start");
		dao.update(dto);
		log.info("GallaryServiceImpl update method end");
	}

	@Override
	@Transactional
	public List<GallaryDTO> list() {
		log.info("GallaryServiceImpl list method start");
		List<GallaryDTO> list = dao.list();
		log.info("GallaryServiceImpl list method end");
		return list;
	}

	@Override
	@Transactional
	public List<GallaryDTO> list(int pageNo, int pageSize) {
		log.info("GallaryServiceImpl list method start");
		List<GallaryDTO> list = dao.list(pageNo, pageSize);
		log.info("GallaryServiceImpl list method end");
		return list;
	}

	@Override
	@Transactional
	public List<GallaryDTO> search(GallaryDTO dto) {
		log.info("GallaryServiceImpl search method start");
		List<GallaryDTO> list = dao.search(dto);
		log.info("GallaryServiceImpl search method end");
		return list;
	}

	@Override
	@Transactional
	public List<GallaryDTO> search(GallaryDTO dto, int pageNo, int pageSize) {
		log.info("GallaryServiceImpl search method start");
		List<GallaryDTO> list = dao.search(dto, pageNo, pageSize);
		log.info("GallaryServiceImpl search method end");
		return list;
	}

	@Override
	@Transactional
	public Blob getImageById(long id) throws SerialException, SQLException {
		return dao.getImageById(id);
	}
	
	@Override
	@Transactional
	public void deleteByEventId(long eventId) {
	    dao.deleteByEventId(eventId);
	}

}
