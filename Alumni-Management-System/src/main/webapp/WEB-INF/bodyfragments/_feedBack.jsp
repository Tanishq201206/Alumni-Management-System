<%@taglib uri="http://www.springframework.org/tags/form" prefix="sf"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="crt"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="s"%>

<style>
  /* === Color Hunt palette === */
  :root{
    --red: #E43636;
    --red-700: #c62f2f;      /* hover/darker */
    --cream: #F6EFD2;        /* light surface */
    --beige: #E2DDB4;        /* subtle accents */
    --black: #000000;        /* strong text */
    --white: #ffffff;
  }

  .card{
    background: var(--cream);
    border: 1px solid #e0e0e0 !important;
    border-radius: 12px !important;
    overflow: hidden;
  }
  .card-header{
    background: var(--red) !important;
    color: var(--white) !important;
    font-weight: 700;
  }

  .form-label{ font-weight: 700; color: var(--black); }
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

  .form-error{ color: var(--red); font-size: 13px; }

  /* Buttons */
  .btn-primary-theme{
    background: var(--red);
    border-color: var(--red);
    color: var(--white);
    border-radius: 8px;
    padding: 8px 16px;
    font-weight: 700;
    box-shadow: 0 2px 6px rgba(0,0,0,.12);
    transition: background-color .2s ease, border-color .2s ease, transform .05s ease;
  }
  .btn-primary-theme:hover{ background: var(--red-700); border-color: var(--red-700); }
  .btn-primary-theme:active{ transform: translateY(1px); }
  .btn-primary-theme:focus{ box-shadow: 0 0 0 .15rem rgba(228,54,54,.25); }

  .btn-secondary{
    border-radius: 8px;
    padding: 8px 16px;
    font-weight: 700;
  }

  /* Optional: helper text style */
  .hint{ font-size: 12px; color:#555; margin-top: 4px; }
</style>

<div class="container mt-3">
  <sf:form method="post" action="${pageContext.request.contextPath}/ctl/feedBack" modelAttribute="form">
    <div class="card shadow border-0 rounded">
      <h5 class="card-header">Feedback</h5>
      <div class="card-body">
        <b><%@ include file="businessMessage.jsp"%></b>

        <div class="col-md-8 mb-3">
          <s:bind path="feedBack">
            <label class="form-label">Your Feedback</label>
            <sf:textarea path="${status.expression}" rows="5" class="form-control" placeholder="Share your thoughts or suggestions..." />
            <div class="hint">Be as specific as you like this helps us improve.</div>
            <div class="form-error"><sf:errors path="${status.expression}" /></div>
          </s:bind>
        </div>

        <div class="mt-3">
          <input type="submit" name="operation" class="btn btn-primary-theme" value="Save" />
          <input type="submit" name="operation" class="btn btn-secondary ms-2" value="Reset" />
        </div>
      </div>
    </div>
  </sf:form>
</div>
