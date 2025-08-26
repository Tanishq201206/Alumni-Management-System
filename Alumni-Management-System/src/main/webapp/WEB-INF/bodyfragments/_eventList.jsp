<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="s"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="sf"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@page isELIgnored="false"%>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>

<style>
  :root{ --red:#E43636; --red-700:#c62f2f; --cream:#F6EFD2; --beige:#E2DDB4; --black:#000; --white:#fff; }
  .bgcolor{ background-color:var(--red)!important; }
  .btn-search{ border-color:var(--red)!important; color:var(--red); }
  .btn-search:hover{ background:var(--red); color:var(--white); }
  .btn-reset{ border-color:#6c757d!important; color:#6c757d!important; }
  .btn-reset:hover{ background:#6c757d!important; color:var(--white)!important; }
  .btn-participate{ background:var(--red); color:#fff; border-radius:8px; padding:4px 10px; font-size:.85rem; font-weight:700; border:1px solid var(--red); }
  .btn-participate:hover{ background:var(--red-700); border-color:var(--red-700); }
  .card{ margin:auto; max-width:1200px; border-radius:12px; background:var(--cream); border:1px solid #e0e0e0; overflow:hidden; }
  .card-header{ color:#fff; font-weight:700; }
  .alert{ margin:15px auto; width:90%; border-radius:10px; }
  .alert-success{ background:#eaf6ea; border-color:#cbe8cf; color:#1f7a3e; }
  .alert-danger{ background:#fdeceb; border-color:#f6c9c6; color:#9b1c1c; }
  .table{ border-radius:8px; overflow:hidden; }
  .table thead th{ background:#000; color:#fff; font-weight:700; border-color:#2b2b2b; }
  .table-hover tbody tr:hover{ background-color:rgba(226,221,180,.25); }
  .search-bar input{ border:1px solid #cfcfcf; border-radius:8px; background:#fff; transition:border-color .2s, box-shadow .2s; }
  .search-bar input:focus{ border-color:var(--red); box-shadow:0 0 0 .15rem rgba(228,54,54,.25); }
  .search-bar .btn{ border-radius:8px; }
  .pagination .page-link{ border-radius:6px!important; color:var(--red); border-color:#e5e5e5; font-weight:600; }
  .pagination .page-link:hover{ color:#fff; background:var(--red); border-color:var(--red); }
  .pagination .page-item.active .page-link{ background:var(--red); border-color:var(--red); color:#fff; }
  .table-responsive{ margin-top:10px; }
  /* Subtle dim for rows where delete is not allowed (Active) */
  tr.is-active td:first-child input[disabled]{ cursor:not-allowed; }
</style>

<c:url var="addUrl" value="/ctl/event"/>
<c:url var="addSearch" value="/ctl/event/search"/>
<c:url var="editUrl" value="/ctl/event?id="/>
<c:url var="partUrl" value="/ctl/participant?eId="/>

<br>

<c:if test="${not empty success}">
  <div id="alertBox" class="alert alert-success animate__animated animate__fadeInDown" role="alert">✅ ${success}</div>
</c:if>
<c:if test="${not empty error}">
  <div id="alertBox" class="alert alert-danger animate__animated animate__fadeInDown" role="alert">❌ ${error}</div>
</c:if>

<sf:form method="post" action="${pageContext.request.contextPath}/ctl/event/search" modelAttribute="form">
  <div class="card shadow mb-5 bg-body rounded">
    <h5 class="card-header bgcolor text-white">Event List</h5>
    <div class="card-body">
      <div class="row g-2 mb-3 search-bar align-items-center">
        <s:bind path="title">
          <div class="col-md-4">
            <sf:input id="searchTitle" path="${status.expression}" class="form-control" placeholder="Search by Title"/>
          </div>
        </s:bind>
        <s:bind path="location">
          <div class="col-md-4">
            <sf:input id="searchLocation" path="${status.expression}" class="form-control" placeholder="Search by Location"/>
          </div>
        </s:bind>
        <div class="col-md-4 d-flex gap-2">
          <input type="submit" class="btn btn-sm btn-search px-3" name="operation" value="Search"/>
          <input type="submit" class="btn btn-sm btn-reset px-3"  name="operation" value="Reset"/>
        </div>
      </div>

      <%@ include file="businessMessage.jsp" %>

      <sf:input type="hidden" path="pageNo"/>
      <sf:input type="hidden" path="pageSize"/>
      <sf:input type="hidden" path="listsize"/>
      <sf:input type="hidden" path="total"/>
      <sf:input type="hidden" path="pagenosize"/>

      <div class="table-responsive">
        <table id="eventTable" class="table table-bordered table-hover align-middle">
          <thead>
            <tr>
              <c:if test="${sessionScope.admin != null}">
                <th><input type="checkbox" id="selectall"/> Select All</th>
              </c:if>
              <th>#</th>
              <th>Title</th>
              <th>Event Date</th>
              <th>Event Time</th>
              <th>Location</th>
              <th>Description</th>
              <th>Status</th>
              <c:if test="${sessionScope.admin != null}"><th>Action</th></c:if>
              <c:if test="${sessionScope.alumni != null}"><th>Participant</th></c:if>
            </tr>
          </thead>
          <tbody>
            <c:forEach items="${list}" var="em" varStatus="event">
              <!-- Mark row when Active (so we can style/recognize it) -->
              <tr class="<c:if test='${em.status ne "Inactive"}'>is-active</c:if>">
                <c:if test="${sessionScope.admin != null}">
                  <!-- Checkbox enabled ONLY for Inactive events -->
                  <td>
                    <input type="checkbox"
                           class="case"
                           name="ids"
                           value="${em.id}"
                           <c:if test='${em.status ne "Inactive"}'>disabled="disabled" title="Only Inactive events can be deleted"</c:if> />
                  </td>
                </c:if>
                <td>${event.index + 1}</td>
                <td>${em.title}</td>
                <td>${em.eventDate}</td>
                <td>${em.eventTime}</td>
                <td>${em.location}</td>
                <td>${em.description}</td>
                <td>${em.status}</td>
                <c:if test="${sessionScope.admin != null}">
                  <td><a href="${editUrl}${em.id}" class="btn btn-sm btn-outline-primary"><i class="fas fa-edit"></i> Edit</a></td>
                </c:if>
                <c:if test="${sessionScope.alumni != null}">
                  <td><a href="${partUrl}${em.id}" class="btn btn-participate">Participate</a></td>
                </c:if>
              </tr>
            </c:forEach>

            <tr class="__noresults" style="display:none;">
              <td colspan="99" style="text-align:center; padding:16px;">No matching events found.</td>
            </tr>
          </tbody>
        </table>
      </div>

      <div class="clearfix mt-3">
        <c:if test="${sessionScope.admin != null}">
          <input type="submit" name="operation" class="btn btn-sm btn-danger float-start"
                 <c:if test="${listsize == 0}">disabled="disabled"</c:if> value="Delete"/>
        </c:if>

        <nav aria-label="Page navigation" class="float-end">
          <ul class="pagination pagination-sm justify-content-end">
            <li class="page-item">
              <input type="submit" name="operation" class="page-link"
                     <c:if test="${form.pageNo == 1}">disabled</c:if> value="Previous"/>
            </li>
            <c:forEach var="i" begin="1" end="${(listsize/10)+1}">
              <li class="page-item <c:if test='${i == pageNo}'>active</c:if>'">
                <a class="page-link" href="${addSearch}?pageNo=${i}">${i}</a>
              </li>
            </c:forEach>
            <li class="page-item">
              <input type="submit" name="operation" class="page-link"
                     <c:if test="${total == pagenosize || listsize < pageSize}">disabled</c:if> value="Next"/>
            </li>
          </ul>
        </nav>
      </div>
    </div>
  </div>
</sf:form>

<script>
  window.addEventListener("DOMContentLoaded", function () {
    const alertBox = document.getElementById("alertBox");
    if (alertBox) {
      setTimeout(() => {
        alertBox.classList.replace("animate__fadeInDown", "animate__fadeOutUp");
        setTimeout(() => alertBox.remove(), 1000);
      }, 4000);
    }
  });
</script>

<script>
(function () {
  function normalize(str){ return (str || "").toString().trim().toLowerCase(); }

  const table = document.getElementById("eventTable");
  if (!table) return;

  const thead = table.querySelector("thead");
  const tbody = table.querySelector("tbody");
  if (!thead || !tbody) return;

  const headers = Array.from(thead.querySelectorAll("th")).map(th => normalize(th.textContent));
  const titleCol = headers.findIndex(h => h.includes("title"));
  const locCol   = headers.findIndex(h => h.includes("location"));
  if (titleCol === -1 || locCol === -1) return;

  const inputTitle = document.getElementById("searchTitle");
  const inputLoc   = document.getElementById("searchLocation");
  const btnSearch  = document.querySelector("input[name='operation'][value='Search']");
  const btnReset   = document.querySelector("input[name='operation'][value='Reset']");

  let noRow = tbody.querySelector("tr.__noresults");
  if (!noRow) {
    noRow = document.createElement("tr");
    noRow.className = "__noresults";
    const td = document.createElement("td");
    td.colSpan = headers.length;
    td.style.textAlign = "center";
    td.style.padding = "16px";
    td.textContent = "No matching events found.";
    noRow.appendChild(td);
    noRow.style.display = "none";
    tbody.appendChild(noRow);
  }

  function applyFilter() {
    const qTitle = normalize(inputTitle ? inputTitle.value : "");
    const qLoc   = normalize(inputLoc ? inputLoc.value : "");
    let visible = 0;

    const rows = Array.from(tbody.querySelectorAll("tr")).filter(r => !r.classList.contains("__noresults"));
    rows.forEach(row => {
      const cells = row.querySelectorAll("td");
      if (!cells.length) return;

      const titleText = normalize(cells[titleCol]?.textContent);
      const locText   = normalize(cells[locCol]?.textContent);

      const okTitle = qTitle === "" || (titleText && titleText.includes(qTitle));
      const okLoc   = qLoc === ""   || (locText && locText.includes(qLoc));
      const show    = okTitle && okLoc;

      row.style.display = show ? "" : "none";
      if (show) visible++;
    });

    noRow.style.display = (visible === 0) ? "" : "none";
  }

  function resetFilter() {
    if (inputTitle) inputTitle.value = "";
    if (inputLoc)   inputLoc.value = "";
    const rows = Array.from(tbody.querySelectorAll("tr")).filter(r => !r.classList.contains("__noresults"));
    rows.forEach(r => r.style.display = "");
    noRow.style.display = "none";
  }

  if (btnSearch) btnSearch.addEventListener("click", function(e){ e.preventDefault(); applyFilter(); });
  if (btnReset)  btnReset.addEventListener("click",  function(e){ e.preventDefault(); resetFilter(); });

  if (inputTitle) inputTitle.addEventListener("input", applyFilter);
  if (inputLoc)   inputLoc.addEventListener("input", applyFilter);
})();
</script>

<!-- Delete logic: only considers ENABLED (inactive) checkboxes -->
<script>
(function () {
  const selectAll = document.getElementById('selectall');
  const deleteBtn = document.querySelector("input[type='submit'][name='operation'][value='Delete']");
  if (!deleteBtn) return;

  // Only eligible checkboxes (not disabled) count for Delete
  const rowBoxes = () => Array.from(document.querySelectorAll("input.case[name='ids']:not([disabled])"));

  function updateDeleteState() {
    const boxes = rowBoxes();
    const any = boxes.some(b => b.checked);
    deleteBtn.disabled = !any;

    if (selectAll) {
      const allChecked = boxes.length && boxes.every(b => b.checked);
      const someChecked = boxes.some(b => b.checked);
      selectAll.checked = allChecked;
      selectAll.indeterminate = someChecked && !allChecked;
    }
  }

  // Init
  updateDeleteState();

  // Select-all toggles only enabled boxes
  if (selectAll) {
    selectAll.addEventListener('change', (e) => {
      rowBoxes().forEach(b => { b.checked = e.target.checked; });
      updateDeleteState();
    });
  }

  // Per-row
  document.querySelectorAll("input.case[name='ids']").forEach(b => {
    if (!b.disabled) b.addEventListener('change', updateDeleteState);
  });

  // Block submit if nothing eligible is selected
  deleteBtn.addEventListener('click', function (e) {
    if (!rowBoxes().some(b => b.checked)) {
      e.preventDefault();
      return false;
    }
  });
})();
</script>
