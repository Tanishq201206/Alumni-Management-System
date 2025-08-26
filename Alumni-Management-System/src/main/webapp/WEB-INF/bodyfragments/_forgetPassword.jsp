<%@taglib uri="http://www.springframework.org/tags/form" prefix="sf"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="crt"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="s"%>

<style>
  /* === Color Hunt palette === */
  :root{
    --red: #E43636;
    --red-700: #c62f2f;     /* hover/darker */
    --cream: #F6EFD2;       /* light surface */
    --beige: #E2DDB4;       /* subtle accents */
    --black: #000000;       /* strong text */
    --white: #ffffff;
  }

  .form-container { max-width: 600px; margin: auto; }

  .card{
    background: var(--cream);
    border: 1px solid #e0e0e0 !important;
    border-radius: 12px !important;
    overflow: hidden;
  }
  .card-header.bgcolor{
    background-color: var(--red) !important;
    color: var(--white) !important;
    font-weight: 700;
  }

  .form-label{ font-weight: 700; color: var(--black); }
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

  /* Buttons */
  .btn-primary{
    background-color: var(--red);
    border-color: var(--red);
    color: var(--white);
    border-radius: 8px;
    padding: 8px 16px;
    font-weight: 700;
    box-shadow: 0 2px 6px rgba(0,0,0,.12);
    transition: background-color .2s ease, border-color .2s ease, transform .05s ease;
  }
  .btn-primary:hover{ background-color: var(--red-700); border-color: var(--red-700); }
  .btn-primary:active{ transform: translateY(1px); }
  .btn-primary:focus{ box-shadow: 0 0 0 .15rem rgba(228,54,54,.25); }

  .breadcrumb-item a { text-decoration: none; }
</style>

<br>

<div class="container form-container">
  <div class="card shadow mb-5 bg-body rounded">
    <h5 class="card-header bgcolor text-white">Forgot Password</h5>

    <%@ include file="businessMessage.jsp" %>

    <div class="card-body">
      <sf:form role="form" action="${pageContext.request.contextPath}/forgetPassword" method="post" modelAttribute="form">
        <s:bind path="email">
          <div class="mb-3">
            <label for="exampleInputEmail1" class="form-label">Email Address</label>
            <sf:input id="exampleInputEmail1" path="${status.expression}" placeholder="Enter your email address" class="form-control" />
            <div class="form-text" style="font-size:13px; color: var(--red);">
              <sf:errors path="${status.expression}" />
            </div>
          </div>
        </s:bind>

        <div class="text-end">
          <input type="submit" name="operation" class="btn btn-primary" value="Send Reset Link" />
        </div>
      </sf:form>
    </div>
  </div>
</div>
