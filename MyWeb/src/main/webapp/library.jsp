<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width,initial-scale=1" />
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700;800&display=swap" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
  <title>Thư viện - BeatFlow</title>
  <link rel="stylesheet" href="assets/css/home.css">
  <link rel="stylesheet" href="assets/css/library.css">
</head>
<body>
  <%@ include file="header.jsp" %>
  <script>
    document.addEventListener('DOMContentLoaded', function() {
      const navLinks = document.querySelectorAll('.site-nav .nav-link');
      navLinks.forEach(link => {
        link.classList.remove('active');
        if (link.textContent.trim() === 'Thư viện') {
          link.classList.add('active');
        }
      });
    });
  </script>

  <!-- PAGE CONTENT -->
  <main class="container library-wrapper">
    <!-- Tabs + Stats -->
    <div class="library-tabs-stats">
      <div class="library-tabs">
        <a href="#overview"  data-tab="overview"  class="library-tab active">Overview</a>
        <a href="#likes"     data-tab="likes"     class="library-tab">Likes</a>
        <a href="#playlists" data-tab="playlists" class="library-tab">Playlists</a>
        <a href="#albums"    data-tab="albums"    class="library-tab">Albums</a>
        <a href="#stations"  data-tab="stations"  class="library-tab">Stations</a>
        <a href="#following" data-tab="following" class="library-tab">Following</a>
        <a href="#history"   data-tab="history"   class="library-tab">History</a>
      </div>
      <div class="library-stats">
        <div class="stat">150<br><span>Likes</span></div>
        <div class="stat">8<br><span>Playlists</span></div>
        <div class="stat">3<br><span>Albums</span></div>
      </div>
    </div>

    <!-- OVERVIEW (Build thêm nội dung từ các tab khác bằng JS) -->
    <section class="section-block lib-pane active" data-tab="overview" id="overviewPane">
      <h4 class="sub-title mb-3">Recently played</h4>
      <div class="card-row">
        <a href="#" class="playlist-card">
          <div class="playlist-img-wrapper">
            <img src="assets/img/avt_travis-scott.jpg" class="playlist-img rounded-circle" alt="Album">
          </div>
          <div class="playlist-title">Album</div>
          <div class="playlist-desc">MCK</div>
        </a>
        <a href="#" class="playlist-card">
          <div class="playlist-img-wrapper">
            <img src="assets/img/album1.jpg" class="playlist-img rounded-circle" alt="Artist">
          </div>
          <div class="playlist-title">MCK</div>
          <div class="playlist-desc">258K followers</div>
        </a>
        <a href="#" class="playlist-card">
          <div class="playlist-img-wrapper">
            <img src="assets/img/playlist1.jpg" class="playlist-img" alt="Playlist 1">
          </div>
          <div class="playlist-title">Cuốn cho anh 1 điều nữa đi</div>
          <div class="playlist-desc">Made for Takezo</div>
        </a>
        <a href="#" class="playlist-card">
          <div class="playlist-img-wrapper">
            <img src="assets/img/playlist2.jpg" class="playlist-img" alt="Playlist 2">
          </div>
          <div class="playlist-title">VSOUL Live</div>
          <div class="playlist-desc">Made for Takezo</div>
        </a>
      </div>
    </section>

    <!-- Likes -->
    <section class="section-block lib-pane" data-tab="likes">
      <div class="d-flex justify-content-between align-items-center mb-3">
        <h4 class="sub-title">Likes</h4>
      </div>
      <div class="card-row">
        <a href="#" class="playlist-card">
          <div class="playlist-img-wrapper">
            <img src="assets/img/drake.jpg" class="playlist-img" alt="God's Plan">
          </div>
          <div class="playlist-title">God's Plan</div>
          <div class="playlist-desc">Drake</div>
        </a>
        <a href="#" class="playlist-card">
          <div class="playlist-img-wrapper">
            <img src="assets/img/taylor-swift.png" class="playlist-img" alt="Cardigan">
          </div>
          <div class="playlist-title">Cardigan</div>
          <div class="playlist-desc">Taylor Swift</div>
        </a>
        <a href="#" class="playlist-card">
          <div class="playlist-img-wrapper">
            <img src="assets/img/ed-sheeran.jpg" class="playlist-img" alt="Shape of You">
          </div>
          <div class="playlist-title">Shape of You</div>
          <div class="playlist-desc">Ed Sheeran</div>
        </a>
        <a href="#" class="playlist-card">
          <div class="playlist-img-wrapper">
            <img src="assets/img/avt_travis-scott.jpg" class="playlist-img" alt="SICKO MODE">
          </div>
          <div class="playlist-title">SICKO MODE</div>
          <div class="playlist-desc">Travis Scott</div>
        </a>
      </div>
    </section>

    <!-- Playlists -->
    <section class="section-block lib-pane" data-tab="playlists">
      <div class="d-flex justify-content-between align-items-center mb-3">
        <h4 class="sub-title">Playlists</h4>
      </div>
      <div class="card-row">
        <a href="#" class="playlist-card"><div class="playlist-img-wrapper"><img src="assets/img/edm-playlist.jpg" class="playlist-img" alt="Electronic Dance"></div><div class="playlist-title">Electronic Dance</div><div class="playlist-desc">by BeatFlow</div></a>
        <a href="#" class="playlist-card"><div class="playlist-img-wrapper"><img src="assets/img/nkl2-playlist.jpg" class="playlist-img" alt="Nhạc Không Lời"></div><div class="playlist-title">Nhạc Không Lời</div><div class="playlist-desc">by BeatFlow</div></a>
        <a href="#" class="playlist-card"><div class="playlist-img-wrapper"><img src="assets/img/pop-playlist.jpg" class="playlist-img" alt="POP Hits"></div><div class="playlist-title">POP Hits</div><div class="playlist-desc">by BeatFlow</div></a>
        <a href="#" class="playlist-card"><div class="playlist-img-wrapper"><img src="assets/img/rnh-playlist.jpg" class="playlist-img" alt="Rap & Hip-Hop"></div><div class="playlist-title">Rap & Hip-Hop</div><div class="playlist-desc">by BeatFlow</div></a>
      </div>
    </section>

    <!-- Albums -->
    <section class="section-block lib-pane" data-tab="albums">
      <h4 class="sub-title mb-3">Albums</h4>
      <div class="card-row">
        <a href="#" class="playlist-card"><div class="playlist-img-wrapper"><img src="assets/img/ca-phe_song.jpg" class="playlist-img" alt="Cà Phê"></div><div class="playlist-title">Cà Phê</div><div class="playlist-desc">Minh</div></a>
        <a href="#" class="playlist-card"><div class="playlist-img-wrapper"><img src="assets/img/kem-duyen_song.jpg" class="playlist-img" alt="Kẻ Mê Duyên"></div><div class="playlist-title">Kẻ Mê Duyên</div><div class="playlist-desc">Hứa Kim Tuyền</div></a>
        <a href="#" class="playlist-card"><div class="playlist-img-wrapper"><img src="assets/img/avt_doja-cat.png" class="playlist-img" alt="Planet Her"></div><div class="playlist-title">Planet Her</div><div class="playlist-desc">Doja Cat</div></a>
        <a href="#" class="playlist-card"><div class="playlist-img-wrapper"><img src="assets/img/avt_bad-bunny.jpg" class="playlist-img" alt="Un Verano Sin Ti"></div><div class="playlist-title">Un Verano Sin Ti</div><div class="playlist-desc">Bad Bunny</div></a>
      </div>
    </section>

    <!-- Stations -->
    <section class="section-block lib-pane" data-tab="stations">
      <h4 class="sub-title mb-3">Stations</h4>
      <div class="card-row">
        <a href="#" class="playlist-card"><div class="playlist-img-wrapper"><img src="assets/img/rnh2-playlist.jpg" class="playlist-img" alt="Hip-Hop Radio"></div><div class="playlist-title">Hip-Hop Radio</div><div class="playlist-desc">Based on Travis Scott</div></a>
        <a href="#" class="playlist-card"><div class="playlist-img-wrapper"><img src="assets/img/edm2-playlist.jpg" class="playlist-img" alt="EDM Radio"></div><div class="playlist-title">EDM Radio</div><div class="playlist-desc">Based on Martin Garrix</div></a>
        <a href="#" class="playlist-card"><div class="playlist-img-wrapper"><img src="assets/img/viet-playlist.jpg" class="playlist-img" alt="V-Pop Radio"></div><div class="playlist-title">V-Pop Radio</div><div class="playlist-desc">Based on Sơn Tùng M-TP</div></a>
      </div>
    </section>

    <!-- Following -->
    <section class="section-block lib-pane" data-tab="following">
      <h4 class="sub-title mb-3">Following</h4>
      <div class="card-row">
        <a href="#" class="playlist-card">
          <div class="playlist-img-wrapper"><img src="assets/img/artist.png" class="playlist-img rounded-circle" alt="Nghệ sĩ"></div>
          <div class="playlist-title">BeatFlow Artist</div>
          <div class="playlist-desc">Nghệ sĩ được theo dõi</div>
        </a>
        <a href="#" class="playlist-card">
          <div class="playlist-img-wrapper"><img src="assets/img/profile_avatar.jpg" class="playlist-img rounded-circle" alt="DJ Night"></div>
          <div class="playlist-title">DJ Night</div>
          <div class="playlist-desc">Producer</div>
        </a>
        <a href="#" class="playlist-card">
          <div class="playlist-img-wrapper"><img src="assets/img/user.jpg" class="playlist-img rounded-circle" alt="Indie Girl"></div>
          <div class="playlist-title">Indie Girl</div>
          <div class="playlist-desc">Singer</div>
        </a>
      </div>
    </section>

    <!-- History -->
    <section class="section-block lib-pane" data-tab="history">
      <h4 class="sub-title mb-3">History</h4>
      <div class="card-row">
        <a href="#" class="playlist-card">
          <div class="playlist-img-wrapper">
            <img src="assets/img/edm-playlist.jpg" class="playlist-img" alt="Night Drive">
          </div>
          <div class="playlist-title">Night Drive</div>
          <div class="playlist-desc">John Doe · 2 ngày trước</div>
        </a>
        <a href="#" class="playlist-card">
          <div class="playlist-img-wrapper">
            <img src="assets/img/pop2-playlist.png" class="playlist-img" alt="Pop Chill">
          </div>
          <div class="playlist-title">Pop Chill</div>
          <div class="playlist-desc">Jane Smith · 1 tuần trước</div>
        </a>
        <a href="#" class="playlist-card">
          <div class="playlist-img-wrapper">
            <img src="assets/img/hero-upload.png" class="playlist-img" alt="Upload Session">
          </div>
          <div class="playlist-title">Upload Session</div>
          <div class="playlist-desc">Bạn · 2 tuần trước</div>
        </a>
      </div>
    </section>
  </main>	

  <script>
    (function () {
      // Build Overview by cloning other panes
      (function buildOverview(){
        const overviewPane = document.getElementById('overviewPane');
        const panes = Array.from(document.querySelectorAll('.lib-pane')).filter(p => p.dataset.tab !== 'overview');
        panes.forEach(p => {
          const clone = p.cloneNode(true);
          clone.classList.remove('lib-pane', 'active');
          overviewPane.appendChild(clone);
        });
      })();

      // Tabs
      const tabs = document.querySelectorAll('.library-tabs .library-tab');
      const panes = document.querySelectorAll('.lib-pane');
      function activate(tab){
        tabs.forEach(a => a.classList.toggle('active', a.dataset.tab === tab));
        let found = false;
        panes.forEach(p => {
          const m = p.dataset.tab === tab;
          p.classList.toggle('active', m);
          if (m) found = true;
        });
        if (!found){ activate('overview'); history.replaceState(null,'','#overview'); }
      }
      function fromHash(){ const h = location.hash.replace('#','').trim(); return h || 'overview'; }
      tabs.forEach(a => a.addEventListener('click', e => { e.preventDefault(); const t=a.dataset.tab; if(location.hash!=='#'+t) history.pushState(null,'','#'+t); activate(t); }));
      window.addEventListener('hashchange', () => activate(fromHash()));
      activate(fromHash());

      // Dropdowns
      const btnProfile = document.getElementById('profileMenuButton');
      const btnCaret   = document.getElementById('dropdownMenuButton');
      const menuAcc    = document.getElementById('dropdownMenu');
      const btnNoti = document.getElementById('notificationsMenuButton');
      const menuNoti = document.getElementById('notificationsMenu');
      const btnMsg = document.getElementById('messagesMenuButton');
      const menuMsg = document.getElementById('messagesMenu');
      const menus = [menuAcc, menuNoti, menuMsg];
      const buttons = [btnProfile, btnCaret, btnNoti, btnMsg];
      function closeAll(){ menus.forEach(m=>m&&m.classList.remove('show')); buttons.forEach(b=>b&&b.setAttribute('aria-expanded','false')); }
      function toggle(menu, btn){ if(!menu) return; const isOpen = menu.classList.contains('show'); closeAll(); if(!isOpen){ menu.classList.add('show'); btn&&btn.setAttribute('aria-expanded','true'); } }
      menus.forEach(m => m && m.addEventListener('click', e => e.stopPropagation()));
      btnProfile && btnProfile.addEventListener('click', e => { e.stopPropagation(); toggle(menuAcc, btnProfile); });
      btnCaret   && btnCaret.addEventListener('click',   e => { e.stopPropagation(); toggle(menuAcc, btnCaret); });
      btnNoti && btnNoti.addEventListener('click', e => { e.stopPropagation(); toggle(menuNoti, btnNoti); });
      btnMsg  && btnMsg.addEventListener('click',  e => { e.stopPropagation(); toggle(menuMsg, btnMsg); });
      document.addEventListener('click', closeAll);
      document.addEventListener('keydown', e => { if(e.key==='Escape') closeAll(); });
    })();
  </script>

  <!-- Footer -->
  <footer class="py-4" style="background:#0d0d0d; color:#bbb; font-size:.9rem;">
    <div class="container text-center">
      <div class="bf-footer-links">
        <div class="mb-3">
          <a href="#" class="text-secondary me-2">Trang chính thức</a> ·
          <a href="#" class="text-secondary mx-2">Bảo mật</a> ·
          <a href="#" class="text-secondary mx-2">Chính sách Cookie</a> ·
          <a href="#" class="text-secondary mx-2">Trình quản lý Cookie</a> ·
          <a href="#" class="text-secondary mx-2">Xuất bản</a> ·
          <a href="#" class="text-secondary mx-2">Nguồn nghệ sĩ</a> ·
          <a href="#" class="text-secondary mx-2">Tin tức</a> ·
          <a href="#" class="text-secondary mx-2">Biểu đồ</a> ·
          <a href="#" class="text-secondary mx-2">Uy tín</a>
        </div>
        <div class="text-secondary">Ngôn ngữ: <a href="#" class="text-primary fw-bold">Tiếng Việt (VN)</a></div>
      </div>
    </div>
  </footer>
</body>
</html>