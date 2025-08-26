<%@taglib uri="http://www.springframework.org/tags/form" prefix="sf"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="crt"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="s"%>

<!-- Animate.css for fade animations -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>
<style>
  /* === Theme Variables (Color Hunt) === */
  :root{
    --red: #E43636;
    --red-700: #c62f2f;   /* hover */
    --cream: #F6EFD2;     /* light bg */
    --beige: #E2DDB4;     /* card bg alt / accents */
    --black: #000000;     /* text / gradient */
    --white: #ffffff;
  }

  /* Carousel */
  .carousel img.imageHeight {
    height: 460px;
    object-fit: cover;
    border-radius: 10px;
  }

  /* Section headers */
  .section-header {
    background-color: var(--red);
    padding: 15px 30px;
    border-radius: 8px;
    margin-top: 40px;
    margin-bottom: 20px;
    color: var(--white);
    box-shadow: 0 4px 8px rgba(0,0,0,0.25);
  }
  .section-header h1 { font-size: 28px; font-weight: 600; margin: 0; }

  /* Primary button */
  .btn-send {
    background-color: var(--red);
    color: var(--white);
    border-radius: 6px;
    padding: 8px 16px;
    border: none;
    transition: background-color 0.3s ease, transform .05s ease, box-shadow .2s ease;
    box-shadow: 0 2px 6px rgba(0,0,0,.15);
  }
  .btn-send:hover { background-color: var(--red-700); }
  .btn-send:active { transform: translateY(1px); }
  .btn-send:focus { outline: 0; box-shadow: 0 0 0 .15rem rgba(228,54,54,.35); }

  /* Cards / Surfaces */
  .info-card {
    background-color: var(--cream);
    color: var(--black);
    padding: 16px;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0,0,0,0.20);
    border: 1px solid rgba(0,0,0,0.05);
  }
  .info-card a { color: var(--red); text-decoration: none; }
  .info-card a:hover { color: var(--red-700); text-decoration: underline; }
  
 .db-card {
    background-color: var(--cream);
    color: var(--black);
    padding: 16px;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0,0,0,0.20);
    border: 1px solid rgba(0,0,0,0.05);
  }
  

  #faqcard{ margin-bottom:15px; }
  .lead { font-size: 1.1rem; line-height: 1.6; font-weight: normal; }

  /* Hero */
  .hero-section {
    /* red → black gradient */
    background: linear-gradient(to right, var(--red), var(--black));
    border-radius: 10px;
    margin: 20px 0;
    padding: 60px 20px;
  }

  /* Testimonials */
  .testimonial-container {
    /* soft transition using beige → red for warmth */
    background: linear-gradient(to right, var(--beige), var(--red));
    color: var(--black);
    border-radius: 10px;
    padding: 30px 20px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
    margin: 30px 0;
    text-align: center;
    font-size: 1.2rem;
    font-style: italic;
  }
  .testimonial-author {
    display: block; margin-top: 15px; font-weight: 600; font-size: 1rem; color: var(--black);
  }

  /* FAQ theme polish (Bootstrap accordion) */
  .accordion-button:not(.collapsed){
    color: var(--red);
    background-color: #fbf8ea; /* tint between cream & white for subtle contrast */
  }
  .accordion-button:focus{
    box-shadow: 0 0 0 .15rem rgba(228,54,54,.25);
    border-color: rgba(228,54,54,.35);
  }
  .accordion-item{
    border-radius:10px;
    overflow:hidden;
    border:1px solid #e8e8e8;
  }

  /* Small utility for logo hover */
  .acc-logo {
    height: 42px;
    margin: 0 6px;
    filter: grayscale(20%);
    transition: transform .08s ease, filter .15s ease;
  }
  .acc-logo:hover { transform: translateY(-1px); filter: none; }

  /* Counters */
  .count { font-weight: 800; font-size: 2rem; color: var(--red); }
</style>


<!-- ===== Hero ===== -->
<div class="hero-section text-center p-4">
  <h2 class="display-6 fw-bold text-light">Empowering Connections, Enabling Careers</h2>
  <p class="text-light">Your bridge between past, present, and future.</p>
  <a href="#contactForm" class="btn btn-send mt-3">Get In Touch</a>
</div>

<!-- ===== Carousel ===== -->
<div class="container mt-4">
  <div id="carouselExampleControls" class="carousel slide" data-bs-ride="carousel">
    <div class="carousel-inner">
      <div class="carousel-item active">
        <img src="${pageContext.request.contextPath}/resources/images/slide2.jpg"
             class="d-block w-100 imageHeight" alt="Slide 2">
      </div>
      <div class="carousel-item">
        <img src="${pageContext.request.contextPath}/resources/images/slide4.jpg"
             class="d-block w-100 imageHeight" alt="Slide 4">
      </div>
      <div class="carousel-item">
        <img src="${pageContext.request.contextPath}/resources/images/slide6.jpg"
             class="d-block w-100 imageHeight" alt="Slide 6">
      </div>
    </div>
    <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="prev">
      <span class="carousel-control-prev-icon"></span>
    </button>
    <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="next">
      <span class="carousel-control-next-icon"></span>
    </button>
  </div>
