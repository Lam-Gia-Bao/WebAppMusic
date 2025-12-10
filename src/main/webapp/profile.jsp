<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Hồ sơ cá nhân - BeatFlow</title>
    <link rel="stylesheet" href="assets/css/profile.css">
</head>
<body>

<div class="profile-cover"></div>

<div class="profile-wrapper">

    <!-- Avatar -->
    <div class="profile-center">
        <img src="assets/img/user.jpg" class="avatar">
        <h1 class="username">Takezo</h1>
    </div>

    <!-- Tabs -->
    <div class="tabs-stats">
        <div class="profile-tabs">
            <a href="profile?tab=all"      class="${tab == 'all' ? 'active' : ''}">Tất cả</a>
            <a href="profile?tab=tracks"   class="${tab == 'tracks' ? 'active' : ''}">Bài hát</a>
            <a href="profile?tab=playlist" class="${tab == 'playlist' ? 'active' : ''}">Playlist</a>
            <a href="profile?tab=favorite" class="${tab == 'favorite' ? 'active' : ''}">Yêu thích</a>
            <a href="profile?tab=upload"   class="${tab == 'upload' ? 'active' : ''}">Đã upload</a>
            <a href="profile?tab=history"  class="${tab == 'history' ? 'active' : ''}">Lịch sử</a>
        </div>

        <div class="profile-stats">
            <div class="stat">150<br><span>Followers</span></div>
            <div class="stat">20<br><span>Following</span></div>
            <div class="stat">36<br><span>Tracks</span></div>
        </div>
    </div>

    <!-- ========================= CONTENT ========================= -->

    <!-- TẤT CẢ -->
    <c:if test="${tab == 'all'}">
        <h2 class="track-title-header">Bài hát nổi bật</h2>

        <div class="track-list">
            <c:forEach var="t" items="${tracks}">
                <div class="track-card">
                    <img src="assets/img/track1.jpg">
                    <div>
                        <p class="track-title">${t}</p>
                    </div>
                </div>
            </c:forEach>
        </div>

        <h2 class="track-title-header" style="margin-top:40px;">Yêu thích</h2>
        <div class="track-list">
            <c:forEach var="f" items="${favorites}">
                <div class="track-card">
                    <img src="assets/img/track3.jpg">
                    <div>
                        <p class="track-title">${f}</p>
                    </div>
                </div>
            </c:forEach>
        </div>
    </c:if>

    <!-- BÀI HÁT -->
    <c:if test="${tab == 'tracks'}">
        <h2 class="track-title-header">Tất cả bài hát</h2>
        <div class="track-list">
            <c:forEach var="t" items="${tracks}">
                <div class="track-card">
                    <img src="assets/img/track1.jpg">
                    <div>
                        <p class="track-title">${t}</p>
                    </div>
                </div>
            </c:forEach>
        </div>
    </c:if>

    <!-- PLAYLIST -->
    <c:if test="${tab == 'playlist'}">
        <h2 class="track-title-header">Playlist</h2>

        <button class="create-playlist-btn">+ Tạo Playlist</button>

        <div class="playlist-grid">
            <c:forEach var="p" items="${playlists}">
                <div class="playlist-card">
                    <img src="assets/img/playlist.jpg" class="playlist-thumb">
                    <p class="playlist-name">${p}</p>
                    <p class="playlist-meta">12 tracks</p>
                </div>
            </c:forEach>
        </div>
    </c:if>

    <!-- YÊU THÍCH -->
    <c:if test="${tab == 'favorite'}">
        <h2 class="track-title-header">Yêu thích</h2>
        <div class="track-list">
            <c:forEach var="f" items="${favorites}">
                <div class="track-card">
                    <img src="assets/img/track3.jpg">
                    <p class="track-title">${f}</p>
                </div>
            </c:forEach>
        </div>
    </c:if>

    <!-- UPLOAD -->
    <c:if test="${tab == 'upload'}">
        <h2 class="track-title-header">Đã upload</h2>
        <div class="track-list">
            <c:forEach var="u" items="${uploads}">
                <div class="track-card">
                    <img src="assets/img/track1.jpg">
                    <p class="track-title">${u}</p>
                </div>
            </c:forEach>
        </div>
    </c:if>

    <!-- LỊCH SỬ -->
    <c:if test="${tab == 'history'}">
        <h2 class="track-title-header">Lịch sử nghe nhạc</h2>
        <div class="track-list">
            <c:forEach var="h" items="${history}">
                <div class="track-card">
                    <img src="assets/img/track2.jpg">
                    <p class="track-title">${h}</p>
                </div>
            </c:forEach>
        </div>
    </c:if>

</div>

</body>
</html>
