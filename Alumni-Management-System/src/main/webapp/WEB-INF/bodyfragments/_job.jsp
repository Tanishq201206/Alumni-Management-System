<%@taglib uri="http://www.springframework.org/tags/form" prefix="sf"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="s"%>

<style>
  :root{
    --red:#E43636;        /* primary */
    --red-700:#c62f2f;    /* hover */
    --cream:#F6EFD2;      /* soft bg */
    --beige:#E2DDB4;      /* accents */
    --black:#000000;
  }

  .card { border: 1px solid #eee; }
  .card-header {
    background-color: var(--red);
    color: #fff;
    font-weight: 700;
    letter-spacing: .2px;
  }

  .form-label { font-weight: 600; }
  .form-control, .form-select, textarea.form-control {
    border-radius: 8px;
    border: 1px solid #d9d9d9;
    transition: border-color .15s ease, box-shadow .15s ease;
  }
  .form-control:focus, .form-select:focus, textarea.form-control:focus {
    border-color: var(--red);
    box-shadow: 0 0 0 .15rem rgba(228,54,54,.2);
  }

  .text-error, .form-text font { color:#E43636 !important; font-size:13px; }

  .btn-primary-theme {
    background-color: var(--red);
    border-color: var(--red);
    color:#fff;
    font-weight: 600;
    border-radius: 8px;
    padding: 8px 16px;
  }
  .btn-primary-theme:hover { background-color: var(--red-700); border-color: var(--red-700); }
</style>

<div class="container mt-3">
  <sf:form method="post" action="${pageContext.request.contextPath}/ctl/job" modelAttribute="form">
    <div class="card shadow border-0 rounded">
      <!-- Header switches based on presence of id (from model or query param) -->
      <h5 class="card-header">
        <c:choose>
          <c:when test="${form.id gt 0 or not empty param.id}">Edit Job</c:when>
          <c:otherwise>Add Job</c:otherwise>
        </c:choose>
      </h5>

      <div class="card-body">
        <b><%@ include file="businessMessage.jsp"%></b>

        <!-- Hidden ID so POST includes it -->
        <sf:hidden path="id" id="jobId"/>

        <div class="row g-3">
          <s:bind path="companyName">
            <div class="col-md-6">
              <label class="form-label">Company Name</label>
              <sf:input path="${status.expression}" class="form-control" placeholder="Enter Company Name"/>
              <div class="text-error"><sf:errors path="${status.expression}"/></div>
            </div>
          </s:bind>

          <s:bind path="title">
            <div class="col-md-6">
              <label class="form-label">Title</label>
              <sf:input path="${status.expression}" class="form-control" placeholder="Enter Title"/>
              <div class="text-error"><sf:errors path="${status.expression}"/></div>
            </div>
          </s:bind>

          <s:bind path="skills">
            <div class="col-md-6">
              <label class="form-label">Key Skills</label>
              <sf:input path="${status.expression}" class="form-control" placeholder="Enter Key Skills"/>
              <div class="text-error"><sf:errors path="${status.expression}"/></div>
            </div>
          </s:bind>

          <s:bind path="jobPackage">
            <div class="col-md-6">
              <label class="form-label">Package</label>
              <sf:input path="${status.expression}" class="form-control" placeholder="e.g., 6–8 LPA"/>
              <div class="text-error"><sf:errors path="${status.expression}"/></div>
            </div>
          </s:bind>

          <s:bind path="experienceRequired">
            <div class="col-md-6">
              <label class="form-label">Experience Required</label>
              <sf:input path="${status.expression}" class="form-control" placeholder="e.g., 2+ years"/>
              <div class="text-error"><sf:errors path="${status.expression}"/></div>
            </div>
          </s:bind>

          <s:bind path="qualification">
            <div class="col-md-6">
              <label class="form-label">Required Qualification</label>
              <sf:textarea path="${status.expression}" rows="3" class="form-control" placeholder="Enter Qualification"></sf:textarea>
              <div class="text-error"><sf:errors path="${status.expression}"/></div>
            </div>
          </s:bind>

          <s:bind path="noOfVaccancy">
            <div class="col-md-6">
              <label class="form-label">No. of Vacancies</label>
              <sf:input path="${status.expression}" class="form-control" placeholder="Enter number of vacancies"/>
              <div class="text-error"><sf:errors path="${status.expression}"/></div>
            </div>
          </s:bind>

          <s:bind path="referenceEmail">
            <div class="col-md-6">
              <label class="form-label">Reference Email ID</label>
              <sf:input path="${status.expression}" class="form-control" placeholder="Enter reference email"/>
              <div class="text-error"><sf:errors path="${status.expression}"/></div>
            </div>
          </s:bind>

          <s:bind path="lastDate">
            <div class="col-md-6">
              <label class="form-label">Last Date</label>
              <sf:input path="${status.expression}" id="datepicker1" class="form-control" placeholder="Enter last date"/>
              <div class="text-error"><sf:errors path="${status.expression}"/></div>
            </div>
          </s:bind>

          <s:bind path="location">
            <div class="col-md-6">
              <label class="form-label">Location</label>
              <sf:textarea path="${status.expression}" rows="3" class="form-control" placeholder="City, State / Remote"></sf:textarea>
              <div class="text-error"><sf:errors path="${status.expression}"/></div>
            </div>
          </s:bind>

          <s:bind path="description">
            <div class="col-md-6">
              <label class="form-label">Description</label>
              <sf:textarea path="${status.expression}" rows="3" class="form-control" placeholder="Brief role description"></sf:textarea>
              <div class="text-error"><sf:errors path="${status.expression}"/></div>
            </div>
          </s:bind>
        </div>

        <div class="mt-4 text-end">
          <input type="submit" name="operation" class="btn btn-primary-theme" value="Save"/>
          <input type="submit" name="operation" class="btn btn-secondary ms-2" value="Reset"/>
        </div>
      </div>
    </div>
  </sf:form>
</div>

<!-- Front-end only: ensure hidden id is set from ?id= if model doesn't have it -->
<script>
(function(){
  var params = new URLSearchParams(window.location.search);
  var idFromQuery = params.get('id');
  var idInput = document.getElementById('jobId');
  if (idInput && (!idInput.value || idInput.value === '0') && idFromQuery) {
    idInput.value = idFromQuery;
  }
})();
</script>
