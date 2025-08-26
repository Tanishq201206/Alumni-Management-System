package com.alumni.management.system.service;

import java.util.List;
import java.util.logging.Logger;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.alumni.management.system.dao.JobDAOInt;
import com.alumni.management.system.dto.JobDTO;
import com.alumni.management.system.exception.DuplicateRecordException;



@Service
public class JobServiceImpl implements JobServiceInt {

	private static Logger log = Logger.getLogger(JobServiceImpl.class.getName());

	@Autowired
	private JobDAOInt dao;

	
	@Override
	@Transactional
	public long add(JobDTO dto) throws DuplicateRecordException {
		log.info("JobServiceImpl Add method start");
		JobDTO existDTO = dao.findByTitle(dto.getTitle());
		if (existDTO != null)
			throw new DuplicateRecordException("Title Already Exist");
		long pk = dao.add(dto);
		log.info("JobServiceImpl Add method end");
		return pk;
	}

	@Override
	@Transactional
	public void delete(JobDTO dto) {
		log.info("JobServiceImpl Delete method start");
		dao.delete(dto);
		log.info("JobServiceImpl Delete method end");

	}

	@Override
	@Transactional
	public JobDTO findBypk(long pk) {
		log.info("JobServiceImpl findBypk method start");
		JobDTO dto = dao.findBypk(pk);
		log.info("JobServiceImpl findBypk method end");
		return dto;
	}

	@Override
	@Transactional
	public JobDTO findByTitle(String title) {
		log.info("JobServiceImpl findByJobName method start");
		JobDTO dto = dao.findByTitle(title);
		log.info("JobServiceImpl findByJobName method end");
		return dto;
	}

	@Override
	@Transactional
	public void update(JobDTO dto) throws DuplicateRecordException {
		log.info("JobServiceImpl update method start");
		JobDTO existDTO = dao.findByTitle(dto.getTitle());
		if (existDTO != null && dto.getId() != existDTO.getId())
			throw new DuplicateRecordException("Title Already Exist");
		dao.update(dto);
		log.info("JobServiceImpl update method end");
	}

	@Override
	@Transactional
	public List<JobDTO> list() {
		log.info("JobServiceImpl list method start");
		List<JobDTO> list = dao.list();
		log.info("JobServiceImpl list method end");
		return list;
	}

	@Override
	@Transactional
	public List<JobDTO> list(int pageNo, int pageSize) {
		log.info("JobServiceImpl list method start");
		List<JobDTO> list = dao.list(pageNo, pageSize);
		log.info("JobServiceImpl list method end");
		return list;
	}

	@Override
	@Transactional
	public List<JobDTO> search(JobDTO dto) {
		log.info("JobServiceImpl search method start");
		List<JobDTO> list = dao.search(dto);
		log.info("JobServiceImpl search method end");
		return list;
	}

	@Override
	@Transactional
	public List<JobDTO> search(JobDTO dto, int pageNo, int pageSize) {
		log.info("JobServiceImpl search method start");
		List<JobDTO> list = dao.search(dto, pageNo, pageSize);
		log.info("JobServiceImpl search method end");
		return list;
	}

	
}
