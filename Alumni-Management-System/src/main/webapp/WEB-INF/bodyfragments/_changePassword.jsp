<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="sf"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="crt"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="s"%>
<%@ page isELIgnored="false" %>

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

  .card-custom{
    border-radius: 20px;
    padding: 30px;
    background-color: var(--cream);
    box-shadow: 0 5px 15px rgba(0,0,0,0.2);
    margin: 40px 0;
    border: 1px solid #e0e0e0;
    overflow: hidden;
  }

  .card-custom .card-header{
    background-color: var(--red);
    color: var(--white);
    font-size: 20px;
    font-weight: 700;
    text-align: center;
    border-top-left-radius: 20px;
    border-top-right-radius: 20px;
  }

  .form-section{ max-width: 600px; margin: 0 auto; }

  .form-label{
    margin-top: 15px;
    font-weight: 700;
    color: var(--black);
  }

  .form-error{
    color: var(--red);
    font-size: 13px;
  }

  .form-control{
    border-radius: 10px;
    border: 1px solid #cfcfcf;
    background: var(--white);
    transition: border-color .2s ease, box-shadow .2s ease;
  }
  .form-control:focus{
    border-color: var(--red);
    box-shadow: 0 0 0 .15rem rgba(228,54,54,.25);
  }

  .btn-red{
    background-color: var(--red);
    color: var(--white);
    border-color: var(--red);
    border-radius: 10px;
    padding: 8px 16px;
    font-weight: 700;
    box-shadow: 0 2px 6px rgba(0,0,0,.12);
    transition: background-color .2s ease, border-color .2s ease, transform .05s ease;
  }
  .btn-red:hover{ background-color: var(--red-700); border-color: var(--red-700); }
  .btn-red:active{ transform: translateY(1px); }
  .btn-red:focus{ box-shadow: 0 0 0 .15rem rgba(228,54,54,.25); }

  .btn-secondary{
    border-radius: 10px;
    padding: 8px 16px;
    font-weight: 700;
  }
</style>

<div class="container">
  <sf:form method="post" action="${pageContext.request.contextPath}/changepassword" modelAttribute="form">
    <sf:hidden path="id"/>

    <div class="card card-custom">
      <h5 class="card-header">Change Password</h5>
      <div class="card-body form-section">
        <b><%@ include file="businessMessage.jsp"%></b>

        <s:bind path="oldPassword">
          <label class="form-label">Old Password</label>
          <sf:input type="password" path="${status.expression}" placeholder="Enter Old Password" class="form-control" />
          <div class="form-error"><sf:errors path="${status.expression}" /></div>
        </s:bind>

        <s:bind path="newPassword">
          <label class="form-label">New Password</label>
          <sf:input type="password" path="${status.expression}" placeholder="Enter New Password" class="form-control" />
          <div class="form-error"><sf:errors path="${status.expression}" /></div>
        </s:bind>

        <s:bind path="confirmPassword">
          <label class="form-label">Confirm Password</label>
          <sf:input type="password" path="${status.expression}" placeholder="Enter Confirm Password" class="form-control" />
          <div class="form-error"><sf:errors path="${status.expression}" /></div>
        </s:bind>

        <div class="mt-4 text-center">
          <input type="submit" name="operation" class="btn btn-red me-2" value="Save" />
          <input type="submit" name="operation" class="btn btn-secondary" value="Reset" />
        </div>
      </div>
    </div>
  </sf:form>
</div>
