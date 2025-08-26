<%@taglib uri="http://www.springframework.org/tags/form" prefix="sf"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="crt"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="s"%>

<!-- Animate.css for alert transitions -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>

<style>
  /* === Color Hunt palette === */
  :root{
    --red: #E43636;
    --red-700: #c62f2f;    /* hover/darker */
    --cream: #F6EFD2;      /* light surface */
    --beige: #E2DDB4;      /* subtle accents */
    --black: #000000;      /* strong text */
    --white: #ffffff;
  }

  .card{
    max-width: 800px;
    margin: auto;
    background: var(--cream);
    border: 1px solid #e0e0e0 !important;
    border-radius: 12px !important;
    overflow: hidden;
  }
  .bgcolor{ background-color: var(--red) !important; }
  .card-header{ color: var(--white); font-weight: 700; }

  .alert{
    margin: 20px auto;
    width: 80%;
    border-radius: 10px;
  }
  .alert-success{ background:#eaf6ea; border-color:#cbe8cf; color:#1f7a3e; }
  .alert-danger { background:#fdeceb; border-color:#f6c9c6; color:#9b1c1c; }

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
  .form-hint{ font-size:12px; color:#666; margin-top:4px; }
  .form-error{ font-size:13px; color: var(--red); }

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

  .btn-secondary{
    border-radius: 8px;
    padding: 8px 16px;
    font-weight: 700;
  }

  /* Image preview */
  #imgPreview{
    display:none;
    max-width: 260px;
    max-height: 180px;
    border-radius: 10px;
    border: 1px solid #e5e5e5;
    background: var(--white);
  }
</style>

<br>

<!-- Optional Success/Error Alert -->
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
  <sf:form method="post"
           action="${pageContext.request.contextPath}/ctl/gallary"
           modelAttribute="form"
           enctype="multipart/form-data">
    <div class="card shadow mb-5 bg-body rounded">
      <h5 class="card-header bgcolor text-white">Add Gallery</h5>
      <div class="card-body">
        <b><%@ include file="businessMessage.jsp"%></b>

        <div class="mb-3 col-md-6">
          <s:bind path="eventId">
            <label for="eventId" class="form-label">Event Name</label>
            <sf:select class="form-select" path="${status.expression}">
              <sf:option value="-1" label="Select"/>
              <sf:options items="${eventList}" itemLabel="title" itemValue="id"/>
            </sf:select>
            <div class="form-error"><sf:errors path="${status.expression}"/></div>
          </s:bind>
        </div>

        <div class="mb-3 col-md-6">
          <s:bind path="image">
            <label for="image" class="form-label">Image</label>
            <!-- Restrict chooser to JPG/JPEG/PNG -->
            <sf:input type="file" path="${status.expression}" class="form-control" accept=".jpg,.jpeg,.png"/>
            <div class="form-hint">Accepted: JPG/JPEG/PNG • Max 10MB (as configured on server)</div>
            <div class="form-error" id="fileClientError" style="display:none;"></div>
            <div class="form-error"><sf:errors path="${status.expression}"/></div>
          </s:bind>
        </div>

        <!-- Optional preview -->
        <div class="mb-3 col-md-6">
          <img id="imgPreview" alt="Preview" />
        </div>

        <div class="col-12 mt-3">
          <input type="submit" name="operation" class="btn btn-primary" value="Save"/>
          &nbsp;
          <input type="submit" name="operation" class="btn btn-secondary" value="Reset"/>
        </div>
      </div>
    </div>
  </sf:form>
</div>

<!-- Fade out alert box + client-side validation + image preview -->
<script>
  (function () {
    // Fade alerts
    const alertBox = document.getElementById("alertBox");
    if (alertBox) {
      setTimeout(() => {
        alertBox.classList.replace("animate__fadeInDown", "animate__fadeOutUp");
        setTimeout(() => alertBox.remove(), 1000);
      }, 4000);
    }

    // File validation config
    const allowedExt = ["jpg","jpeg","png"];
    const allowedMime = ["image/jpeg","image/png"];
    const MAX_BYTES = 10 * 1024 * 1024; // 10MB

    // Elements
    const form     = document.querySelector('form[action$="/ctl/gallary"]');
    const fileInput= form ? form.querySelector('input[type="file"]') : null;
    const errBox   = document.getElementById("fileClientError");
    const preview  = document.getElementById("imgPreview");

    function showErr(msg){
      if (!errBox) return;
      errBox.textContent = msg || "";
      errBox.style.display = msg ? "block" : "none";
    }

    function isValidFile(file){
      if (!file) return true; // nothing chosen yet

      // Extension check
      const name = (file.name || "").toLowerCase();
      const ext  = name.includes(".") ? name.split(".").pop() : "";
      if (!allowedExt.includes(ext)) {
        return { ok:false, msg:"Please upload a JPG or PNG image." };
      }

      // MIME check (best-effort; some browsers report 'application/octet-stream')
      if (file.type && !allowedMime.includes(file.type)) {
        return { ok:false, msg:"Only image files (JPG/PNG) are allowed." };
      }

      // Size check
      if (typeof file.size === "number" && file.size > MAX_BYTES) {
        return { ok:false, msg:"File is too large. Max allowed size is 10MB." };
      }

      return { ok:true };
    }

    function refreshPreview(file){
      if (!preview) return;
      if (!file) { preview.style.display="none"; preview.src=""; return; }
      const url = URL.createObjectURL(file);
      preview.src = url;
      preview.style.display = "block";
    }

    // Validate on change
    if (fileInput) {
      fileInput.addEventListener("change", function(){
        showErr("");
        const f = this.files && this.files[0];
        const res = isValidFile(f);
        if (!res.ok) {
          showErr(res.msg);
          this.value = "";     // reset invalid selection
          refreshPreview(null);
          return;
        }
        refreshPreview(f);
      });
    }

    // Validate on submit (Save only; do not block Reset)
    if (form) {
      form.addEventListener("submit", function (e) {
        const submitter = e.submitter; // modern browsers
        if (submitter && submitter.value !== "Save") return; // let Reset pass

        showErr("");
        const f = fileInput && fileInput.files ? fileInput.files[0] : null;

        // Require a file and validate it
        if (!f) {
          showErr("Please choose an image file (JPG/PNG).");
          e.preventDefault();
          return;
        }
        const res = isValidFile(f);
        if (!res.ok) {
          showErr(res.msg);
          e.preventDefault();
        }
      });
    }
  })();
</script>
