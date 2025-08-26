package com.alumni.management.system.service;

import java.util.List;
import java.util.logging.Logger;

import javax.transaction.Transactional;

import org.hibernate.exception.ConstraintViolationException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Service;

import com.alumni.management.system.dao.ParticipantDAOInt;
import com.alumni.management.system.dto.ParticipantDTO;
import com.alumni.management.system.exception.DuplicateRecordException;

@Service
public class ParticipantServiceImpl implements ParticipantServiceInt {

    private static final Logger log = Logger.getLogger(ParticipantServiceImpl.class.getName());

    @Autowired
    private ParticipantDAOInt dao;

    @Override
    @Transactional
    public long add(ParticipantDTO dto) throws DuplicateRecordException {
        log.info("ParticipantServiceImpl Add method start");

        // Guard: one alumni per event
        if (dto.getEventId() <= 0 || dto.getUserId() <= 0) {
            throw new IllegalArgumentException("eventId and userId must be provided");
        }

        if (dao.existsByEventIdAndUserId(dto.getEventId(), dto.getUserId())) {
            throw new DuplicateRecordException("You are already participating in this event.");
        }

        try {
            long pk = dao.add(dto);
            log.info("ParticipantServiceImpl Add method end");
            return pk;
        } catch (DataIntegrityViolationException | ConstraintViolationException ex) {
            // In case of a race, DB unique constraint wins → treat as duplicate
            throw new DuplicateRecordException("You are already participating in this event.");
        } catch (RuntimeException ex) {
            // Walk the cause chain to detect unique violations from different providers
            if (causedByUniqueViolation(ex)) {
                throw new DuplicateRecordException("You are already participating in this event.");
            }
            throw ex;
        }
    }

    private boolean causedByUniqueViolation(Throwable t) {
        while (t != null) {
            String n = t.getClass().getName();
            if (n.contains("ConstraintViolationException") || n.contains("DataIntegrityViolation")) {
                return true;
            }
            t = t.getCause();
        }
        return false;
    }

    @Override
    @Transactional
    public void delete(ParticipantDTO dto) {
        log.info("ParticipantServiceImpl Delete method start");
        dao.delete(dto);
        log.info("ParticipantServiceImpl Delete method end");
    }

    @Override
    @Transactional
    public ParticipantDTO findBypk(long pk) {
        log.info("ParticipantServiceImpl findBypk method start");
        ParticipantDTO dto = dao.findBypk(pk);
        log.info("ParticipantServiceImpl findBypk method end");
        return dto;
    }

    @Override
    @Transactional
    public ParticipantDTO findByName(String name) {
        log.info("ParticipantServiceImpl findByParticipantName method start");
        ParticipantDTO dto = dao.findByName(name);
        log.info("ParticipantServiceImpl findByParticipantName method end");
        return dto;
    }

    @Override
    @Transactional
    public void update(ParticipantDTO dto) throws DuplicateRecordException {
        log.info("ParticipantServiceImpl update method start");

        // Optional: if eventId/userId are being changed, prevent creating a duplicate
        if (dto.getEventId() > 0 && dto.getUserId() > 0) {
            ParticipantDTO existing = dao.findByEventIdAndUserId(dto.getEventId(), dto.getUserId());
            if (existing != null && existing.getId() != dto.getId()) {
                throw new DuplicateRecordException("You are already participating in this event.");
            }
        }

        try {
            dao.update(dto);
            log.info("ParticipantServiceImpl update method end");
        } catch (DataIntegrityViolationException | ConstraintViolationException ex) {
            throw new DuplicateRecordException("You are already participating in this event.");
        }
    }

    @Override
    @Transactional
    public List<ParticipantDTO> list() {
        log.info("ParticipantServiceImpl list method start");
        List<ParticipantDTO> list = dao.list();
        log.info("ParticipantServiceImpl list method end");
        return list;
    }

    @Override
    @Transactional
    public List<ParticipantDTO> list(int pageNo, int pageSize) {
        log.info("ParticipantServiceImpl list method start");
        List<ParticipantDTO> list = dao.list(pageNo, pageSize);
        log.info("ParticipantServiceImpl list method end");
        return list;
    }

    @Override
    @Transactional
    public List<ParticipantDTO> search(ParticipantDTO dto) {
        log.info("ParticipantServiceImpl search method start");
        List<ParticipantDTO> list = dao.search(dto);
        log.info("ParticipantServiceImpl search method end");
        return list;
    }

    @Override
    @Transactional
    public List<ParticipantDTO> search(ParticipantDTO dto, int pageNo, int pageSize) {
        log.info("ParticipantServiceImpl search method start");
        List<ParticipantDTO> list = dao.search(dto, pageNo, pageSize);
        log.info("ParticipantServiceImpl search method end");
        return list;
    }

    @Override
    @Transactional
    public void deleteByEventId(long eventId) {
        dao.deleteByEventId(eventId);
    }

    // === NEW: idempotency helpers ===
    @Override
    @Transactional
    public boolean existsByEventIdAndUserId(long eventId, long userId) {
        return dao.existsByEventIdAndUserId(eventId, userId);
    }

    @Override
    @Transactional
    public ParticipantDTO findByEventIdAndUserId(long eventId, long userId) {
        return dao.findByEventIdAndUserId(eventId, userId);
    }
}
