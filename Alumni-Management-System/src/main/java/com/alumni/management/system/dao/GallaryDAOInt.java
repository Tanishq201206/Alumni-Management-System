package com.alumni.management.system.dao;

import java.sql.Blob;
import java.sql.SQLException;
import java.util.List;

import javax.sql.rowset.serial.SerialException;

import com.alumni.management.system.dto.GallaryDTO;



public interface GallaryDAOInt {

	public long add(GallaryDTO dto);
	
	public void delete(GallaryDTO dto);
	
	public GallaryDTO findBypk(long pk);
	
	public GallaryDTO findByTitle(String title);
	
	public void update(GallaryDTO dto);
	
	public List<GallaryDTO> list();
	
	public List<GallaryDTO>list(int pageNo,int pageSize);
	
	public List<GallaryDTO> search(GallaryDTO dto);
	
	public List<GallaryDTO> search(GallaryDTO dto,int pageNo,int pageSize);
	
	public Blob getImageById(long id) throws SerialException, SQLException;
	
	void deleteByEventId(long eventId);
	
	
}
