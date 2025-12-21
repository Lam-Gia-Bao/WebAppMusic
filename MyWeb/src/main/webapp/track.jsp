<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width,initial-scale=1" />
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700;800&display=swap" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
  <title>Thắc Mắc? - BeatFlow</title>
  <link rel="stylesheet" href="assets/css/track.css">
</head>
<body>

  <!-- NAVBAR -->
  <nav class="site-nav">
    <div class="container d-flex align-items-center justify-content-between">
      <div class="d-flex align-items-center gap-3">
        <div class="bf-logo d-flex align-items-center gap-2">
          <img src="assets/img/logo.png" alt="BeatFlow logo" class="bf-logo-img">
          <span class="brand">BeatFlow</span>
        </div>
        <ul class="nav d-none d-md-flex">
          <li class="nav-item"><a class="nav-link" href="index.jsp">Trang chủ</a></li>
          <li class="nav-item"><a class="nav-link" href="#">Tin tức</a></li>
          <li class="nav-item"><a class="nav-link" href="library.jsp">Thư viện</a></li>
        </ul>
      </div>
      <div class="flex-grow-1 px-4">
        <div class="search-wrapper">
          <input class="search-input" type="text" placeholder="Tìm kiếm bài hát, playlist, album">
          <i class="bi bi-search search-icon"></i>
        </div>
      </div>
      <div class="d-flex align-items-center gap-3">
        <a href="#" class="nav-function-link">Dành cho nghệ sĩ</a>
        <a href="upload.jsp" class="nav-function-link">Đăng tải</a>
        <button class="btn-icon-nav" id="profileMenuButton" aria-label="Profile" aria-expanded="false" aria-haspopup="true">
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
          </div>
        </div>
        <div class="dropdown-container">
          <button class="btn-icon-nav" id="notificationsMenuButton" aria-label="Thông báo" aria-expanded="false" aria-haspopup="true">
            <i class="bi bi-bell"></i>
          </button>
          <div class="messages-dropdown" id="notificationsMenu" role="menu">
            <div class="messages-header"><h5 class="m-0">Thông báo</h5></div>
            <div class="messages-body"><p class="no-messages">Bạn chưa có thông báo nào.</p></div>
            <div class="messages-footer"><a href="#" class="view-all-link">Xem tất cả thông báo</a></div>
          </div>
        </div>
        <div class="dropdown-container">
          <button class="btn-icon-nav" id="messagesMenuButton" aria-label="Tin nhắn" aria-expanded="false" aria-haspopup="true">
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

  <!-- TRACK PAGE (FULL-WIDTH PLAYER + COMMENTS, NO FANS COLUMN) -->
  <main class="container track-page">
    <div class="track-grid one-col">
      <!-- HERO (extra-wide waveform like SoundCloud) -->
      <section class="track-main">
        <div class="hero hero-wide">
          <div class="hero-left">
            <button class="hero-play" id="heroPlay" data-thumb="assets/img/track1.jpg" data-artist="Thịnh Suy" data-title="Thắc Mắc?">
              <i class="bi bi-play-fill"></i>
            </button>
            <div class="hero-title-wrap">
              <h1 class="hero-title">Thắc Mắc? - Thịnh Suy</h1>
              <div class="hero-sub">6 years ago · <span class="tag-chip">#Indie</span></div>
            </div>
            <!-- dài toàn hàng: -->
            <div class="wave-hero long" aria-hidden="true"></div>
            <div class="listeners-avatars">
              <img src="assets/img/user.jpg" alt="">
              <img src="assets/img/profile_avatar.jpg" alt="">
              <img src="assets/img/avt_travis-scott.jpg" alt="">
              <img src="assets/img/avt_bad-bunny.jpg" alt="">
            </div>
          </div>

          <!-- cover nhỏ bên phải -->
          <div class="hero-cover">
            <img src="assets/img/album1.jpg" alt="cover">
          </div>
        </div>

        <!-- COMMENT INPUT + ACTIONS -->
        <div class="cmt-bar">
          <div class="cmt-input">
            <img src="assets/img/profile_avatar.jpg" class="cmt-avt" alt="">
            <input type="text" placeholder="Viết bình luận">
            <button class="btn-send"><i class="bi bi-send"></i></button>
          </div>
          <div class="cmt-actions">
            <button class="btn-act"><i class="bi bi-heart"></i></button>
            <button class="btn-act"><i class="bi bi-repeat"></i></button>
            <button class="btn-act"><i class="bi bi-share"></i></button>
            <button class="btn-act"><i class="bi bi-ellipsis"></i></button>
            <div class="stats-pill">
              <span><i class="bi bi-play-fill"></i> 8.09M</span>
              <span><i class="bi bi-heart-fill"></i> 67.9K</span>
              <span><i class="bi bi-chat"></i> 1,834</span>
            </div>
          </div>
        </div>

        <!-- TAGS -->
        <div class="tag-row">
          <span class="tag-chip">#Nhạc trẻ</span>
          <span class="tag-chip">#Vpop</span>
        </div>

        <!-- COMMENTS -->
        <div class="comments-head">
          <div class="left">
            <img src="assets/img/playlist3.jpg" class="ch-avt" alt="">
            <div>
              <div class="ch-title">Vpop Official</div>
              <div class="ch-sub"><i class="bi bi-people"></i> 4,629 · <i class="bi bi-music-note-beamed"></i> 36</div>
            </div>
          </div>
          <button class="btn-follow">Follow</button>
        </div>

        <div class="cmt-sort">
          <div>828 comments</div>
          <button class="sort-btn" id="sortBtn">Sorted by: Newest <i class="bi bi-chevron-down"></i></button>
        </div>

        <div class="comment">
          <img src="assets/img/user.jpg" class="cmt-avt big" alt="">
          <div class="cmt-body">
            <div class="cmt-meta"><span class="name">Do Nguyen Hoan</span> <span class="time">· 1 month ago</span></div>
            <div class="cmt-text">Hay qua anh oi</div>
            <div class="cmt-actions-row">
              <button class="mini"><i class="bi bi-heart"></i> 0</button>
              <button class="mini">Reply</button>
            </div>
          </div>
        </div>

        <div class="comment">
          <img src="assets/img/profile_avatar.jpg" class="cmt-avt big" alt="">
          <div class="cmt-body">
            <div class="cmt-meta"><span class="name">lonely</span> <span class="time">· 2 months ago</span></div>
            <div class="cmt-text">Chi la chut thac mac thoi ma</div>
            <div class="cmt-actions-row">
              <button class="mini"><i class="bi bi-heart"></i> 2</button>
              <button class="mini">Reply</button>
            </div>
          </div>
        </div>
      </section>
    </div>
  </main>

  <!-- Fixed Music Player Bar -->
  <div class="fixed-player-bar">
    <div class="player-container">
      <div class="player-controls-left">
        <button class="player-btn"><i class="bi bi-skip-backward-fill"></i></button>
        <button class="player-btn player-play-btn" id="mainPlayBtn"><i class="bi bi-play-fill"></i></button>
        <button class="player-btn"><i class="bi bi-skip-forward-fill"></i></button>
      </div>
      <div class="player-progress-section">
        <span class="player-time" id="curTime">0:00</span>
        <div class="player-progress-bar" id="progressBar">
          <div class="player-progress-fill" id="progressFill"></div>
        </div>
        <span class="player-time" id="durTime">3:25</span>
      </div>
      <div class="player-song-info">
        <img src="assets/img/track1.jpg" alt="Now Playing" class="player-song-thumb" id="nowThumb">
        <div class="player-song-details">
          <div class="player-song-title" id="nowArtist">Thịnh Suy</div>
          <div class="player-song-artist" id="nowTitle">Thắc Mắc?</div>
        </div>
      </div>
      <div class="player-controls-right">
        <button class="player-btn"><i class="bi bi-shuffle"></i></button>
        <button class="player-btn"><i class="bi bi-chat"></i></button>
        <div class="player-volume-control">
          <i class="bi bi-volume-up"></i>
          <input type="range" class="player-volume-slider" min="0" max="100" value="60">
        </div>
        <button class="player-btn" id="nextUpButton"><i class="bi bi-justify"></i></button>
      </div>
    </div>
  </div>

  <script src="assets/js/track.js"></script>
</body>
</html>