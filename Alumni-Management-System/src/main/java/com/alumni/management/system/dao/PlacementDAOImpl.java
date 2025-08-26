package com.alumni.management.system.dao;

import java.sql.Blob;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Logger;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.sql.rowset.serial.SerialBlob;
import javax.sql.rowset.serial.SerialException;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.alumni.management.system.dto.GallaryDTO;
import com.alumni.management.system.dto.PlacementDTO;




@Repository
public class PlacementDAOImpl implements PlacementDAOInt {

	private static Logger log = Logger.getLogger(PlacementDAOImpl.class.getName());

	@Autowired
	private EntityManager entityManager;

	@Override
	public long add(PlacementDTO dto) {
		log.info("PlacementDAOImpl Add method Start");
		Session session = entityManager.unwrap(Session.class);
		long pk = (long) session.save(dto);
		log.info("PlacementDAOImpl Add method End");
		return pk;
	}

	@Override
	public void delete(PlacementDTO dto) {
		log.info("PlacementDAOImpl Delete method Start");
		entityManager.remove(entityManager.contains(dto) ? dto : entityManager.merge(dto));
		log.info("PlacementDAOImpl Delete method End");

	}

	@Override
	public PlacementDTO findBypk(long pk) {
		log.info("PlacementDAOImpl FindByPk method Start");
		Session session = entityManager.unwrap(Session.class);
		PlacementDTO dto = (PlacementDTO) session.get(PlacementDTO.class, pk);
		log.info("PlacementDAOImpl FindByPk method End");
		return dto;
	}

	@Override
	public PlacementDTO findByName(String name) {
		log.info("PlacementDAOImpl FindByLogin method Start");
		Session session = entityManager.unwrap(Session.class);
		Criteria criteria = session.createCriteria(PlacementDTO.class);
		criteria.add(Restrictions.eq("name", name));
		PlacementDTO dto = (PlacementDTO) criteria.uniqueResult();
		log.info("PlacementDAOImpl FindByLogin method End");
		return dto;
	}

	@Override
	public void update(PlacementDTO dto) {
		log.info("PlacementDAOImpl Update method Start");
		Session session = entityManager.unwrap(Session.class);
		session.merge(dto);
		log.info("PlacementDAOImpl update method End");
	}

	@Override
	public List<PlacementDTO> list() {
		return list(0, 0);
	}

	@Override
	public List<PlacementDTO> list(int pageNo, int pageSize) {
		log.info("PlacementDAOImpl List method Start");
		Session session = entityManager.unwrap(Session.class);
		Query<PlacementDTO> query = session.createQuery("from PlacementDTO", PlacementDTO.class);
		List<PlacementDTO> list = query.getResultList();
		log.info("PlacementDAOImpl List method End");
		return list;
	}

	@Override
	public List<PlacementDTO> search(PlacementDTO dto) {
		return search(dto, 0, 0);
	}

	@Override
	public List<PlacementDTO> search(PlacementDTO dto, int pageNo, int pageSize) {
		log.info("PlacementDAOImpl Search method Start");
		Session session = entityManager.unwrap(Session.class);
		StringBuffer hql = new StringBuffer("from PlacementDTO as u where 1=1 ");
		if (dto != null) {
			if (dto.getId() > 0) {
				hql.append("and u.id = " + dto.getId());
			}
			
			if (dto.getName() != null && dto.getName().length() > 0) {
				hql.append("and u.name like '%" + dto.getName() + "%'");
			}
			
		}
		Query<PlacementDTO> query = session.createQuery(hql.toString(), PlacementDTO.class);
		if (pageNo > 0) {
			pageNo = (pageNo - 1) * pageSize;
			query.setFirstResult(pageNo);
			query.setMaxResults(pageSize);
		}
		List<PlacementDTO> list = query.getResultList();
		log.info("PlacementDAOImpl Search method End");
		return list;
	}
	
	@Override
	public Blob getImageById(long id) throws SerialException, SQLException {

		Session session = entityManager.unwrap(Session.class);
		PlacementDTO person = (PlacementDTO) session.get(PlacementDTO.class, id);
		byte[] blob = person.getImage();
		Blob bBlob = new SerialBlob(blob);
		return bBlob;
	}

}
