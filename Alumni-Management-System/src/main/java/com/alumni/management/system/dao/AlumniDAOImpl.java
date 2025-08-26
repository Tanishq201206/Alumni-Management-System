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

import com.alumni.management.system.dto.AlumniDTO;




@Repository
public class AlumniDAOImpl implements AlumniDAOInt {

	private static Logger log = Logger.getLogger(AlumniDAOImpl.class.getName());

	@Autowired
	private EntityManager entityManager;

	@Override
	public long add(AlumniDTO dto) {
		log.info("AlumniDAOImpl Add method Start");
		Session session = entityManager.unwrap(Session.class);
		long pk = (long) session.save(dto);
		log.info("AlumniDAOImpl Add method End");
		return pk;
	}

	@Override
	public void delete(AlumniDTO dto) {
		log.info("AlumniDAOImpl Delete method Start");
		entityManager.remove(entityManager.contains(dto) ? dto : entityManager.merge(dto));
		log.info("AlumniDAOImpl Delete method End");

	}

	@Override
	public AlumniDTO findBypk(long pk) {
		log.info("AlumniDAOImpl FindByPk method Start");
		Session session = entityManager.unwrap(Session.class);
		AlumniDTO dto = (AlumniDTO) session.get(AlumniDTO.class, pk);
		log.info("AlumniDAOImpl FindByPk method End");
		return dto;
	}

	@Override
	public AlumniDTO findByEmail(String email) {
		log.info("AlumniDAOImpl FindByLogin method Start");
		Session session = entityManager.unwrap(Session.class);
		Criteria criteria = session.createCriteria(AlumniDTO.class);
		criteria.add(Restrictions.eq("email", email));
		AlumniDTO dto = (AlumniDTO) criteria.uniqueResult();
		log.info("AlumniDAOImpl FindByLogin method End");
		return dto;
	}

	@Override
	public void update(AlumniDTO dto) {
		log.info("AlumniDAOImpl Update method Start");
		Session session = entityManager.unwrap(Session.class);
		session.merge(dto);
		log.info("AlumniDAOImpl update method End");
	}

	@Override
	public List<AlumniDTO> list() {
		return list(0, 0);
	}

	@Override
	public List<AlumniDTO> list(int pageNo, int pageSize) {
		log.info("AlumniDAOImpl List method Start");
		Session session = entityManager.unwrap(Session.class);
		Query<AlumniDTO> query = session.createQuery("from AlumniDTO", AlumniDTO.class);
		List<AlumniDTO> list = query.getResultList();
		log.info("AlumniDAOImpl List method End");
		return list;
	}

	@Override
	public List<AlumniDTO> search(AlumniDTO dto) {
		return search(dto, 0, 0);
	}

	@Override
	public List<AlumniDTO> search(AlumniDTO dto, int pageNo, int pageSize) {
		log.info("AlumniDAOImpl Search method Start");
		Session session = entityManager.unwrap(Session.class);
		StringBuffer hql = new StringBuffer("from AlumniDTO as u where 1=1 ");
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
		Query<AlumniDTO> query = session.createQuery(hql.toString(), AlumniDTO.class);
		if (pageNo > 0) {
			pageNo = (pageNo - 1) * pageSize;
			query.setFirstResult(pageNo);
			query.setMaxResults(pageSize);
		}
		List<AlumniDTO> list = query.getResultList();
		log.info("AlumniDAOImpl Search method End");
		return list;
	}

	@Override
	public AlumniDTO authentication(AlumniDTO dto) {
		log.info("AlumniDAOImpl Authentication method Start");
		Session session = entityManager.unwrap(Session.class);
		Query<AlumniDTO> query = session.createQuery("from AlumniDTO where email=:login and password=:password",
				AlumniDTO.class);
		query.setParameter("login", dto.getEmail());
		query.setParameter("password", dto.getPassword());
		dto = null;
		try {
			dto = query.getSingleResult();
		} catch (NoResultException nre) {
		}
		log.info("AlumniDAOImpl Authentication method End");
		return dto;
	}
}
