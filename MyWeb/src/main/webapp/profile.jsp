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
  <link rel="stylesheet" href="assets/css/home.css?v=2">
  <link rel="stylesheet" href="assets/css/profile.css?v=3">
  
  <style>
    /* Favorite Grid - Override */
    .favorite-grid {
      display: flex !important;
      flex-wrap: wrap !important;
      gap: 16px !important;
    }
    .favorite-grid .fav-card {
      width: 150px !important;
      background: transparent !important;
      padding: 0 !important;
      border: none !important;
    }
    .favorite-grid .fav-img-wrap {
      position: relative;
      width: 150px !important;
      height: 150px !important;
      border-radius: 4px;
      overflow: hidden;
    }
    .favorite-grid .fav-img-wrap img {
      width: 100%;
      height: 100%;
      object-fit: cover;
    }
    .favorite-grid .fav-overlay {
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      background: rgba(0,0,0,0.5);
      opacity: 0;
      transition: opacity 0.2s;
      display: flex;
      align-items: center;
      justify-content: center;
    }
    .favorite-grid .fav-card:hover .fav-overlay {
      opacity: 1;
    }
    .favorite-grid .fav-play {
      width: 50px;
      height: 50px;
      border-radius: 50%;
      background: #fff;
      border: none;
      color: #111;
      font-size: 22px;
      cursor: pointer;
    }
    .favorite-grid .fav-play i {
      margin-left: 3px;
    }
    .favorite-grid .fav-actions {
      position: absolute;
      bottom: 8px;
      right: 8px;
      display: flex;
      gap: 6px;
    }
    .favorite-grid .fav-btn {
      width: 28px;
      height: 28px;
      border-radius: 50%;
      background: rgba(255,255,255,0.15);
      border: 1px solid rgba(255,255,255,0.3);
      color: #fff;
      font-size: 12px;
      cursor: pointer;
      display: flex;
      align-items: center;
      justify-content: center;
    }
    .favorite-grid .fav-btn:hover {
      background: rgba(255,255,255,0.3);
    }
    .favorite-grid .fav-btn.liked {
      color: #ff3b5c;
    }
    .favorite-grid .fav-title {
      display: block;
      margin-top: 8px;
      font-size: 13px;
      color: #fff;
      text-decoration: none;
      white-space: nowrap;
      overflow: hidden;
      text-overflow: ellipsis;
    }
    .favorite-grid .fav-title:hover {
      text-decoration: underline;
    }
    .favorite-grid .fav-artist {
      font-size: 12px;
      color: #888;
      white-space: nowrap;
      overflow: hidden;
      text-overflow: ellipsis;
    }
  </style>
