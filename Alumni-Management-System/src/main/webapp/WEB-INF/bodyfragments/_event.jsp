<%@taglib uri="http://www.springframework.org/tags/form" prefix="sf"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="crt"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="s"%>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>

<style>
  :root{
    --red: #E43636;
    --red-700: #c62f2f;
    --cream: #F6EFD2;
    --beige: #E2DDB4;
    --black: #000000;
    --white: #ffffff;
  }
  .bgcolor { background-color: var(--red) !important; }
  .card { max-width: 850px; margin: auto; background: var(--cream); border: 1px solid #e0e0e0; border-radius: 12px; overflow: hidden; }
  .card-header { color: var(--white); font-weight: 700; }
  .alert { margin: 20px auto; width: 850px; border-radius: 10px; }
  .alert-success { background-color: #eaf6ea; border-color: #cbe8cf; color: #1f7a3e; }
  .alert-danger  { background-color: #fdeceb; border-color: #f6c9c6; color: #9b1c1c; }
  .form-label { font-weight: 700; color: var(--black); }
  .form-text  { font-size: 13px; color: var(--red); }
  .form-control, .form-select {
    border-radius: 8px;
    border: 1px solid #cfcfcf;
    background: var(--white);
    transition: border-color .2s ease, box-shadow .2s ease;
  }
  .form-control:focus, .form-select:focus {
    border-color: var(--red);
    box-shadow: 0 0 0 .15rem rgba(228,54,54,.25);
  }
  .btn-primary {
    background-color: var(--red);
    border-color: var(--red);
    color: var(--white);
    border-radius: 8px;
    padding: 8px 16px;
    font-weight: 700;
    box-shadow: 0 2px 6px rgba(0,0,0,.12);
    transition: background-color .2s ease, border-color .2s ease, transform .05s ease;
  }
  .btn-primary:hover { background-color: var(--red-700); border-color: var(--red-700); }
  .btn-primary:active { transform: translateY(1px); }
  .btn-secondary{ border-radius: 8px; padding: 8px 16px; font-weight: 700; }
</style>

<br>

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

<div class="container">
  <sf:form method="post"
           action="${pageContext.request.contextPath}/ctl/event"
           modelAttribute="form">

    <!-- keep record id so edit goes to update path -->
    <sf:hidden path="id"/>

    <!-- post original title as a plain param (do NOT bind to a non-existent bean property) -->
    <input type="hidden" name="originalTitle" value="${form.title}"/>

    <div class="card shadow mb-5 bg-body rounded">
      <h5 class="card-header bgcolor text-white">
        <c:choose>
          <c:when test="${form.id != null && form.id ne 0}">Edit Event</c:when>
          <c:otherwise>Add Event</c:otherwise>
        </c:choose>
      </h5>
      <div class="card-body">
        <%@ include file="businessMessage.jsp"%>

        <div class="row g-4">
          <div class="col-md-6">
            <s:bind path="title">
              <label class="form-label">Title</label>
              <sf:input path="${status.expression}" placeholder="Enter Title" class="form-control"/>
              <div class="form-text"><sf:errors path="${status.expression}"/></div>
            </s:bind>
          </div>

          <div class="col-md-6">
            <s:bind path="eventDate">
              <label class="form-label">Event Date</label>
              <sf:input path="${status.expression}" id="datepicker1" placeholder="Enter Event Date" class="form-control"/>
              <div class="form-text"><sf:errors path="${status.expression}"/></div>
            </s:bind>
          </div>

          <div class="col-md-6">
            <s:bind path="eventTime">
              <label class="form-label">Event Time</label>
              <sf:input path="${status.expression}" placeholder="Enter Event Time" class="form-control"/>
              <div class="form-text"><sf:errors path="${status.expression}"/></div>
            </s:bind>
          </div>

          <div class="col-md-6">
            <s:bind path="location">
              <label class="form-label">Location</label>
              <sf:textarea path="${status.expression}" rows="3" placeholder="Enter Location" class="form-control"/>
              <div class="form-text"><sf:errors path="${status.expression}"/></div>
            </s:bind>
          </div>

          <div class="col-md-6">
            <s:bind path="description">
              <label class="form-label">Description</label>
              <sf:textarea path="${status.expression}" rows="3" placeholder="Enter Description" class="form-control"/>
              <div class="form-text"><sf:errors path="${status.expression}"/></div>
            </s:bind>
          </div>

          <div class="col-md-6">
            <s:bind path="status">
              <label class="form-label">Status</label>
              <sf:select class="form-select" path="${status.expression}">
                <sf:option value="" label="Select"/>
                <sf:options items="${statusMap}"/>
              </sf:select>
              <div class="form-text"><sf:errors path="${status.expression}"/></div>
            </s:bind>
          </div>
        </div>

        <div class="text-end mt-4">
          <!-- Always use the value your controller expects -->
          <input type="submit" name="operation" class="btn btn-primary" value="Save"/>
          &nbsp;
          <input type="submit" name="operation" class="btn btn-secondary" value="Reset"/>
        </div>
      </div>
    </div>
  </sf:form>
</div>

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
