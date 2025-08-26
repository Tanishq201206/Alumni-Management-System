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
    --red-700: #c62f2f;       /* hover/darker red */
    --cream: #F6EFD2;         /* light surface */
    --beige: #E2DDB4;         /* accents */
    --black: #000000;         /* strong text */
    --white: #ffffff;
  }

  /* Header bar color (replaces old green) */
  .bgcolor { background-color: var(--red) !important; }

  /* Layout */
  .card { width: 700px; margin: auto; background: var(--cream); border: 1px solid #e0e0e0; border-radius: 10px; overflow: hidden; }
  .card-header { color: var(--white); font-weight: 700; }

  .alert { margin: 20px auto; width: 700px; border-radius: 10px; }
  .alert-success { background-color: #eaf6ea; border-color: #cbe8cf; color: #1f7a3e; }
  .alert-danger  { background-color: #fdeceb; border-color: #f6c9c6; color: #9b1c1c; }

  .form-label { font-weight: 700; color: var(--black); }
  .form-text  { font-size: 13px; color: var(--red); }

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
  .btn-primary:focus { box-shadow: 0 0 0 .15rem rgba(228,54,54,.25); }
</style>

<br>

<!-- Animated Success/Error Alert -->
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
  <div class="card shadow mb-5 bg-body rounded">
    <h5 class="card-header bgcolor text-white">Forget Password</h5>

    <div class="card-body">
      <sf:form role="form"
               action="${pageContext.request.contextPath}/alumni/forgetPassword"
               method="post" modelAttribute="form">

        <s:bind path="email">
          <div class="mb-3">
            <label for="exampleInputEmail1" class="form-label">Email Id</label>
            <sf:input path="${status.expression}" placeholder="Enter Email Id" class="form-control" />
            <div class="form-text">
              <sf:errors path="${status.expression}"/>
            </div>
          </div>
        </s:bind>

        <div class="text-end">
          <input type="submit" name="operation" class="btn btn-primary" value="Go" />
        </div>

      </sf:form>
    </div>
  </div>
</div>

<!-- JS: Animate alert fade out -->
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
