<%@taglib uri="http://www.springframework.org/tags/form" prefix="sf"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="crt"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="s"%>

<style>
  /* === Color Hunt Palette === */
  :root{
    --red: #E43636;
    --red-700: #c62f2f;   /* hover */
    --cream: #F6EFD2;
    --beige: #E2DDB4;
    --black: #000000;
    --white: #ffffff;
  }

  /* Top bar */
  .navbar-top {
    background: var(--red);
    min-height: 59px;
  }
  .navbar-top .navbar-brand,
  .navbar-top .navbar-text {
    color: var(--white) !important;
  }

  /* Sub bar */
  .navbar-sub {
    background: var(--black);
    min-height: 39px;
    border-top: 1px solid rgba(255,255,255,.06);
  }

  /* Nav links */
  .navbar .nav-link {
    color: #f5f5f5 !important;
    padding: 6px 10px;
    transition: color .2s ease, background-color .2s ease;
    border-radius: 6px;
  }
  .navbar .nav-link:hover,
  .navbar .nav-link.active {
    color: var(--white) !important;
    background-color: rgba(228,54,54,.18); /* red tint */
  }

  /* Highlight CTA buttons (like Admin SignIn) */
  .navbar .nav-link.cta {
    background: var(--black);
    color: var(--white) !important;
  }
  .navbar .nav-link.cta:hover { background: rgba(228,54,54,.18); }

  /* Greeting text */
  .navbar-text {
    font-size: 14px;
    font-variant-caps: petite-caps;
    margin-left: .5rem;
  }

  /* Toggler button */
  .navbar-dark .navbar-toggler {
    border-color: rgba(255,255,255,.25);
  }
  .navbar-dark .navbar-toggler-icon {
    filter: invert(1) grayscale(100%);
  }

  /* === Font-only change: inherit site's default font === */
  .navbar-top, .navbar-sub, .navbar-brand, .navbar .nav-link, .navbar-text {
   font-family: -apple-system, "SF Pro Text", "Helvetica Neue", Helvetica, Arial, sans-serif !important;

  }
</style>

<!-- ====== HEADER ====== -->
<nav class="navbar navbar-expand-lg navbar-top">
  <div class="container-fluid">
    <!-- removed font-family:serif -->
    <a class="navbar-brand" href="#" style="font-size:26px;">
      <span>Alumni Management System</span>
    </a>

    <form class="container-fluid"></form>

    <div class="collapse navbar-collapse" id="navbarText">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <c:if test="${sessionScope.alumni != null}">
          <span class="navbar-text">Hello, ${sessionScope.alumni.name}</span>
        </c:if>
        <c:if test="${sessionScope.admin != null}">
          <span class="navbar-text">Hello, ${sessionScope.admin.name}</span>
        </c:if>
        <c:if test="${sessionScope.staff != null}">
          <span class="navbar-text">Hello, ${sessionScope.staff.name}</span>
        </c:if>
        <c:if test="${sessionScope.admin == null && sessionScope.alumni == null && sessionScope.staff == null}">
          <span class="navbar-text">Welcome</span>
        </c:if>
      </ul>
    </div>
  </div>
</nav>

