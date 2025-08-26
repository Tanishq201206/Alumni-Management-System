<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s"   uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sf"  uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ page isELIgnored="false" %>

<c:url var="addSearch" value="/ctl/applyJob/search" />

<!-- Role + current alumni id -->
<c:set var="isAlumni" value="${not empty sessionScope.alumni}" />
<c:set var="currentAlumniId" value="${isAlumni ? sessionScope.alumni.id : null}" />

<style>
  /* === Color Hunt palette === */
  :root{
    --red: #E43636;
    --red-700: #c62f2f;
    --cream: #F6EFD2;
    --beige: #E2DDB4;
    --black: #000000;
    --white: #ffffff;
  }
  .card.shadow.border-0{
    background: var(--cream);
    border: 1px solid #e0e0e0 !important;
    border-radius: 12px !important;
    overflow: hidden;
  }
  .card-header{ background: var(--red); color: var(--white); font-weight: 700; }
  .form-control.form-control-sm{
    border-radius: 8px; border: 1px solid #cfcfcf; background: var(--white);
    transition: border-color .2s ease, box-shadow .2s ease;
  }
  .form-control:focus{ border-color: var(--red); box-shadow: 0 0 0 .15rem rgba(228,54,54,.25); }

  .btn-theme-sm{
    background: var(--red); border-color: var(--red); color: var(--white);
    border-radius: 8px; padding: 6px 12px; font-weight: 700;
    box-shadow: 0 2px 6px rgba(0,0,0,.12);
    transition: background-color .2s ease, border-color .2s ease, transform .05s ease;
  }
  .btn-theme-sm:hover{ background: var(--red-700); border-color: var(--red-700); }
  .btn-theme-sm:active{ transform: translateY(1px); }
  .btn-secondary{
    border-color: #6c757d; color:#6c757d; background-color:var(--white);
    border-radius: 8px; padding: 6px 12px; font-weight: 700;
    box-shadow: 0 2px 6px rgba(0,0,0,.12);
    transition: background-color .2s ease, border-color .2s ease, transform .05s ease;
  }
  .btn-secondary:hover{ color: var(--white); background-color:#6c757d; }
  .btn-secondary:active{ transform: translateY(1px); }
  .btn-outline-theme{ color: var(--red); border-color: var(--red); border-radius: 8px; padding: 4px 10px; font-weight: 700; }
  .btn-outline-theme:hover{ color: var(--white); background: var(--red); border-color: var(--red); }

  .table thead th{ background: var(--black); color: var(--white); border-color: #2b2b2b; }
  .table tbody tr:hover{ background: rgba(226,221,180,.25); }

  .pagination .page-link{ border-radius: 6px !important; color: var(--red); border-color: #e5e5e5; }
  .pagination .page-link:hover{ color: var(--white); background: var(--red); border-color: var(--red); }
  .pagination .page-item.active .page-link{ background: var(--red); border-color: var(--red); color: var(--white); }

  th:first-child, td:first-child{ white-space: nowrap; }
</style>

<sf:form method="post" action="${pageContext.request.contextPath}/ctl/applyJob/search" modelAttribute="form">
  <div class="card shadow border-0">
    <h5 class="card-header text-white">ApplyJob List</h5>

    <div class="card-body">
      <!-- Search -->
      <div class="row g-3">
        <s:bind path="name">
          <div class="col-md-4">
            <sf:input path="${status.expression}" class="form-control form-control-sm" placeholder="Search by Name" />
          </div>
        </s:bind>
        <s:bind path="jobName">
          <div class="col-md-4">
            <sf:input path="${status.expression}" class="form-control form-control-sm" placeholder="Search by Job Name" />
          </div>
        </s:bind>
        <div class="col-md-4 d-flex align-items-start">
          <input type="submit" name="operation" class="btn btn-sm btn-theme-sm me-2" value="Search" />
          <input type="submit" name="operation" class="btn btn-sm btn-secondary" value="Reset" />
        </div>
      </div>

      <b><%@ include file="businessMessage.jsp" %></b>
      <br/>

      <!-- hidden paging fields -->
      <sf:input type="hidden" path="pageNo" />
      <sf:input type="hidden" path="pageSize" />
      <sf:input type="hidden" path="listsize" />
      <sf:input type="hidden" path="total" />
      <sf:input type="hidden" path="pagenosize" />

      <!-- Determine if there are any applications for this alumni's jobs -->
      <c:set var="hasOwnApps" value="false" />
      <c:forEach items="${list}" var="probe">
        <c:if test="${not empty probe.job and probe.job.alumniId == currentAlumniId}">
          <c:set var="hasOwnApps" value="true" />
        </c:if>
      </c:forEach>

      <div class="table-responsive">
        <table class="table table-bordered table-striped mt-3 align-middle">
          <thead>
            <tr>
              <!-- Checkbox column only if alumni has any of their-job applications -->
              <c:if test="${isAlumni and hasOwnApps}">
                <th style="width:140px;">
                  <input type="checkbox" id="selectall"> Select All
                </th>
              </c:if>
              <th style="width:60px;">#</th>
              <th>Job Name</th>
              <th>Name</th>
              <th>Email</th>
              <th>Contact No</th>
              <th style="width:140px;">Resume</th>
            </tr>
          </thead>
          <tbody>
            <!-- Row counter that only increments for visible (filtered) rows -->
            <c:set var="rowNum" value="0" />
            <c:forEach items="${list}" var="em">
              <!-- Show only applications where the related job belongs to the logged-in alumni -->
              <c:if test="${not empty em.job and em.job.alumniId == currentAlumniId}">
                <c:set var="rowNum" value="${rowNum + 1}" />
                <tr>
                  <c:if test="${isAlumni and hasOwnApps}">
                    <td><input type="checkbox" class="case" name="ids" value="${em.id}"></td>
                  </c:if>
                  <td>${rowNum}</td>
                  <td>${em.jobName}</td>
                  <td>${em.name}</td>
                  <td>${em.email}</td>
                  <td>${em.contactNo}</td>
                  <td>
                    <a class="btn btn-sm btn-outline-theme" target="_blank"
                       href="<c:url value='/ctl/applyJob/getFile/${em.id}' />">View Resume</a>
                  </td>
                </tr>
              </c:if>
            </c:forEach>

            <!-- Empty-state row -->
            <c:if test="${!hasOwnApps}">
              <tr>
                <td colspan="7" class="text-center py-3">No applications for your jobs.</td>
              </tr>
            </c:if>
          </tbody>
        </table>
      </div>

      <div class="d-flex justify-content-between align-items-center mt-3">
        <!-- Delete button only if there are rows for this alumni -->
        <c:if test="${isAlumni and hasOwnApps}">
          <input type="submit" name="operation" class="btn btn-sm btn-danger"
                 value="Delete" />
        </c:if>

        <!-- Keep existing server-side pagination controls -->
        <nav>
          <ul class="pagination pagination-sm mb-0">
            <li class="page-item">
              <input type="submit" name="operation" class="page-link"
                     <c:if test="${form.pageNo == 1}">disabled</c:if>
                     value="Previous" />
            </li>
            <c:forEach var="i" begin="1" end="${(listsize / 10) + 1}">
              <li class="page-item <c:if test='${i == pageNo}'>active</c:if>">
                <a class="page-link" href="${addSearch}?pageNo=${i}">${i}</a>
              </li>
            </c:forEach>
            <li class="page-item">
              <input type="submit" name="operation" class="page-link"
                     <c:if test="${total == pagenosize || listsize < pageSize}">disabled</c:if>
                     value="Next" />
            </li>
          </ul>
        </nav>
      </div>
    </div>
  </div>
</sf:form>

<script>
  // Select-all helper for checkboxes (only present when hasOwnApps)
  (function () {
    var selectAll = document.getElementById('selectall');
    if (!selectAll) return;
    selectAll.addEventListener('change', function () {
      document.querySelectorAll('input.case[type="checkbox"]').forEach(function (cb) {
        cb.checked = selectAll.checked;
      });
    });
  })();
</script>
