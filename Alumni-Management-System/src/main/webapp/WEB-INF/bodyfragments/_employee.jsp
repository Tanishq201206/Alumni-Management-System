<%@taglib uri="http://www.springframework.org/tags/form" prefix="sf"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="crt"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="s"%>
<br>

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

  .bgcolor { background: var(--red) !important; }

  .card{
    border: 1px solid #e0e0e0;
    border-radius: 12px;
    overflow: hidden;
    background: var(--cream);
  }
  .card-header{
    color: var(--white);
    font-weight: 700;
  }

  .form-label{ font-weight: 700; color: var(--black); }
  .form-control, .form-select{
    border-radius: 8px;
    border: 1px solid #cfcfcf;
    background: var(--white);
    transition: border-color .2s ease, box-shadow .2s ease;
  }
  .form-control:focus, .form-select:focus{
    border-color: var(--red);
    box-shadow: 0 0 0 .15rem rgba(228,54,54,.25);
  }

  .form-error{ color: var(--red); font-size: 13px; }

  /* Buttons */
  .btn-theme{
    background: var(--red);
    border-color: var(--red);
    color: var(--white);
    border-radius: 8px;
    padding: 8px 16px;
    font-weight: 700;
    box-shadow: 0 2px 6px rgba(0,0,0,.12);
    transition: background-color .2s ease, border-color .2s ease, transform .05s ease;
  }
  .btn-theme:hover{ background: var(--red-700); border-color: var(--red-700); }
  .btn-theme:active{ transform: translateY(1px); }
  .btn-secondary{
    border-radius: 8px;
    padding: 8px 16px;
    font-weight: 700;
  }

  /* Layout niceties */
  .card-body > .col-md-8{ margin-bottom: 14px; }
</style>

<div class="container">
  <sf:form method="post"
           action="${pageContext.request.contextPath}/ctl/employee"
           modelAttribute="form" enctype="multipart/form-data">
    <div class="card">
      <h5 class="card-header bgcolor" style="color: white;">Add Employee</h5>
      <div class="card-body">
        <b><%@ include file="businessMessage.jsp"%></b>

        <div class="col-md-8">
          <div class="row">
            <div class="col-6">
              <s:bind path="firstName">
                <label class="form-label">First Name</label>
                <sf:input path="${status.expression}" placeholder="Enter First Name" class="form-control" />
                <div class="form-error"><sf:errors path="${status.expression}" /></div>
              </s:bind>
            </div>

            <div class="col-6">
              <s:bind path="lastName">
                <label class="form-label">Last Name</label>
                <sf:input path="${status.expression}" placeholder="Enter last Name" class="form-control" />
                <div class="form-error"><sf:errors path="${status.expression}" /></div>
              </s:bind>
            </div>
          </div>
        </div>

        <div class="col-md-8">
          <div class="row">
            <div class="col-6">
              <s:bind path="fatherName">
                <label class="form-label">Father Name</label>
                <sf:input path="${status.expression}" placeholder="Enter Father Name" class="form-control" />
                <div class="form-error"><sf:errors path="${status.expression}" /></div>
              </s:bind>
            </div>

            <div class="col-6">
              <s:bind path="emailId">
                <label class="form-label">Email Id</label>
                <sf:input path="${status.expression}" placeholder="Enter Email Id" class="form-control" />
                <div class="form-error"><sf:errors path="${status.expression}" /></div>
              </s:bind>
            </div>
          </div>
        </div>

        <div class="col-md-8">
          <div class="row">
            <div class="col-6">
              <s:bind path="mobielNo">
                <label class="form-label">Mobile No</label>
                <sf:input path="${status.expression}" placeholder="Enter Mobile No" class="form-control" />
                <div class="form-error"><sf:errors path="${status.expression}" /></div>
              </s:bind>
            </div>

            <div class="col-6">
              <s:bind path="dob">
                <label class="form-label">Date Of Birth</label>
                <sf:input path="${status.expression}" id="datepicker" placeholder="Enter DOB" class="form-control" />
                <div class="form-error"><sf:errors path="${status.expression}" /></div>
              </s:bind>
            </div>
          </div>
        </div>

        <div class="col-md-8">
          <div class="row">
            <div class="col-6">
              <s:bind path="roleId">
                <label class="form-label">Company Profile</label>
                <sf:select class="form-control" path="${status.expression}">
                  <sf:option value="-1" label="Select" />
                  <sf:options itemLabel="name" itemValue="id" items="${roleList}" />
                </sf:select>
                <div class="form-error"><sf:errors path="${status.expression}" /></div>
              </s:bind>
            </div>

            <div class="col-6">
              <s:bind path="joiningDate">
                <label class="form-label">Joining Date</label>
                <sf:input path="${status.expression}" id="datepicker1" placeholder="Enter Joining Date" class="form-control" />
                <div class="form-error"><sf:errors path="${status.expression}" /></div>
              </s:bind>
            </div>
          </div>
        </div>

        <div class="col-md-8">
          <div class="row">
            <div class="col-6">
              <s:bind path="technology">
                <label class="form-label">Technology</label>
                <sf:input path="${status.expression}" placeholder="Enter Technology" class="form-control" />
                <div class="form-error"><sf:errors path="${status.expression}" /></div>
              </s:bind>
            </div>

            <div class="col-6">
              <s:bind path="exprience">
                <label class="form-label">Experience</label>
                <sf:input path="${status.expression}" placeholder="Enter Experience" class="form-control" />
                <div class="form-error"><sf:errors path="${status.expression}" /></div>
              </s:bind>
            </div>
          </div>
        </div>

        <div class="col-md-8">
          <div class="row">
            <div class="col-6">
              <s:bind path="qualification">
                <label class="form-label">Qualification</label>
                <sf:textarea path="${status.expression}" rows="4" cols="4" placeholder="Enter Qualification" class="form-control" />
                <div class="form-error"><sf:errors path="${status.expression}" /></div>
              </s:bind>
            </div>

            <div class="col-6">
              <s:bind path="address">
                <label class="form-label">Address</label>
                <sf:textarea rows="4" cols="4" path="${status.expression}" placeholder="Enter Address" class="form-control" />
                <div class="form-error"><sf:errors path="${status.expression}" /></div>
              </s:bind>
            </div>
          </div>
        </div>

        <div class="col-md-6">
          <s:bind path="profilePic">
            <label class="form-label">Profile Pic</label>
            <sf:input type="file" path="${status.expression}" class="form-control" required="required" />
            <div class="form-error"><sf:errors path="${status.expression}" /></div>
          </s:bind>
        </div>

        <br>

        <div class="col-12">
          <input type="submit" name="operation" class="btn btn-theme pull-right" value="Save">
          &nbsp;or&nbsp;
          <input type="submit" name="operation" class="btn btn-secondary pull-right" value="Reset">
        </div>

      </div>
    </div>
  </sf:form>
</div>
