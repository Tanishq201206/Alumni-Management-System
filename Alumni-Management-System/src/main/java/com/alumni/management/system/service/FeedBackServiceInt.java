package com.alumni.management.system.service;

import java.util.List;

import com.alumni.management.system.dto.FeedBackDTO;
import com.alumni.management.system.exception.DuplicateRecordException;



public interface FeedBackServiceInt {

	public long add(FeedBackDTO dto) throws DuplicateRecordException;

	public void delete(FeedBackDTO dto);

	public FeedBackDTO findBypk(long pk);

	public FeedBackDTO findByTitle(String title);

	public void update(FeedBackDTO dto) throws DuplicateRecordException;

	public List<FeedBackDTO> list();

	public List<FeedBackDTO> list(int pageNo, int pageSize);

	public List<FeedBackDTO> search(FeedBackDTO dto);

	public List<FeedBackDTO> search(FeedBackDTO dto, int pageNo, int pageSize);


}
