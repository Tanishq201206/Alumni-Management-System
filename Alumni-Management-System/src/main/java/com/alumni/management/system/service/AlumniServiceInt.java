package com.alumni.management.system.service;

import java.util.List;

import com.alumni.management.system.dto.AlumniDTO;
import com.alumni.management.system.exception.DuplicateRecordException;



public interface AlumniServiceInt {

	public long add(AlumniDTO dto) throws DuplicateRecordException;

	public void delete(AlumniDTO dto);

	public AlumniDTO findBypk(long pk);

	public AlumniDTO findByLogin(String login);

	public void update(AlumniDTO dto) throws DuplicateRecordException;

	public List<AlumniDTO> list();

	public List<AlumniDTO> list(int pageNo, int pageSize);

	public List<AlumniDTO> search(AlumniDTO dto);

	public List<AlumniDTO> search(AlumniDTO dto, int pageNo, int pageSize);

	public AlumniDTO authentication(AlumniDTO dto);

	public boolean changePassword(Long id, String oldPassword, String newPassword);

	public boolean forgetPassword(String login);

	public long register(AlumniDTO dto) throws DuplicateRecordException;

}
