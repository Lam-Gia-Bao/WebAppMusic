<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width,initial-scale=1" />

  <!-- Bootstrap 5 CSS (utilities + icons sizing) -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

  <!-- Google Font -->
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700;800&display=swap" rel="stylesheet">

  <!-- Bootstrap Icons -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">

  <title>Hồ sơ - BeatFlow</title>

  <!-- Page CSS -->
  <link rel="stylesheet" href="assets/css/profile.css">
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
          <li class="nav-item"><a class="nav-link active" href="#">Trang chủ</a></li>
          <li class="nav-item"><a class="nav-link" href="#">Tin tức</a></li>
          <li class="nav-item"><a class="nav-link" href="#">Thư viện</a></li>
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

  <!-- COVER + PROFILE -->
  <div class="profile-cover"></div>

  <div class="profile-wrapper">

    <!-- Avatar -->
    <div class="profile-center">
      <img src="assets/img/user.jpg" class="avatar" alt="avatar">
      <h1 class="username">Takezo</h1>
    </div>

    <!-- Tabs + Stats -->
    <div class="tabs-stats">
      <div class="profile-tabs">
        <a href="#all"      data-tab="all" class="active">Tất cả</a>
        <a href="#tracks"   data-tab="tracks">Bài hát</a>
        <a href="#playlist" data-tab="playlist">Playlist</a>
        <a href="#favorite" data-tab="favorite">Yêu thích</a>
        <a href="#upload"   data-tab="upload">Đã upload</a>
        <a href="#history"  data-tab="history">Lịch sử</a>
      </div>

      <div class="profile-stats">
        <div class="stat">150<br><span>Followers</span></div>
        <div class="stat">20<br><span>Following</span></div>
        <div class="stat">36<br><span>Tracks</span></div>
      </div>
    </div>

    <!-- ========================= CONTENT ========================= -->

    <!-- ALL -->
    <section class="tab-content active" data-tab="all">
      <h2 class="track-title-header">Bài hát nổi bật</h2>
      <div class="track-list">
        <div class="track-card">
          <img src="assets/img/track1.jpg" alt="track">
          <div><p class="track-title">Track A</p></div>
        </div>
        <div class="track-card">
          <img src="assets/img/track1.jpg" alt="track">
          <div><p class="track-title">Track B</p></div>
        </div>
        <div class="track-card">
          <img src="assets/img/track1.jpg" alt="track">
          <div><p class="track-title">Track C</p></div>
        </div>
        <div class="track-card">
          <img src="assets/img/track1.jpg" alt="track">
          <div><p class="track-title">Track D</p></div>
        </div>
      </div>

      <h2 class="track-title-header" style="margin-top:24px;">Yêu thích</h2>
      <div class="track-list">
        <div class="track-card">
          <img src="assets/img/track3.jpg" alt="favorite">
          <div><p class="track-title">Fav 1</p></div>
        </div>
        <div class="track-card">
          <img src="assets/img/track3.jpg" alt="favorite">
          <div><p class="track-title">Fav 2</p></div>
        </div>
        <div class="track-card">
          <img src="assets/img/track3.jpg" alt="favorite">
          <div><p class="track-title">Fav 3</p></div>
        </div>
      </div>
    </section>

    <!-- TRACKS -->
    <section class="tab-content" data-tab="tracks">
      <h2 class="track-title-header">Tất cả bài hát</h2>
      <div class="track-list">
        <div class="track-card">
          <img src="assets/img/track1.jpg" alt="track">
          <div><p class="track-title">Track A</p></div>
        </div>
        <div class="track-card">
          <img src="assets/img/track1.jpg" alt="track">
          <div><p class="track-title">Track B</p></div>
        </div>
        <div class="track-card">
          <img src="assets/img/track1.jpg" alt="track">
          <div><p class="track-title">Track C</p></div>
        </div>
        <div class="track-card">
          <img src="assets/img/track1.jpg" alt="track">
          <div><p class="track-title">Track D</p></div>
        </div>
      </div>
    </section>

    <!-- PLAYLIST -->
    <section class="tab-content" data-tab="playlist">
      <h2 class="track-title-header">Playlist</h2>
      <button class="create-playlist-btn" id="openCreatePlaylist">+ Tạo Playlist</button>
      <div class="playlist-grid">
        <div class="playlist-card">
          <img src="assets/img/playlist.jpg" class="playlist-thumb" alt="playlist">
          <p class="playlist-name">Chill Vibes</p>
          <p class="playlist-meta">12 tracks</p>
        </div>
        <div class="playlist-card">
          <img src="assets/img/playlist.jpg" class="playlist-thumb" alt="playlist">
          <p class="playlist-name">Workout Mix</p>
          <p class="playlist-meta">20 tracks</p>
        </div>
        <div class="playlist-card">
          <img src="assets/img/playlist.jpg" class="playlist-thumb" alt="playlist">
          <p class="playlist-name">Study Beats</p>
          <p class="playlist-meta">15 tracks</p>
        </div>
      </div>
    </section>

    <!-- FAVORITE -->
    <section class="tab-content" data-tab="favorite">
      <h2 class="track-title-header">Yêu thích</h2>
      <div class="track-list">
        <div class="track-card">
          <img src="assets/img/track3.jpg" alt="favorite">
          <p class="track-title">Fav 1</p>
        </div>
        <div class="track-card">
          <img src="assets/img/track3.jpg" alt="favorite">
          <p class="track-title">Fav 2</p>
        </div>
        <div class="track-card">
          <img src="assets/img/track3.jpg" alt="favorite">
          <p class="track-title">Fav 3</p>
        </div>
      </div>
    </section>

    <!-- UPLOAD -->
    <section class="tab-content" data-tab="upload">
      <h2 class="track-title-header">Đã upload</h2>
      <div class="track-list">
        <div class="track-card">
          <img src="assets/img/track1.jpg" alt="upload">
          <p class="track-title">My Upload 1</p>
        </div>
        <div class="track-card">
          <img src="assets/img/track1.jpg" alt="upload">
          <p class="track-title">My Upload 2</p>
        </div>
      </div>
    </section>

    <!-- HISTORY -->
    <section class="tab-content" data-tab="history">
      <h2 class="track-title-header">Lịch sử nghe nhạc</h2>
      <div class="track-list">
        <div class="track-card">
          <img src="assets/img/track2.jpg" alt="history">
          <p class="track-title">Played X</p>
        </div>
        <div class="track-card">
          <img src="assets/img/track2.jpg" alt="history">
          <p class="track-title">Played Y</p>
        </div>
        <div class="track-card">
          <img src="assets/img/track2.jpg" alt="history">
          <p class="track-title">Played Z</p>
        </div>
      </div>
    </section>

  </div>

  <!-- CREATE PLAYLIST MODAL -->
  <div class="modal-overlay" id="createPlaylistModal" role="dialog" aria-modal="true" aria-labelledby="createPlaylistTitle">
    <div class="modal-box">
      <button class="modal-close" id="closeCreatePlaylist" aria-label="Đóng">
        <i class="bi bi-x-lg"></i>
      </button>
      <h3 id="createPlaylistTitle">Tạo playlist mới</h3>

      <form id="createPlaylistForm">
        <!-- Cover -->
        <div class="cover-row">
          <div class="cover-preview">
            <img id="plCoverPreview" src="assets/img/playlist.jpg" alt="Ảnh bìa">
          </div>
          <div class="cover-actions">
            <label class="btn-file">
              <input type="file" id="plCoverInput" accept="image/*" hidden>
              <i class="bi bi-image"></i> Chọn ảnh bìa
            </label>
            <button type="button" class="btn-ghost" id="plCoverReset"><i class="bi bi-arrow-counterclockwise"></i> Đặt lại</button>
          </div>
        </div>

        <!-- Name -->
        <label class="form-label" for="plName">Tên playlist</label>
        <input type="text" id="plName" class="form-control-like" placeholder="VD: Chill tối thứ 7" required maxlength="80">

        <!-- Description -->
        <label class="form-label" for="plDesc">Mô tả (tuỳ chọn)</label>
        <textarea id="plDesc" class="form-control-like" rows="3" placeholder="Giới thiệu ngắn về playlist này..."></textarea>

        <!-- Privacy + Topic -->
        <div class="row-2">
          <div class="col">
            <label class="form-label" for="plPrivacy">Quyền riêng tư</label>
            <select id="plPrivacy" class="form-control-like">
              <option value="public">Công khai</option>
              <option value="unlisted">Không công khai</option>
              <option value="private">Riêng tư</option>
            </select>
          </div>
          <div class="col">
            <label class="form-label" for="plTopic">Chủ đề</label>
            <select id="plTopic" class="form-control-like">
              <option value="chill">Chill</option>
              <option value="workout">Workout</option>
              <option value="study">Study</option>
              <option value="party">Party</option>
              <option value="lofi">Lo-fi</option>
            </select>
          </div>
        </div>

        <!-- Tags -->
        <label class="form-label" for="plTags">Thẻ (phân tách bằng dấu phẩy)</label>
        <input type="text" id="plTags" class="form-control-like" placeholder="vd: chill, lofi, relax">

        <!-- Actions -->
        <div class="modal-actions">
          <button type="button" class="btn-cancel" id="btnCancelCreate">Hủy</button>
          <button type="submit" class="btn-create" id="btnCreate" disabled>Tạo playlist</button>
        </div>
      </form>
    </div>
  </div>

  <!-- Tabs + Modal script -->
  <script>
    (function () {
      // Tabs
      const tabs = document.querySelectorAll('.profile-tabs a');
      const panes = document.querySelectorAll('.tab-content');

      function activate(tab) {
        tabs.forEach(a => a.classList.toggle('active', a.dataset.tab === tab));
        let found = false;
        panes.forEach(p => {
          const match = p.dataset.tab === tab;
          p.classList.toggle('active', match);
          if (match) found = true;
        });
        if (!found) {
          activate('all');
          history.replaceState(null, '', '#all');
        }
      }
      function fromHash() {
        const h = location.hash.replace('#', '').trim();
        return h || 'all';
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

      // Modal
      const openBtn = document.getElementById('openCreatePlaylist');
      const modal = document.getElementById('createPlaylistModal');
      const closeBtn = document.getElementById('closeCreatePlaylist');
      const cancelBtn = document.getElementById('btnCancelCreate');
      const form = document.getElementById('createPlaylistForm');
      const nameInput = document.getElementById('plName');
      const createBtn = document.getElementById('btnCreate');
      const coverInput = document.getElementById('plCoverInput');
      const coverPreview = document.getElementById('plCoverPreview');
      const coverReset = document.getElementById('plCoverReset');
      const defaultCover = coverPreview.src;

      function openModal() {
        modal.classList.add('show');
        // focus tên sau 150ms để đảm bảo CSS animation
        setTimeout(() => nameInput.focus(), 150);
        document.body.style.overflow = 'hidden';
      }
      function closeModal() {
        modal.classList.remove('show');
        document.body.style.overflow = '';
      }

      openBtn?.addEventListener('click', () => openModal());
      closeBtn?.addEventListener('click', () => closeModal());
      cancelBtn?.addEventListener('click', () => closeModal());

      // click ra ngoài để đóng
      modal?.addEventListener('click', (e) => {
        if (e.target === modal) closeModal();
      });
      // phím ESC
      document.addEventListener('keydown', (e) => {
        if (e.key === 'Escape' && modal.classList.contains('show')) closeModal();
      });

      // enable nút tạo khi có tên
      nameInput?.addEventListener('input', () => {
        const ok = nameInput.value.trim().length > 0;
        createBtn.disabled = !ok;
      });

      // preview ảnh bìa
      coverInput?.addEventListener('change', () => {
        const file = coverInput.files?.[0];
        if (file) {
          const url = URL.createObjectURL(file);
          coverPreview.src = url;
        }
      });
      coverReset?.addEventListener('click', () => {
        coverInput.value = '';
        coverPreview.src = defaultCover;
      });

      // submit demo
      form?.addEventListener('submit', (e) => {
        e.preventDefault();
        const data = {
          name: document.getElementById('plName').value.trim(),
          desc: document.getElementById('plDesc').value.trim(),
          privacy: document.getElementById('plPrivacy').value,
          topic: document.getElementById('plTopic').value,
          tags: document.getElementById('plTags').value.trim()
        };
        console.log('Create playlist payload (demo):', data);
        // Hiển thị thông báo demo
        alert('Đã tạo playlist: ' + data.name);
        closeModal();
        // TODO: khi làm backend, gửi data bằng fetch/XHR ở đây
      });
    })();
  </script>
</body>
</html>