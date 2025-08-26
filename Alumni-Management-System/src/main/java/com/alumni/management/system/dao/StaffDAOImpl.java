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

import com.alumni.management.system.dto.StaffDTO;




@Repository
public class StaffDAOImpl implements StaffDAOInt {

	private static Logger log = Logger.getLogger(StaffDAOImpl.class.getName());

	@Autowired
	private EntityManager entityManager;

	@Override
	public long add(StaffDTO dto) {
		log.info("StaffDAOImpl Add method Start");
		Session session = entityManager.unwrap(Session.class);
		long pk = (long) session.save(dto);
		log.info("StaffDAOImpl Add method End");
		return pk;
	}

	@Override
	public void delete(StaffDTO dto) {
		log.info("StaffDAOImpl Delete method Start");
		entityManager.remove(entityManager.contains(dto) ? dto : entityManager.merge(dto));
		log.info("StaffDAOImpl Delete method End");

	}

	@Override
	public StaffDTO findBypk(long pk) {
		log.info("StaffDAOImpl FindByPk method Start");
		Session session = entityManager.unwrap(Session.class);
		StaffDTO dto = (StaffDTO) session.get(StaffDTO.class, pk);
		log.info("StaffDAOImpl FindByPk method End");
		return dto;
	}

	@Override
	public StaffDTO findByEmail(String login) {
		log.info("StaffDAOImpl FindByLogin method Start");
		Session session = entityManager.unwrap(Session.class);
		Criteria criteria = session.createCriteria(StaffDTO.class);
		criteria.add(Restrictions.eq("email", login));
		StaffDTO dto = (StaffDTO) criteria.uniqueResult();
		log.info("StaffDAOImpl FindByLogin method End");
		return dto;
	}

	@Override
	public void update(StaffDTO dto) {
		log.info("StaffDAOImpl Update method Start");
		Session session = entityManager.unwrap(Session.class);
		session.merge(dto);
		log.info("StaffDAOImpl update method End");
	}

	@Override
	public List<StaffDTO> list() {
		return list(0, 0);
	}

	@Override
	public List<StaffDTO> list(int pageNo, int pageSize) {
		log.info("StaffDAOImpl List method Start");
		Session session = entityManager.unwrap(Session.class);
		Query<StaffDTO> query = session.createQuery("from StaffDTO", StaffDTO.class);
		List<StaffDTO> list = query.getResultList();
		log.info("StaffDAOImpl List method End");
		return list;
	}

	@Override
	public List<StaffDTO> search(StaffDTO dto) {
		return search(dto, 0, 0);
	}

	@Override
	public List<StaffDTO> search(StaffDTO dto, int pageNo, int pageSize) {
		log.info("StaffDAOImpl Search method Start");
		Session session = entityManager.unwrap(Session.class);
		StringBuffer hql = new StringBuffer("from StaffDTO as u where 1=1 ");
		if (dto != null) {
			if (dto.getId() > 0) {
				hql.append("and u.id = " + dto.getId());
			}
			
			if (dto.getName() != null && dto.getName().length() > 0) {
				hql.append("and u.name like '%" + dto.getName() + "%'");
			}
			
			if (dto.getEmail() != null && dto.getEmail().length() > 0) {
				hql.append("and u.email like '%" + dto.getEmail() + "%'");
			}
			
		
		}
		Query<StaffDTO> query = session.createQuery(hql.toString(), StaffDTO.class);
		if (pageNo > 0) {
			pageNo = (pageNo - 1) * pageSize;
			query.setFirstResult(pageNo);
			query.setMaxResults(pageSize);
		}
		List<StaffDTO> list = query.getResultList();
		log.info("StaffDAOImpl Search method End");
		return list;
	}

	@Override
	public StaffDTO authentication(StaffDTO dto) {
		log.info("StaffDAOImpl Authentication method Start");
		Session session = entityManager.unwrap(Session.class);
		Query<StaffDTO> query = session.createQuery("from StaffDTO where email=:login and password=:password",
				StaffDTO.class);
		query.setParameter("login", dto.getEmail());
		query.setParameter("password", dto.getPassword());
		dto = null;
		try {
			dto = query.getSingleResult();
		} catch (NoResultException nre) {
		}
		log.info("StaffDAOImpl Authentication method End");
		return dto;
	}
}
