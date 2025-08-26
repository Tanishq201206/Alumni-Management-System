<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="sf"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="s"%>

<style>
  /* ===== Color Hunt palette ===== */
  :root{
    --red:#E43636;
    --red-700:#c62f2f;
    --cream:#F6EFD2;
    --beige:#E2DDB4;
    --black:#000000;
  }

  .card{ border:1px solid #eee; border-radius:12px; overflow:hidden; }
  .card-header{
    background:var(--red) !important;
    color:#fff !important;
    font-weight:700;
    letter-spacing:.2px;
  }

  .form-label{ font-weight:600; }
  .form-control{
    border-radius:8px;
    border:1px solid #d9d9d9;
    transition:border-color .15s ease, box-shadow .15s ease;
  }
  .form-control:focus{
    border-color:var(--red);
    box-shadow:0 0 0 .15rem rgba(228,54,54,.2);
  }

  .btn-primary{
    background:var(--red);
    border-color:var(--red);
    color:#fff;
  }
  .btn-primary:hover{ background:var(--red-700); border-color:var(--red-700); }

  .avatar{
    height:120px; width:120px; object-fit:cover; border-radius:50%;
    box-shadow:0 6px 20px rgba(0,0,0,.15);
    border:3px solid #fff;
  }

  .error-text{ color:#d63939; font-size:13px; }
</style>

<br/>

<div class="container mt-3">
  <sf:form method="post" action="${pageContext.request.contextPath}/profile" modelAttribute="form">
    <div class="card shadow border-0 rounded">
      <h5 class="card-header">My Profile</h5>
      <div class="card-body">
        <b><%@ include file="businessMessage.jsp"%></b>

        <div class="text-center mb-4">
          <img src="${pageContext.request.contextPath}/resources/images/admindp.jpg"
               class="avatar"
               alt="Admin profile picture">
        </div>

        <div class="row g-3">
          <div class="col-md-6">
            <s:bind path="name">
              <label class="form-label">Name</label>
              <sf:input path="${status.expression}" class="form-control" placeholder="Enter Name"/>
              <div class="error-text"><sf:errors path="${status.expression}"/></div>
            </s:bind>
          </div>

          <div class="col-md-6">
            <s:bind path="email">
              <label class="form-label">Email</label>
              <sf:input path="${status.expression}" class="form-control" placeholder="Enter Email"/>
              <div class="error-text"><sf:errors path="${status.expression}"/></div>
            </s:bind>
          </div>

          <div class="col-md-6">
            <s:bind path="contactNo">
              <label class="form-label">Contact No</label>
              <sf:input path="${status.expression}" class="form-control" placeholder="Enter Contact No"/>
              <div class="error-text"><sf:errors path="${status.expression}"/></div>
            </s:bind>
          </div>
        </div>

        <div class="mt-4">
          <input type="submit" name="operation" class="btn btn-primary" value="Save"/>
          <input type="submit" name="operation" class="btn btn-secondary ms-2" value="Reset"/>
        </div>
      </div>
    </div>
  </sf:form>
</div>
