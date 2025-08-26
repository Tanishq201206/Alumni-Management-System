package com.alumni.management.system.service;

import java.util.HashMap;
import java.util.List;
import java.util.logging.Logger;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.alumni.management.system.dao.StaffDAOInt;
import com.alumni.management.system.dto.StaffDTO;
import com.alumni.management.system.exception.DuplicateRecordException;
import com.alumni.management.system.util.EmailBuilder;



@Service
public class StaffServiceImpl implements StaffServiceInt {

	private static Logger log = Logger.getLogger(StaffServiceImpl.class.getName());

	@Autowired
	private StaffDAOInt dao;

	@Autowired
	private JavaMailSenderImpl mailSender;

	@Override
	@Transactional
	public long add(StaffDTO dto) throws DuplicateRecordException {
		log.info("StaffServiceImpl Add method start");
		StaffDTO existDTO = dao.findByEmail(dto.getEmail());
		if (existDTO != null)
			throw new DuplicateRecordException("Email Already Exist");
		long pk = dao.add(dto);
		log.info("StaffServiceImpl Add method end");
		return pk;
	}

	@Override
	@Transactional
	public void delete(StaffDTO dto) {
		log.info("StaffServiceImpl Delete method start");
		dao.delete(dto);
		log.info("StaffServiceImpl Delete method end");

	}

	@Override
	@Transactional
	public StaffDTO findBypk(long pk) {
		log.info("StaffServiceImpl findBypk method start");
		StaffDTO dto = dao.findBypk(pk);
		log.info("StaffServiceImpl findBypk method end");
		return dto;
	}

	@Override
	@Transactional
	public StaffDTO findByLogin(String login) {
		log.info("StaffServiceImpl findByStaffName method start");
		StaffDTO dto = dao.findByEmail(login);
		log.info("StaffServiceImpl findByStaffName method end");
		return dto;
	}

	@Override
	@Transactional
	public void update(StaffDTO dto) throws DuplicateRecordException {
		log.info("StaffServiceImpl update method start");
		StaffDTO existDTO = dao.findByEmail(dto.getEmail());
		if (existDTO != null && dto.getId() != existDTO.getId())
			throw new DuplicateRecordException("Email Id Already Exist");
		dao.update(dto);
		log.info("StaffServiceImpl update method end");
	}

	@Override
	@Transactional
	public List<StaffDTO> list() {
		log.info("StaffServiceImpl list method start");
		List<StaffDTO> list = dao.list();
		log.info("StaffServiceImpl list method end");
		return list;
	}

	@Override
	@Transactional
	public List<StaffDTO> list(int pageNo, int pageSize) {
		log.info("StaffServiceImpl list method start");
		List<StaffDTO> list = dao.list(pageNo, pageSize);
		log.info("StaffServiceImpl list method end");
		return list;
	}

	@Override
	@Transactional
	public List<StaffDTO> search(StaffDTO dto) {
		log.info("StaffServiceImpl search method start");
		List<StaffDTO> list = dao.search(dto);
		log.info("StaffServiceImpl search method end");
		return list;
	}

	@Override
	@Transactional
	public List<StaffDTO> search(StaffDTO dto, int pageNo, int pageSize) {
		log.info("StaffServiceImpl search method start");
		List<StaffDTO> list = dao.search(dto, pageNo, pageSize);
		log.info("StaffServiceImpl search method end");
		return list;
	}

	@Override
	@Transactional
	public StaffDTO authentication(StaffDTO dto) {
		log.info("StaffServiceImpl authentication method start");
		dto = dao.authentication(dto);
		log.info("StaffServiceImpl authentication method end");
		return dto;
	}

	@Override
	@Transactional
	public boolean changePassword(Long id, String oldPassword, String newPassword) {
		log.info("StaffServiceImpl  changePassword method start");
		StaffDTO dtoExist = findBypk(id);
		if (dtoExist != null && dtoExist.getPassword().equals(oldPassword)) {
			dtoExist.setPassword(newPassword);
			dao.update(dtoExist);
			log.info("StaffServiceImpl  changePassword method end");
			return true;
		} else {
			return false;
		}
	}

	@Transactional(propagation = Propagation.REQUIRED, readOnly = false)
	public boolean forgetPassword(String email) {

		StaffDTO dtoExist = dao.findByEmail(email);

		/*
		 * if (dtoExist != null) {
		 * 
		 * HashMap<String, String> map = new HashMap<String, String>();
		 * map.put("firstName", dtoExist.getFirstName()); map.put("lastName",
		 * dtoExist.getLastName()); map.put("login", dtoExist.getLogin());
		 * map.put("password", dtoExist.getPassword());
		 * 
		 * String message = EmailBuilder.getForgetPasswordMessage(map);
		 * 
		 * MimeMessage msg = mailSender.createMimeMessage();
		 * 
		 * try { MimeMessageHelper helper = new MimeMessageHelper(msg);
		 * helper.setTo(dtoExist.getEmail());
		 * helper.setSubject("Project Tracking System  Forget Password ");
		 * helper.setText(message, true); mailSender.send(msg); } catch
		 * (MessagingException e) { e.printStackTrace(); return false; } } else { return
		 * false; }
		 */
		return true;
	}

	@Override
	public long register(StaffDTO dto) throws DuplicateRecordException {
		long pk = add(dto);
		return pk;
	}
}