</div>

<!-- ===== About ===== -->
<div class="container">
  <div class="section-header"><h1>About Us</h1></div>
  <p class="lead">
    Our platform bridges the gap between alumni, students, and institutions by creating a digital ecosystem for knowledge sharing, networking, and mentorship.
  </p>
  <p class="lead">
    We are committed to empowering educational institutions with smart digital tools that allow them to maintain lifelong connections with their alumni while providing students access to a strong support network.
  </p>
  <p class="lead">
    With a secure, user-friendly interface, alumni can share experiences, offer guidance, and contribute to the development of future professionals. Our mission is to foster a collaborative environment where every member can grow and give back meaningfully.
  </p>
  <p class="lead">
    Whether you're a recent graduate or a seasoned professional, our platform ensures your voice, experience, and insights continue to shape the academic and professional journeys of others.
  </p>
</div>

<!-- ===== Counters ===== -->
<div class="container my-5">
  <div class="row text-center">
    <div class="col">
      <h2 class="count" data-target="1200">0</h2>
      <p>Registered Alumni</p>
    </div>
    <div class="col">
      <h2 class="count" data-target="350">0</h2>
      <p>Mentorship Sessions</p>
    </div>
    <div class="col">
      <h2 class="count" data-target="25">0</h2>
      <p>Years of Alumni Engagement</p>
    </div>
  </div>
</div>

<!-- ===== Testimonials ===== -->
<div class="container my-5">
  <div class="section-header"><h1>What Alumni Say</h1></div>

  <div id="testimonialCarousel" class="carousel slide" data-bs-ride="carousel">
    <div class="carousel-inner text-center">
      <div class="carousel-item active">
        <blockquote class="blockquote mb-0">
          <p class="mb-3">"This platform helped me reconnect and mentor the next generation. A true game-changer!"</p>
          <footer class="blockquote-footer text-black">Ananya Singh, Student of 2015</footer>
        </blockquote>
      </div>
      <div class="carousel-item">
        <blockquote class="blockquote mb-0">
          <p class="mb-3">"Finally, a place where I can give back and stay connected to my roots."</p>
          <footer class="blockquote-footer text-black">Rahul Verma, Student of 2010</footer>
        </blockquote>
      </div>
      <div class="carousel-item">
        <blockquote class="blockquote mb-0">
         <p class="mb-3">"An incredible initiative! The platform helped me collaborate on projects and share opportunities."</p>
         <footer class="blockquote-footer text-black">Meera Thakur, Student of 2012</footer>
      </blockquote>
     </div>
     <div class="carousel-item">
       <blockquote class="blockquote mb-0">
         <p class="mb-3">"I found a mentor for my startup idea through this network. Super helpful and motivating!"</p>
         <footer class="blockquote-footer text-black">Yash Agarwal, Student of 2016</footer>
      </blockquote>
      </div>
      <div class="carousel-item">
        <blockquote class="blockquote mb-0">
          <p class="mb-3">"A professional space that doesn't feel formal — it's like coming back home to your college."</p>
          <footer class="blockquote-footer text-black">Neha Sharma, Student of 2014</footer>
        </blockquote>
      </div>
    </div>

    <button class="carousel-control-prev" type="button" data-bs-target="#testimonialCarousel" data-bs-slide="prev">
      <span class="carousel-control-prev-icon"></span>
    </button>
    <button class="carousel-control-next" type="button" data-bs-target="#testimonialCarousel" data-bs-slide="next">
      <span class="carousel-control-next-icon"></span>
    </button>
  </div>
</div>

