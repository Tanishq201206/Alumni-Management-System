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

import com.alumni.management.system.dto.AdminDTO;




@Repository
public class AdminDAOImpl implements AdminDAOInt {

	private static Logger log = Logger.getLogger(AdminDAOImpl.class.getName());

	@Autowired
	private EntityManager entityManager;

	@Override
	public long add(AdminDTO dto) {
		log.info("AdminDAOImpl Add method Start");
		Session session = entityManager.unwrap(Session.class);
		long pk = (long) session.save(dto);
		log.info("AdminDAOImpl Add method End");
		return pk;
	}

	@Override
	public void delete(AdminDTO dto) {
		log.info("AdminDAOImpl Delete method Start");
		entityManager.remove(entityManager.contains(dto) ? dto : entityManager.merge(dto));
		log.info("AdminDAOImpl Delete method End");

	}

	@Override
	public AdminDTO findBypk(long pk) {
		log.info("AdminDAOImpl FindByPk method Start");
		Session session = entityManager.unwrap(Session.class);
		AdminDTO dto = (AdminDTO) session.get(AdminDTO.class, pk);
		log.info("AdminDAOImpl FindByPk method End");
		return dto;
	}

	@Override
	public AdminDTO findByEmail(String email) {
		log.info("AdminDAOImpl FindByLogin method Start");
		Session session = entityManager.unwrap(Session.class);
		Criteria criteria = session.createCriteria(AdminDTO.class);
		criteria.add(Restrictions.eq("email", email));
		AdminDTO dto = (AdminDTO) criteria.uniqueResult();
		log.info("AdminDAOImpl FindByLogin method End");
		return dto;
	}

	@Override
	public void update(AdminDTO dto) {
		log.info("AdminDAOImpl Update method Start");
		Session session = entityManager.unwrap(Session.class);
		session.merge(dto);
		log.info("AdminDAOImpl update method End");
	}

	@Override
	public List<AdminDTO> list() {
		return list(0, 0);
	}

	@Override
	public List<AdminDTO> list(int pageNo, int pageSize) {
		log.info("AdminDAOImpl List method Start");
		Session session = entityManager.unwrap(Session.class);
		Query<AdminDTO> query = session.createQuery("from AdminDTO", AdminDTO.class);
		List<AdminDTO> list = query.getResultList();
		log.info("AdminDAOImpl List method End");
		return list;
	}

	@Override
	public List<AdminDTO> search(AdminDTO dto) {
		return search(dto, 0, 0);
	}

	@Override
	public List<AdminDTO> search(AdminDTO dto, int pageNo, int pageSize) {
		log.info("AdminDAOImpl Search method Start");
		Session session = entityManager.unwrap(Session.class);
		StringBuffer hql = new StringBuffer("from AdminDTO as u where 1=1 ");
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
		Query<AdminDTO> query = session.createQuery(hql.toString(), AdminDTO.class);
		if (pageNo > 0) {
			pageNo = (pageNo - 1) * pageSize;
			query.setFirstResult(pageNo);
			query.setMaxResults(pageSize);
		}
		List<AdminDTO> list = query.getResultList();
		log.info("AdminDAOImpl Search method End");
		return list;
	}

	@Override
	public AdminDTO authentication(AdminDTO dto) {
		log.info("AdminDAOImpl Authentication method Start");
		Session session = entityManager.unwrap(Session.class);
		Query<AdminDTO> query = session.createQuery("from AdminDTO where email=:login and password=:password",
				AdminDTO.class);
		query.setParameter("login", dto.getEmail());
		query.setParameter("password", dto.getPassword());
		dto = null;
		try {
			dto = query.getSingleResult();
		} catch (NoResultException nre) {
		}
		log.info("AdminDAOImpl Authentication method End");
		return dto;
	}
}
