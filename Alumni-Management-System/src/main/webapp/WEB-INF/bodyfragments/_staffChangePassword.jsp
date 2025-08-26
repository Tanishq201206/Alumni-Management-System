<%@taglib uri="http://www.springframework.org/tags/form" prefix="sf"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="s"%>

<style>
  /* ===== ColorHunt Palette =====
     Red:   #E43636
     Cream: #F6EFD2
     Sand:  #E2DDB4
     Black: #000000
  */
  :root{
    --cl-red:#E43636;
    --cl-cream:#F6EFD2;
    --cl-sand:#E2DDB4;
    --cl-black:#000000;
  }

  .bgcolor{ background-color: var(--cl-red) !important; }

  .card{
    border-radius: 12px;
    box-shadow: 0 6px 18px rgba(0,0,0,.12);
    overflow:hidden;
  }
  .card-header{
    font-weight: 600;
    letter-spacing: .3px;
    background: var(--cl-red);
    color:#fff;
  }

  .form-label{ font-weight: 500; }
  .form-control{
    font-size: 14px;
    border-radius: 8px;
    border: 1px solid var(--cl-sand);
    transition: border-color .15s ease, box-shadow .15s ease;
  }
  .form-control:focus{
    border-color: var(--cl-red);
    box-shadow: 0 0 0 .15rem rgba(228,54,54,.25);
  }

  .form-error{
    color:#c82323;
    font-size: 13px;
  }

  .btn-primary, .btn-save{
    background-color: var(--cl-red);
    border-color: var(--cl-red);
    border-radius: 8px;
    font-weight: 600;
    color:#fff;
  }
  .btn-primary:hover, .btn-save:hover{
    background-color:#c42e2e;
    border-color:#c42e2e;
  }

  .btn-secondary{
    border-radius:8px;
    font-weight:600;
  }

  body{ background: linear-gradient(180deg, var(--cl-cream), #fff); }
</style>

<br/>

<div class="container mt-3">
  <sf:form method="post" action="${pageContext.request.contextPath}/staff/changepassword" modelAttribute="form">
    <sf:hidden path="id" />
    <div class="card shadow border-0 rounded">
      <div class="card-header">Change Password</div>
      <div class="card-body">

        <%-- Display any business message --%>
        <b><%@ include file="businessMessage.jsp" %></b>

        <div class="row g-3">
          <div class="col-md-6">
            <s:bind path="oldPassword">
              <label class="form-label">Old Password</label>
              <sf:input type="password" path="${status.expression}" class="form-control" placeholder="Enter Old Password"/>
              <div class="form-error"><sf:errors path="${status.expression}" /></div>
            </s:bind>
          </div>

          <div class="col-md-6">
            <s:bind path="newPassword">
              <label class="form-label">New Password</label>
              <sf:input type="password" path="${status.expression}" class="form-control" placeholder="Enter New Password"/>
              <div class="form-error"><sf:errors path="${status.expression}" /></div>
            </s:bind>
          </div>

          <div class="col-md-6">
            <s:bind path="confirmPassword">
              <label class="form-label">Confirm Password</label>
              <sf:input type="password" path="${status.expression}" class="form-control" placeholder="Enter Confirm Password"/>
              <div class="form-error"><sf:errors path="${status.expression}" /></div>
            </s:bind>
          </div>
        </div>

        <div class="mt-4">
          <input type="submit" name="operation" class="btn btn-save" value="Save"/>
          <input type="submit" name="operation" class="btn btn-secondary ms-2" value="Reset"/>
        </div>
      </div>
    </div>
  </sf:form>
</div>
