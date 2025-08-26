<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="s"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="sf"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@page isELIgnored="false"%>

<c:url var="addUrl" value="/ctl/gallary" />
<c:url var="addSearch" value="/ctl/gallary/search" />
<c:url var="editUrl" value="/ctl/gallary?id=" />

<!-- Role flags (front-end) -->
<c:set var="isAdmin"  value="${not empty sessionScope.admin}" />
<c:set var="isAlumni" value="${not empty sessionScope.alumni}" />
<c:set var="isStaff"  value="${not empty sessionScope.staff}" />

<style>
  /* === Color Hunt palette === */
  :root{
    --red:#E43636;
    --red-700:#c62f2f;
    --cream:#F6EFD2;
    --beige:#E2DDB4;
    --black:#000000;
    --white:#ffffff;
  }

  .page-wrap{ padding:24px; }

  .page-title{
    background:var(--red); color:var(--white);
    border-radius:12px; padding:14px 18px;
    display:flex; align-items:center; justify-content:space-between; gap:12px;
    box-shadow:0 8px 24px rgba(0,0,0,.12); margin-bottom:16px;
  }
  .page-title h1{ margin:0; font-size:22px; font-weight:800; letter-spacing:.2px; }

  .toolbar{ display:flex; flex-wrap:wrap; gap:12px; align-items:center; margin:12px 0 4px; }
  .toolbar .right{ display:flex; gap:10px; align-items:center; margin-left:auto; }

  .search-input{
    flex:1 1 280px; max-width:520px; border-radius:10px; border:1px solid #d8d8d8;
    padding:10px 14px; outline:none; background:var(--white);
    transition:border .15s ease, box-shadow .15s ease;
  }
  .search-input:focus{ border-color:var(--red); box-shadow:0 0 0 .15rem rgba(228,54,54,.25); }
  .result-pill{ min-width:fit-content; font-weight:700; color:black; background:var(--beige); padding:6px 10px; border-radius:999px; }

  .gallery-grid{
    display:grid; grid-template-columns:repeat(auto-fill, minmax(240px,1fr));
    gap:16px; margin-top:12px;
  }

  .g-card{
    background:var(--cream); border:1px solid #e9e9e9; border-radius:14px; overflow:hidden;
    box-shadow:0 10px 28px rgba(0,0,0,.06);
    transition:transform .08s ease, box-shadow .2s ease, border-color .2s ease;
  }
  .g-card:hover{ transform:translateY(-2px); box-shadow:0 14px 36px rgba(0,0,0,.10); border-color:#e0e0e0; }

  .g-media{ position:relative; aspect-ratio:16/10; background:#f6f6f6; overflow:hidden; cursor:pointer; }
  .g-media img{ width:100%; height:100%; object-fit:cover; display:block; transition:transform .25s; }
  .g-card:hover .g-media img{ transform:scale(1.03); }
  .g-badge{
    position:absolute; left:10px; top:10px; background:rgba(228,54,54,.95); color:#fff;
    padding:4px 8px; border-radius:999px; font-size:12px; font-weight:700; letter-spacing:.2px;
  }

  .g-body{ padding:12px 14px 14px; }
  .g-title{ font-weight:800; margin:0 0 6px; font-size:16px; line-height:1.25; color:var(--black); }
  .g-meta{ display:flex; justify-content:space-between; align-items:center; color:#666; font-size:12px; }

  .g-actions{ display:flex; gap:8px; }
  .g-btn{
    background:var(--white); color:var(--black);
    border:1px solid #e1e1e1; padding:7px 12px; border-radius:8px; font-weight:700; cursor:pointer;
    transition: border-color .2s ease, box-shadow .2s ease, transform .05s ease;
  }
  .g-btn:hover{ border-color:var(--red); box-shadow:0 0 0 .12rem rgba(228,54,54,.15); }
  .g-btn:active{ transform: translateY(1px); }

  .pick-wrap{ position:absolute; right:10px; top:10px; z-index:2; }
  .pick{
    width:18px; height:18px; accent-color:var(--red);
    border:1px solid #ddd; border-radius:4px; cursor:pointer;
  }

  .empty{
    border:1px dashed #cfcfcf; border-radius:12px; padding:30px 18px; text-align:center; color:#4b5b53;
    background:linear-gradient(180deg, var(--cream), #faf6e6);
  }
  .empty h3{ margin:0 0 6px; font-weight:800; color:#1b1b1b; }

  .foot-hint{ color:#6a7a71; font-size:12.5px; text-align:center; margin-top:16px; }

  .btn-danger{ border-radius:10px; font-weight:800; }
  .btn-outline-dark{ border-radius:10px; font-weight:700; }
</style>

<sf:form method="post" action="${pageContext.request.contextPath}/ctl/gallary/search" modelAttribute="form">
  <div class="container page-wrap">

    <!-- Header -->
    <div class="page-title">
      <h1>Gallery</h1>
    </div>

    <!-- Toolbar -->
    <div class="toolbar">
      <input id="gallerySearch" class="search-input" type="search" placeholder="Search by event title" aria-label="Search gallery">
      <div id="resultCount" class="result-pill">0 items</div>

      <div class="right">
        <!-- Admin-only: Select all + Delete -->
        <c:if test="${isAdmin}">
          <label class="form-check-label" style="display:flex; align-items:center; gap:6px;">
            <input id="selectall" type="checkbox" class="form-check-input" style="accent-color:var(--red);">
            Select All
          </label>

          <!-- Delete (posts operation=Delete + ids[]) -->
          <input id="deleteBtn" type="submit" name="operation" class="btn btn-danger btn-sm" value="Delete" disabled>
        </c:if>
      </div>
    </div>

    <!-- paging hidden fields -->
    <sf:input type="hidden" path="pageNo"/>
    <sf:input type="hidden" path="pageSize"/>
    <sf:input type="hidden" path="listsize"/>
    <sf:input type="hidden" path="total"/>
    <sf:input type="hidden" path="pagenosize"/>

    <!-- Grid -->
    <div id="galleryGrid" class="gallery-grid">
      <c:if test="${empty list}">
        <div class="empty" style="grid-column:1/-1;">
          <h3>No images yet</h3>
          <div>Add your first memories using <strong>Add to Gallery</strong>.</div>
        </div>
      </c:if>

      <c:forEach items="${list}" var="gl">
        <c:url var="imgUrl" value="/ctl/gallary/getImage/${gl.id}"/>
        <div class="g-card"
             data-title="${fn:toLowerCase(gl.event.title != null ? fn:escapeXml(gl.event.title) : '')}">
          <!-- Image / open modal -->
          <div class="g-media"
               role="button"
               tabindex="0"
               aria-label="Preview ${fn:escapeXml(gl.event.title != null ? gl.event.title : 'Untitled')}"
               data-bs-toggle="modal"
               data-bs-target="#previewModal"
               data-title="${fn:escapeXml(gl.event.title != null ? gl.event.title : 'Preview')}"
               data-img="${imgUrl}">

            <!-- Admin-only selection checkbox (name=ids for OP_DELETE) -->
            <c:if test="${isAdmin}">
              <div class="pick-wrap">
                <input type="checkbox" class="pick case" name="ids" value="${gl.id}">
              </div>
            </c:if>

            <img
              src="${imgUrl}"
              alt="${fn:escapeXml(gl.event.title != null ? gl.event.title : 'Untitled')}"
              loading="lazy"
              onerror="this.src='${pageContext.request.contextPath}/resources/images/placeholder.jpg'">
            <span class="g-badge">ALUMNI</span>
          </div>

          <div class="g-body">
            <h3 class="g-title">
              <c:out value="${gl.event.title != null ? gl.event.title : 'Untitled'}"/>
            </h3>
            <div class="g-meta">
              <div></div>
              <div class="g-actions">
                <button type="button"
                        class="g-btn"
                        data-bs-toggle="modal"
                        data-bs-target="#previewModal"
                        data-title="${fn:escapeXml(gl.event.title != null ? gl.event.title : 'Preview')}"
                        data-img="${imgUrl}">
                  Preview
                </button>
              </div>
            </div>
          </div>
        </div>
      </c:forEach>
    </div>

    <div class="foot-hint">Tip: use the search box to quickly filter cards. Select cards to enable delete.</div>
  </div>
</sf:form>

<!-- Preview Modal -->
<div class="modal fade" id="previewModal" tabindex="-1" aria-labelledby="previewModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg modal-dialog-centered">
    <div class="modal-content" style="border-radius:14px;overflow:hidden;">
      <div class="modal-header" style="border:0;">
        <h5 class="modal-title" id="previewModalLabel">Preview</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body" style="padding-top:0;">
        <img id="previewImg" src="" alt="" style="width:100%;height:auto;border-radius:10px;">
      </div>
      <div class="modal-footer" style="border:0;">
        <button type="button" class="btn btn-outline-dark" data-bs-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

<script>
  (function () {
    const grid = document.getElementById('galleryGrid');
    const input = document.getElementById('gallerySearch');
    const counter = document.getElementById('resultCount');
    const selectAll = document.getElementById('selectall');
    const deleteBtn = document.getElementById('deleteBtn');

    function updateCount() {
      if (!grid || !counter) return;
      const shown = grid.querySelectorAll('.g-card:not([hidden])').length;
      const total = grid.querySelectorAll('.g-card').length;
      counter.textContent = total ? (shown + ' of ' + total + ' items') : '0 items';
    }

    function filter() {
      const q = (input && input.value || '').toLowerCase().trim();
      const cards = grid.querySelectorAll('.g-card');
      cards.forEach(card => {
        const t = (card.dataset.title || '');
        const match = !q || t.indexOf(q) > -1;
        card.hidden = !match;
      });
      updateCount();
    }

    function boxes() {
      return Array.from(document.querySelectorAll('.case'));
    }

    function updateDeleteEnabled() {
      const any = boxes().some(b => b.checked);
      if (deleteBtn) deleteBtn.disabled = !any;
      if (selectAll) {
        const all = boxes();
        selectAll.checked = all.length && all.every(x => x.checked);
        selectAll.indeterminate = all.some(x => x.checked) && !selectAll.checked;
      }
    }

    if (input) input.addEventListener('input', filter);
    updateCount();

    if (selectAll) {
      selectAll.addEventListener('change', (e) => {
        boxes().forEach(b => b.checked = e.target.checked);
        updateDeleteEnabled();
      });
    }
    boxes().forEach(b => b.addEventListener('change', updateDeleteEnabled));
    updateDeleteEnabled();

    // Modal wiring
    const modal = document.getElementById('previewModal');
    if (modal) {
      modal.addEventListener('show.bs.modal', function (event) {
        const btn = event.relatedTarget;
        if (!btn) return;
        const img = btn.getAttribute('data-img');
        const title = btn.getAttribute('data-title') || 'Preview';
        document.getElementById('previewModalLabel').textContent = title;
        const imgEl = document.getElementById('previewImg');
        imgEl.src = img;
        imgEl.alt = title;
      });
      modal.addEventListener('hidden.bs.modal', function(){
        const imgEl = document.getElementById('previewImg');
        if (imgEl) imgEl.src = '';
      });
    }
  })();
</script>