<div class="shadow bg-body rounded">
  <nav class="navbar navbar-expand-lg navbar-dark navbar-sub">
    <div class="container-fluid">
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
              data-bs-target="#navbarNav" aria-controls="navbarNav"
              aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>

      <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav">
          <li class="nav-item linkSize">
            <a class="nav-link active" aria-current="page" href="<c:url value="/home"/>">Home</a>
          </li>

          <c:if test="${sessionScope.admin != null}">
            <li class="nav-item linkSize"><a class="nav-link" href="<c:url value="/ctl/admin"/>">AddAdmin</a></li>
            <li class="nav-item linkSize"><a class="nav-link" href="<c:url value="/ctl/event"/>">Add Event</a></li>
            <li class="nav-item linkSize"><a class="nav-link" href="<c:url value="/ctl/event/search"/>">Event List</a></li>
            <li class="nav-item linkSize"><a class="nav-link" href="<c:url value="/ctl/participant/search"/>">Participants</a></li>
            <li class="nav-item linkSize"><a class="nav-link" href="<c:url value="/ctl/gallary"/>">Add Gallery</a></li>
            <li class="nav-item linkSize"><a class="nav-link" href="<c:url value="/ctl/gallary/search"/>">Gallery List</a></li>
            <li class="nav-item linkSize"><a class="nav-link" href="<c:url value="/ctl/job/search"/>">Jobs</a></li>
            <li class="nav-item linkSize"><a class="nav-link" href="<c:url value="/ctl/placement"/>">Add Placement</a></li>
            <li class="nav-item linkSize"><a class="nav-link" href="<c:url value="/ctl/placement/search"/>">Placements</a></li>
            <li class="nav-item linkSize"><a class="nav-link" href="<c:url value="/ctl/feedBack/search"/>">FeedBack</a></li>
          </c:if>

          <c:if test="${sessionScope.alumni != null}">
            <li class="nav-item linkSize"><a class="nav-link" href="<c:url value="/ctl/event/search"/>">Events</a></li>
            <li class="nav-item linkSize"><a class="nav-link" href="<c:url value="/ctl/gallary/search"/>">Gallery</a></li>
            <li class="nav-item linkSize"><a class="nav-link" href="<c:url value="/ctl/job"/>">Add Job</a></li>
            <li class="nav-item linkSize"><a class="nav-link" href="<c:url value="/ctl/job/search"/>">Jobs</a></li>
            <li class="nav-item linkSize"><a class="nav-link" href="<c:url value="/ctl/participant/search"/>">My Event</a></li>
            <li class="nav-item linkSize"><a class="nav-link" href="<c:url value="/ctl/applyJob/search"/>">Apply Jobs</a></li>
            <li class="nav-item linkSize"><a class="nav-link" href="<c:url value="/ctl/placement/search"/>">Placements</a></li>
            <li class="nav-item linkSize"><a class="nav-link" href="<c:url value="/ctl/feedBack"/>">FeedBack</a></li>
          </c:if>

          <c:if test="${sessionScope.staff != null}">
            <li class="nav-item linkSize"><a class="nav-link" href="<c:url value="/ctl/event/search"/>">Events</a></li>
            <li class="nav-item linkSize"><a class="nav-link" href="<c:url value="/ctl/gallary/search"/>">Gallery</a></li>
            <li class="nav-item linkSize"><a class="nav-link" href="<c:url value="/ctl/job/search"/>">Jobs</a></li>
            <li class="nav-item linkSize"><a class="nav-link" href="<c:url value="/ctl/placement/search"/>">Placements</a></li>
            <li class="nav-item linkSize"><a class="nav-link" href="<c:url value="/ctl/feedBack"/>">FeedBack</a></li>
          </c:if>

          <c:if test="${sessionScope.admin == null && sessionScope.alumni == null && sessionScope.staff == null}">
            <li class="nav-item linkSize"><a class="nav-link" href="<c:url value="/aboutUs"/>">AboutUs</a></li>
            <li class="nav-item linkSize"><a class="nav-link" href="<c:url value="/contactUs"/>">ContactUs</a></li>
          </c:if>
        </ul>
      </div>

      <ul class="nav justify-content-end">
        <c:if test="${sessionScope.admin != null}">
          <li class="nav-item linkSize"><a class="nav-link" href="<c:url value="/profile"/>">My Profile</a></li>
          <li class="nav-item linkSize"><a class="nav-link" href="<c:url value="/changepassword"/>">Change Password</a></li>
          <li class="nav-item linkSize"><a class="nav-link" href="<c:url value="/login"/>">Logout</a></li>
        </c:if>

        <c:if test="${sessionScope.alumni != null}">
          <li class="nav-item linkSize"><a class="nav-link" href="<c:url value="/alumni/profile"/>">My Profile</a></li>
          <li class="nav-item linkSize"><a class="nav-link" href="<c:url value="/alumni/changepassword"/>">Change Password</a></li>
          <li class="nav-item linkSize"><a class="nav-link" href="<c:url value="/alumni/login"/>">Logout</a></li>
        </c:if>

        <c:if test="${sessionScope.staff != null}">
          <li class="nav-item linkSize"><a class="nav-link" href="<c:url value="/staff/profile"/>">My Profile</a></li>
          <li class="nav-item linkSize"><a class="nav-link" href="<c:url value="/staff/changepassword"/>">Change Password</a></li>
          <li class="nav-item linkSize"><a class="nav-link" href="<c:url value="/staff/login"/>">Logout</a></li>
        </c:if>

        <c:if test="${sessionScope.admin == null && sessionScope.alumni == null && sessionScope.staff == null}">
          <li class="nav-item linkSize"><a class="nav-link cta" href="<c:url value="/login"/>">Admin SignIn</a></li>
          <li class="nav-item linkSize"><a class="nav-link" href="<c:url value="/alumni/login"/>">Alumni SignIn</a></li>
          <li class="nav-item linkSize"><a class="nav-link" href="<c:url value="/staff/login"/>">Staff SignIn</a></li>
          <li class="nav-item linkSize"><a class="nav-link" href="<c:url value="/alumni/al-signUp"/>">Alumni SignUp</a></li>
          <li class="nav-item linkSize"><a class="nav-link" href="<c:url value="/staff/st-signUp"/>">Staff SignUp</a></li>
        </c:if>
      </ul>
    </div>
  </nav>
</div>
