package com.alumni.management.system.service;

import java.sql.Blob;
import java.sql.SQLException;
import java.util.List;

import javax.sql.rowset.serial.SerialException;

import com.alumni.management.system.dto.PlacementDTO;
import com.alumni.management.system.exception.DuplicateRecordException;



public interface PlacementServiceInt {

	public long add(PlacementDTO dto) throws DuplicateRecordException;

	public void delete(PlacementDTO dto);

	public PlacementDTO findBypk(long pk);

	public PlacementDTO findByName(String name);

	public void update(PlacementDTO dto) throws DuplicateRecordException;

	public List<PlacementDTO> list();

	public List<PlacementDTO> list(int pageNo, int pageSize);

	public List<PlacementDTO> search(PlacementDTO dto);

	public List<PlacementDTO> search(PlacementDTO dto, int pageNo, int pageSize);
	
	public Blob getImageById(long id) throws SerialException, SQLException;


}
