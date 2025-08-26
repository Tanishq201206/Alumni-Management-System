package com.alumni.management.system.service;

import java.sql.Blob;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Logger;

import javax.sql.rowset.serial.SerialException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.alumni.management.system.dao.PlacementDAOInt;
import com.alumni.management.system.dto.PlacementDTO;
import com.alumni.management.system.exception.DuplicateRecordException;



@Service
public class PlacementServiceImpl implements PlacementServiceInt {

	private static Logger log = Logger.getLogger(PlacementServiceImpl.class.getName());

	@Autowired
	private PlacementDAOInt dao;

	
	@Override
	@Transactional
	public long add(PlacementDTO dto) throws DuplicateRecordException {
		log.info("PlacementServiceImpl Add method start");
		PlacementDTO existDTO = dao.findByName(dto.getName());
		if (existDTO != null)
			throw new DuplicateRecordException("Name Already Exist");
		long pk = dao.add(dto);
		log.info("PlacementServiceImpl Add method end");
		return pk;
	}

	@Override
	@Transactional
	public void delete(PlacementDTO dto) {
		log.info("PlacementServiceImpl Delete method start");
		dao.delete(dto);
		log.info("PlacementServiceImpl Delete method end");

	}

	@Override
	@Transactional
	public PlacementDTO findBypk(long pk) {
		log.info("PlacementServiceImpl findBypk method start");
		PlacementDTO dto = dao.findBypk(pk);
		log.info("PlacementServiceImpl findBypk method end");
		return dto;
	}

	@Override
	@Transactional
	public PlacementDTO findByName(String name) {
		log.info("PlacementServiceImpl findByPlacementName method start");
		PlacementDTO dto = dao.findByName(name);
		log.info("PlacementServiceImpl findByPlacementName method end");
		return dto;
	}

	@Override
	@Transactional
	public void update(PlacementDTO dto) throws DuplicateRecordException {
		log.info("PlacementServiceImpl update method start");
		PlacementDTO existDTO = dao.findByName(dto.getName());
		if (existDTO != null && dto.getId() != existDTO.getId())
			throw new DuplicateRecordException("Name Already Exist");
		dao.update(dto);
		log.info("PlacementServiceImpl update method end");
	}

	@Override
	@Transactional
	public List<PlacementDTO> list() {
		log.info("PlacementServiceImpl list method start");
		List<PlacementDTO> list = dao.list();
		log.info("PlacementServiceImpl list method end");
		return list;
	}

	@Override
	@Transactional
	public List<PlacementDTO> list(int pageNo, int pageSize) {
		log.info("PlacementServiceImpl list method start");
		List<PlacementDTO> list = dao.list(pageNo, pageSize);
		log.info("PlacementServiceImpl list method end");
		return list;
	}

	@Override
	@Transactional
	public List<PlacementDTO> search(PlacementDTO dto) {
		log.info("PlacementServiceImpl search method start");
		List<PlacementDTO> list = dao.search(dto);
		log.info("PlacementServiceImpl search method end");
		return list;
	}

	@Override
	@Transactional
	public List<PlacementDTO> search(PlacementDTO dto, int pageNo, int pageSize) {
		log.info("PlacementServiceImpl search method start");
		List<PlacementDTO> list = dao.search(dto, pageNo, pageSize);
		log.info("PlacementServiceImpl search method end");
		return list;
	}
	
	@Override
	@Transactional
	public Blob getImageById(long id) throws SerialException, SQLException {
		return dao.getImageById(id);
	}

	
}
