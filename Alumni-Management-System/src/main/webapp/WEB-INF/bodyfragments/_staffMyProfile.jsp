<%@taglib uri="http://www.springframework.org/tags/form" prefix="sf"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="crt"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="s"%>

<style>
  :root{
    --accent:#E43636;   /* red */
    --cream:#F6EFD2;    /* light background */
    --sand:#E2DDB5;     /* soft border */
    --black:#000000;    /* header */
  }

  body { background: var(--cream); }

  .card {
    border: 1px solid var(--sand);
    border-radius: 14px;
    overflow: hidden;
    box-shadow: 0 10px 26px rgba(0,0,0,.08);
    background: #fff;
  }

  .card-header {
    background: var(--accent);
    color: #fff !important;
    font-weight: 700;
    letter-spacing: .3px;
  }

  .form-label { font-weight: 600; color:#1a1a1a; }

  .form-control{
    border:1px solid var(--sand);
    border-radius:10px;
    font-size:14px;
    transition: border-color .15s ease, box-shadow .15s ease;
  }
  .form-control:focus{
    border-color: var(--accent);
    box-shadow: 0 0 0 .15rem rgba(228,54,54,.25);
  }

  .btn-accent{
    background: var(--accent);
    border-color: var(--accent);
    color:#fff;
    border-radius:10px;
    font-weight:600;
  }
  .btn-accent:hover{ background:#c82f2f; border-color:#c82f2f; }

  .btn-ghost{
    background:#fff;
    color: var(--black);
    border:1px solid var(--sand);
    border-radius:10px;
    font-weight:600;
  }
  .btn-ghost:hover{ background: var(--cream); }

  .avatar {
    height:120px; width:120px; object-fit:cover;
    border:3px solid var(--sand);
  }
</style>

<br/>

<div class="container mt-3">
  <sf:form method="post" action="${pageContext.request.contextPath}/staff/profile" modelAttribute="form">
    <div class="card shadow border-0 rounded">
      <div class="card-header">My Profile</div>

      <div class="card-body">
        <b><%@ include file="businessMessage.jsp"%></b>

        <div class="text-center mb-4">
          <img
            src="${pageContext.request.contextPath}/resources/images/staffdp.jpg"
            class="rounded-circle shadow avatar"
            alt="Profile Image">
        </div>

        <div class="row g-3">
          <div class="col-md-6">
            <s:bind path="name">
              <label class="form-label">Name</label>
              <sf:input path="${status.expression}" placeholder="Enter Name" class="form-control" />
              <small style="color:#E43636;font-size:13px;"><sf:errors path="${status.expression}" /></small>
            </s:bind>
          </div>

          <div class="col-md-6">
            <s:bind path="email">
              <label class="form-label">Email</label>
              <sf:input path="${status.expression}" placeholder="Enter Email" class="form-control" />
              <small style="color:#E43636;font-size:13px;"><sf:errors path="${status.expression}" /></small>
            </s:bind>
          </div>

          <div class="col-md-6">
            <s:bind path="contactNo">
              <label class="form-label">Contact No</label>
              <sf:input path="${status.expression}" placeholder="Enter Contact No" class="form-control" />
              <small style="color:#E43636;font-size:13px;"><sf:errors path="${status.expression}" /></small>
            </s:bind>
          </div>
        </div>

        <div class="mt-4">
          <input type="submit" name="operation" class="btn btn-accent" value="Save" />
          <input type="submit" name="operation" class="btn btn-ghost ms-2" value="Reset" />
        </div>
      </div>
    </div>
  </sf:form>
</div>
