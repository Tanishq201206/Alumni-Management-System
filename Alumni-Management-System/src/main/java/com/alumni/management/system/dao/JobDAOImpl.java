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

import com.alumni.management.system.dto.JobDTO;




@Repository
public class JobDAOImpl implements JobDAOInt {

	private static Logger log = Logger.getLogger(JobDAOImpl.class.getName());

	@Autowired
	private EntityManager entityManager;

	@Override
	public long add(JobDTO dto) {
		log.info("JobDAOImpl Add method Start");
		Session session = entityManager.unwrap(Session.class);
		long pk = (long) session.save(dto);
		log.info("JobDAOImpl Add method End");
		return pk;
	}

	@Override
	public void delete(JobDTO dto) {
	    log.info("JobDAOImpl Delete method Start");
	    Session session = entityManager.unwrap(Session.class);

	    long id = dto.getId();
	    if (id <= 0) {
	        log.warning("Delete called without id");
	        return;
	    }

	    // 1) Delete child applications linked to this job
	    //    Use the fully-qualified entity name to be safe.
	    Query<?> delApps = session.createQuery(
	        "delete from com.alumni.management.system.dto.ApplyJobDTO a where a.job.id = :jid"
	    );
	    delApps.setParameter("jid", id);
	    delApps.executeUpdate();

	    // 2) Now delete the job
	    JobDTO managed = entityManager.contains(dto) ? dto : entityManager.merge(dto);
	    entityManager.remove(managed);

	    log.info("JobDAOImpl Delete method End");
	}


	@Override
	public JobDTO findBypk(long pk) {
		log.info("JobDAOImpl FindByPk method Start");
		Session session = entityManager.unwrap(Session.class);
		JobDTO dto = (JobDTO) session.get(JobDTO.class, pk);
		log.info("JobDAOImpl FindByPk method End");
		return dto;
	}

	@Override
	public JobDTO findByTitle(String title) {
		log.info("JobDAOImpl FindByLogin method Start");
		Session session = entityManager.unwrap(Session.class);
		Criteria criteria = session.createCriteria(JobDTO.class);
		criteria.add(Restrictions.eq("title", title));
		JobDTO dto = (JobDTO) criteria.uniqueResult();
		log.info("JobDAOImpl FindByLogin method End");
		return dto;
	}

	@Override
	public void update(JobDTO dto) {
		log.info("JobDAOImpl Update method Start");
		Session session = entityManager.unwrap(Session.class);
		session.merge(dto);
		log.info("JobDAOImpl update method End");
	}

	@Override
	public List<JobDTO> list() {
		return list(0, 0);
	}

	@Override
	public List<JobDTO> list(int pageNo, int pageSize) {
		log.info("JobDAOImpl List method Start");
		Session session = entityManager.unwrap(Session.class);
		Query<JobDTO> query = session.createQuery("from JobDTO", JobDTO.class);
		List<JobDTO> list = query.getResultList();
		log.info("JobDAOImpl List method End");
		return list;
	}

	@Override
	public List<JobDTO> search(JobDTO dto) {
		return search(dto, 0, 0);
	}

	@Override
	public List<JobDTO> search(JobDTO dto, int pageNo, int pageSize) {
		log.info("JobDAOImpl Search method Start");
		Session session = entityManager.unwrap(Session.class);
		StringBuffer hql = new StringBuffer("from JobDTO as u where 1=1 ");
		if (dto != null) {
			if (dto.getId() > 0) {
				hql.append("and u.id = " + dto.getId());
			}
			
			if (dto.getTitle() != null && dto.getTitle().length() > 0) {
				hql.append("and u.title like '%" + dto.getTitle() + "%'");
			}
			
		}
		Query<JobDTO> query = session.createQuery(hql.toString(), JobDTO.class);
		if (pageNo > 0) {
			pageNo = (pageNo - 1) * pageSize;
			query.setFirstResult(pageNo);
			query.setMaxResults(pageSize);
		}
		List<JobDTO> list = query.getResultList();
		log.info("JobDAOImpl Search method End");
		return list;
	}

}
