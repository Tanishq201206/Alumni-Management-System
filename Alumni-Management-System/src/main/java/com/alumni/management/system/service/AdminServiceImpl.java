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

import com.alumni.management.system.dao.AdminDAOInt;
import com.alumni.management.system.dto.AdminDTO;
import com.alumni.management.system.exception.DuplicateRecordException;
import com.alumni.management.system.util.EmailBuilder;



@Service
public class AdminServiceImpl implements AdminServiceInt {

	private static Logger log = Logger.getLogger(AdminServiceImpl.class.getName());

	@Autowired
	private AdminDAOInt dao;

	@Autowired
	private JavaMailSenderImpl mailSender;

	@Override
	@Transactional
	public long add(AdminDTO dto) throws DuplicateRecordException {
		log.info("AdminServiceImpl Add method start");
		AdminDTO existDTO = dao.findByEmail(dto.getEmail());
		if (existDTO != null)
			throw new DuplicateRecordException("Email Already Exist");
		long pk = dao.add(dto);
		log.info("AdminServiceImpl Add method end");
		return pk;
	}

	@Override
	@Transactional
	public void delete(AdminDTO dto) {
		log.info("AdminServiceImpl Delete method start");
		dao.delete(dto);
		log.info("AdminServiceImpl Delete method end");

	}

	@Override
	@Transactional
	public AdminDTO findBypk(long pk) {
		log.info("AdminServiceImpl findBypk method start");
		AdminDTO dto = dao.findBypk(pk);
		log.info("AdminServiceImpl findBypk method end");
		return dto;
	}

	@Override
	@Transactional
	public AdminDTO findByLogin(String login) {
		log.info("AdminServiceImpl findByAdminName method start");
		AdminDTO dto = dao.findByEmail(login);
		log.info("AdminServiceImpl findByAdminName method end");
		return dto;
	}

	@Override
	@Transactional
	public void update(AdminDTO dto) throws DuplicateRecordException {
		log.info("AdminServiceImpl update method start");
		AdminDTO existDTO = dao.findByEmail(dto.getEmail());
		if (existDTO != null && dto.getId() != existDTO.getId())
			throw new DuplicateRecordException("Email Id Already Exist");
		dao.update(dto);
		log.info("AdminServiceImpl update method end");
	}

	@Override
	@Transactional
	public List<AdminDTO> list() {
		log.info("AdminServiceImpl list method start");
		List<AdminDTO> list = dao.list();
		log.info("AdminServiceImpl list method end");
		return list;
	}

	@Override
	@Transactional
	public List<AdminDTO> list(int pageNo, int pageSize) {
		log.info("AdminServiceImpl list method start");
		List<AdminDTO> list = dao.list(pageNo, pageSize);
		log.info("AdminServiceImpl list method end");
		return list;
	}

	@Override
	@Transactional
	public List<AdminDTO> search(AdminDTO dto) {
		log.info("AdminServiceImpl search method start");
		List<AdminDTO> list = dao.search(dto);
		log.info("AdminServiceImpl search method end");
		return list;
	}

	@Override
	@Transactional
	public List<AdminDTO> search(AdminDTO dto, int pageNo, int pageSize) {
		log.info("AdminServiceImpl search method start");
		List<AdminDTO> list = dao.search(dto, pageNo, pageSize);
		log.info("AdminServiceImpl search method end");
		return list;
	}

	@Override
	@Transactional
	public AdminDTO authentication(AdminDTO dto) {
		log.info("AdminServiceImpl authentication method start");
		dto = dao.authentication(dto);
		log.info("AdminServiceImpl authentication method end");
		return dto;
	}

	@Override
	@Transactional
	public boolean changePassword(Long id, String oldPassword, String newPassword) {
		log.info("AdminServiceImpl  changePassword method start");
		AdminDTO dtoExist = findBypk(id);
		if (dtoExist != null && dtoExist.getPassword().equals(oldPassword)) {
			dtoExist.setPassword(newPassword);
			dao.update(dtoExist);
			log.info("AdminServiceImpl  changePassword method end");
			return true;
		} else {
			return false;
		}
	}

	@Transactional(propagation = Propagation.REQUIRED, readOnly = false)
	public boolean forgetPassword(String email) {

		AdminDTO dtoExist = dao.findByEmail(email);

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
	public long register(AdminDTO dto) throws DuplicateRecordException {
		long pk = add(dto);
		return pk;
	}
}
