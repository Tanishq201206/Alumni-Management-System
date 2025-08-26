<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="s"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="sf"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@page isELIgnored="false"%>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>

<style>
  /* ===== Color Hunt palette ===== */
  :root{
    --red:#E43636;      /* primary */
    --red-700:#c62f2f;  /* hover/dark */
    --cream:#F6EFD2;    /* soft header */
    --beige:#E2DDB4;    /* accents */
    --black:#000000;
  }

  .btn-primary,
  .btn-outline-primary{
    background-color: var(--red);
    border-color: var(--red);
    color: #fff;
  }
  .btn-outline-primary{
    background: transparent;
    color: var(--red);
  }
  .btn-primary:hover,
  .btn-outline-primary:hover{
    background-color: var(--red-700);
    border-color: var(--red-700);
    color:#fff;
  }

  .alert { margin: 15px auto; width: 90%; }

  .card { margin: auto; max-width: 1200px; border-radius: 12px; overflow: hidden; }
  .card-header{
    background: var(--red);
    color:#fff;
    font-weight:700;
    letter-spacing:.2px;
  }

  /* ===== Modern table ===== */
  .modern-table{
    border:1px solid rgba(0,0,0,.06);
    border-radius:12px;
    background:#fff;
    box-shadow:0 10px 24px rgba(0,0,0,.08);
    overflow:hidden;
  }
  .modern-table .table{
    width:100%;
    border-collapse:separate;
    border-spacing:0;
    margin:0;
  }
  .modern-table thead th{
    background: var(--cream);
    color:#291d1d;
    font-weight:700;
    position:sticky; top:0; z-index:1;
  }
  .modern-table th, .modern-table td{
    padding:14px 16px;
    border-bottom:1px solid #eee9cf;
    vertical-align: middle;
  }
  .modern-table tbody tr:hover{ background:#fff9ef; }
  .modern-table input[type="checkbox"]{
    width:16px; height:16px; accent-color: var(--red);
  }

  /* Inputs */
  .form-control.form-control-sm{
    border:1px solid #e2e2e2;
    border-radius:8px;
    transition:border-color .15s ease, box-shadow .15s ease;
  }
  .form-control.form-control-sm:focus{
    border-color: var(--red);
    box-shadow: 0 0 0 .15rem rgba(228,54,54,.2);
  }
</style>

<c:url var="addUrl" value="/ctl/participant"/>
<c:url var="addSearch" value="/ctl/participant/search"/>
<c:url var="editUrl" value="/ctl/participant?id="/>

<br/>

<c:if test="${not empty success}">
  <div id="alertBox" class="alert alert-success animate__animated animate__fadeInDown" role="alert">
    ✅ ${success}
  </div>
</c:if>
<c:if test="${not empty error}">
  <div id="alertBox" class="alert alert-danger animate__animated animate__fadeInDown" role="alert">
    ❌ ${error}
  </div>
</c:if>

<sf:form method="post" action="${pageContext.request.contextPath}/ctl/participant/search" modelAttribute="form">
  <div class="card shadow mb-5 bg-body rounded">
    <h5 class="card-header">Participant List</h5>
    <div class="card-body">

      <div class="row g-3 mb-3">
        <s:bind path="name">
          <div class="col">
            <sf:input id="searchName" path="${status.expression}" class="form-control form-control-sm"
                      placeholder="Search By Name"/>
          </div>
        </s:bind>

        <s:bind path="eventName">
          <div class="col">
            <sf:input id="searchEvent" path="${status.expression}" class="form-control form-control-sm"
                      placeholder="Search By Event"/>
          </div>
        </s:bind>

        <div class="col">
          <input type="submit" class="btn btn-sm btn-outline-primary" name="operation" value="Search"/>
          &nbsp;
          <input type="submit" class="btn btn-sm btn-outline-secondary" name="operation" value="Reset"/>
        </div>
      </div>

      <%@ include file="businessMessage.jsp" %>

      <sf:input type="hidden" path="pageNo"/>
      <sf:input type="hidden" path="pageSize"/>
      <sf:input type="hidden" path="listsize"/>
      <sf:input type="hidden" path="total"/>
      <sf:input type="hidden" path="pagenosize"/>

      <div class="table-responsive modern-table mt-2">
        <table id="participantTable" class="table">
          <thead>
            <tr>
              <c:if test="${sessionScope.admin != null}">
                <th style="width:140px;"><input type="checkbox" id="selectall"/> Select All</th>
              </c:if>
              <th style="width:56px;">#</th>
              <th>Event Name</th>
              <th>Name</th>
              <th>Contact No</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach items="${list}" var="em" varStatus="participant">
              <tr>
                <c:if test="${sessionScope.admin != null}">
                  <td><input type="checkbox" class="case" name="ids" value="${em.id}"/></td>
                </c:if>
                <td>${participant.index + 1}</td>
                <td>${em.eventName}</td>
                <td>${em.name}</td>
                <td>${em.contactNo}</td>
              </tr>
            </c:forEach>

            <tr class="__noresults" style="display:none;">
              <td colspan="99" style="text-align:center; padding:16px;">No matching participants found.</td>
            </tr>
          </tbody>
        </table>
      </div>

      <div class="clearfix">
        <c:if test="${sessionScope.admin != null}">
          <input type="submit" name="operation" class="btn btn-sm btn-danger float-start"
                 <c:if test="${listsize == 0}">disabled</c:if> value="Delete"/>
        </c:if>

        <nav class="float-end">
          <ul class="pagination pagination-sm justify-content-end" style="font-size: 13px">
            <li class="page-item">
              <input type="submit" name="operation" class="page-link"
                     <c:if test="${form.pageNo == 1}">disabled</c:if> value="Previous"/>
            </li>
            <c:forEach var="i" begin="1" end="${(listsize/10)+1}">
              <li class="page-item <c:if test='${i == pageNo}'>active</c:if>">
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
  // fade animated alerts
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

<!-- Client-side filtering (Name + Event Name) -->
<script>
(function () {
  function norm(s){ return (s||"").toString().trim().toLowerCase(); }

  const table = document.getElementById("participantTable");
  if(!table) return;
  const thead = table.querySelector("thead");
  const tbody = table.querySelector("tbody");
  if(!thead || !tbody) return;

  const headers = Array.from(thead.querySelectorAll("th")).map(th => norm(th.textContent));
  let eventNameCol = headers.findIndex(h => h.includes("event") && h.includes("name"));
  if (eventNameCol === -1) eventNameCol = headers.findIndex(h => h.includes("event"));
  const nameCol = headers.findIndex(h => h === "name" || h.endsWith(" name") || h.includes("name"));

  if (eventNameCol === -1 || nameCol === -1) return;

  const inputName  = document.getElementById("searchName");
  const inputEvent = document.getElementById("searchEvent");
  const btnSearch  = document.querySelector("input[name='operation'][value='Search']");
  const btnReset   = document.querySelector("input[name='operation'][value='Reset']");

  let noRow = tbody.querySelector("tr.__noresults");
  if(!noRow){
    noRow = document.createElement("tr");
    noRow.className="__noresults";
    const td=document.createElement("td");
    td.colSpan = headers.length;
    td.style.textAlign="center";
    td.style.padding="16px";
    td.textContent="No matching participants found.";
    noRow.appendChild(td);
    noRow.style.display="none";
    tbody.appendChild(noRow);
  }

  function apply(){
    const qName  = norm(inputName ? inputName.value : "");
    const qEvent = norm(inputEvent ? inputEvent.value : "");
    let visible = 0;

    const rows = Array.from(tbody.querySelectorAll("tr")).filter(r => !r.classList.contains("__noresults"));
    rows.forEach(row => {
      const cells = row.querySelectorAll("td");
      if(!cells.length) return;

      const nameTxt  = norm(cells[nameCol]?.textContent);
      const eventTxt = norm(cells[eventNameCol]?.textContent);

      const okName  = !qName  || (nameTxt  && nameTxt.includes(qName));
      const okEvent = !qEvent || (eventTxt && eventTxt.includes(qEvent));
      const show = okName && okEvent;

      row.style.display = show ? "" : "none";
      if (show) visible++;
    });

    noRow.style.display = visible === 0 ? "" : "none";
  }

  function reset(){
    if(inputName)  inputName.value = "";
    if(inputEvent) inputEvent.value = "";
    Array.from(tbody.querySelectorAll("tr")).filter(r=>!r.classList.contains("__noresults")).forEach(r=>r.style.display="");
    noRow.style.display="none";
  }

  if (btnSearch) btnSearch.addEventListener("click", e => { e.preventDefault(); apply(); });
  if (btnReset)  btnReset.addEventListener("click",  e => { e.preventDefault(); reset(); });

  if (inputName)  inputName.addEventListener("input", apply);
  if (inputEvent) inputEvent.addEventListener("input", apply);
})();
</script>
