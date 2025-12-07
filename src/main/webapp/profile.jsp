<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Hồ sơ cá nhân - BeatFlow</title>
    <link rel="stylesheet" href="assets/css/profile.css">
</head>
<body>

<!-- COVER BACKGROUND -->
<div class="profile-cover"></div>

<!-- AVATAR + NAME + MAIN WRAPPER -->
<div class="profile-wrapper">

    <div class="profile-center">
        <img src="assets/img/user.jpg" class="avatar">
        <h1 class="username">Takezo</h1>
    </div>

    <!-- TABS + STATS -->
    <div class="tabs-stats">

        <div class="profile-tabs">
            <a href="#" class="active">Tất cả</a>
            <a href="#">Bài hát</a>
            <a href="#">Playlist</a>
            <a href="#">Yêu thích</a>
            <a href="#">Đã upload</a>
            <a href="#">Lịch sử</a>
        </div>

        <div class="profile-stats">
            <div class="stat">150<br><span>Followers</span></div>
            <div class="stat">20<br><span>Following</span></div>
            <div class="stat">36<br><span>Tracks</span></div>
        </div>

    </div>

    <!-- TRACK LIST -->
    <h2 class="track-title-header">Bài hát nổi bật</h2>

    <div class="track-list">

        <div class="track-card">
            <img src="assets/img/track1.jpg">
            <div>
                <p class="track-title">Lofi Midnight Rain</p>
                <p class="track-info">23K plays · 320 likes</p>
            </div>
        </div>

        <div class="track-card">
            <img src="assets/img/track2.jpg">
            <div>
                <p class="track-title">Sad Piano Type Beat</p>
                <p class="track-info">11K plays · 140 likes</p>
            </div>
        </div>

    </div>

</div>

</body>
</html>
