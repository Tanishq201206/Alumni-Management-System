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
    border-radius: 8px;
    border: 1px solid #cfcfcf;
    background: var(--white);
    transition: border-color .2s ease, box-shadow .2s ease;
  }
  .form-control:focus{
    border-color: var(--red);
    box-shadow: 0 0 0 .15rem rgba(228,54,54,.25);
  }

  /* Inline error text */
  .form-error{
    color: var(--red);
    font-size: 13px;
  }

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
  }

  /* Optional helper beneath file input */
  .hint{
    font-size: 12px;
    color: #555;
    margin-top: 4px;
  }
</style>

<div class="container mt-3">
  <sf:form method="post" action="${pageContext.request.contextPath}/ctl/applyJob" modelAttribute="form" enctype="multipart/form-data">
    <div class="card shadow border-0 rounded">
      <div class="card-header">
        Apply For Job
      </div>

      <div class="card-body">
        <b><%@ include file="businessMessage.jsp"%></b>

        <div class="row g-3">
          <div class="col-md-6">
            <s:bind path="name">
              <label class="form-label">Name</label>
              <sf:input path="${status.expression}" class="form-control" placeholder="Enter First Name" />
              <div class="form-error"><sf:errors path="${status.expression}" /></div>
            </s:bind>
          </div>

          <div class="col-md-6">
            <s:bind path="email">
              <label class="form-label">Email</label>
              <sf:input path="${status.expression}" class="form-control" placeholder="Enter Email" />
              <div class="form-error"><sf:errors path="${status.expression}" /></div>
            </s:bind>
          </div>

          <div class="col-md-6">
            <s:bind path="contactNo">
              <label class="form-label">Contact No</label>
              <sf:input path="${status.expression}" class="form-control" placeholder="Enter Contact No" />
              <div class="form-error"><sf:errors path="${status.expression}" /></div>
            </s:bind>
          </div>

          <div class="col-md-6">
            <s:bind path="file">
              <label class="form-label">Upload File</label>
              <!-- Added id + accept to restrict picker; keeps backend binding intact -->
              <sf:input
                type="file"
                path="${status.expression}"
                class="form-control"
                required="required"
                id="resumeFile"
                accept=".jpg,.jpeg,image/jpeg"
              />
              <div class="hint">Accepted format: <strong>JPG</strong> only.</div>
              <!-- Local error surface for client-side validation -->
              <div id="fileError" class="form-error"></div>
              <div class="form-error"><sf:errors path="${status.expression}" /></div>
            </s:bind>
          </div>
        </div>

        <div class="mt-4">
          <input type="submit" name="operation" class="btn btn-primary-theme" value="Save" />
          <input type="submit" name="operation" class="btn btn-secondary ms-2" value="Reset" />
        </div>
      </div>
    </div>
  </sf:form>
</div>

<!-- Lightweight client-side guard: JPG/JPEG only (prevents whitelabel if user picks bad file) -->
<script>
(function () {
  const form  = document.querySelector('form[action$="/ctl/applyJob"]');
  const input = document.getElementById('resumeFile');
  const error = document.getElementById('fileError');
  const MAX_BYTES = 5 * 1024 * 1024; // optional 5MB cap (adjust or remove if undesired)

  function showError(msg){
    if (error) error.textContent = msg || "";
    if (input) input.classList.toggle('is-invalid', !!msg);
  }

  function isJpgFile(file){
    if (!file) return false;
    // Check MIME first (most reliable), then extension as a fallback
    const okMime = (file.type || '').toLowerCase() === 'image/jpeg';
    const name = (file.name || '').toLowerCase();
    const okExt = name.endsWith('.jpg') || name.endsWith('.jpeg');
    return okMime || okExt;
  }

  function validateFile(){
    showError(""); // clear
    const file = (input && input.files && input.files[0]) ? input.files[0] : null;
    if (!file){
      showError("Please choose a JPG file.");
      return false;
    }
    if (!isJpgFile(file)){
      showError("Only JPG (.jpg / .jpeg) files are allowed.");
      return false;
    }
    if (file.size > MAX_BYTES){
      showError("File is too large. Max allowed is 5 MB.");
      return false;
    }
    return true;
  }

  if (input){
    input.addEventListener('change', validateFile);
  }
  if (form){
    form.addEventListener('submit', function(e){
      // Only guard the Save action; let Reset pass through
      const op = (e.submitter && e.submitter.value) ? e.submitter.value : "";
      if (op === "Save" && !validateFile()){
        e.preventDefault();
        e.stopPropagation();
      }
    });
  }
})();
</script>
