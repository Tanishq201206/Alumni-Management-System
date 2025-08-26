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

import com.alumni.management.system.dao.ApplyJobDAOInt;
import com.alumni.management.system.dto.ApplyJobDTO;
import com.alumni.management.system.exception.DuplicateRecordException;



@Service
public class ApplyJobServiceImpl implements ApplyJobServiceInt {

	private static Logger log = Logger.getLogger(ApplyJobServiceImpl.class.getName());

	@Autowired
	private ApplyJobDAOInt dao;

	@Override
    @Transactional(readOnly = true)
    public boolean existsByJobAndEmail(long jobId, String email) {
        return dao.countByJobAndEmail(jobId, email) > 0;
    }
	
	 @Override
	    @Transactional
	    public long add(ApplyJobDTO dto) throws DuplicateRecordException {
	        log.info("ApplyJobServiceImpl Add method start");

	        // Guard: same job + same email (case-insensitive)
	        if (existsByJobAndEmail(dto.getJobId(), dto.getEmail())) {
	            throw new DuplicateRecordException("You have already applied to this job.");
	        }

	        long pk = dao.add(dto);
	        log.info("ApplyJobServiceImpl Add method end");
	        return pk;
	    }
	@Override
	@Transactional
	public void delete(ApplyJobDTO dto) {
		log.info("ApplyJobServiceImpl Delete method start");
		dao.delete(dto);
		log.info("ApplyJobServiceImpl Delete method end");

	}

	@Override
	@Transactional
	public ApplyJobDTO findBypk(long pk) {
		log.info("ApplyJobServiceImpl findBypk method start");
		ApplyJobDTO dto = dao.findBypk(pk);
		log.info("ApplyJobServiceImpl findBypk method end");
		return dto;
	}

	@Override
	@Transactional
	public ApplyJobDTO findByName(String name) {
		log.info("ApplyJobServiceImpl findByApplyJobName method start");
		ApplyJobDTO dto = dao.findByName(name);
		log.info("ApplyJobServiceImpl findByApplyJobName method end");
		return dto;
	}

	@Override
	@Transactional
	public void update(ApplyJobDTO dto) throws DuplicateRecordException {
		log.info("ApplyJobServiceImpl update method start");
		
		dao.update(dto);
		log.info("ApplyJobServiceImpl update method end");
	}

	@Override
	@Transactional
	public List<ApplyJobDTO> list() {
		log.info("ApplyJobServiceImpl list method start");
		List<ApplyJobDTO> list = dao.list();
		log.info("ApplyJobServiceImpl list method end");
		return list;
	}

	@Override
	@Transactional
	public List<ApplyJobDTO> list(int pageNo, int pageSize) {
		log.info("ApplyJobServiceImpl list method start");
		List<ApplyJobDTO> list = dao.list(pageNo, pageSize);
		log.info("ApplyJobServiceImpl list method end");
		return list;
	}

	@Override
	@Transactional
	public List<ApplyJobDTO> search(ApplyJobDTO dto) {
		log.info("ApplyJobServiceImpl search method start");
		List<ApplyJobDTO> list = dao.search(dto);
		log.info("ApplyJobServiceImpl search method end");
		return list;
	}

	@Override
	@Transactional
	public List<ApplyJobDTO> search(ApplyJobDTO dto, int pageNo, int pageSize) {
		log.info("ApplyJobServiceImpl search method start");
		List<ApplyJobDTO> list = dao.search(dto, pageNo, pageSize);
		log.info("ApplyJobServiceImpl search method end");
		return list;
	}
	
	@Override
	@Transactional
	public Blob getFileById(long id) throws SerialException, SQLException {
		return dao.getFileById(id);
	}

	
}
