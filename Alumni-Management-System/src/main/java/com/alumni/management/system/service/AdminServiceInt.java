package com.alumni.management.system.service;

import java.util.List;

import com.alumni.management.system.dto.AdminDTO;
import com.alumni.management.system.exception.DuplicateRecordException;



public interface AdminServiceInt {

	public long add(AdminDTO dto) throws DuplicateRecordException;

	public void delete(AdminDTO dto);

	public AdminDTO findBypk(long pk);

	public AdminDTO findByLogin(String login);

	public void update(AdminDTO dto) throws DuplicateRecordException;

	public List<AdminDTO> list();

	public List<AdminDTO> list(int pageNo, int pageSize);

	public List<AdminDTO> search(AdminDTO dto);

	public List<AdminDTO> search(AdminDTO dto, int pageNo, int pageSize);

	public AdminDTO authentication(AdminDTO dto);

	public boolean changePassword(Long id, String oldPassword, String newPassword);

	public boolean forgetPassword(String login);

	public long register(AdminDTO dto) throws DuplicateRecordException;

}
