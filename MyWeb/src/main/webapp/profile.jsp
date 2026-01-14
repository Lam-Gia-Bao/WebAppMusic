<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

  <title>Hồ sơ - BeatFlow</title>

  <!-- Page CSS -->
  <link rel="stylesheet" href="assets/css/home.css">
  <link rel="stylesheet" href="assets/css/profile.css">
</head>
<body>

  <%@ include file="header.jsp" %>

  <!-- COVER + PROFILE -->
  <div class="profile-cover"></div>

  <div class="profile-wrapper">

    <!-- Avatar -->
    <div class="profile-center">
      <img src="assets/img/user.jpg" class="avatar" alt="avatar">
      <h1 class="username">${username}</h1>
    </div>

    <!-- Success Message -->
    <c:if test="${not empty successMessage}">
      <div class="alert alert-success alert-dismissible fade show" role="alert" style="max-width: 600px; margin: 10px auto;">
        ${successMessage}
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
      </div>
    </c:if>

    <!-- Tabs + Stats -->
    <div class="tabs-stats">
      <div class="profile-tabs">
        <a href="#all"      data-tab="all" class="${tab == 'all' ? 'active' : ''}">Tất cả</a>
        <a href="#tracks"   data-tab="tracks" class="${tab == 'tracks' ? 'active' : ''}">Bài hát</a>
        <a href="#playlist" data-tab="playlist" class="${tab == 'playlist' ? 'active' : ''}">Playlist</a>
        <a href="#favorite" data-tab="favorite" class="${tab == 'favorite' ? 'active' : ''}">Yêu thích</a>
        <a href="#upload"   data-tab="upload" class="${tab == 'upload' ? 'active' : ''}">Đã upload</a>
        <a href="#history"  data-tab="history" class="${tab == 'history' ? 'active' : ''}">Lịch sử</a>
      </div>

      <div class="profile-stats">
        <div class="stat">${followers}<br><span>Followers</span></div>
        <div class="stat">${following}<br><span>Following</span></div>
        <div class="stat">${tracksCount}<br><span>Tracks</span></div>
      </div>
    </div>

    <!-- ========================= CONTENT ========================= -->

    <!-- ALL -->
    <section class="tab-content${tab == 'all' || empty tab ? ' active' : ''}" data-tab="all">
      <h2 class="track-title-header">Bài hát nổi bật</h2>
      <div class="track-list">
        <c:choose>
          <c:when test="${not empty tracks}">
            <c:forEach var="track" items="${tracks}" end="3">
              <a href="track.jsp?id=${track.trackId}" class="track-card" style="text-decoration: none; color: inherit; cursor: pointer;" data-track-id="${track.trackId}">
                <img src="${not empty track.artworkUrl ? track.artworkUrl : 'assets/img/track1.jpg'}" alt="track">
                <div><p class="track-title">${track.title}</p><p class="track-artist">${track.artist}</p></div>
              </a>
            </c:forEach>
          </c:when>
          <c:otherwise>
            <p class="text-muted">Chưa có bài hát nào.</p>
          </c:otherwise>
        </c:choose>
      </div>

      <h2 class="track-title-header" style="margin-top:24px;">Yêu thích</h2>
      <div class="track-list">
        <c:choose>
          <c:when test="${not empty favorites}">
            <c:forEach var="fav" items="${favorites}" end="2">
              <a href="track.jsp?id=${fav.trackId}" class="track-card" style="text-decoration: none; color: inherit; cursor: pointer;" data-track-id="${fav.trackId}">
                <img src="${not empty fav.artworkUrl ? fav.artworkUrl : 'assets/img/track3.jpg'}" alt="favorite">
                <div>
                  <p class="track-title">${fav.title}</p>
                  <p class="track-artist">${fav.artist}</p>
                </div>
              </a>
            </c:forEach>
          </c:when>
          <c:otherwise>
            <p class="text-muted">Chưa có bài hát yêu thích.</p>
          </c:otherwise>
        </c:choose>
      </div>
    </section>

    <!-- TRACKS -->
    <section class="tab-content${tab == 'tracks' ? ' active' : ''}" data-tab="tracks">
      <h2 class="track-title-header">Tất cả bài hát</h2>
      <div class="track-list">
        <c:choose>
          <c:when test="${not empty tracks}">
            <c:forEach var="track" items="${tracks}">
              <a href="track.jsp?id=${track.trackId}" class="track-card" style="text-decoration: none; color: inherit; cursor: pointer;" data-track-id="${track.trackId}">
                <img src="${not empty track.artworkUrl ? track.artworkUrl : 'assets/img/track1.jpg'}" alt="track">
                <div><p class="track-title">${track.title}</p><p class="track-artist">${track.artist}</p></div>
              </a>
            </c:forEach>
          </c:when>
          <c:otherwise>
            <p class="text-muted">Chưa có bài hát nào.</p>
          </c:otherwise>
        </c:choose>
      </div>
    </section>

    <!-- PLAYLIST -->
    <section class="tab-content${tab == 'playlist' ? ' active' : ''}" data-tab="playlist">
      <h2 class="track-title-header">Playlist</h2>
      <button class="create-playlist-btn" id="openCreatePlaylist">+ Tạo Playlist</button>
      <div class="playlist-grid">
        <c:choose>
          <c:when test="${not empty playlists}">
            <c:forEach var="playlist" items="${playlists}">
              <a href="playlist_detail.jsp?id=${playlist.id}" class="playlist-card" style="text-decoration: none; color: inherit;">
                <img src="${not empty playlist.imagePath ? playlist.imagePath : 'assets/img/playlist.jpg'}" class="playlist-thumb" alt="playlist">
                <p class="playlist-name">${playlist.name}</p>
                <p class="playlist-meta">${playlist.trackCount} tracks</p>
              </a>
            </c:forEach>
          </c:when>
          <c:otherwise>
            <p class="text-muted">Chưa có playlist nào. Hãy tạo playlist mới!</p>
          </c:otherwise>
        </c:choose>
      </div>
    </section>

    <!-- FAVORITE -->
    <section class="tab-content${tab == 'favorite' ? ' active' : ''}" data-tab="favorite">
      <h2 class="track-title-header">Yêu thích</h2>
      <div class="track-list">
        <c:choose>
          <c:when test="${not empty favorites}">
            <c:forEach var="fav" items="${favorites}">
              <a href="track.jsp?id=${fav.trackId}" class="track-card" style="text-decoration: none; color: inherit; cursor: pointer;" data-track-id="${fav.trackId}">
                <img src="${not empty fav.artworkUrl ? fav.artworkUrl : 'assets/img/track3.jpg'}" alt="favorite">
                <div>
                  <p class="track-title">${fav.title}</p>
                  <p class="track-artist">${fav.artist}</p>
                </div>
              </a>
            </c:forEach>
          </c:when>
          <c:otherwise>
            <p class="text-muted">Chưa có bài hát yêu thích.</p>
          </c:otherwise>
        </c:choose>
      </div>
    </section>

    <!-- UPLOAD -->
    <section class="tab-content${tab == 'upload' ? ' active' : ''}" data-tab="upload">
      <h2 class="track-title-header">Đã upload</h2>
      <div class="track-list">
        <c:choose>
          <c:when test="${not empty uploads}">
            <c:forEach var="track" items="${uploads}">
              <a href="track.jsp?id=${track.trackId}" class="track-card" style="text-decoration: none; color: inherit; cursor: pointer;" data-track-id="${track.trackId}">
                <img src="${not empty track.artworkUrl ? track.artworkUrl : 'assets/img/track1.jpg'}" alt="upload">
                <div>
                  <p class="track-title">${track.title}</p>
                  <p class="track-artist">${track.artist}</p>
                </div>
              </a>
            </c:forEach>
          </c:when>
          <c:otherwise>
            <p class="text-muted">Chưa có bài hát nào được upload. <a href="upload.jsp">Upload ngay!</a></p>
          </c:otherwise>
        </c:choose>
      </div>
    </section>

    <!-- HISTORY -->
    <section class="tab-content${tab == 'history' ? ' active' : ''}" data-tab="history">
      <h2 class="track-title-header">Lịch sử nghe nhạc</h2>
      <div class="track-list">
        <c:choose>
          <c:when test="${not empty history}">
            <c:forEach var="item" items="${history}">
              <div class="track-card">
                <img src="assets/img/track2.jpg" alt="history">
                <p class="track-title">${item}</p>
              </div>
            </c:forEach>
          </c:when>
          <c:otherwise>
            <p class="text-muted">Chưa có lịch sử nghe nhạc.</p>
          </c:otherwise>
        </c:choose>
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

  <!-- Scripts: Tabs + Modal + Dropdowns -->
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

      function closeAll() {
        menus.forEach(m => m && m.classList.remove('show'));
        buttons.forEach(b => b && b.setAttribute('aria-expanded', 'false'));
      }
      function toggle(menu, btn) {
        if (!menu) return;
        const isOpen = menu.classList.contains('show');
        closeAll();
        if (!isOpen) {
          menu.classList.add('show');
          btn && btn.setAttribute('aria-expanded', 'true');
        }
      }

      // Stop click inside menu from closing
      menus.forEach(m => m && m.addEventListener('click', e => e.stopPropagation()));

      // Open account menu by avatar or caret
      btnProfile && btnProfile.addEventListener('click', (e) => { e.stopPropagation(); toggle(menuAcc, btnProfile); });
      btnCaret   && btnCaret.addEventListener('click',   (e) => { e.stopPropagation(); toggle(menuAcc, btnCaret); });

      // Other menus
      btnNoti && btnNoti.addEventListener('click', (e) => { e.stopPropagation(); toggle(menuNoti, btnNoti); });
      btnMsg  && btnMsg.addEventListener('click',  (e) => { e.stopPropagation(); toggle(menuMsg, btnMsg); });

      document.addEventListener('click', closeAll);
      document.addEventListener('keydown', (e) => { if (e.key === 'Escape') closeAll(); });

      // Modal Create Playlist
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
      const defaultCover = coverPreview ? coverPreview.src : '';

      function openModal() {
        modal.classList.add('show');
        setTimeout(() => nameInput && nameInput.focus(), 150);
        document.body.style.overflow = 'hidden';
      }
      function closeModal() {
        modal.classList.remove('show');
        document.body.style.overflow = '';
      }

      openBtn && openBtn.addEventListener('click', () => openModal());
      closeBtn && closeBtn.addEventListener('click', () => closeModal());
      cancelBtn && cancelBtn.addEventListener('click', () => closeModal());

      modal && modal.addEventListener('click', (e) => { if (e.target === modal) closeModal(); });
      document.addEventListener('keydown', (e) => { if (e.key === 'Escape' && modal.classList.contains('show')) closeModal(); });

      nameInput && nameInput.addEventListener('input', () => {
        createBtn.disabled = nameInput.value.trim().length === 0;
      });

      coverInput && coverInput.addEventListener('change', () => {
        const file = coverInput.files && coverInput.files[0];
        if (file) {
          const url = URL.createObjectURL(file);
          coverPreview.src = url;
        }
      });
      coverReset && coverReset.addEventListener('click', () => {
        if (coverInput) coverInput.value = '';
        if (defaultCover) coverPreview.src = defaultCover;
      });

      form && form.addEventListener('submit', (e) => {
        e.preventDefault();
        const name = document.getElementById('plName').value.trim();
        const desc = document.getElementById('plDesc').value.trim();
        const privacy = document.getElementById('plPrivacy').value;
        
        if (!name) {
          alert('Vui lòng nhập tên playlist');
          return;
        }
        
        // Tạo form data để gửi POST
        const formData = new URLSearchParams();
        formData.append('name', name);
        formData.append('description', desc);
        formData.append('isPublic', privacy === 'public' ? 'true' : 'false');
        formData.append('artworkUrl', '');
        
        fetch('${pageContext.request.contextPath}/playlist/create', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
          },
          body: formData.toString()
        })
        .then(response => response.json())
        .then(data => {
          if (data.success) {
            // Redirect về profile với tab playlist
            window.location.href = '${pageContext.request.contextPath}/profile?tab=playlist';
          } else {
            alert('Không thể tạo playlist: ' + (data.error || 'Lỗi không xác định'));
          }
        })
        .catch(err => {
          console.error('Error creating playlist:', err);
          alert('Lỗi kết nối. Vui lòng thử lại.');
        });
        
        closeModal();
      });
    })();
  </script>
  
  <%@ include file="player.jsp" %>
  
  <!-- Footer -->
		<footer class="py-4"
			style="background: #0d0d0d; color: #bbb; font-size: 0.9rem;">
			<div class="container text-center">
				<div class="bf-footer-links">
					<div class="mb-3">
						<a href="#" class="text-secondary me-2">Trang chính thức</a> · <a
							href="#" class="text-secondary mx-2">Bảo mật</a> · <a href="#"
							class="text-secondary mx-2">Chính sách Cookie</a> · <a href="#"
							class="text-secondary mx-2">Trình quản lý Cookie</a> · <a
							href="#" class="text-secondary mx-2">Xuất bản</a> · <a href="#"
							class="text-secondary mx-2">Nguồn nghệ sĩ</a> · <a href="#"
							class="text-secondary mx-2">Tin tức</a> · <a href="#"
							class="text-secondary mx-2">Biểu đồ</a> · <a href="#"
							class="text-secondary mx-2">Uy tín</a>
					</div>
					<div class="text-secondary">
						Ngôn ngữ: <a href="#" class="text-primary fw-bold">Tiếng Việt
							(VN)</a>
					</div>
				</div>
			</div>
		</footer>
  
  <link rel="stylesheet" href="assets/css/next_up.css">
</body>
</html>