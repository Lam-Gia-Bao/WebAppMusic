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
  <link rel="stylesheet" href="assets/css/home.css">
  <link rel="stylesheet" href="assets/css/track.css">
</head>
<body>

  <%@ include file="header.jsp" %>

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

  <%@ include file="player.jsp" %>

  <script src="assets/js/track.js"></script>
</body>
</html>