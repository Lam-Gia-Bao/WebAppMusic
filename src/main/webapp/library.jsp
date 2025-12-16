<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width,initial-scale=1" />

  <!-- Bootstrap 5 CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

  <!-- Google Font -->
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700;800&display=swap" rel="stylesheet">

  <!-- Bootstrap Icons -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">

  <title>Thư viện - BeatFlow</title>


  <link rel="stylesheet" href="assets/css/library.css">
</head>
<body>

  <!-- NAVBAR -->
  <nav class="site-nav">
    <div class="container d-flex align-items-center justify-content-between">
      <div class="d-flex align-items-center gap-3">
        <div class="bf-logo">
          <img src="assets/img/logo.png" alt="BeatFlow logo" class="bf-logo-img">
          <span class="brand">BeatFlow</span>
        </div>
        <ul class="nav d-none d-md-flex">
          <li class="nav-item"><a class="nav-link " href="#">Trang chủ</a></li>
          <li class="nav-item"><a class="nav-link" href="#">Tin tức</a></li>
          <li class="nav-item"><a class="nav-link active" href="#">Thư viện</a></li>
        </ul>
      </div>
      <div class="flex-grow-1 px-4">
        <div class="search-wrapper">
          <input class="search-input" type="text" placeholder="Tìm kiếm những bài hát, bản nhạc, playlist, album">
          <i class="bi bi-search search-icon"></i>
        </div>
      </div>
      <div class="d-flex align-items-center gap-3">
        <a href="#" class="nav-function-link">Dành cho nghệ sĩ</a>
        <a href="upload.jsp" class="nav-function-link">Đăng tải</a>

        <button class="btn-icon-nav" aria-label="Profile">
          <img src="assets/img/profile_avatar.jpg" alt="Profile" class="profile-avatar-small">
        </button>

        <div class="dropdown-container">
          <button class="btn-icon-nav" id="dropdownMenuButton" aria-haspopup="true" aria-expanded="false" aria-label="Tài khoản">
            <i class="bi bi-chevron-down"></i>
          </button>
          <div class="dropdown-menu-custom" id="dropdownMenu" role="menu">
            <a href="#" class="dropdown-item-custom"><i class="bi bi-person"></i><span>Trang cá nhân</span></a>
            <a href="#" class="dropdown-item-custom"><i class="bi bi-heart"></i><span>Đã thích</span></a>
            <a href="#" class="dropdown-item-custom"><i class="bi bi-collection-play"></i><span>Playlist nhạc</span></a>
            <a href="#" class="dropdown-item-custom"><i class="bi bi-broadcast"></i><span>Đài phát thanh</span></a>
            <a href="#" class="dropdown-item-custom"><i class="bi bi-people"></i><span>Đang theo dõi</span></a>
            <a href="#" class="dropdown-item-custom"><i class="bi bi-person-plus"></i><span>Đề xuất theo dõi</span></a>
            <a href="#" class="dropdown-item-custom"><i class="bi bi-music-note-list"></i><span>Những bản track</span></a>
            <a href="#" class="dropdown-item-custom"><i class="bi bi-bar-chart"></i><span>Thông tin về người nghe</span></a>
          </div>
        </div>

        <div class="dropdown-container">
          <button class="btn-icon-nav" id="notificationsMenuButton" aria-haspopup="true" aria-expanded="false" aria-label="Thông báo">
            <i class="bi bi-bell"></i>
          </button>
          <div class="messages-dropdown" id="notificationsMenu" role="menu">
            <div class="messages-header"><h5 class="m-0">Thông báo</h5></div>
            <div class="messages-body"><p class="no-messages">Bạn chưa có thông báo nào.</p></div>
            <div class="messages-footer"><a href="#" class="view-all-link">Xem tất cả thông báo</a></div>
          </div>
        </div>

        <div class="dropdown-container">
          <button class="btn-icon-nav" id="messagesMenuButton" aria-haspopup="true" aria-expanded="false" aria-label="Tin nhắn">
            <i class="bi bi-envelope"></i>
          </button>
          <div class="messages-dropdown" id="messagesMenu" role="menu">
            <div class="messages-header"><h5 class="m-0">Tin nhắn</h5></div>
            <div class="messages-body"><p class="no-messages">Bạn chưa có tin nhắn nào.</p></div>
            <div class="messages-footer"><a href="#" class="view-all-link">Xem tất cả tin nhắn</a></div>
          </div>
        </div>
      </div>
    </div>
  </nav>

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

    <!-- OVERVIEW -->
    <section class="section-block lib-pane active" data-tab="overview">
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
        <a href="#likes" class="view-all-link-small">Browse trending playlists</a>
      </div>
      <div class="card-row">
        <a href="#" class="playlist-card only-img"><div class="playlist-img-wrapper"><img src="assets/img/like1.jpg" class="playlist-img" alt="Like 1"></div></a>
        <a href="#" class="playlist-card only-img"><div class="playlist-img-wrapper"><img src="assets/img/like2.jpg" class="playlist-img" alt="Like 2"></div></a>
        <a href="#" class="playlist-card only-img"><div class="playlist-img-wrapper"><img src="assets/img/like3.jpg" class="playlist-img" alt="Like 3"></div></a>
        <a href="#" class="playlist-card only-img"><div class="playlist-img-wrapper"><img src="assets/img/like4.jpg" class="playlist-img" alt="Like 4"></div></a>
      </div>
    </section>

    <!-- Playlists -->
    <section class="section-block lib-pane" data-tab="playlists">
      <div class="d-flex justify-content-between align-items-center mb-3">
        <h4 class="sub-title">Playlists</h4>
        <a href="#playlists" class="view-all-link-small">View all</a>
      </div>
      <div class="card-row">
        <a href="#" class="playlist-card"><div class="playlist-img-wrapper"><img src="assets/img/playlist3.jpg" class="playlist-img" alt="Chill Vibes"></div><div class="playlist-title">Chill Vibes</div><div class="playlist-desc">by Takezo</div></a>
        <a href="#" class="playlist-card"><div class="playlist-img-wrapper"><img src="assets/img/playlist4.jpg" class="playlist-img" alt="Road Trip"></div><div class="playlist-title">Road Trip</div><div class="playlist-desc">by Takezo</div></a>
        <a href="#" class="playlist-card"><div class="playlist-img-wrapper"><img src="assets/img/playlist5.jpg" class="playlist-img" alt="Workout Mix"></div><div class="playlist-title">Workout Mix</div><div class="playlist-desc">by Takezo</div></a>
        <a href="#" class="playlist-card"><div class="playlist-img-wrapper"><img src="assets/img/playlist6.jpg" class="playlist-img" alt="Focus Beats"></div><div class="playlist-title">Focus Beats</div><div class="playlist-desc">by Takezo</div></a>
      </div>
    </section>

    <!-- Albums -->
    <section class="section-block lib-pane" data-tab="albums">
      <h4 class="sub-title mb-3">Albums</h4>
      <p class="text-muted">Nội dung mẫu.</p>
    </section>

    <!-- Stations -->
    <section class="section-block lib-pane" data-tab="stations">
      <h4 class="sub-title mb-3">Stations</h4>
      <p class="text-muted">Nội dung mẫu.</p>
    </section>

    <!-- Following -->
    <section class="section-block lib-pane" data-tab="following">
      <h4 class="sub-title mb-3">Following</h4>
      <p class="text-muted">Nội dung mẫu.</p>
    </section>

    <!-- History -->
    <section class="section-block lib-pane" data-tab="history">
      <h4 class="sub-title mb-3">History</h4>
      <p class="text-muted">Nội dung mẫu.</p>
    </section>
  </main>

  <!-- Tabs script (client-side, không cần JSTL/Servlet) -->
  <script>
    (function () {
      const tabs = document.querySelectorAll('.library-tabs .library-tab');
      const panes = document.querySelectorAll('.lib-pane');

      function activate(tab) {
        tabs.forEach(a => a.classList.toggle('active', a.dataset.tab === tab));
        let found = false;
        panes.forEach(p => {
          const match = p.dataset.tab === tab;
          p.classList.toggle('active', match);
          if (match) found = true;
        });
        if (!found) {
          activate('overview');
          history.replaceState(null, '', '#overview');
        }
      }

      function fromHash() {
        const h = location.hash.replace('#', '').trim();
        return h || 'overview';
      }

      tabs.forEach(a => {
        a.addEventListener('click', (e) => {
          e.preventDefault();
          const tab = a.dataset.tab;
          if (location.hash !== '#' + tab) history.pushState(null, '', '#' + tab);
          activate(tab);
        });
      });

      window.addEventListener('hashchange', () => activate(fromHash()));
      activate(fromHash());
    })();
  </script>
</body>
</html>