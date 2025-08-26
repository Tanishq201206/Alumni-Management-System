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

  .card{ border-radius: 10px; overflow: hidden; background: var(--cream); border: 1px solid #e0e0e0; }
  .card-header{ background: var(--red); color: var(--white); font-weight: 700; }

  .form-label{ font-weight: 700; color: var(--black); }
  small.text-danger{ font-size: 13px; }

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
  .btn-outline-dark:hover{ background: var(--black); color: var(--white); }

  /* Avatar ring */
  .avatar{
    height:120px; width:120px; object-fit:cover;
    border-radius:50%;
    box-shadow: 0 6px 18px rgba(0,0,0,.2);
    border: 4px solid var(--red);
    background: var(--white);
  }
</style>

<br>

<div class="container">
  <sf:form method="post" action="${pageContext.request.contextPath}/alumni/profile" modelAttribute="form">
    <div class="card shadow">
      <h5 class="card-header">My Profile</h5>
      <div class="card-body">
        <b><%@ include file="businessMessage.jsp" %></b>

        <div class="text-center mb-4">
          <img src="${pageContext.request.contextPath}/resources/images/alumnidp.jpg"
               class="avatar"
               alt="Profile Image">
        </div>

        <div class="row g-3">
          <div class="col-md-6">
            <s:bind path="name">
              <label class="form-label">Name</label>
              <sf:input path="${status.expression}" placeholder="Enter Name" class="form-control" />
              <small class="text-danger"><sf:errors path="${status.expression}" /></small>
            </s:bind>
          </div>

          <div class="col-md-6">
            <s:bind path="email">
              <label class="form-label">Email</label>
              <sf:input path="${status.expression}" placeholder="Enter Email" class="form-control" />
              <small class="text-danger"><sf:errors path="${status.expression}" /></small>
            </s:bind>
          </div>

          <div class="col-md-6">
            <s:bind path="contactNo">
              <label class="form-label">Contact No</label>
              <sf:input path="${status.expression}" placeholder="Enter Contact No" class="form-control" />
              <small class="text-danger"><sf:errors path="${status.expression}" /></small>
            </s:bind>
          </div>
        </div>

        <div class="text-end mt-4">
          <input type="submit" name="operation" class="btn btn-primary-theme me-2" value="Save" />
          <input type="submit" name="operation" class="btn btn-outline-dark" value="Reset" />
        </div>
      </div>
    </div>
  </sf:form>
</div>
