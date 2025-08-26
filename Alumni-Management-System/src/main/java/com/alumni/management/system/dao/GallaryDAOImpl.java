package com.alumni.management.system.dao;

import java.sql.Blob;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Logger;

import javax.persistence.EntityManager;
import javax.sql.rowset.serial.SerialBlob;
import javax.sql.rowset.serial.SerialException;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.alumni.management.system.dto.GallaryDTO;




@Repository
public class GallaryDAOImpl implements GallaryDAOInt {

	private static Logger log = Logger.getLogger(GallaryDAOImpl.class.getName());

	@Autowired
	private EntityManager entityManager;

	@Override
	public long add(GallaryDTO dto) {
		log.info("GallaryDAOImpl Add method Start");
		Session session = entityManager.unwrap(Session.class);
		long pk = (long) session.save(dto);
		log.info("GallaryDAOImpl Add method End");
		return pk;
	}

	@Override
	public void delete(GallaryDTO dto) {
		log.info("GallaryDAOImpl Delete method Start");
		entityManager.remove(entityManager.contains(dto) ? dto : entityManager.merge(dto));
		log.info("GallaryDAOImpl Delete method End");

	}

	@Override
	public GallaryDTO findBypk(long pk) {
		log.info("GallaryDAOImpl FindByPk method Start");
		Session session = entityManager.unwrap(Session.class);
		GallaryDTO dto = (GallaryDTO) session.get(GallaryDTO.class, pk);
		log.info("GallaryDAOImpl FindByPk method End");
		return dto;
	}

	@Override
	public GallaryDTO findByTitle(String title) {
		log.info("GallaryDAOImpl FindByLogin method Start");
		Session session = entityManager.unwrap(Session.class);
		Criteria criteria = session.createCriteria(GallaryDTO.class);
		criteria.add(Restrictions.eq("title", title));
		GallaryDTO dto = (GallaryDTO) criteria.uniqueResult();
		log.info("GallaryDAOImpl FindByLogin method End");
		return dto;
	}

	@Override
	public void update(GallaryDTO dto) {
		log.info("GallaryDAOImpl Update method Start");
		Session session = entityManager.unwrap(Session.class);
		session.merge(dto);
		log.info("GallaryDAOImpl update method End");
	}

	@Override
	public List<GallaryDTO> list() {
		return list(0, 0);
	}

	@Override
	public List<GallaryDTO> list(int pageNo, int pageSize) {
		log.info("GallaryDAOImpl List method Start");
		Session session = entityManager.unwrap(Session.class);
		Query<GallaryDTO> query = session.createQuery("from GallaryDTO", GallaryDTO.class);
		List<GallaryDTO> list = query.getResultList();
		log.info("GallaryDAOImpl List method End");
		return list;
	}

	@Override
	public List<GallaryDTO> search(GallaryDTO dto) {
		return search(dto, 0, 0);
	}

	@Override
	public List<GallaryDTO> search(GallaryDTO dto, int pageNo, int pageSize) {
		log.info("GallaryDAOImpl Search method Start");
		Session session = entityManager.unwrap(Session.class);
		StringBuffer hql = new StringBuffer("from GallaryDTO as u where 1=1 ");
		if (dto != null) {
			if (dto.getId() > 0) {
				hql.append("and u.id = " + dto.getId());
			}
			
			
			
		}
		Query<GallaryDTO> query = session.createQuery(hql.toString(), GallaryDTO.class);
		if (pageNo > 0) {
			pageNo = (pageNo - 1) * pageSize;
			query.setFirstResult(pageNo);
			query.setMaxResults(pageSize);
		}
		List<GallaryDTO> list = query.getResultList();
		log.info("GallaryDAOImpl Search method End");
		return list;
	}
	
	@Override
	public Blob getImageById(long id) throws SerialException, SQLException {

		Session session = entityManager.unwrap(Session.class);
		GallaryDTO person = (GallaryDTO) session.get(GallaryDTO.class, id);
		byte[] blob = person.getImage();
		Blob bBlob = new SerialBlob(blob);
		return bBlob;
	}
	
	@Override
	public void deleteByEventId(long eventId) {
	    Session session = entityManager.unwrap(Session.class);
	    session.createQuery("delete from GallaryDTO g where g.event.id = :eid")
	           .setParameter("eid", eventId)
	           .executeUpdate();
	}


}
