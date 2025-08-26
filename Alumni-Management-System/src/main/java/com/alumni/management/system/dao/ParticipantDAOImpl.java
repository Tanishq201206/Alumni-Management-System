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

import com.alumni.management.system.dto.ParticipantDTO;




@Repository
public class ParticipantDAOImpl implements ParticipantDAOInt {

	private static Logger log = Logger.getLogger(ParticipantDAOImpl.class.getName());

	@Autowired
	private EntityManager entityManager;

	@Override
	public long add(ParticipantDTO dto) {
		log.info("ParticipantDAOImpl Add method Start");
		Session session = entityManager.unwrap(Session.class);
		long pk = (long) session.save(dto);
		log.info("ParticipantDAOImpl Add method End");
		return pk;
	}

	@Override
	public void delete(ParticipantDTO dto) {
		log.info("ParticipantDAOImpl Delete method Start");
		entityManager.remove(entityManager.contains(dto) ? dto : entityManager.merge(dto));
		log.info("ParticipantDAOImpl Delete method End");

	}

	@Override
	public ParticipantDTO findBypk(long pk) {
		log.info("ParticipantDAOImpl FindByPk method Start");
		Session session = entityManager.unwrap(Session.class);
		ParticipantDTO dto = (ParticipantDTO) session.get(ParticipantDTO.class, pk);
		log.info("ParticipantDAOImpl FindByPk method End");
		return dto;
	}

	@Override
	public ParticipantDTO findByName(String name) {
		log.info("ParticipantDAOImpl FindByLogin method Start");
		Session session = entityManager.unwrap(Session.class);
		Criteria criteria = session.createCriteria(ParticipantDTO.class);
		criteria.add(Restrictions.eq("name", name));
		ParticipantDTO dto = (ParticipantDTO) criteria.uniqueResult();
		log.info("ParticipantDAOImpl FindByLogin method End");
		return dto;
	}

	@Override
	public void update(ParticipantDTO dto) {
		log.info("ParticipantDAOImpl Update method Start");
		Session session = entityManager.unwrap(Session.class);
		session.merge(dto);
		log.info("ParticipantDAOImpl update method End");
	}

	@Override
	public List<ParticipantDTO> list() {
		return list(0, 0);
	}

	@Override
	public List<ParticipantDTO> list(int pageNo, int pageSize) {
		log.info("ParticipantDAOImpl List method Start");
		Session session = entityManager.unwrap(Session.class);
		Query<ParticipantDTO> query = session.createQuery("from ParticipantDTO", ParticipantDTO.class);
		List<ParticipantDTO> list = query.getResultList();
		log.info("ParticipantDAOImpl List method End");
		return list;
	}

	@Override
	public List<ParticipantDTO> search(ParticipantDTO dto) {
		return search(dto, 0, 0);
	}

	@Override
	public List<ParticipantDTO> search(ParticipantDTO dto, int pageNo, int pageSize) {
		log.info("ParticipantDAOImpl Search method Start");
		Session session = entityManager.unwrap(Session.class);
		StringBuffer hql = new StringBuffer("from ParticipantDTO as u where 1=1 ");
		if (dto != null) {
			if (dto.getId() > 0) {
				hql.append("and u.id = " + dto.getId());
			}
			
			if (dto.getName() != null && dto.getName().length() > 0) {
				hql.append("and u.name like '%" + dto.getName() + "%'");
			}
			
			if (dto.getEventName() != null && dto.getEventName().length() > 0) {
				hql.append("and u.eventName like '%" + dto.getEventName() + "%'");
			}
			
		}
		Query<ParticipantDTO> query = session.createQuery(hql.toString(), ParticipantDTO.class);
		if (pageNo > 0) {
			pageNo = (pageNo - 1) * pageSize;
			query.setFirstResult(pageNo);
			query.setMaxResults(pageSize);
		}
		List<ParticipantDTO> list = query.getResultList();
		log.info("ParticipantDAOImpl Search method End");
		return list;
	}
	
	@Override
	public void deleteByEventId(long eventId) {
	    Session session = entityManager.unwrap(Session.class);
	    session.createQuery("delete from ParticipantDTO p where p.event.id = :eid")
	           .setParameter("eid", eventId)
	           .executeUpdate();
	}

	
	@Override
	public boolean existsByEventIdAndUserId(long eventId, long userId) {
	    Session session = entityManager.unwrap(Session.class);
	    Long cnt = (Long) session.createQuery(
	        "select count(p.id) from ParticipantDTO p where p.eventId = :eid and p.userId = :uid"
	    ).setParameter("eid", eventId)
	     .setParameter("uid", userId)
	     .uniqueResult();
	    return cnt != null && cnt > 0;
	}

	@Override
	public ParticipantDTO findByEventIdAndUserId(long eventId, long userId) {
	    try {
	        Session session = entityManager.unwrap(Session.class);
	        return session.createQuery(
	            "from ParticipantDTO p where p.eventId = :eid and p.userId = :uid", ParticipantDTO.class
	        ).setParameter("eid", eventId)
	         .setParameter("uid", userId)
	         .getSingleResult();
	    } catch (javax.persistence.NoResultException e) {
	        return null;
	    }
	}


}
