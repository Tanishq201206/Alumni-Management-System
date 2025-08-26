package com.alumni.management.system.dao;

import java.util.List;
import java.util.logging.Logger;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.alumni.management.system.dto.EventDTO;




@Repository
public class EventDAOImpl implements EventDAOInt {

	private static Logger log = Logger.getLogger(EventDAOImpl.class.getName());

	@Autowired
	private EntityManager entityManager;

	@Override
	public long add(EventDTO dto) {
		log.info("EventDAOImpl Add method Start");
		Session session = entityManager.unwrap(Session.class);
		long pk = (long) session.save(dto);
		log.info("EventDAOImpl Add method End");
		return pk;
	}

	@Override
	public void delete(EventDTO dto) {
		log.info("EventDAOImpl Delete method Start");
		entityManager.remove(entityManager.contains(dto) ? dto : entityManager.merge(dto));
		log.info("EventDAOImpl Delete method End");

	}

	@Override
	public EventDTO findBypk(long pk) {
		log.info("EventDAOImpl FindByPk method Start");
		Session session = entityManager.unwrap(Session.class);
		EventDTO dto = (EventDTO) session.get(EventDTO.class, pk);
		log.info("EventDAOImpl FindByPk method End");
		return dto;
	}

	@Override
	public EventDTO findByTitle(String title) {
		log.info("EventDAOImpl FindByLogin method Start");
		Session session = entityManager.unwrap(Session.class);
		Criteria criteria = session.createCriteria(EventDTO.class);
		criteria.add(Restrictions.eq("title", title));
		EventDTO dto = (EventDTO) criteria.uniqueResult();
		log.info("EventDAOImpl FindByLogin method End");
		return dto;
	}

	@Override
	public void update(EventDTO dto) {
		log.info("EventDAOImpl Update method Start");
		Session session = entityManager.unwrap(Session.class);
		session.merge(dto);
		log.info("EventDAOImpl update method End");
	}

	@Override
	public List<EventDTO> list() {
		return list(0, 0);
	}

	@Override
	public List<EventDTO> list(int pageNo, int pageSize) {
		log.info("EventDAOImpl List method Start");
		Session session = entityManager.unwrap(Session.class);
		Query<EventDTO> query = session.createQuery("from EventDTO", EventDTO.class);
		List<EventDTO> list = query.getResultList();
		log.info("EventDAOImpl List method End");
		return list;
	}

	@Override
	public List<EventDTO> search(EventDTO dto) {
		return search(dto, 0, 0);
	}

	@Override
	public List<EventDTO> search(EventDTO dto, int pageNo, int pageSize) {
		log.info("EventDAOImpl Search method Start");
		Session session = entityManager.unwrap(Session.class);
		StringBuffer hql = new StringBuffer("from EventDTO as u where 1=1 ");
		if (dto != null) {
			if (dto.getId() > 0) {
				hql.append("and u.id = " + dto.getId());
			}
			
			if (dto.getTitle() != null && dto.getTitle().length() > 0) {
				hql.append("and u.title like '%" + dto.getTitle() + "%'");
			}
			
		}
		Query<EventDTO> query = session.createQuery(hql.toString(), EventDTO.class);
		if (pageNo > 0) {
			pageNo = (pageNo - 1) * pageSize;
			query.setFirstResult(pageNo);
			query.setMaxResults(pageSize);
		}
		List<EventDTO> list = query.getResultList();
		log.info("EventDAOImpl Search method End");
		return list;
	}

}
