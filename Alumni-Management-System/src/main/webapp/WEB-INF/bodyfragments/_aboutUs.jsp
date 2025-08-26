<%@taglib uri="http://www.springframework.org/tags/form" prefix="sf"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="crt"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="s"%>

<!-- Optional animation support -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>

<!-- Styles (updated to Color Hunt palette) -->
<style>
  :root{
    --red: #E43636;
    --red-700: #c62f2f;    /* hover/darker red */
    --cream: #F6EFD2;      /* light surface */
    --beige: #E2DDB4;      /* secondary surface */
    --black: #000000;      /* headings / strong text */
    --white: #ffffff;
  }

  /* Section headers */
  .section-header {
    background-color: var(--red);
    padding: 15px 30px;
    border-radius: 8px;
    margin-top: 20px;
    margin-bottom: 30px;
    color: var(--white);
    box-shadow: 0 4px 8px rgba(0,0,0,0.25);
  }
  .section-header h1 {
    font-size: 28px;
    font-weight: 700;
    margin: 0;
    letter-spacing: .2px;
  }

  /* Body text */
  .lead {
    font-size: 1.15rem;
    color: #222; /* stronger contrast on light bg */
    line-height: 1.75;
    margin-bottom: 16px;
    font-weight: 400;
  }

  /* Team section spacing */
  .team-section {
    margin-top: 60px;
  }

  /* Team cards (cream base, beige accent top border) */
  .team-card {
    background-color: var(--cream);
    color: var(--black);
    padding: 20px;
    border-radius: 12px;
    box-shadow: 0 4px 10px rgba(0,0,0,0.18);
    text-align: center;
    border: 1px solid rgba(0,0,0,0.06);
    position: relative;
  }
  .team-card::before{
    content: "";
    position: absolute;
    top: 0; left: 0; right: 0;
    height: 6px;
    background: linear-gradient(90deg, var(--red), var(--beige));
    border-top-left-radius: 12px;
    border-top-right-radius: 12px;
  }

  .team-card img {
    width: 120px;
    height: 120px;
    object-fit: cover;
    border-radius: 50%;
    margin-bottom: 10px;
    border: 3px solid var(--red);
    background: var(--white);
  }

  .team-card h5 {
    margin: 12px 0 6px;
    font-weight: 700;
    color: var(--black);
    letter-spacing: .2px;
  }

  .team-card p {
    font-size: 0.95rem;
    color: #333;
    margin: 0;
  }

  /* Small hover lift for cards */
  .team-card:hover{
    transform: translateY(-2px);
    transition: transform .15s ease, box-shadow .15s ease;
    box-shadow: 0 10px 18px rgba(0,0,0,0.22);
  }
</style>

<!-- About Us Header -->
<div class="container">
  <div class="section-header">
    <h1>About Us</h1>
  </div>

  <!-- About Content -->
  <div>
    <p class="lead">
      The Alumni Management System is designed to bridge the gap between former students and their alma mater, creating a vibrant, connected, and collaborative alumni community.
    </p>

    <p class="lead">
      Our mission is to provide a centralized platform where alumni can stay informed about campus news, participate in events, post and apply for jobs, and share their achievements with peers and faculty.
    </p>

    <p class="lead">
      Whether you're a recent graduate or a long-standing member of the alumni family, our system makes it easy to reconnect with classmates, engage with students, and contribute to institutional growth.
    </p>

    <p class="lead">
      From managing placement opportunities and gathering feedback to showcasing galleries of past memories, this platform empowers both administrators and alumni to maintain meaningful connections.
    </p>

    <p class="lead">
      We believe in fostering lifelong relationships, professional networking, and community-building — all made possible through secure, user-friendly technology.
    </p>
  </div>

  <!-- Team Section -->
  <div class="team-section">
    <div class="section-header">
      <h1>Meet Our Team</h1>
    </div>

    <div class="row">
      <div class="col-md-4 mb-4">
        <div class="team-card">
          <img src="${pageContext.request.contextPath}/resources/images/user-avatar1.png" alt="Tanishq Singh">
          <h5>Tanishq Singh</h5>
          <p>Founder &amp; Project Lead</p>
        </div>
      </div>

      <div class="col-md-4 mb-4">
        <div class="team-card">
          <img src="${pageContext.request.contextPath}/resources/images/user-avatar2.png" alt="Team Member">
        <h5>Tarang Sharma</h5>
          <p>Lead Developer</p>
        </div>
      </div>

      <div class="col-md-4 mb-4">
        <div class="team-card">
          <img src="${pageContext.request.contextPath}/resources/images/user-avatar3.png" alt="Team Member">
          <h5>Vidit Raj Jain</h5>
          <p>UI/UX Designer</p>
        </div>
      </div>
    </div>
  </div>
</div>
