<%@taglib uri="http://www.springframework.org/tags/form" prefix="sf"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="crt"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="s"%>

<!-- Animate.css for animation -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>

<style>
  /* === Color Hunt Palette === */
  :root{
    --red: #E43636;
    --red-700: #c62f2f;       /* hover/darker red */
    --cream: #F6EFD2;         /* light surface */
    --beige: #E2DDB4;         /* subtle accents */
    --black: #000000;         /* headings / strong text */
    --white: #ffffff;
  }

  /* Page Header */
  .page-header {
    background-color: var(--red);
    padding: 15px 30px;
    border-radius: 8px;
    margin-top: 20px;
    margin-bottom: 30px;
    color: var(--white);
    box-shadow: 0 4px 8px rgba(0,0,0,0.25);
  }
  .page-header h1 {
    font-size: 28px;
    font-weight: 700;
    margin: 0;
    letter-spacing: .2px;
  }

  /* Card / Surface */
  .info-card {
    background-color: var(--cream);
    color: var(--black);
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0,0,0,0.25);
    border: 1px solid rgba(0,0,0,0.06);
  }
  .info-card a { color: var(--red); text-decoration: none; }
  .info-card a:hover { color: var(--red-700); text-decoration: underline; }

  .legend-title {
    font-size: 18px;
    font-weight: 700;
    color: var(--black);
    margin-bottom: 15px;
  }

  /* Form elements */
  .form-control {
    border-radius: 8px;
    box-shadow: none;
    border: 1px solid #cfcfcf;
    transition: border-color .2s ease, box-shadow .2s ease;
    background-color: var(--white);
  }
  .form-control:focus {
    border-color: var(--red);
    box-shadow: 0 0 0 .15rem rgba(228,54,54,.25);
  }

  /* Button */
  .btn-send {
    background-color: var(--red);
    border: none;
    padding: 10px 18px;
    font-size: 16px;
    color: var(--white);
    border-radius: 8px;
    transition: background-color .2s ease, transform .05s ease, box-shadow .2s ease;
    box-shadow: 0 2px 6px rgba(0,0,0,.15);
  }
  .btn-send:hover { background-color: var(--red-700); }
  .btn-send:active { transform: translateY(1px); }

  /* Hours table + map wrapper */
  .hours-table { width:100%; font-size:14px; }
  .hours-table td { padding:6px 0; border-bottom:1px dashed #e9e1ba; } /* beige tint */
  .hours-table td:first-child { color:#555; width:42%; }
  .map-embed { border-radius:10px; overflow:hidden; }

  /* Success alert tweak to match palette */
  .alert-success {
    background-color: #e8f6ea;
    border-color: #c9eccf;
    color: #1d7b3a;
  }
</style>

<!-- Main Contact Us Page -->
<div class="container">
  <div class="page-header">
    <h1>Contact Us</h1>
  </div>

  <div class="row">
    <!-- Contact Form -->
    <div class="col-md-8">
      <div class="info-card p-4 mb-4">
        <form id="contactForm">
          <div class="row">
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

      <!-- College Hours card -->
      <div class="info-card mb-4">
        <div class="legend-title">College Hours</div>
        <table class="hours-table">
          <tr><td>Mon to Fri</td><td>09:30 AM to 06:30 PM (IST)</td></tr>
          <tr><td>Saturday</td><td>10:00 AM to 02:00 PM (IST)</td></tr>
          <tr><td>Sunday and Holidays</td><td>Closed</td></tr>
        </table>
      </div>
    </div>

    <!-- Contact Info + Find Us -->
    <div class="col-md-4">
      <div class="info-card mb-4">
        <div class="legend-title">Our Office</div>
        <address>
          <strong>INSTAGRAM: </strong><br>
          Ghaziabad, Uttar Pradesh<br>
          <abbr title="Phone">P:</abbr> (+91) 0000000000
        </address>
        <address>
          <strong>Full Name</strong><br>
          <a href="mailto:">....@gmail.com</a>
        </address>
      </div>

      <div class="info-card">
        <div class="legend-title">Find Us</div>
        <div class="map-embed">
          <iframe
            title="Map to College"
            width="100%" height="230" style="border:0"
            loading="lazy" referrerpolicy="no-referrer-when-downgrade"
            src="https://www.google.com/maps?q=Ghaziabad%2C%20Uttar%20Pradesh&output=embed">
          </iframe>
        </div>
        <div class="mt-2" style="font-size: 12px; color:#6b6b6b;">Ghaziabad, Uttar Pradesh</div>
      </div>
    </div>
  </div>
</div>

<!-- JavaScript to show animated success message -->
<script>
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
</script>
