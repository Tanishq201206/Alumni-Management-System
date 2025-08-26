package com.alumni.management.system.service;

import java.sql.Blob;
import java.sql.SQLException;
import java.util.List;

import javax.sql.rowset.serial.SerialException;

import com.alumni.management.system.dto.ApplyJobDTO;
import com.alumni.management.system.exception.DuplicateRecordException;



public interface ApplyJobServiceInt {

	public long add(ApplyJobDTO dto) throws DuplicateRecordException;

	public void delete(ApplyJobDTO dto);

	public ApplyJobDTO findBypk(long pk);

	public ApplyJobDTO findByName(String name);

	public void update(ApplyJobDTO dto) throws DuplicateRecordException;

	public List<ApplyJobDTO> list();

	public List<ApplyJobDTO> list(int pageNo, int pageSize);

	public List<ApplyJobDTO> search(ApplyJobDTO dto);

	public List<ApplyJobDTO> search(ApplyJobDTO dto, int pageNo, int pageSize);

	public Blob getFileById(long id) throws SerialException, SQLException;
	
	boolean existsByJobAndEmail(long jobId, String email);

}
