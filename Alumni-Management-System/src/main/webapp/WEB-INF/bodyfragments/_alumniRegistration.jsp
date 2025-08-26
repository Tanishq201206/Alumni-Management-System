<%@taglib uri="http://www.springframework.org/tags/form" prefix="sf"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="crt"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="s"%>

<!-- Custom Styles (Color Hunt palette) -->
<style>
  :root{
    --red: #E43636;
    --red-700: #c62f2f;     /* hover/darker */
    --cream: #F6EFD2;       /* light surface */
    --beige: #E2DDB4;       /* subtle accent */
    --black: #000000;       /* strong text */
    --white: #ffffff;
  }

  /* Card */
  .card {
    border-radius: 10px;
    overflow: hidden;
    border: 1px solid #e0e0e0;
    background-color: var(--cream);
  }

  .card-header {
    background-color: var(--red);
    color: var(--white);
    font-weight: 700;
    font-size: 20px;
  }

  /* Labels & helpers */
  .form-label { font-weight: 600; color: var(--black); }
  .form-text { font-size: 13px; color: var(--red); }

  /* Inputs & selects */
  .form-control {
    border-radius: 8px;
    border: 1px solid #cfcfcf;
    background-color: var(--white);
    transition: border-color .2s ease, box-shadow .2s ease;
  }
  .form-control:focus, .form-select:focus {
    border-color: var(--red);
    box-shadow: 0 0 0 .15rem rgba(228,54,54,.25);
  }
  .form-select, .form-control { /* ensure consistent rounding for selects too */
    border-radius: 8px;
  }

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
  .btn-primary:hover { background-color: var(--red-700); border-color: var(--red-700); }
  .btn-primary:active { transform: translateY(1px); }
  .btn-primary:focus  { box-shadow: 0 0 0 .15rem rgba(228,54,54,.25); }

  .btn-secondary {
    background-color: var(--black);
    border-color: var(--black);
    color: var(--white);
    font-weight: 600;
    border-radius: 8px;
    padding: 8px 16px;
    transition: background-color .2s ease, border-color .2s ease, transform .05s ease;
  }
  .btn-secondary:hover { background-color: #1a1a1a; border-color: #1a1a1a; }
  .btn-secondary:active { transform: translateY(1px); }
  .btn-secondary:focus  { box-shadow: 0 0 0 .15rem rgba(0,0,0,.2); }

  /* Spacing tweaks */
  .g-3 > [class*="col-"] { margin-top: .25rem; }
</style>

<br>

<div class="container">
  <sf:form method="post"
           action="${pageContext.request.contextPath}/alumni/al-signUp"
           modelAttribute="form">
    <div class="card shadow mb-5">
      <h5 class="card-header">User Registration</h5>
      <div class="card-body">
        <b><%@ include file="businessMessage.jsp" %></b>

        <div class="row g-3">

          <div class="col-md-6">
            <s:bind path="name">
              <label class="form-label">Name</label>
              <sf:input path="${status.expression}" class="form-control" placeholder="Enter Full Name" />
              <div class="form-text"><sf:errors path="${status.expression}" /></div>
            </s:bind>
          </div>

          <div class="col-md-6">
            <s:bind path="email">
              <label class="form-label">Email</label>
              <sf:input path="${status.expression}" class="form-control" placeholder="Enter Email" />
              <div class="form-text"><sf:errors path="${status.expression}" /></div>
            </s:bind>
          </div>

          <div class="col-md-6">
            <s:bind path="contactNo">
              <label class="form-label">Contact No</label>
              <sf:input path="${status.expression}" class="form-control" placeholder="Enter Contact Number" />
              <div class="form-text"><sf:errors path="${status.expression}" /></div>
            </s:bind>
          </div>

          <div class="col-md-6">
            <s:bind path="dob">
              <label class="form-label">Date of Birth</label>
              <sf:input path="${status.expression}" class="form-control" placeholder="DD-MM-YYYY" />
              <div class="form-text"><sf:errors path="${status.expression}" /></div>
            </s:bind>
          </div>

          <div class="col-md-6">
            <s:bind path="gender">
              <label class="form-label">Gender</label>
              <sf:select class="form-select" path="${status.expression}">
                <sf:option value="" label="Select" />
                <sf:options items="${gender}" />
              </sf:select>
              <div class="form-text"><sf:errors path="${status.expression}" /></div>
            </s:bind>
          </div>

          <div class="col-md-6">
            <s:bind path="courseName">
              <label class="form-label">Course Name</label>
              <sf:input path="${status.expression}" class="form-control" placeholder="Enter Course Name" />
              <div class="form-text"><sf:errors path="${status.expression}" /></div>
            </s:bind>
          </div>

          <div class="col-md-6">
            <s:bind path="occupation">
              <label class="form-label">Occupation</label>
              <sf:input path="${status.expression}" class="form-control" placeholder="Enter Occupation" />
              <div class="form-text"><sf:errors path="${status.expression}" /></div>
            </s:bind>
          </div>

          <div class="col-md-6">
            <s:bind path="address">
              <label class="form-label">Address</label>
              <sf:textarea path="${status.expression}" class="form-control" rows="3" placeholder="Enter Address" />
              <div class="form-text"><sf:errors path="${status.expression}" /></div>
            </s:bind>
          </div>

          <div class="col-md-6">
            <s:bind path="region">
              <label class="form-label">Region</label>
              <sf:input path="${status.expression}" class="form-control" placeholder="Enter Region" />
              <div class="form-text"><sf:errors path="${status.expression}" /></div>
            </s:bind>
          </div>

          <div class="col-md-6">
            <s:bind path="message">
              <label class="form-label">Message</label>
              <sf:textarea path="${status.expression}" class="form-control" rows="3" placeholder="Any message (optional)" />
              <div class="form-text"><sf:errors path="${status.expression}" /></div>
            </s:bind>
          </div>

          <div class="col-md-6">
            <s:bind path="password">
              <label class="form-label">Password</label>
              <sf:input type="password" path="${status.expression}" class="form-control" placeholder="Enter Password" />
              <div class="form-text"><sf:errors path="${status.expression}" /></div>
            </s:bind>
          </div>

          <div class="col-md-6">
            <s:bind path="confirmPassword">
              <label class="form-label">Confirm Password</label>
              <sf:input type="password" path="${status.expression}" class="form-control" placeholder="Re-enter Password" />
              <div class="form-text"><sf:errors path="${status.expression}" /></div>
            </s:bind>
          </div>

          <div class="col-12 text-end mt-3">
            <input type="submit" name="operation" value="Save" class="btn btn-primary me-2" />
            <input type="submit" name="operation" value="Reset" class="btn btn-secondary" />
          </div>

        </div>
      </div>
    </div>
  </sf:form>
</div>