<!-- ===== Contact Us ===== -->
<div class="container">
  <div class="section-header"><h1>Contact Us</h1></div>

  <div class="row">
    <!-- Contact Form -->
    <div class="col-md-8">
      <div class="info-card p-4 mb-4">
        <form id="contactForm">
          <div class="row" id="contactForm">
            <div class="col-md-6">
              <div class="form-group mb-3">
                <label for="name">Name</label>
                <input type="text" class="form-control" id="name" placeholder="Enter name" required />
              </div>

              <div class="form-group mb-3">
                <label for="email">Email Address</label>
                <input type="email" class="form-control" id="email" placeholder="Enter email" required />
              </div>

              <div class="form-group mb-3">
                <label for="subject">Subject</label>
                <select id="subject" name="subject" class="form-control" required>
                  <option value="na" selected>Choose One:</option>
                  <option value="service">General Customer Service</option>
                  <option value="suggestions">Suggestions</option>
                  <option value="product">Product Support</option>
                </select>
              </div>
            </div>

            <div class="col-md-6">
              <div class="form-group mb-3">
                <label for="message">Message</label>
                <textarea name="message" id="message" class="form-control" rows="9" placeholder="Message" required></textarea>
              </div>
            </div>

            <div class="col-md-12 text-end">
              <button type="button" class="btn btn-send" id="btnContactUs">Send Message</button>
            </div>

            <!-- Animated success message -->
            <div class="col-md-12 mt-3">
              <div id="successAlert" class="alert alert-success d-none animate__animated" role="alert">
                ✅ Your message has been sent successfully!
              </div>
            </div>
          </div>
        </form>
      </div>
    </div>

    <!-- Right Column: Office + Download + Accreditations -->
    <div class="col-md-4">
      <!-- Our Office -->
      <div class="info-card mb-4">
        <div class="mb-2 fs-5 fw-bold">Our Office</div>
        <address>
          <strong>NEAR...</strong><br>
          example<br>
          <abbr title="Phone">Ph:</abbr> (+91) 0000000000
        </address>
        <address>
          <strong>G-Mail</strong><br>
          <a href="mailto:">@gmail.com</a>
        </address>
      </div>

      <!-- Download Brochure -->
      <div class="db-card mb-4 text-center">
        <h5 class="mb-2">Download Prospectus</h5>
        <p class="mb-3">Get detailed information about us.</p>
        <a href="${pageContext.request.contextPath}/resources/docs/prospectus.pdf"
           class="btn btn-send"  download>Download PDF</a>
      </div>

      
    </div>
  </div>
</div>

<!-- ===== FAQ ===== -->
<div class="container">
  <div class="row mt-4">
    <div class="col-12">
      <div class="section-header"><h1>Frequently Asked Questions</h1></div>

      <div class="info-card" id="faqcard">
        <div class="accordion" id="faqAcc">
          <!-- Q1 -->
          <div class="accordion-item">
            <h2 class="accordion-header" id="fq1h">
              <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#fq1" aria-expanded="false" aria-controls="fq1">
                How do I create an alumni account?
              </button>
            </h2>
            <div id="fq1" class="accordion-collapse collapse" aria-labelledby="fq1h" data-bs-parent="#faqAcc">
              <div class="accordion-body">
                Go to <a href="${pageContext.request.contextPath}/alumni/al-signUp">Alumni Sign-Up</a>,
                fill the form, and verify your email. You will be able to log in after approval.
              </div>
            </div>
          </div>

          <!-- Q2 -->
          <div class="accordion-item mt-2">
            <h2 class="accordion-header" id="fq2h">
              <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#fq2" aria-expanded="false" aria-controls="fq2">
                I forgot my password what should I do?
              </button>
            </h2>
            <div id="fq2" class="accordion-collapse collapse" aria-labelledby="fq2h" data-bs-parent="#faqAcc">
              <div class="accordion-body">
                Use <em>Change Password</em> from your account. If you are locked out, contact support via this form and we will assist.
              </div>
            </div>
          </div>

          <!-- Q3 -->
          <div class="accordion-item mt-2">
            <h2 class="accordion-header" id="fq3h">
              <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#fq3" aria-expanded="false" aria-controls="fq3">
                How can I register for events?
              </button>
            </h2>
            <div id="fq3" class="accordion-collapse collapse" aria-labelledby="fq3h" data-bs-parent="#faqAcc">
              <div class="accordion-body">
                Open events, choose an event, and click <em>Register</em>.
                You will receive a confirmation email (make sure you are signed in).
              </div>
            </div>
          </div>
        </div><!-- /accordion -->
      </div><!-- /info-card -->
    </div>
  </div>
</div>

<!-- ===== Scripts ===== -->
<script>
  // Contact form success toast
  document.getElementById("btnContactUs").addEventListener("click", function () {
    const alert = document.getElementById("successAlert");
    alert.classList.add("d-none");
    alert.classList.remove("animate__fadeInDown");
    setTimeout(() => {
      alert.classList.remove("d-none");
      alert.classList.add("animate__fadeInDown");
      setTimeout(() => { alert.classList.add("d-none"); }, 4000);
    }, 200);
  });

  // Counters
  document.querySelectorAll('.count').forEach(counter => {
    const target = +counter.getAttribute('data-target');
    let current = 0;
    const step = Math.max(1, Math.ceil(target / 200));
    const tick = () => {
      current += step;
      if (current >= target) current = target;
      counter.textContent = current;
      if (current < target) requestAnimationFrame(tick);
    };
    requestAnimationFrame(tick);
  });
</script>
