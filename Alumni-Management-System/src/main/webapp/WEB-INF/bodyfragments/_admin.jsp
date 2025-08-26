<%@taglib uri="http://www.springframework.org/tags/form" prefix="sf"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="crt"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="s"%>

<!-- Animate.css for fade effects -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>

<style>
  /* === Color Hunt palette === */
  :root{
    --red: #E43636;
    --red-700: #c62f2f;      /* hover/darker red */
    --cream: #F6EFD2;        /* light surface */
    --beige: #E2DDB4;        /* subtle accent lines */
    --black: #000000;        /* strong text */
    --white: #ffffff;
  }

  /* Replaces old .bgcolor green with theme red */
  .bgcolor { background-color: var(--red) !important; }

  .form-label { font-weight: 700; color: var(--black); }

  .btn-primary {
    background-color: var(--red);
    border-color: var(--red);
    font-weight: 700;
    border-radius: 8px;
    padding: 8px 16px;
    box-shadow: 0 2px 6px rgba(0,0,0,.12);
    transition: background-color .2s ease, border-color .2s ease, transform .05s ease;
  }
  .btn-primary:hover  { background-color: var(--red-700); border-color: var(--red-700); }
  .btn-primary:active { transform: translateY(1px); }
  .btn-primary:focus  { box-shadow: 0 0 0 .15rem rgba(228,54,54,.25); }

  .btn-secondary {
    background-color: var(--black);
    border-color: var(--black);
    color: var(--white);
    border-radius: 8px;
    padding: 8px 16px;
    font-weight: 700;
    transition: background-color .2s ease, border-color .2s ease, transform .05s ease;
  }
  .btn-secondary:hover  { background-color: #1a1a1a; border-color: #1a1a1a; }
  .btn-secondary:active { transform: translateY(1px); }

  .form-text { font-size: 13px; color: var(--red); }

  .card { max-width: 800px; margin: auto; background-color: var(--cream); border: 1px solid #e0e0e0; }
  .card-header { color: var(--white); }

  .alert { margin: 20px auto; width: 800px; border-radius: 10px; }
  .alert-success { background-color: #eaf6ea; border-color: #cbe8cf; color: #1f7a3e; }
  .alert-danger  { background-color: #fdeceb; border-color: #f6c9c6; color: #9b1c1c; }

  .form-section { margin-bottom: 20px; }

  /* Inputs */
  .form-control {
    border-radius: 8px;
    border: 1px solid #cfcfcf;
    background-color: var(--white);
    transition: border-color .2s ease, box-shadow .2s ease;
  }
  .form-control:focus {
    border-color: var(--red);
    box-shadow: 0 0 0 .15rem rgba(228,54,54,.25);
  }
</style>

<br>

<!-- Animated Success/Error Message -->
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
           action="${pageContext.request.contextPath}/ctl/admin"
           modelAttribute="form">
    <div class="card shadow mb-5 bg-body rounded">
      <h5 class="card-header bgcolor text-white">Add Admin</h5>
      <div class="card-body">
        <%@ include file="businessMessage.jsp"%>

        <div class="row g-3">
          <div class="col-md-6">
            <s:bind path="name">
              <label class="form-label">Name</label>
              <sf:input path="${status.expression}" placeholder="Enter First Name" class="form-control"/>
              <div class="form-text"><sf:errors path="${status.expression}"/></div>
            </s:bind>
          </div>

          <div class="col-md-6">
            <s:bind path="email">
              <label class="form-label">Email</label>
              <sf:input path="${status.expression}" placeholder="Enter Email" class="form-control"/>
              <div class="form-text"><sf:errors path="${status.expression}"/></div>
            </s:bind>
          </div>

          <div class="col-md-6">
            <s:bind path="password">
              <label class="form-label">Password</label>
              <sf:input type="password" path="${status.expression}" placeholder="Enter Password" class="form-control"/>
              <div class="form-text"><sf:errors path="${status.expression}"/></div>
            </s:bind>
          </div>

          <div class="col-md-6">
            <s:bind path="confirmPassword">
              <label class="form-label">Confirm Password</label>
              <sf:input type="password" path="${status.expression}" placeholder="Enter Confirm Password" class="form-control"/>
              <div class="form-text"><sf:errors path="${status.expression}"/></div>
            </s:bind>
          </div>

          <div class="col-md-6">
            <s:bind path="contactNo">
              <label class="form-label">Contact No</label>
              <sf:input path="${status.expression}" placeholder="Enter Contact No" class="form-control"/>
              <div class="form-text"><sf:errors path="${status.expression}"/></div>
            </s:bind>
          </div>
        </div>

        <div class="text-end mt-4">
          <input type="submit" name="operation" class="btn btn-primary" value="Save"/>
          &nbsp;
          <input type="submit" name="operation" class="btn btn-secondary" value="Reset"/>
        </div>
      </div>
    </div>
  </sf:form>
</div>

<!-- JS to auto-hide alert -->
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
