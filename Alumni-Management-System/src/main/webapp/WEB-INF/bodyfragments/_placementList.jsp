<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="s"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="sf"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="crt"%>
<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@page isELIgnored="false"%>

<c:url var="addUrl" value="/ctl/placement" />
<c:url var="addSearch" value="/ctl/placement/search" />
<c:url var="editUrl" value="/ctl/placement?id=" />

<style>
  /* ===== ColorHunt Palette =====
     Primary: #E43636 (red)
     Cream:   #F6EFD2
     Sand:    #E2DDB4
     Black:   #000000
  */
  :root{
    --cl-red:#E43636;
    --cl-cream:#F6EFD2;
    --cl-sand:#E2DDB4;
    --cl-black:#000000;
  }

  /* Header */
  .card-header{
    background-color: var(--cl-red);
    color:#fff;
    font-weight:600;
    letter-spacing:.4px;
  }

  /* Inputs */
  .form-control-sm{
    border:1px solid var(--cl-sand);
    font-size:14px;
  }
  .form-control-sm:focus{
    border-color: var(--cl-red);
    box-shadow: 0 0 0 .15rem rgba(228,54,54,.25);
  }

  /* Table */
  table{ border-radius:10px; overflow:hidden; }
  thead{
    background-color: var(--cl-cream) !important;
    color: var(--cl-black);
    font-weight:700;
    text-align:center;
  }
  tbody tr:nth-child(even){ background:#fff; }
  tbody tr:hover{ background: #fff6f6; } /* soft red tint */
  td{ vertical-align: middle; font-size:14px; }

  /* No-results */
  .__noresults td{
    background:#ffecec;
    color:#a94442;
    font-weight:500;
    text-align:center;
  }

  /* Buttons */
  .btn-theme{
    background-color: var(--cl-red);
    color:#fff;
    border:1px solid var(--cl-red);
  }
  .btn-theme:hover{
    background-color:#c42e2e;
    border-color:#c42e2e;
    color:#fff;
  }
  .btn-outline-theme{
    color: var(--cl-red);
    border:1px solid var(--cl-red);
    background:#fff;
  }
  .btn-outline-theme:hover{
    background: var(--cl-red);
    color:#fff;
  }

  /* Pagination */
  .pagination .page-item.active .page-link{
    background-color: var(--cl-red);
    border-color: var(--cl-red);
    color:#fff;
  }
  .pagination .page-link{ color: var(--cl-red); }
  .pagination .page-link:hover{ background: var(--cl-cream); }

  /* Small polish */
  .table img{
    height:70px; width:70px; object-fit:cover; border-radius:8px; border:1px solid var(--cl-sand);
  }
</style>

<sf:form method="post" action="${pageContext.request.contextPath}/ctl/placement/search" modelAttribute="form">
  <div class="container mt-3">
    <div class="card shadow border-0 rounded">
      <h5 class="card-header">Placements</h5>

      <div class="card-body">
        <!-- Search Row -->
        <div class="row g-3 mb-3">
          <s:bind path="name">
            <div class="col-md-4">
              <sf:input id="searchName" path="${status.expression}" class="form-control form-control-sm" placeholder="Search By Name" />
            </div>
          </s:bind>
          <s:bind path="companyName">
            <div class="col-md-4">
              <sf:input id="searchCompany" path="${status.expression}" class="form-control form-control-sm" placeholder="Search By Company" />
            </div>
          </s:bind>
          <div class="col-md-4">
            <input type="submit" class="btn btn-sm btn-theme" name="operation" value="Search" />
            <input type="submit" class="btn btn-sm btn-secondary ms-2" name="operation" value="Reset" />
          </div>
        </div>

        <b><%@ include file="businessMessage.jsp"%></b>

        <!-- keep paging fields for backend -->
        <sf:input type="hidden" path="pageNo" />
        <sf:input type="hidden" path="pageSize" />
        <sf:input type="hidden" path="listsize" />
        <sf:input type="hidden" path="total" />
        <sf:input type="hidden" path="pagenosize" />

        <div class="table-responsive">
          <table id="placementTable" class="table table-bordered table-hover align-middle text-center">
            <thead>
              <tr>
                <c:if test="${sessionScope.admin != null}">
                  <th><input type="checkbox" id="selectall" /> Select All</th>
                </c:if>
                <th>#</th>
                <th>Profile</th>
                <th>Company</th>
                <th>Name</th>
                <th>Designation</th>
                <th>Package</th>
                <th>Date</th>
                <th>Location</th>
                <c:if test="${sessionScope.admin != null}">
                  <th>Action</th>
                </c:if>
              </tr>
            </thead>
            <tbody>
              <c:forEach items="${list}" var="em" varStatus="placement">
                <tr>
                  <c:if test="${sessionScope.admin != null}">
                    <td><input type="checkbox" class="case" name="ids" value="${em.id}" /></td>
                  </c:if>
                  <td>${placement.index + 1}</td>
                  <td>
                    <img src="<c:url value='/ctl/placement/getImage/${em.id}' />" alt="${em.name}" />
                  </td>
                  <td>${em.companyName}</td>
                  <td>${em.name}</td>
                  <td>${em.post}</td>
                  <td>${em.jobPackage}</td>
                  <td>${em.date}</td>
                  <td>${em.location}</td>
                  <c:if test="${sessionScope.admin != null}">
                    <td>
                      <a href="${editUrl}${em.id}" class="btn btn-sm btn-outline-theme" title="Edit Placement">
                        <i class="fas fa-edit"></i> Edit
                      </a>
                    </td>
                  </c:if>
                </tr>
              </c:forEach>

              <tr class="__noresults" style="display:none;">
                <td colspan="99">No matching placements found.</td>
              </tr>
            </tbody>
          </table>
        </div>

        <div class="d-flex justify-content-between align-items-center mt-3">
          <c:if test="${sessionScope.admin != null}">
            <input type="submit" name="operation" class="btn btn-danger btn-sm"
                   <c:if test="${listsize == 0}">disabled="disabled"</c:if> value="Delete" />
          </c:if>

          <nav aria-label="Page navigation">
            <ul class="pagination pagination-sm mb-0">
              <li class="page-item">
                <input type="submit" name="operation" class="page-link" value="Previous"
                       <c:if test="${form.pageNo == 1}">disabled</c:if>>
              </li>
              <c:forEach var="i" begin="1" end="${(listsize/10)+1}">
                <li class="page-item <c:if test='${i== pageNo}'>active</c:if>">
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

<script>
(function () {
  function norm(s){ return (s||"").toString().trim().toLowerCase(); }

  const table = document.getElementById("placementTable");
  if(!table) return;
  const thead = table.querySelector("thead");
  const tbody = table.querySelector("tbody");
  if(!thead || !tbody) return;

  const headers = Array.from(thead.querySelectorAll("th")).map(th => norm(th.textContent));
  const companyCol = headers.findIndex(h => h.includes("company"));
  const nameCol    = headers.findIndex(h => h === "name" || h.endsWith(" name") || h.includes("name"));
  if (companyCol === -1 || nameCol === -1) return;

  const inputName    = document.getElementById("searchName");
  const inputCompany = document.getElementById("searchCompany");
  const btnSearch    = document.querySelector("input[name='operation'][value='Search']");
  const btnReset     = document.querySelector("input[name='operation'][value='Reset']");

  let noRow = tbody.querySelector("tr.__noresults");
  if(!noRow){
    noRow = document.createElement("tr");
    noRow.className="__noresults";
    const td=document.createElement("td");
    td.colSpan = headers.length;
    td.style.textAlign="center";
    td.style.padding="16px";
    td.textContent="No matching placements found.";
    noRow.appendChild(td);
    noRow.style.display="none";
    tbody.appendChild(noRow);
  }

  function apply(){
    const qName = norm(inputName ? inputName.value : "");
    const qComp = norm(inputCompany ? inputCompany.value : "");
    let visible = 0;

    const rows = Array.from(tbody.querySelectorAll("tr")).filter(r => !r.classList.contains("__noresults"));
    rows.forEach(row => {
      const cells = row.querySelectorAll("td");
      if(!cells.length) return;

      const nameTxt = norm(cells[nameCol]?.textContent);
      const compTxt = norm(cells[companyCol]?.textContent);

      const okName = !qName || (nameTxt && nameTxt.includes(qName));
      const okComp = !qComp || (compTxt && compTxt.includes(qComp));
      const show = okName && okComp;

      row.style.display = show ? "" : "none";
      if (show) visible++;
    });

    noRow.style.display = visible === 0 ? "" : "none";
  }

  function reset(){
    if(inputName) inputName.value = "";
    if(inputCompany) inputCompany.value = "";
    Array.from(tbody.querySelectorAll("tr")).filter(r=>!r.classList.contains("__noresults")).forEach(r=>r.style.display="");
    noRow.style.display="none";
  }

  if (btnSearch) btnSearch.addEventListener("click", e => { e.preventDefault(); apply(); });
  if (btnReset)  btnReset.addEventListener("click",  e => { e.preventDefault(); reset(); });

  if (inputName)    inputName.addEventListener("input", apply);
  if (inputCompany) inputCompany.addEventListener("input", apply);
})();
</script>
