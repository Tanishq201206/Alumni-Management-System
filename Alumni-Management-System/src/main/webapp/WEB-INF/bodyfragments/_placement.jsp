<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="sf"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="s"%>

<style>
  :root{ --cl-red:#E43636; --cl-cream:#F6EFD2; --cl-sand:#E2DDB4; --cl-black:#000000; }
  .bgcolor{ background-color: var(--cl-red) !important; }
  .card{ border-radius: 12px; box-shadow: 0 6px 18px rgba(0,0,0,.12); overflow: hidden; }
  .card-header{ font-weight: 600; letter-spacing: .3px; color:#fff; background: var(--cl-red); }
  .form-label{ font-weight: 500; }
  .form-error{ color: #c92121; font-size: 13px; }
  .form-control{ font-size: 14px; border-radius: 8px; border: 1px solid var(--cl-sand); transition: border-color .15s, box-shadow .15s, background-color .15s; background:#fff; }
  .form-control:focus{ border-color: var(--cl-red); box-shadow: 0 0 0 .15rem rgba(228,54,54,.25); background:#fff; }
  .btn-primary{ background: var(--cl-red); border-color: var(--cl-red); border-radius: 8px; font-weight: 600; color:#fff; }
  .btn-primary:hover{ background:#c42e2e; border-color:#c42e2e; }
  .btn-secondary{ border-radius: 8px; font-weight: 600; }
  .card-body .col-md-6{ margin-bottom:16px; }
  body{ background: linear-gradient(180deg, var(--cl-cream), #fff); }
</style>

<br/>

<div class="container">
  <sf:form method="post"
           action="${pageContext.request.contextPath}/ctl/placement"
           modelAttribute="form"
           enctype="multipart/form-data">

    <!-- keep id so controller updates instead of creating -->
    <sf:hidden path="id"/>
    <!-- let backend know the original candidate name to bypass duplicate on self-update -->
    <input type="hidden" name="originalName" value="${form.name}"/>

    <div class="card">
      <h5 class="card-header bgcolor">
        <c:choose>
          <c:when test="${form.id != null && form.id ne 0}">Edit Placement</c:when>
          <c:otherwise>Add Placement</c:otherwise>
        </c:choose>
      </h5>

      <div class="card-body">
        <b><%@ include file="businessMessage.jsp" %></b>

        <div class="row">
          <div class="col-md-6">
            <s:bind path="companyName">
              <label class="form-label">Company Name</label>
              <sf:input path="${status.expression}" placeholder="Enter Company Name" class="form-control"/>
              <div class="form-error"><sf:errors path="${status.expression}"/></div>
            </s:bind>
          </div>

          <div class="col-md-6">
            <s:bind path="name">
              <label class="form-label">Name</label>
              <sf:input path="${status.expression}" placeholder="Enter Candidate Name" class="form-control"/>
              <div class="form-error"><sf:errors path="${status.expression}"/></div>
            </s:bind>
          </div>

          <div class="col-md-6">
            <s:bind path="jobPackage">
              <label class="form-label">Job Package</label>
              <sf:input path="${status.expression}" placeholder="Enter Job Package" class="form-control"/>
              <div class="form-error"><sf:errors path="${status.expression}"/></div>
            </s:bind>
          </div>

          <div class="col-md-6">
            <s:bind path="post">
              <label class="form-label">Designation</label>
              <sf:input path="${status.expression}" placeholder="Enter Designation" class="form-control"/>
              <div class="form-error"><sf:errors path="${status.expression}"/></div>
            </s:bind>
          </div>

          <div class="col-md-6">
            <s:bind path="date">
              <label class="form-label">Placement Date</label>
              <sf:input path="${status.expression}" id="datepicker1" placeholder="Enter Placement Date" class="form-control"/>
              <div class="form-error"><sf:errors path="${status.expression}"/></div>
            </s:bind>
          </div>

          <div class="col-md-6">
            <s:bind path="location">
              <label class="form-label">Location</label>
              <sf:textarea path="${status.expression}" rows="3" placeholder="Enter Location" class="form-control"></sf:textarea>
              <div class="form-error"><sf:errors path="${status.expression}"/></div>
            </s:bind>
          </div>

          <div class="col-md-6">
            <s:bind path="image">
              <label class="form-label">
                Profile Image
                <small class="text-muted">(JPG/PNG, optional when editing)</small>
              </label>
              <sf:input type="file" path="${status.expression}" class="form-control" accept=".jpg,.jpeg,.png"/>
              <div class="form-error" id="imgClientError" style="display:none;"></div>
              <div class="form-error"><sf:errors path="${status.expression}"/></div>
            </s:bind>
          </div>
        </div>

        <div class="mt-3 text-end">
          <!-- Always submit "Save" so the controller hits OP_SAVE branch -->
          <input type="submit" name="operation" class="btn btn-primary" value="Save"/>
          <input type="submit" name="operation" class="btn btn-secondary ms-2" value="Reset"/>
        </div>
      </div>
    </div>
  </sf:form>
</div>

<script>
(function () {
  // Only validate on this page/form
  const form = document.querySelector('form[action$="/ctl/placement"]');
  if (!form) return;

  const fileInput = form.querySelector('input[type="file"]');
  const errBox    = document.getElementById("imgClientError");

  const allowedExt  = ["jpg","jpeg","png"];
  const allowedMime = ["image/jpeg","image/png"];
  const MAX_BYTES   = 10 * 1024 * 1024; // 10MB

  function showErr(msg){
    if (!errBox) return;
    errBox.textContent = msg || "";
    errBox.style.display = msg ? "block" : "none";
  }

  function validate(file){
    // If no file chosen, that's OK (especially during edit)
    if (!file) return { ok:true };

    const name = (file.name || "").toLowerCase();
    const ext  = name.includes(".") ? name.split(".").pop() : "";
    if (!allowedExt.includes(ext)) return { ok:false, msg:"Only JPG or PNG images are allowed." };
    if (file.type && !allowedMime.includes(file.type)) return { ok:false, msg:"Invalid file type. Please upload JPG/PNG." };
    if (typeof file.size === "number" && file.size > MAX_BYTES) return { ok:false, msg:"File too large. Max allowed is 10MB." };
    return { ok:true };
  }

  if (fileInput) {
    fileInput.addEventListener("change", function(){
      showErr("");
      const f = this.files && this.files[0];
      const res = validate(f);
      if (!res.ok) {
        showErr(res.msg);
        this.value = ""; // reset invalid selection
      }
    });
  }

  // Block Save submit only when an invalid file is chosen
  form.addEventListener("submit", function(e){
    const submitter = e.submitter;
    if (!submitter) return;
    if (submitter.value !== "Save") return;

    showErr("");
    const f = fileInput && fileInput.files ? fileInput.files[0] : null;
    const res = validate(f);
    if (!res.ok) {
      showErr(res.msg);
      e.preventDefault();
    }
  });
})();
</script>
