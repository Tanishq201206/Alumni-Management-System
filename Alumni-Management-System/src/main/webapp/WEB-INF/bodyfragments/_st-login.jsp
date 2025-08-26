<%@taglib uri="http://www.springframework.org/tags/form" prefix="sf"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="crt"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="s"%>

<!-- Font Awesome for icons (breadcrumb) -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet"/>

<!-- Modern Theme Styling (Color Hunt) -->
<style>
  :root{
    --red: #E43636;
    --red-700: #c62f2f;      /* hover/darker */
    --cream: #F6EFD2;        /* light surface */
    --beige: #E2DDB4;        /* accent */
    --black: #000000;        /* strong text */
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
    max-width: 700px;
    margin: auto;
    border-radius: 10px;
    overflow: hidden;
    border: 1px solid #e0e0e0;
    background-color: var(--cream);
  }
  .card-header {
    background-color: var(--red);
    color: var(--white);
    font-size: 22px;
    font-weight: 700;
  }

  /* Labels & Inputs */
  .form-label { font-weight: 600; color: var(--black); }
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
  .form-text { font-size: 13px; }

  /* Links */
  a { color: var(--red); text-decoration: none; font-weight: 600; }
  a:hover { color: var(--red-700); text-decoration: underline; }

  /* Buttons */
  .btn-primary {
    background-color: var(--red);
    border-color: var(--red);
    font-weight: 600;
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
  .btn-primary:focus  { box-shadow: 0 0 0 .15rem rgba(228,54,54,.25); }

  /* Loading state for submit button */
  .btn-loading { position: relative; opacity: 0.7; pointer-events: none; }
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
</style>

<br>

<!-- Login Card -->
<div class="container">
  <div class="card shadow mb-5 bg-body rounded">
    <h5 class="card-header">Staff Login</h5>

    <b><%@ include file="businessMessage.jsp" %></b>

    <div class="card-body">
      <sf:form role="form" action="${pageContext.request.contextPath}/staff/login" method="post" modelAttribute="form">
        
        <!-- Email Field -->
        <s:bind path="email">
          <div class="mb-3">
            <label for="email" class="form-label">Email Id</label>
            <sf:input path="${status.expression}" placeholder="Enter Email Id" class="form-control" />
            <div class="form-text text-danger"><sf:errors path="${status.expression}" /></div>
          </div>
        </s:bind>

        <!-- Password Field -->
        <s:bind path="password">
          <div class="mb-3">
            <label for="password" class="form-label">Password</label>
            <sf:input type="password" path="${status.expression}" placeholder="Enter Password" class="form-control" />
            <div class="form-text text-danger"><sf:errors path="${status.expression}" /></div>
          </div>
        </s:bind>

        <!-- Submit & Forgot Password -->
        <div class="d-flex justify-content-between align-items-center">
          <input type="submit" name="operation" class="btn btn-primary" value="SignIn" />
          <a href="${pageContext.request.contextPath}/staff/forgetPassword">Forgot Password?</a>
        </div>

      </sf:form>
    </div>
  </div>
</div>