</head>
<body>

  <%@ include file="header.jsp" %>

  <!-- COVER + PROFILE -->
  <div class="profile-cover"></div>

  <div class="profile-wrapper">

    <!-- Avatar -->
    <div class="profile-center">
      <div class="avatar-container">
        <img src="${not empty avatarUrl ? avatarUrl : 'assets/img/user.jpg'}" class="avatar" alt="avatar" id="avatarImg">
        <label class="avatar-edit-btn" title="Đổi avatar">
          <i class="bi bi-camera-fill"></i>
          <input type="file" id="avatarInput" accept="image/*" hidden>
        </label>
      </div>
      <h1 class="username">${username}</h1>
      <button class="btn-edit-profile" id="openEditProfile">
        <i class="bi bi-pencil"></i> Chỉnh sửa hồ sơ
      </button>
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
      <div class="favorite-grid">
        <c:choose>
          <c:when test="${not empty playlists}">
            <c:forEach var="playlist" items="${playlists}">
              <div class="fav-card" data-playlist-id="${playlist.id}">
                <div class="fav-img-wrap">
                  <img src="${not empty playlist.artworkUrl ? playlist.artworkUrl : (not empty playlist.imagePath ? playlist.imagePath : 'assets/img/playlist.jpg')}" alt="${playlist.name}">
                  <div class="fav-overlay">
                    <button class="fav-play" data-playlist-id="${playlist.id}" title="Phát playlist">
                      <i class="bi bi-play-fill"></i>
                    </button>
                    <div class="fav-actions">
                      <button class="fav-btn btn-menu" data-playlist-id="${playlist.id}" data-type="playlist" title="Tùy chọn">
                        <i class="bi bi-three-dots"></i>
                      </button>
                    </div>
                  </div>
                </div>
                <a href="playlist_detail.jsp?id=${playlist.id}" class="fav-title">${playlist.name}</a>
                <div class="fav-artist">${playlist.trackCount} tracks</div>
              </div>
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
      <div class="favorite-grid">
        <c:choose>
          <c:when test="${not empty favorites}">
            <c:forEach var="fav" items="${favorites}">
              <div class="fav-card" data-track-id="${fav.trackId}">
                <div class="fav-img-wrap">
                  <img src="${not empty fav.artworkUrl ? fav.artworkUrl : 'assets/img/track3.jpg'}" alt="${fav.title}">
                  <div class="fav-overlay">
                    <button class="fav-play" data-track-id="${fav.trackId}" title="Phát">
                      <i class="bi bi-play-fill"></i>
                    </button>
                    <div class="fav-actions">
                      <button class="fav-btn liked" data-track-id="${fav.trackId}" title="Bỏ yêu thích">
                        <i class="bi bi-heart-fill"></i>
                      </button>
                      <button class="fav-btn btn-menu" data-track-id="${fav.trackId}" data-type="favorite" title="Tùy chọn">
                        <i class="bi bi-three-dots"></i>
                      </button>
                    </div>
                  </div>
                </div>
                <a href="track.jsp?id=${fav.trackId}" class="fav-title">${fav.title}</a>
                <div class="fav-artist">${fav.artist}</div>
              </div>
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

  <!-- EDIT PROFILE MODAL -->
  <div class="modal-overlay" id="editProfileModal" role="dialog" aria-modal="true" aria-labelledby="editProfileTitle">
    <div class="modal-box">
      <button class="modal-close" id="closeEditProfile" aria-label="Đóng">
        <i class="bi bi-x-lg"></i>
      </button>
      <h3 id="editProfileTitle">Chỉnh sửa hồ sơ</h3>

      <form id="editProfileForm">
        <!-- Email -->
        <label class="form-label" for="editEmail">Email</label>
        <input type="email" id="editEmail" class="form-control-like" placeholder="your@email.com" value="${email}">

        <hr style="border-color: #333; margin: 20px 0;">
        
        <h4 style="color: #fff; margin-bottom: 15px;">Đổi mật khẩu</h4>
        
        <!-- Current Password -->
        <label class="form-label" for="currentPassword">Mật khẩu hiện tại</label>
        <input type="password" id="currentPassword" class="form-control-like" placeholder="Nhập mật khẩu hiện tại">

        <!-- New Password -->
        <label class="form-label" for="newPassword">Mật khẩu mới</label>
        <input type="password" id="newPassword" class="form-control-like" placeholder="Tối thiểu 6 ký tự">

        <!-- Confirm Password -->
        <label class="form-label" for="confirmPassword">Xác nhận mật khẩu mới</label>
        <input type="password" id="confirmPassword" class="form-control-like" placeholder="Nhập lại mật khẩu mới">

        <!-- Actions -->
        <div class="modal-actions">
          <button type="button" class="btn-cancel" id="btnCancelEdit">Hủy</button>
          <button type="submit" class="btn-create">Lưu thay đổi</button>
        </div>
      </form>
    </div>
  </div>

  <!-- CONFIRM DELETE MODAL -->
  <div class="modal-overlay" id="confirmDeleteModal" role="dialog" aria-modal="true">
    <div class="modal-box modal-box-sm">
      <h3 id="confirmDeleteTitle">Xác nhận xóa</h3>
      <p id="confirmDeleteMessage">Bạn có chắc muốn xóa?</p>
      <div class="modal-actions">
        <button type="button" class="btn-cancel" id="btnCancelDelete">Hủy</button>
        <button type="button" class="btn-danger" id="btnConfirmDelete">Xóa</button>
      </div>
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
        
        var contextPath = '${pageContext.request.contextPath}';
        fetch(contextPath + '/playlist/create', {
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
            window.location.href = contextPath + '/profile?tab=playlist';
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

      // ============== PROFILE EDIT FEATURES ==============
      var contextPath = '${pageContext.request.contextPath}';
      
      // Toast notification
      function showToast(message, type) {
        var existing = document.querySelector('.toast-notification');
        if (existing) existing.remove();
        
        var toast = document.createElement('div');
        toast.className = 'toast-notification ' + type;
        toast.innerHTML = '<i class="bi ' + (type === 'success' ? 'bi-check-circle-fill' : 'bi-x-circle-fill') + '"></i> ' + message;
        document.body.appendChild(toast);
        
        setTimeout(function() { toast.classList.add('show'); }, 10);
        setTimeout(function() {
          toast.classList.remove('show');
          setTimeout(function() { toast.remove(); }, 300);
        }, 3000);
      }

      // Avatar upload
      var avatarInput = document.getElementById('avatarInput');
      var avatarImg = document.getElementById('avatarImg');
      
      if (avatarInput) {
        avatarInput.addEventListener('change', function() {
          var file = this.files && this.files[0];
          if (!file) return;
          
          if (!file.type.startsWith('image/')) {
            showToast('Vui lòng chọn file hình ảnh', 'error');
            return;
          }
          
          var formData = new FormData();
          formData.append('avatar', file);
          
          fetch(contextPath + '/api/profile/avatar', {
            method: 'POST',
            body: formData
          })
          .then(function(r) { return r.json(); })
          .then(function(data) {
            if (data.success) {
              var newAvatarUrl = data.avatarUrl + '?t=' + Date.now();
              avatarImg.src = newAvatarUrl;
              // Cập nhật avatar trên header
              var headerAvatar = document.querySelector('.profile-avatar-small');
              if (headerAvatar) {
                headerAvatar.src = newAvatarUrl;
              }
              showToast('Đã cập nhật avatar!', 'success');
            } else {
              showToast(data.error || 'Lỗi cập nhật avatar', 'error');
            }
          })
          .catch(function(err) {
            console.error(err);
            showToast('Lỗi kết nối', 'error');
          });
        });
      }

      // Edit Profile Modal
      var openEditBtn = document.getElementById('openEditProfile');
      var editModal = document.getElementById('editProfileModal');
      var closeEditBtn = document.getElementById('closeEditProfile');
      var cancelEditBtn = document.getElementById('btnCancelEdit');
      var editForm = document.getElementById('editProfileForm');

      function openEditModal() {
        editModal.classList.add('show');
        document.body.style.overflow = 'hidden';
      }
      function closeEditModal() {
        editModal.classList.remove('show');
        document.body.style.overflow = '';
      }

      if (openEditBtn) openEditBtn.addEventListener('click', openEditModal);
      if (closeEditBtn) closeEditBtn.addEventListener('click', closeEditModal);
      if (cancelEditBtn) cancelEditBtn.addEventListener('click', closeEditModal);
      if (editModal) editModal.addEventListener('click', function(e) { if (e.target === editModal) closeEditModal(); });

      if (editForm) {
        editForm.addEventListener('submit', function(e) {
          e.preventDefault();
          
          var newEmail = document.getElementById('editEmail').value.trim();
          var currentPwd = document.getElementById('currentPassword').value;
          var newPwd = document.getElementById('newPassword').value;
          var confirmPwd = document.getElementById('confirmPassword').value;
          
          var promises = [];
          
          // Update email if changed
          if (newEmail) {
            var emailData = new URLSearchParams();
            emailData.append('email', newEmail);
            promises.push(
              fetch(contextPath + '/api/profile/email', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: emailData.toString()
              }).then(function(r) { return r.json(); })
            );
          }
          
          // Update password if provided
          if (currentPwd && newPwd) {
            if (newPwd !== confirmPwd) {
              showToast('Xác nhận mật khẩu không khớp', 'error');
              return;
            }
            if (newPwd.length < 6) {
              showToast('Mật khẩu mới phải từ 6 ký tự', 'error');
              return;
            }
            var pwdData = new URLSearchParams();
            pwdData.append('currentPassword', currentPwd);
            pwdData.append('newPassword', newPwd);
            pwdData.append('confirmPassword', confirmPwd);
            promises.push(
              fetch(contextPath + '/api/profile/password', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: pwdData.toString()
              }).then(function(r) { return r.json(); })
            );
          }
          
          if (promises.length === 0) {
            closeEditModal();
            return;
          }
          
          Promise.all(promises)
            .then(function(results) {
              var hasError = false;
              results.forEach(function(data) {
                if (!data.success) {
                  showToast(data.error || 'Có lỗi xảy ra', 'error');
                  hasError = true;
                }
              });
              if (!hasError) {
                showToast('Đã cập nhật hồ sơ!', 'success');
                closeEditModal();
                // Clear password fields
                document.getElementById('currentPassword').value = '';
                document.getElementById('newPassword').value = '';
                document.getElementById('confirmPassword').value = '';
              }
            })
            .catch(function(err) {
              console.error(err);
              showToast('Lỗi kết nối', 'error');
            });
        });
      }

      // Delete functionality
      var deleteModal = document.getElementById('confirmDeleteModal');
      var cancelDeleteBtn = document.getElementById('btnCancelDelete');
      var confirmDeleteBtn = document.getElementById('btnConfirmDelete');
      var deleteType = null;
      var deleteId = null;

      function openDeleteModal(type, id, name) {
        deleteType = type;
        deleteId = id;
        var title = document.getElementById('confirmDeleteTitle');
        var msg = document.getElementById('confirmDeleteMessage');
        
        if (type === 'favorite') {
          title.textContent = 'Xóa khỏi yêu thích';
          msg.textContent = 'Bạn có chắc muốn xóa bài hát này khỏi danh sách yêu thích?';
        } else if (type === 'playlist') {
          title.textContent = 'Xóa playlist';
          msg.textContent = 'Bạn có chắc muốn xóa playlist này? Hành động này không thể hoàn tác.';
        }
        
        deleteModal.classList.add('show');
        document.body.style.overflow = 'hidden';
      }

      function closeDeleteModal() {
        deleteModal.classList.remove('show');
        document.body.style.overflow = '';
        deleteType = null;
        deleteId = null;
      }

      if (cancelDeleteBtn) cancelDeleteBtn.addEventListener('click', closeDeleteModal);
      if (deleteModal) deleteModal.addEventListener('click', function(e) { if (e.target === deleteModal) closeDeleteModal(); });

      if (confirmDeleteBtn) {
        confirmDeleteBtn.addEventListener('click', function() {
          if (!deleteType || !deleteId) return;
          
          var url = contextPath + '/api/profile/' + deleteType + '/' + deleteId;
          
          fetch(url, { method: 'DELETE' })
            .then(function(r) { return r.json(); })
            .then(function(data) {
              if (data.success) {
                showToast(data.message || 'Đã xóa thành công!', 'success');
                // Remove the element from DOM
                var element;
                if (deleteType === 'favorite') {
                  element = document.querySelector('.fav-card[data-track-id="' + deleteId + '"]');
                } else if (deleteType === 'playlist') {
                  element = document.querySelector('.fav-card[data-playlist-id="' + deleteId + '"]');
                }
                if (element) {
                  element.remove();
                }
                closeDeleteModal();
              } else {
                showToast(data.error || 'Lỗi xóa', 'error');
              }
            })
            .catch(function(err) {
              console.error(err);
              showToast('Lỗi kết nối', 'error');
            });
        });
      }

      // ============ 3-DOT MENU FUNCTIONALITY (giống login_home) ============
      var activeActionMenu = null;
      
      // Tạo dropdown menu element
      function createActionMenu() {
        var menu = document.createElement('div');
        menu.className = 'action-menu-dropdown';
        menu.innerHTML = 
          '<div class="action-menu-item" data-action="add-queue">' +
            '<i class="bi bi-collection"></i> Thêm vào danh sách chờ' +
          '</div>' +
          '<div class="action-menu-item" data-action="add-playlist">' +
            '<i class="bi bi-plus-square"></i> Thêm vào playlist' +
          '</div>' +
          '<div class="action-menu-item" data-action="go-track">' +
            '<i class="bi bi-music-note"></i> Đi đến bài hát' +
          '</div>' +
          '<div class="action-menu-item" data-action="go-artist">' +
            '<i class="bi bi-person"></i> Đi đến nghệ sĩ' +
          '</div>' +
          '<div class="action-menu-item" data-action="share">' +
            '<i class="bi bi-share"></i> Chia sẻ' +
          '</div>' +
          '<div class="action-menu-item" data-action="copy-link">' +
            '<i class="bi bi-link-45deg"></i> Sao chép liên kết' +
          '</div>' +
          '<div class="action-menu-item text-danger" data-action="remove">' +
            '<i class="bi bi-trash"></i> Xóa' +
          '</div>';
        return menu;
      }

      // Tạo dropdown menu cho playlist
      function createPlaylistMenu() {
        var menu = document.createElement('div');
        menu.className = 'action-menu-dropdown';
        menu.innerHTML = 
          '<div class="action-menu-item" data-action="play-playlist">' +
            '<i class="bi bi-play-fill"></i> Phát playlist' +
          '</div>' +
          '<div class="action-menu-item" data-action="edit-playlist">' +
            '<i class="bi bi-pencil"></i> Chỉnh sửa' +
          '</div>' +
          '<div class="action-menu-item" data-action="share">' +
            '<i class="bi bi-share"></i> Chia sẻ' +
          '</div>' +
          '<div class="action-menu-item" data-action="copy-link">' +
            '<i class="bi bi-link-45deg"></i> Sao chép liên kết' +
          '</div>' +
          '<div class="action-menu-item text-danger" data-action="delete-playlist">' +
            '<i class="bi bi-trash"></i> Xóa playlist' +
          '</div>';
        return menu;
      }

      function closeActionMenu() {
        if (activeActionMenu) {
          activeActionMenu.remove();
          activeActionMenu = null;
        }
      }

      // Handle btn-menu click (3 dots)
      document.addEventListener('click', function(e) {
        var menuBtn = e.target.closest('.btn-menu');
        
        if (menuBtn) {
          e.preventDefault();
          e.stopPropagation();
          
          closeActionMenu();
          
          var trackId = menuBtn.dataset.trackId;
          var playlistId = menuBtn.dataset.playlistId;
          var type = menuBtn.dataset.type;
          
          var menu;
          if (type === 'playlist' || playlistId) {
            menu = createPlaylistMenu();
            menu.dataset.playlistId = playlistId;
            menu.dataset.type = 'playlist';
          } else {
            menu = createActionMenu();
            menu.dataset.trackId = trackId;
            menu.dataset.type = 'favorite';
          }
          
          // Position menu
          var rect = menuBtn.getBoundingClientRect();
          menu.style.position = 'fixed';
          menu.style.top = (rect.bottom + 5) + 'px';
          menu.style.left = (rect.left - 150) + 'px';
          
          document.body.appendChild(menu);
          activeActionMenu = menu;
          
          // Show with animation
          setTimeout(function() { menu.classList.add('show'); }, 10);
          
        } else if (!e.target.closest('.action-menu-dropdown')) {
          closeActionMenu();
        }
      });

      // Handle menu item click
      document.addEventListener('click', function(e) {
        var menuItem = e.target.closest('.action-menu-item');
        if (!menuItem) return;
        
        e.preventDefault();
        e.stopPropagation();
        
        var menu = menuItem.closest('.action-menu-dropdown');
        var action = menuItem.dataset.action;
        var trackId = menu.dataset.trackId;
        var playlistId = menu.dataset.playlistId;
        var type = menu.dataset.type;
        
        closeActionMenu();
        
        switch(action) {
          case 'add-queue':
            showToast('Đã thêm vào danh sách chờ', 'success');
            break;
          case 'add-playlist':
            showToast('Tính năng sắp ra mắt', 'success');
            break;
          case 'go-track':
            window.location.href = contextPath + '/track.jsp?id=' + trackId;
            break;
          case 'go-artist':
            showToast('Tính năng sắp ra mắt', 'success');
            break;
          case 'share':
          case 'copy-link':
            var url;
            if (type === 'playlist') {
              url = window.location.origin + contextPath + '/playlist_detail.jsp?id=' + playlistId;
            } else {
              url = window.location.origin + contextPath + '/track.jsp?id=' + trackId;
            }
            navigator.clipboard.writeText(url).then(function() {
              showToast('Đã sao chép liên kết!', 'success');
            });
            break;
          case 'remove':
            deleteType = 'favorite';
            deleteId = trackId;
            openDeleteModal('favorite', trackId);
            break;
          case 'play-playlist':
            showToast('Đang phát playlist...', 'success');
            break;
          case 'edit-playlist':
            showToast('Tính năng sắp ra mắt', 'success');
            break;
          case 'delete-playlist':
            deleteType = 'playlist';
            deleteId = playlistId;
            openDeleteModal('playlist', playlistId);
            break;
        }
      });

      // Handle favorite button click (both old .btn-favorite and new .sc-btn-like)
      document.querySelectorAll('.btn-favorite, .sc-btn-like').forEach(function(btn) {
        btn.addEventListener('click', function(e) {
          e.preventDefault();
          e.stopPropagation();
          
          var trackId = this.dataset.trackId;
          deleteType = 'favorite';
          deleteId = trackId;
          openDeleteModal('favorite', trackId);
        });
      });

      // Handle play button click
      document.querySelectorAll('.fav-play, .btn-play').forEach(function(btn) {
        btn.addEventListener('click', function(e) {
          e.preventDefault();
          e.stopPropagation();
          
          var trackId = this.dataset.trackId;
          if (window.playTrack) {
            window.playTrack(trackId);
          } else {
            showToast('Đang phát bài hát...', 'success');
          }
        });
      });

      // Handle fav-btn.liked click (remove from favorites)
      document.querySelectorAll('.fav-btn.liked').forEach(function(btn) {
        btn.addEventListener('click', function(e) {
          e.preventDefault();
          e.stopPropagation();
          
          var trackId = this.dataset.trackId;
          openDeleteModal('favorite', trackId);
        });
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