package com.alumni.management.system.service;

import java.util.List;

import com.alumni.management.system.dto.StaffDTO;
import com.alumni.management.system.exception.DuplicateRecordException;



public interface StaffServiceInt {

	public long add(StaffDTO dto) throws DuplicateRecordException;

	public void delete(StaffDTO dto);

	public StaffDTO findBypk(long pk);

	public StaffDTO findByLogin(String login);

	public void update(StaffDTO dto) throws DuplicateRecordException;

	public List<StaffDTO> list();

	public List<StaffDTO> list(int pageNo, int pageSize);

	public List<StaffDTO> search(StaffDTO dto);

	public List<StaffDTO> search(StaffDTO dto, int pageNo, int pageSize);

	public StaffDTO authentication(StaffDTO dto);

	public boolean changePassword(Long id, String oldPassword, String newPassword);

	public boolean forgetPassword(String login);

	public long register(StaffDTO dto) throws DuplicateRecordException;

}
