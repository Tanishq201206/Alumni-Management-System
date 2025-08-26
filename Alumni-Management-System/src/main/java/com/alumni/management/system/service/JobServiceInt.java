package com.alumni.management.system.service;

import java.util.List;

import com.alumni.management.system.dto.JobDTO;
import com.alumni.management.system.exception.DuplicateRecordException;



public interface JobServiceInt {

	public long add(JobDTO dto) throws DuplicateRecordException;

	public void delete(JobDTO dto);

	public JobDTO findBypk(long pk);

	public JobDTO findByTitle(String title);

	public void update(JobDTO dto) throws DuplicateRecordException;

	public List<JobDTO> list();

	public List<JobDTO> list(int pageNo, int pageSize);

	public List<JobDTO> search(JobDTO dto);

	public List<JobDTO> search(JobDTO dto, int pageNo, int pageSize);


}
