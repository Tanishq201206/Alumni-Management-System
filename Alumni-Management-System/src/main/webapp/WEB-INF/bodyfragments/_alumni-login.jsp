<%@taglib uri="http://www.springframework.org/tags/form" prefix="sf"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="crt"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="s"%>

<!-- FontAwesome (for icons) -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet"/>

<!-- Custom Theme Style -->
<style>
  /* === Color Hunt palette === */
  :root{
    --red: #E43636;
    --red-700: #c62f2f;       /* hover/darker */
    --cream: #F6EFD2;         /* light surface */
    --beige: #E2DDB4;         /* accent */
    --black: #000000;         /* strong text */
    --white: #ffffff;
  }

  /* Breadcrumbs */
  .breadcrumb-item a {
    color: var(--red);
    font-weight: 600;
    text-decoration: none;
  }
  .breadcrumb-item a:hover { text-decoration: underline; }
  .breadcrumb-item.active {
    color: var(--black);
    font-weight: 600;
  }

  /* Card */
  .card {
    margin: 0 auto;
    max-width: 700px;
    border: 1px solid #e0e0e0;
    background-color: var(--cream);
  }
  .card-header {
    background-color: var(--red);
    color: var(--white);
    font-size: 20px;
    font-weight: 700;
  }

  /* Buttons */
  .btn-primary {
    background-color: var(--red);
    border-color: var(--red);
    border-radius: 8px;
    padding: 8px 16px;
    box-shadow: 0 2px 6px rgba(0,0,0,.12);
    transition: background-color .2s ease, border-color .2s ease, transform .05s ease;
  }
  .btn-primary:hover {
    background-color: var(--red-700);
    border-color: var(--red-700);
  }
  .btn-primary:active { transform: translateY(1px); }
  .btn-primary:focus { box-shadow: 0 0 0 .15rem rgba(228,54,54,.25); }

  /* Labels */
  .form-label { font-weight: 700; color: var(--black); }

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

  /* Loading state for submit button */
  .btn-loading { position: relative; opacity: 0.75; pointer-events: none; }
  .btn-loading::after {
    content: "";
    position: absolute;
    top: 50%; right: 14px;
    width: 16px; height: 16px;
    margin-top: -8px;
    border: 2px solid #fff;
    border-top-color: transparent;
    border-radius: 50%;
    animation: spin .6s linear infinite;
  }
  @keyframes spin { to { transform: rotate(360deg); } }

  /* Link next to button */
  .card a { color: var(--red); text-decoration: none; font-weight: 600; }
  .card a:hover { color: var(--red-700); text-decoration: underline; }
</style>

<br>

<div class="container">
  <div class="card shadow mb-5 bg-body rounded">
    <h5 class="card-header">Alumni Login</h5>

    <b><%@ include file="businessMessage.jsp" %></b>

    <div class="card-body">
      <sf:form role="form" action="${pageContext.request.contextPath}/alumni/login" method="post" modelAttribute="form">
        <s:bind path="email">
          <div class="mb-3">
            <label for="email" class="form-label">Email Id</label>
            <sf:input path="${status.expression}" placeholder="Enter Email Id" class="form-control" />
            <div class="form-text">
              <font color="red" style="font-size: 13px"><sf:errors path="${status.expression}"/></font>
            </div>
          </div>
        </s:bind>

        <s:bind path="password">
          <div class="mb-3">
            <label for="password" class="form-label">Password</label>
            <sf:input type="password" path="${status.expression}" placeholder="Enter Password" class="form-control" />
            <div class="form-text">
              <font color="red" style="font-size: 13px"><sf:errors path="${status.expression}"/></font>
            </div>
          </div>
        </s:bind>

        <div class="d-flex justify-content-between align-items-center">
          <input type="submit" name="operation" class="btn btn-primary" value="SignIn">
          <a href="${pageContext.request.contextPath}/alumni/forgetPassword">Forgot Password?</a>
        </div>
      </sf:form>
    </div>
  </div>
</div>
