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

import com.alumni.management.system.dao.AlumniDAOInt;
import com.alumni.management.system.dto.AlumniDTO;
import com.alumni.management.system.exception.DuplicateRecordException;
import com.alumni.management.system.util.EmailBuilder;



@Service
public class AlumniServiceImpl implements AlumniServiceInt {

	private static Logger log = Logger.getLogger(AlumniServiceImpl.class.getName());

	@Autowired
	private AlumniDAOInt dao;

	@Autowired
	private JavaMailSenderImpl mailSender;

	@Override
	@Transactional
	public long add(AlumniDTO dto) throws DuplicateRecordException {
		log.info("AlumniServiceImpl Add method start");
		AlumniDTO existDTO = dao.findByEmail(dto.getEmail());
		if (existDTO != null)
			throw new DuplicateRecordException("Email Already Exist");
		long pk = dao.add(dto);
		log.info("AlumniServiceImpl Add method end");
		return pk;
	}

	@Override
	@Transactional
	public void delete(AlumniDTO dto) {
		log.info("AlumniServiceImpl Delete method start");
		dao.delete(dto);
		log.info("AlumniServiceImpl Delete method end");

	}

	@Override
	@Transactional
	public AlumniDTO findBypk(long pk) {
		log.info("AlumniServiceImpl findBypk method start");
		AlumniDTO dto = dao.findBypk(pk);
		log.info("AlumniServiceImpl findBypk method end");
		return dto;
	}

	@Override
	@Transactional
	public AlumniDTO findByLogin(String login) {
		log.info("AlumniServiceImpl findByAlumniName method start");
		AlumniDTO dto = dao.findByEmail(login);
		log.info("AlumniServiceImpl findByAlumniName method end");
		return dto;
	}

	@Override
	@Transactional
	public void update(AlumniDTO dto) throws DuplicateRecordException {
		log.info("AlumniServiceImpl update method start");
		AlumniDTO existDTO = dao.findByEmail(dto.getEmail());
		if (existDTO != null && dto.getId() != existDTO.getId())
			throw new DuplicateRecordException("Email Id Already Exist");
		dao.update(dto);
		log.info("AlumniServiceImpl update method end");
	}

	@Override
	@Transactional
	public List<AlumniDTO> list() {
		log.info("AlumniServiceImpl list method start");
		List<AlumniDTO> list = dao.list();
		log.info("AlumniServiceImpl list method end");
		return list;
	}

	@Override
	@Transactional
	public List<AlumniDTO> list(int pageNo, int pageSize) {
		log.info("AlumniServiceImpl list method start");
		List<AlumniDTO> list = dao.list(pageNo, pageSize);
		log.info("AlumniServiceImpl list method end");
		return list;
	}

	@Override
	@Transactional
	public List<AlumniDTO> search(AlumniDTO dto) {
		log.info("AlumniServiceImpl search method start");
		List<AlumniDTO> list = dao.search(dto);
		log.info("AlumniServiceImpl search method end");
		return list;
	}

	@Override
	@Transactional
	public List<AlumniDTO> search(AlumniDTO dto, int pageNo, int pageSize) {
		log.info("AlumniServiceImpl search method start");
		List<AlumniDTO> list = dao.search(dto, pageNo, pageSize);
		log.info("AlumniServiceImpl search method end");
		return list;
	}

	@Override
	@Transactional
	public AlumniDTO authentication(AlumniDTO dto) {
		log.info("AlumniServiceImpl authentication method start");
		dto = dao.authentication(dto);
		log.info("AlumniServiceImpl authentication method end");
		return dto;
	}

	@Override
	@Transactional
	public boolean changePassword(Long id, String oldPassword, String newPassword) {
		log.info("AlumniServiceImpl  changePassword method start");
		AlumniDTO dtoExist = findBypk(id);
		if (dtoExist != null && dtoExist.getPassword().equals(oldPassword)) {
			dtoExist.setPassword(newPassword);
			dao.update(dtoExist);
			log.info("AlumniServiceImpl  changePassword method end");
			return true;
		} else {
			return false;
		}
	}

	@Transactional(propagation = Propagation.REQUIRED, readOnly = false)
	public boolean forgetPassword(String email) {

		AlumniDTO dtoExist = dao.findByEmail(email);

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
	public long register(AlumniDTO dto) throws DuplicateRecordException {
		long pk = add(dto);
		return pk;
	}
}
