<%@taglib uri="http://www.springframework.org/tags/form" prefix="sf"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="crt"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="s"%>

<!-- Animate.css for fade animations -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>

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

  body{ background: linear-gradient(180deg, var(--cl-cream), #ffffff); }

  .bgcolor{ background-color: var(--cl-red) !important; }

  .card{
    width: 700px;
    margin: auto;
    border-radius: 12px;
    box-shadow: 0 6px 18px rgba(0,0,0,.12);
    overflow: hidden;
    border: 1px solid var(--cl-sand);
  }

  .card-header{
    background: var(--cl-red);
    color: #fff;
    font-weight: 600;
    letter-spacing: .3px;
  }

  .alert{
    margin: 20px auto;
    width: 700px;
    border-radius: 10px;
    border: 1px solid var(--cl-sand);
  }

  .form-label{ font-weight: 600; }

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

  .form-text{
    font-size: 13px;
    color: #b02a2a; /* readable error text on cream */
  }

  .btn-primary{
    background-color: var(--cl-red);
    border-color: var(--cl-red);
    border-radius: 8px;
    font-weight: 600;
    color:#fff;
  }
  .btn-primary:hover{
    background-color:#c42e2e;
    border-color:#c42e2e;
  }
</style>

<br/>

<!-- Animated Alert for Success/Error -->
<c:if test="${not empty success}">
  <div id="alertBox" class="alert alert-success animate__animated animate__fadeInDown" role="alert"
       style="background:#e9f7ef; color:#125c2a;">
    ✅ ${success}
  </div>
</c:if>
<c:if test="${not empty error}">
  <div id="alertBox" class="alert alert-danger animate__animated animate__fadeInDown" role="alert"
       style="background:#fdecea; color:#a12020;">
    ❌ ${error}
  </div>
</c:if>

<div class="container">
  <div class="card shadow mb-5 bg-body rounded">
    <h5 class="card-header">Forget Password</h5>

    <div class="card-body">
      <sf:form role="form"
               action="${pageContext.request.contextPath}/staff/forgetPassword"
               method="post" modelAttribute="form">

        <s:bind path="email">
          <div class="mb-3">
            <label for="exampleInputEmail1" class="form-label">Email Address</label>
            <sf:input path="${status.expression}" placeholder="Enter your email address" class="form-control" />
            <div class="form-text">
              <sf:errors path="${status.expression}"/>
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

<!-- JavaScript: Animate alert fade out -->
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
