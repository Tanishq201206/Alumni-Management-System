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

import com.alumni.management.system.dto.ApplyJobDTO;
import com.alumni.management.system.dto.GallaryDTO;




@Repository
public class ApplyJobDAOImpl implements ApplyJobDAOInt {

	private static Logger log = Logger.getLogger(ApplyJobDAOImpl.class.getName());

	@Autowired
	private EntityManager entityManager;

	@Override
	public long add(ApplyJobDTO dto) {
		log.info("ApplyJobDAOImpl Add method Start");
		Session session = entityManager.unwrap(Session.class);
		long pk = (long) session.save(dto);
		log.info("ApplyJobDAOImpl Add method End");
		return pk;
	}

	@Override
	public void delete(ApplyJobDTO dto) {
		log.info("ApplyJobDAOImpl Delete method Start");
		entityManager.remove(entityManager.contains(dto) ? dto : entityManager.merge(dto));
		log.info("ApplyJobDAOImpl Delete method End");

	}

	@Override
	public ApplyJobDTO findBypk(long pk) {
		log.info("ApplyJobDAOImpl FindByPk method Start");
		Session session = entityManager.unwrap(Session.class);
		ApplyJobDTO dto = (ApplyJobDTO) session.get(ApplyJobDTO.class, pk);
		log.info("ApplyJobDAOImpl FindByPk method End");
		return dto;
	}

	@Override
	public ApplyJobDTO findByName(String name) {
		log.info("ApplyJobDAOImpl FindByLogin method Start");
		Session session = entityManager.unwrap(Session.class);
		Criteria criteria = session.createCriteria(ApplyJobDTO.class);
		criteria.add(Restrictions.eq("name", name));
		ApplyJobDTO dto = (ApplyJobDTO) criteria.uniqueResult();
		log.info("ApplyJobDAOImpl FindByLogin method End");
		return dto;
	}

	@Override
	public void update(ApplyJobDTO dto) {
		log.info("ApplyJobDAOImpl Update method Start");
		Session session = entityManager.unwrap(Session.class);
		session.merge(dto);
		log.info("ApplyJobDAOImpl update method End");
	}

	@Override
	public List<ApplyJobDTO> list() {
		return list(0, 0);
	}

	@Override
	public List<ApplyJobDTO> list(int pageNo, int pageSize) {
		log.info("ApplyJobDAOImpl List method Start");
		Session session = entityManager.unwrap(Session.class);
		Query<ApplyJobDTO> query = session.createQuery("from ApplyJobDTO", ApplyJobDTO.class);
		List<ApplyJobDTO> list = query.getResultList();
		log.info("ApplyJobDAOImpl List method End");
		return list;
	}

	@Override
	public List<ApplyJobDTO> search(ApplyJobDTO dto) {
		return search(dto, 0, 0);
	}

	@Override
	public List<ApplyJobDTO> search(ApplyJobDTO dto, int pageNo, int pageSize) {
		log.info("ApplyJobDAOImpl Search method Start");
		Session session = entityManager.unwrap(Session.class);
		StringBuffer hql = new StringBuffer("from ApplyJobDTO as u where 1=1 ");
		if (dto != null) {
			if (dto.getId() > 0) {
				hql.append("and u.id = " + dto.getId());
			}
			
			if (dto.getName() != null && dto.getName().length() > 0) {
				hql.append("and u.name like '%" + dto.getName() + "%'");
			}
			
		}
		Query<ApplyJobDTO> query = session.createQuery(hql.toString(), ApplyJobDTO.class);
		if (pageNo > 0) {
			pageNo = (pageNo - 1) * pageSize;
			query.setFirstResult(pageNo);
			query.setMaxResults(pageSize);
		}
		List<ApplyJobDTO> list = query.getResultList();
		log.info("ApplyJobDAOImpl Search method End");
		return list;
	}
	
	@Override
	public Blob getFileById(long id) throws SerialException, SQLException {
		Session session = entityManager.unwrap(Session.class);
		ApplyJobDTO person = (ApplyJobDTO) session.get(ApplyJobDTO.class, id);
		byte[] blob = person.getFile();
		Blob bBlob = new SerialBlob(blob);
		return bBlob;
	}
	@Override
	public long countByJobAndEmail(long jobId, String email) {
	    Session session = entityManager.unwrap(Session.class);
	    String hql = "select count(a.id) " +
	                 "from com.alumni.management.system.dto.ApplyJobDTO a " +
	                 "where a.job.id = :jid and lower(a.email) = :eml";
	    Query<Long> q = session.createQuery(hql, Long.class);
	    q.setParameter("jid", jobId);
	    q.setParameter("eml", (email == null ? "" : email.toLowerCase()));
	    Long cnt = q.uniqueResult();
	    return (cnt == null) ? 0L : cnt;
	}

}
