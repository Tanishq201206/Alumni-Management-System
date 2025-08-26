<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>

<!-- Sticky footer + palette -->
<style>
  /* === Color Hunt palette (local to this page) === */
  :root{
    --red: #E43636;
    --red-700: #c62f2f;            /* hover */
    --cream: #F6EFD2;              /* light backgrounds */
    --beige: #E2DDB4;              /* accents */
    --black: #000000;              /* dark bar / text */
    --white: #ffffff;
  }

  /* Layout: push footer to bottom when content is short */
  body {
    display: flex;
    flex-direction: column;
    min-height: 100vh;
    background-color: var(--white);
  }
  footer.glass-footer { margin-top: auto; }

  /* === Footer styles (updated to palette) === */
  .glass-footer {
    /* Subtle red-to-black tint for depth, mostly red */
    background: linear-gradient(90deg, var(--red) 0%, #d53434 40%, var(--black) 100%);
    color: var(--white);
    border-top: 1px solid rgba(255,255,255,0.18);
    backdrop-filter: blur(8px);
    -webkit-backdrop-filter: blur(8px);
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    font-size: 14px;
    padding: 30px 0 15px 0;
    text-align: center;
    transition: all 0.3s ease;
    box-shadow: 0 -6px 18px rgba(0,0,0,0.18);
  }

  .footer-links { margin-bottom: 15px; }
  .footer-links a {
    margin: 0 12px;
    font-weight: 600;
    color: var(--cream);
    text-decoration: none;
    padding: 4px 6px;
    border-radius: 6px;
    transition: color .2s ease, background-color .2s ease, text-decoration .2s ease;
  }
  .footer-links a:hover {
    color: var(--white);
    background-color: rgba(246,239,210,0.12); /* cream tint */
    text-decoration: underline;
  }

  .footer-social-icons a {
    margin: 0 10px;
    font-size: 20px;
    display: inline-block;
    color: var(--beige);
    transition: transform 0.2s ease, color 0.2s ease, background-color 0.2s ease;
    padding: 6px;
    border-radius: 50%;
  }
  .footer-social-icons a:hover {
    transform: scale(1.12);
    color: var(--white);
    background-color: rgba(0,0,0,0.18);
  }

  .developer-credit {
    font-size: 13px;
    opacity: 0.9;
    margin-top: 8px;
  }
</style>

<!-- Footer Component -->
<footer class="glass-footer">
  <div class="container">
    <!-- Quick Links -->
    <div class="footer-links">
      <a href="${pageContext.request.contextPath}/home">Home</a>
      <a href="${pageContext.request.contextPath}/aboutUs">About</a>
      <a href="${pageContext.request.contextPath}/alumni/login">Login</a>
    </div>

    <!-- Social Media -->
    <div class="footer-social-icons">
      <a href="" target="_blank" title="Instagram" rel="noopener">
        <i class="bi bi-instagram"></i>
      </a>
      <a href="mailto:" title="Email">
        <i class="bi bi-envelope-fill"></i>
      </a>
    </div>

    <!-- Copyright -->
    <div class="mt-2">
      &copy; <%= new SimpleDateFormat("yyyy").format(new Date()) %> Alumni Management System. All Rights Reserved.
    </div>

    <!-- Developer Credit -->
    <div class="developer-credit">
      Designed &amp; Developed by <strong>Tanishq Singh Dheda, Tarang Sharma, Vidit Raj Jain</strong>
    </div>
  </div>
</footer>

<!-- Bootstrap Icons CDN -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
