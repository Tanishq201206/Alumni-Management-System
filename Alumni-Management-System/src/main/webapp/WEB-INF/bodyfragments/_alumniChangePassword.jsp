<%@taglib uri="http://www.springframework.org/tags/form" prefix="sf"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="crt"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="s"%>

<style>
  /* === Color Hunt palette === */
  :root{
    --red: #E43636;
    --red-700: #c62f2f;     /* hover */
    --cream: #F6EFD2;       /* light surface */
    --beige: #E2DDB4;       /* subtle accents */
    --black: #000000;       /* text / outline */
    --white: #ffffff;
  }

  .card { border-radius: 10px; overflow: hidden; background: var(--cream); border: 1px solid #e0e0e0; }
  .card-header { background: var(--red); font-weight: 700; }
  .card-header.text-white { color: var(--white) !important; }

  .form-label { font-weight: 700; color: var(--black); }

  .form-control{
    border-radius: 8px;
    border: 1px solid #cfcfcf;
    background: var(--white);
    transition: border-color .2s ease, box-shadow .2s ease;
  }
  .form-control:focus{
    border-color: var(--red);
    box-shadow: 0 0 0 .15rem rgba(228,54,54,.25);
  }

  small.text-danger{ font-size: 13px; }

  .btn-primary-theme{
    background: var(--red);
    color: var(--white);
    border-color: var(--red);
    border-radius: 8px;
    padding: 8px 16px;
    font-weight: 700;
    box-shadow: 0 2px 6px rgba(0,0,0,.12);
    transition: background-color .2s ease, border-color .2s ease, transform .05s ease;
  }
  .btn-primary-theme:hover{ background: var(--red-700); border-color: var(--red-700); }
  .btn-primary-theme:active{ transform: translateY(1px); }
  .btn-primary-theme:focus{ box-shadow: 0 0 0 .15rem rgba(228,54,54,.25); }

  .btn-outline-dark{
    color: var(--black);
    border-color: var(--black);
    border-radius: 8px;
    padding: 8px 16px;
    font-weight: 700;
    background: transparent;
    transition: background-color .2s ease, color .2s ease;
  }
  .btn-outline-dark:hover{
    background: var(--black);
    color: var(--white);
  }
</style>

<br>

<div class="container">
  <sf:form method="post" action="${pageContext.request.contextPath}/alumni/changepassword" modelAttribute="form">
    <sf:hidden path="id"/>
    <div class="card shadow">
      <h5 class="card-header text-white">Change Password</h5>
      <div class="card-body">
        <b><%@ include file="businessMessage.jsp" %></b>

        <div class="row g-3">
          <div class="col-md-6">
            <s:bind path="oldPassword">
              <label class="form-label">Old Password</label>
              <sf:input type="password" path="${status.expression}" placeholder="Enter Old Password" class="form-control" />
              <small class="text-danger"><sf:errors path="${status.expression}" /></small>
            </s:bind>
          </div>

          <div class="col-md-6">
            <s:bind path="newPassword">
              <label class="form-label">New Password</label>
              <sf:input type="password" path="${status.expression}" placeholder="Enter New Password" class="form-control" />
              <small class="text-danger"><sf:errors path="${status.expression}" /></small>
            </s:bind>
          </div>

          <div class="col-md-6">
            <s:bind path="confirmPassword">
              <label class="form-label">Confirm Password</label>
              <sf:input type="password" path="${status.expression}" placeholder="Enter Confirm Password" class="form-control" />
              <small class="text-danger"><sf:errors path="${status.expression}" /></small>
            </s:bind>
          </div>
        </div>

       

        <div class="text-end">
          <input type="submit" name="operation" class="btn btn-primary-theme me-2" value="Save" />
          <input type="submit" name="operation" class="btn btn-outline-dark" value="Reset" />
        </div>
      </div>
    </div>
  </sf:form>
</div>
