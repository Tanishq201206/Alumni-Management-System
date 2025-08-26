<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="s"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="sf"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>   <!-- 👈 add this -->
<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@page isELIgnored="false"%>

<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet"/>

<style>
  /* ===== Your palette ===== */
  :root{
    --red:#E43636; --red-700:#c62f2f;
    --cream:#F6EFD2; --beige:#E2DDB4;
    --black:#000000;
  }

  .card { border: 1px solid #eee; border-radius: 12px; overflow: hidden; }
  .card-header{ background: var(--red)!important; color:#fff!important; font-weight:700; letter-spacing:.2px; }

  .btn-outline-primary{ border-color: var(--red); color: var(--red); }
  .btn-outline-primary:hover{ background: var(--red); color:#fff; border-color: var(--red); }

  .btn-outline-success{ color:#198754; border-color:#198754; }
  .btn-outline-success:hover{ color:#fff; background:#198754; border-color:#198754; }

  .pagination .page-link{ color: var(--red); }
  .pagination .page-item.active .page-link{ background: var(--red); border-color: var(--red); color:#fff; }

  /* ===== Accordion list ===== */
  .job-accordion{
    border:1px solid rgba(0,0,0,.06);
    border-radius:12px;
    background:#fff;
    box-shadow:0 10px 24px rgba(0,0,0,.08);
    padding:12px;
  }
  .job-accordion details{
    background:#fff;
    border-radius:12px;
    margin:10px 0;
    border:1px solid #f1e9cc;
    overflow: hidden;
  }
  .job-accordion summary{
    list-style:none;
    cursor:pointer;
    padding:16px;
    background:#fff;
    display:flex;
    align-items:center;
    gap:12px;
  }
  .job-accordion summary:hover{ background:#fff7f7; }

  .job-accordion summary::after{
    content:"\f107";
    font-family:"Font Awesome 6 Free";
    font-weight:900;
    margin-left:auto;
    color:#444;
    transition: transform .2s ease;
  }
  .job-accordion details[open] summary::after{ transform: rotate(180deg); }

  .job-summary-left{ display:flex; flex-direction:column; gap:4px; min-width:0; }
  .job-company{ font-weight:700; color:#2b2b2b; white-space:nowrap; overflow:hidden; text-overflow:ellipsis; }
  .job-title{ color:#555; white-space:nowrap; overflow:hidden; text-overflow:ellipsis; }

  .job-actions{ display:flex; gap:8px; align-items:center; margin-left:auto; }

  .job-details{
    background:#fff;
    border-top: 3px solid rgba(228,54,54,.25);
    padding:16px;
  }

  .kv{ display:grid; grid-template-columns: 160px 1fr; gap:8px 16px; }
  .kv dt{ color:#333; font-weight:600; }
  .kv dd{ margin:0; color:#333; }

  .form-control.form-control-sm{
    border:1px solid #d9d9d9; border-radius:8px;
    transition:border-color .15s ease, box-shadow .15s ease;
  }
  .form-control.form-control-sm:focus{
    border-color: var(--red); box-shadow: 0 0 0 .15rem rgba(228,54,54,.2);
  }
</style>

<c:url var="addUrl" value="/ctl/job" />
<c:url var="addSearch" value="/ctl/job/search" />
<c:url var="editUrl" value="/ctl/job?id=" />
<c:url var="applyUrl" value="/ctl/applyJob?jId=" />

<!-- Roles -->
<c:set var="isAdmin"  value="${not empty sessionScope.admin}" />
<c:set var="isAlumni" value="${not empty sessionScope.alumni}" />
<c:set var="isStaff"  value="${not empty sessionScope.staff}" />
<c:set var="currentAlumniId" value="${isAlumni ? sessionScope.alumni.id : null}" />

<br/>

<sf:form method="post" action="${pageContext.request.contextPath}/ctl/job/search" modelAttribute="form">
  <div class="card">
    <h5 class="card-header">Job List</h5>
    <div class="card-body">
      <!-- Search -->
      <div class="row g-3 mb-3">
        <s:bind path="title">
          <div class="col-md-4">
            <sf:input id="searchTitle" path="${status.expression}" class="form-control form-control-sm" placeholder="Search By Title"/>
          </div>
        </s:bind>
        <s:bind path="location">
          <div class="col-md-4">
            <sf:input id="searchLocation" path="${status.expression}" class="form-control form-control-sm" placeholder="Search By Location"/>
          </div>
        </s:bind>
        <div class="col-md-4">
          <input type="submit" class="btn btn-sm btn-outline-primary" name="operation" value="Search"/>
           or
          <input type="submit" class="btn btn-sm btn-outline-secondary" name="operation" value="Reset"/>
        </div>
      </div>

      <b><%@ include file="businessMessage.jsp" %></b>

      <!-- keep paging fields bound -->
      <sf:input type="hidden" path="pageNo"/>
      <sf:input type="hidden" path="pageSize"/>
      <sf:input type="hidden" path="listsize"/>
      <sf:input type="hidden" path="total"/>
      <sf:input type="hidden" path="pagenosize"/>

      <!-- ===== Accordion list ===== -->
      <div class="job-accordion" id="jobList">
        <c:if test="${empty list}">
          <div class="text-center p-3">No jobs found.</div>
        </c:if>

        <c:forEach items="${list}" var="jb" varStatus="st">
          <c:set var="isOwner" value="${isAlumni and jb.alumniId == currentAlumniId}" />
          <details class="job" data-title="${fn:escapeXml(jb.title)}" data-location="${fn:escapeXml(jb.location)}">
            <summary>
              <div class="job-summary-left">
                <div class="job-company" title="${jb.companyName}">${st.index + 1}. ${jb.companyName}</div>
                <div class="job-title" title="${jb.title}">${jb.title}</div>
              </div>

              <div class="job-actions">
                <!-- Apply: Staff OR Alumni not owner. Admin never -->
                <c:if test="${isStaff or (isAlumni and not isOwner)}">
                  <a href="${applyUrl}${jb.id}" class="btn btn-sm btn-outline-success">Apply</a>
                </c:if>

                <!-- Edit: only Alumni owner -->
                <c:if test="${isOwner}">
                  <a href="${editUrl}${jb.id}" class="btn btn-sm btn-outline-primary">Edit</a>
                </c:if>

                <!-- Delete: Admin (any) OR Alumni owner -->
                <c:if test="${isAdmin or isOwner}">
                  <form method="post" action="${addSearch}" style="display:inline;">
                    <input type="hidden" name="ids" value="${jb.id}"/>
                    <input type="hidden" name="operation" value="Delete"/>
                    <button type="submit" class="btn btn-sm btn-danger"
                            onclick="return confirm('Delete this job?');">Delete</button>
                  </form>
                </c:if>
              </div>
            </summary>

            <div class="job-details">
              <dl class="kv">
                <dt>Company</dt>       <dd>${jb.companyName}</dd>
                <dt>Title</dt>         <dd>${jb.title}</dd>
                <dt>Location</dt>      <dd>${jb.location}</dd>
                <dt>Qualification</dt> <dd>${jb.qualification}</dd>
                <dt>Skills</dt>        <dd>${jb.skills}</dd>
                <dt>Package</dt>       <dd>${jb.jobPackage}</dd>
                <dt>Experience</dt>    <dd>${jb.experienceRequired}</dd>
                <dt>Vacancies</dt>     <dd>${jb.noOfVaccancy}</dd>
                <dt>Reference Email</dt><dd>${jb.referenceEmail}</dd>
                <dt>Last Date</dt>     <dd><fmt:formatDate value="${jb.lastDate}" pattern="dd-MMM-yyyy"/></dd>
                <dt>Description</dt>   <dd>${jb.description}</dd>
              </dl>
            </div>
          </details>
        </c:forEach>
      </div>

      <!-- ===== Pagination ===== -->
      <div class="clearfix mt-2">
        <nav class="float-end">
          <ul class="pagination justify-content-end mt-2">
            <li class="page-item">
              <input type="submit" name="operation" class="page-link" value="Previous"
                     <c:if test="${form.pageNo == 1}">disabled="disabled"</c:if> />
            </li>
            <c:forEach var="i" begin="1" end="${(listsize/10)+1}">
              <li class="page-item <c:if test='${i == pageNo}'>active</c:if>">
                <a class="page-link" href="${addSearch}?pageNo=${i}">${i}</a>
              </li>
            </c:forEach>
            <li class="page-item">
              <input type="submit" name="operation" class="page-link" value="Next"
                     <c:if test="${total == pagenosize || listsize < pageSize}">disabled="disabled"</c:if> />
            </li>
          </ul>
        </nav>
      </div>
    </div>
  </div>
</sf:form>

<!-- Client-side filter for Title + Location -->
<script>
(function(){
  function norm(s){ return (s||"").toString().trim().toLowerCase(); }
  const wrap = document.getElementById('jobList');
  if(!wrap) return;

  const inputTitle = document.getElementById("searchTitle");
  const inputLoc   = document.getElementById("searchLocation");

  function apply(){
    const qTitle = norm(inputTitle ? inputTitle.value : "");
    const qLoc   = norm(inputLoc ? inputLoc.value : "");
    let visible = 0;

    Array.from(wrap.querySelectorAll('details.job')).forEach(d => {
      const t = norm(d.getAttribute('data-title'));
      const l = norm(d.getAttribute('data-location'));
      const ok = (!qTitle || (t && t.includes(qTitle))) && (!qLoc || (l && l.includes(qLoc)));
      d.style.display = ok ? "" : "none";
      if(ok) visible++;
    });

    let empty = wrap.querySelector('.__empty');
    if (!empty) {
      empty = document.createElement('div');
      empty.className = '__empty';
      empty.style.cssText = 'text-align:center;padding:12px;display:none;';
      empty.textContent = 'No matching jobs found.';
      wrap.appendChild(empty);
    }
    empty.style.display = visible === 0 ? "" : "none";
  }

  if(inputTitle) inputTitle.addEventListener('input', apply);
  if(inputLoc)   inputLoc.addEventListener('input', apply);
})();
</script>
