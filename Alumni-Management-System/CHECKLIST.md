# Pre-Publish Checklist (Auto-generated on 2025-08-26)

**Project**: Alumni-Management-System

## Must-do before pushing
- [ ] Replace hard-coded DB creds in `src/main/resources/application.properties` with environment variables (see `.env.example`).
- [ ] Do **NOT** commit the `target/` directory (adjust `.gitignore`).
- [ ] Decide whether to include large images (3 files >1MB) as regular git files or via Git LFS.
- [ ] Add a `LICENSE` file (MIT recommended unless you prefer otherwise).
- [ ] Add a clear `README.md` with setup, database schema, and screenshots.
- [ ] Remove any test/throwaway data from the DB and seed scripts.
- [ ] Verify all login flows work; currently passwords are compared in plaintext in DAO classes (security risk).
- [ ] Ensure email credentials are not committed; use environment variables.

## Findings summary
- Spring Boot 2.5.4; Java 11.
- 13 controllers, 20 services, 20 DAOs, 11 DTOs, 23 form classes.
- 40 JSP files under `src/main/webapp/WEB-INF` (fragments based UI).
- No Spring Security dependency detected.
- Potential plaintext password comparison in `*DAOImpl.java` authentication methods.
- App context path: `/AMS` and port `8081`.

## Large assets (>1MB)
- src/main/webapp/resources/images/alumnidp.jpg (1.20 MB)
- src/main/webapp/resources/images/shutterstock_1150180799.jpg (3.04 MB)
- src/main/webapp/resources/images/staffdp.jpg (1.39 MB)
