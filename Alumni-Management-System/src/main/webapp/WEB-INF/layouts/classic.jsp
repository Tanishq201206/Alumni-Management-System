<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<html>
<head>
<title><tiles:getAsString name="title" /></title>
<meta charset="utf-8">
<link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/images/favicon.ico" />
<link
  href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css"
  rel="stylesheet"
  integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x"
  crossorigin="anonymous">
<link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>

<script
  src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js"
  integrity="sha384-gtEjrD/SeCtmISkJkNUaaKMoLD0//ElJ19smozuHV6z3Iehds+3Ulb9Bn9Plx0x4"
  crossorigin="anonymous"></script>

<style type="text/css">
:root{
  --accent:#E43636;   /* red */
  --cream:#F6EFD2;    /* page bg */
  --sand:#E2DDB5;     /* soft border */
  --ink:#000000;      /* black */
}

html, body { height: 100%; margin: 0; padding: 0; background: var(--cream); }

.blockquote { padding: 20px; box-shadow: inset 0 -3em 3em rgba(0,0,0,.1), 0 0 0 2px #fff, .3em .3em 1em rgba(0,0,0,.3); }
.imageHeight { height: 380px; }
.linkSize { font-size: 14px; }
/* .bgcolor utility used by included pages */
.bgcolor{ background-color: var(--ink) !important; color:#fff; }

#demo { height:100%; position:relative; overflow:hidden; }

.green{ background-color:#6fb936; } /* legacy – safe to keep if referenced by old pages */
.thumb{ margin-bottom: 30px; }
.page-top{ margin-top:85px; }

img.zoom {
  width: 100%;
  height: 200px;
  border-radius:5px;
  object-fit:cover;
  -webkit-transition: all .3s ease-in-out;
  -moz-transition: all .3s ease-in-out;
  -o-transition: all .3s ease-in-out;
  -ms-transition: all .3s ease-in-out;
}
.transition { transform: scale(1.2); }
.modal-header { border-bottom: none; }
.modal-title { color:var(--ink); }
.modal-footer{ display:none; }

/* ===== Modern “Glass Card” Loader – Palette: black/red/cream ===== */
#page-loader {
  position: fixed;
  inset: 0;
  z-index: 9999;
  display: none;                 /* hidden by default; JS will show it */
  align-items: center;
  justify-content: center;
  /* subtle vignette using black; lets page peek through */
  background:
    radial-gradient(1200px 800px at 50% -10%,
      rgba(0,0,0,.18),
      rgba(0,0,0,.88));
  backdrop-filter: blur(6px);
  -webkit-backdrop-filter: blur(6px);
  transition: opacity .35s ease;
  opacity: 0;
}

/* Card wrapper */
.loader-card {
  width: 220px;
  padding: 24px 22px;
  border-radius: 16px;
  background: rgba(255,255,255,.08);
  border: 1px solid rgba(255,255,255,.22);
  box-shadow: 0 20px 45px rgba(0,0,0,.25);
  text-align: center;
  color: #fff;
}

/* Logo ring */
.loader-logo {
  width: 72px; height: 72px;
  margin: 0 auto 16px;
  position: relative;
  border-radius: 50%;
  background: linear-gradient(135deg, #141414, #2a2a2a); /* black shades */
  display: grid; place-items: center;
  box-shadow: inset 0 0 0 2px rgba(255,255,255,.12);
}

/* Spinning ring – accent red */
.loader-ring {
  position: absolute;
  inset: -6px;
  border-radius: 50%;
  border: 3px solid transparent;
  border-top-color: var(--accent);
  border-right-color: var(--accent);
  animation: spin 1s linear infinite;
  filter: drop-shadow(0 0 8px rgba(228,54,54,.65));
}

/* Inner dot pulse – cream hint */
.loader-dot {
  width: 10px; height: 10px;
  border-radius: 50%;
  background: var(--cream);
  box-shadow: 0 0 12px rgba(246,239,210,.9);
  animation: pulse 1.4s ease-in-out infinite;
}

/* Title + caption */
.loader-title { font-weight: 700; letter-spacing: .3px; margin-bottom: 4px; }
.loader-caption { font-size: 12px; opacity: .9; }

/* Progress bar (indeterminate) */
.loader-bar {
  margin-top: 16px;
  height: 6px;
  width: 100%;
  border-radius: 999px;
  background: rgba(255,255,255,.18);
  overflow: hidden;
  position: relative;
}
.loader-bar::before {
  content: "";
  position: absolute;
  inset: 0;
  transform: translateX(-100%);
  background: linear-gradient(90deg, transparent, var(--accent), transparent);
  animation: slide 1.2s ease-in-out infinite;
}

/* Animations */
@keyframes spin { to { transform: rotate(360deg); } }
@keyframes pulse { 0%,100% { transform: scale(.9); opacity: .85; } 50% { transform: scale(1.12); opacity: 1; } }
@keyframes slide { 0% { transform: translateX(-100%);} 50% { transform: translateX(0);} 100% { transform: translateX(100%);} }

/* Respect reduced motion */
@media (prefers-reduced-motion: reduce) {
  .loader-ring, .loader-dot, .loader-bar::before { animation: none; }
}

/* Optional: inputs/focus using palette (handy for shared pages) */
.form-control:focus, .form-select:focus{
  border-color: var(--accent);
  box-shadow: 0 0 0 .15rem rgba(228,54,54,.25);
}
.btn-primary{
  background: var(--accent);
  border-color: var(--accent);
}
.btn-primary:hover{ background:#c82f2f; border-color:#c82f2f; }
.border-soft{ border-color: var(--sand) !important; }
.bg-ink{ background: var(--ink) !important; color:#fff !important; }
</style>

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>
$(function() {
  $("#datepicker").datepicker({ changeMonth:true, changeYear:true, defaultDate:'01/01/1992' });
  $("#datepicker1").datepicker({ changeMonth:true, changeYear:true });
  $("#datepicker2").datepicker({ changeMonth:true, changeYear:true });

  $(".fancybox").fancybox?.({ openEffect:"none", closeEffect:"none" });
  $(".zoom").hover(function(){ $(this).addClass('transition'); }, function(){ $(this).removeClass('transition'); });

  $("#selectall").click(function(){ $('.case').prop('checked', this.checked); });
  $(".case").click(function(){
    $("#selectall").prop('checked', $(".case").length === $(".case:checked").length);
  });
});
</script>
</head>

<body>
  <!-- Modern Page Loader (palette-ready) -->
  <div id="page-loader" aria-live="polite" aria-busy="true" aria-hidden="true">
    <div class="loader-card" role="status">
      <div class="loader-logo">
        <div class="loader-ring" aria-hidden="true"></div>
        <div class="loader-dot" aria-hidden="true"></div>
      </div>
      <div class="loader-title">Loading</div>
      <div class="loader-caption">Please wait a moment</div>
      <div class="loader-bar" aria-hidden="true"></div>
    </div>
  </div>

  <tiles:insertAttribute name="header" />
  <tiles:insertAttribute name="body" />
  <tiles:insertAttribute name="footer" />

  <script>
(function () {
  const loader = document.getElementById("page-loader");
  if (!loader) return;

  function showLoader() {
    loader.setAttribute("aria-hidden", "false");
    loader.style.display = "flex";
    requestAnimationFrame(() => { loader.style.opacity = "1"; });
  }
  function hideLoader() {
    loader.style.opacity = "0";
    loader.setAttribute("aria-hidden", "true");
    setTimeout(() => { loader.style.display = "none"; }, 350);
  }

  window.addEventListener("load", hideLoader);

  window.addEventListener("pageshow", function (e) {
    if (e.persisted) hideLoader();
    else hideLoader();
  });

  document.addEventListener("visibilitychange", () => {
    if (document.visibilityState === "visible") hideLoader();
  });

  window.addEventListener("pagehide", hideLoader);

  document.addEventListener("click", function (e) {
    const link = e.target.closest("a[href]");
    if (!link) return;

    if (e.defaultPrevented || e.button !== 0 || e.metaKey || e.ctrlKey || e.shiftKey || e.altKey) return;

    const href = link.getAttribute("href") || "";
    if (href.startsWith("#") || href.startsWith("javascript:") || link.hasAttribute("download") || link.target === "_blank") return;
    if (/^(mailto:|tel:|sms:|intent:)/i.test(href)) return;

    const current = location.pathname + location.search + location.hash;
    if (href === current) return;

    showLoader();
  });

  document.addEventListener("DOMContentLoaded", function () {
    const loginForm = document.querySelector("form[action*='/login']");
    if (!loginForm) return;
    const submitBtn = loginForm.querySelector("input[type='submit']");
    loginForm.addEventListener("submit", function () {
      if (submitBtn) { submitBtn.classList.add("btn-loading"); submitBtn.value = "Signing in..."; }
    });
  });
})();
</script>

</body>
</html>
