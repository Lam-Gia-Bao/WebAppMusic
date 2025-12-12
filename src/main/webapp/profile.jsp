<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Hồ sơ cá nhân - BeatFlow</title>
  <link rel="stylesheet" href="assets/css/profile.css" />
</head>
<body>

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
        <a href="#all"      data-tab="all"      class="active">Tất cả</a>
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

    <!-- TẤT CẢ -->
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

    <!-- BÀI HÁT -->
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
      <button class="create-playlist-btn">+ Tạo Playlist</button>
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

    <!-- YÊU THÍCH -->
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

    <!-- LỊCH SỬ -->
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

  <script>
    (function () {
      const tabs = document.querySelectorAll('.profile-tabs a');
      const panes = document.querySelectorAll('.tab-content');

      function activate(tab) {
        // Tab links
        tabs.forEach(a => {
          a.classList.toggle('active', a.dataset.tab === tab);
        });
        // Content panes
        let found = false;
        panes.forEach(p => {
          const match = p.dataset.tab === tab;
          p.classList.toggle('active', match);
          if (match) found = true;
        });
        // Fallback về 'all' nếu hash lạ
        if (!found) {
          activate('all');
          history.replaceState(null, '', '#all');
        }
      }

      function fromHash() {
        const h = location.hash.replace('#', '').trim();
        return h || 'all';
      }

      // Click tabs
      tabs.forEach(a => {
        a.addEventListener('click', (e) => {
          e.preventDefault();
          const tab = a.dataset.tab;
          if (location.hash !== '#' + tab) {
            history.pushState(null, '', '#' + tab);
          }
          activate(tab);
        });
      });

      // On load + hash change
      window.addEventListener('hashchange', () => activate(fromHash()));
      activate(fromHash());
    })();
  </script>
</body>
</html>