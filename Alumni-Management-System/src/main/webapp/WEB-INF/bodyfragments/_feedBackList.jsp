<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="s"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="sf"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="crt"%>
<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@page isELIgnored="false"%>

<c:url var="addUrl" value="/ctl/feedBack" />
<c:url var="addSearch" value="/ctl/feedBack/search" />
<c:url var="editUrl" value="/ctl/feedBack?id=" />

<style>
  /* === Color Hunt palette === */
  :root{
    --red: #E43636;
    --red-700: #c62f2f;   /* hover/darker */
    --cream: #F6EFD2;     /* light surface */
    --beige: #E2DDB4;     /* subtle accents */
    --black: #000000;     /* strong text */
    --white: #ffffff;
  }

  /* Header + buttons */
  .card-header{ background: var(--red); color: var(--white); font-weight:700; letter-spacing:.3px; }
  .btn-theme{
    background: var(--red); color: var(--white); border-color: var(--red);
    border-radius: 8px; font-weight:700; padding:6px 14px;
    box-shadow: 0 2px 6px rgba(0,0,0,.12);
    transition: background-color .2s ease, border-color .2s ease, transform .05s ease;
  }
  .btn-theme:hover{ background: var(--red-700); border-color: var(--red-700); }
  .btn-theme:active{ transform: translateY(1px); }

  /* Inputs */
  .form-control-sm{
    border:1px solid #cfcfcf; font-size:14px; border-radius:8px; background: var(--white);
    transition: border-color .2s ease, box-shadow .2s ease;
  }
  .form-control-sm:focus{ border-color: var(--red); box-shadow: 0 0 0 .15rem rgba(228,54,54,.25); }

  /* Card surface */
  .card.shadow.border-0.rounded{
    background: var(--cream);
    border: 1px solid #e0e0e0 !important;
    border-radius: 12px !important;
    overflow: hidden;
  }

  /* Modern table wrapper */
  .modern-table{
    border:1px solid rgba(0,0,0,.06);
    border-radius:12px;
    background:#fff;
    box-shadow:0 10px 24px rgba(0,0,0,.08);
    overflow:hidden;
  }
  .modern-table .table{ width:100%; border-collapse:separate; border-spacing:0; margin:0; }
  .modern-table thead th{
    background: var(--black); color: var(--white); font-weight:700;
    position:sticky; top:0; z-index:1; text-align:left; vertical-align:middle; white-space:nowrap;
  }
  .modern-table th, .modern-table td{ padding:14px 16px; border-bottom:1px solid #eef2e6; }
  .modern-table tbody tr:nth-child(even){ background: rgba(226,221,180,.25); } /* beige tint */
  .modern-table tbody tr:hover{ background: rgba(226,221,180,.35); }

  .modern-table input[type="checkbox"]{ width:16px; height:16px; accent-color: var(--red); }

  /* Column helpers */
  .col-idx{ width:56px; text-align:center; vertical-align:middle; }
  .col-fb { min-width:420px; overflow-wrap:anywhere; word-break:break-word; }

  /* No-results row */
  .__noresults td{ background:#fdeceb; color:#9b1c1c; font-weight:600; text-align:center; }

  /* Pagination */
  .pagination .page-item.active .page-link{ background: var(--red); border-color: var(--red); color:#fff; }
  .pagination .page-link{ color: var(--red); border-color: #e5e5e5; border-radius:6px; font-weight:600; }
  .pagination .page-link:hover{ background: var(--red); color:#fff; border-color: var(--red); }
</style>

<sf:form method="post" action="${pageContext.request.contextPath}/ctl/feedBack/search" modelAttribute="form">
  <div class="container mt-3">
    <div class="card shadow border-0 rounded">
      <h5 class="card-header">Feedback List</h5>

      <div class="card-body">
        <div class="row g-3 mb-3">
          <!-- Search input -->
          <s:bind path="feedBack">
            <div class="col-md-6 col-lg-4">
              <sf:input id="searchFeedback" path="${status.expression}" class="form-control form-control-sm"
                        placeholder="Search feedback..." />
            </div>
          </s:bind>
          <div class="col-md-6 col-lg-4">
            <input type="submit" class="btn btn-sm btn-theme" name="operation" value="Search" />
            <input type="submit" class="btn btn-sm btn-secondary ms-2" name="operation" value="Reset" />
          </div>
        </div>

        <b><%@ include file="businessMessage.jsp"%></b>

        <!-- paging fields for backend -->
        <sf:input type="hidden" path="pageNo" />
        <sf:input type="hidden" path="pageSize" />
        <sf:input type="hidden" path="listsize" />
        <sf:input type="hidden" path="total" />
        <sf:input type="hidden" path="pagenosize" />

        <div class="table-responsive modern-table">
          <table id="feedbackTable" class="table align-middle">
            <thead>
              <tr>
                <c:if test="${sessionScope.admin != null}">
                  <th style="width:140px;"><input type="checkbox" id="selectall" /> Select All</th>
                </c:if>
                <th class="col-idx">#</th>
                <th class="col-fb">Feedback</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach items="${list}" var="fd" varStatus="feedBack">
                <tr>
                  <c:if test="${sessionScope.admin != null}">
                    <td><input type="checkbox" class="case" name="ids" value="${fd.id}" /></td>
                  </c:if>
                  <td class="col-idx">${feedBack.index + 1}</td>
                  <td class="col-fb">${fd.feedBack}</td>
                </tr>
              </c:forEach>

              <!-- hidden no-results row -->
              <tr class="__noresults" style="display:none;">
                <td colspan="99" style="padding:16px;">No matching feedback found.</td>
              </tr>
            </tbody>
          </table>
        </div>

        <div class="d-flex justify-content-between align-items-center mt-3">
          <c:if test="${sessionScope.admin != null}">
            <input type="submit" name="operation" class="btn btn-danger btn-sm"
                   <c:if test="${listsize == 0}">disabled</c:if> value="Delete" />
          </c:if>

          <nav aria-label="Page navigation">
            <ul class="pagination pagination-sm mb-0">
              <li class="page-item">
                <input type="submit" name="operation" class="page-link" value="Previous"
                       <c:if test="${form.pageNo == 1}">disabled</c:if>>
              </li>
              <c:forEach var="i" begin="1" end="${(listsize/10)+1}">
                <li class="page-item <c:if test='${i == pageNo}'>active</c:if>">
                  <a class="page-link" href="${addSearch}?pageNo=${i}">${i}</a>
                </li>
              </c:forEach>
              <li class="page-item">
                <input type="submit" name="operation" class="page-link" value="Next"
                       <c:if test="${total == pagenosize || listsize < pageSize}">disabled</c:if>>
              </li>
            </ul>
          </nav>
        </div>
      </div>
    </div>
  </div>
</sf:form>

<!-- Client-side filtering (Feedback column) -->
<script>
(function () {
  function norm(s){ return (s||"").toString().trim().toLowerCase(); }

  const table = document.getElementById("feedbackTable");
  if(!table) return;
  const thead = table.querySelector("thead");
  const tbody = table.querySelector("tbody");
  if(!thead || !tbody) return;

  const headers = Array.from(thead.querySelectorAll("th")).map(th => norm(th.textContent));
  const fbCol = headers.findIndex(h => h.includes("feedback"));
  if (fbCol === -1) return;

  const inputFb  = document.getElementById("searchFeedback");
  const btnSearch = document.querySelector("input[name='operation'][value='Search']");
  const btnReset  = document.querySelector("input[name='operation'][value='Reset']");

  let noRow = tbody.querySelector("tr.__noresults");
  if(!noRow){
    noRow = document.createElement("tr");
    noRow.className="__noresults";
    const td=document.createElement("td");
    td.colSpan = headers.length;
    td.style.textAlign="center";
    td.style.padding="16px";
    td.textContent="No matching feedback found.";
    noRow.appendChild(td);
    noRow.style.display="none";
    tbody.appendChild(noRow);
  }

  function apply(){
    const q = norm(inputFb ? inputFb.value : "");
    let visible = 0;

    const rows = Array.from(tbody.querySelectorAll("tr")).filter(r => !r.classList.contains("__noresults"));
    rows.forEach(row => {
      const cells = row.querySelectorAll("td");
      if(!cells.length) return;

      const fbTxt = norm(cells[fbCol]?.textContent);
      const show = !q || (fbTxt && fbTxt.includes(q));

      row.style.display = show ? "" : "none";
      if (show) visible++;
    });

    noRow.style.display = visible === 0 ? "" : "none";
  }

  function reset(){
    if(inputFb) inputFb.value = "";
    Array.from(tbody.querySelectorAll("tr"))
      .filter(r=>!r.classList.contains("__noresults"))
      .forEach(r=>r.style.display="");
    noRow.style.display="none";
  }

  if (btnSearch) btnSearch.addEventListener("click", e => { e.preventDefault(); apply(); });
  if (btnReset)  btnReset.addEventListener("click",  e => { e.preventDefault(); reset(); });
  if (inputFb) inputFb.addEventListener("input", apply);
})();
</script>
