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
  <link rel="stylesheet" href="assets/css/playlist_detail.css">
  <style>
    .detail-view { display: none; }
    .detail-view.active { display: block; }
    .library-content.hidden { display: none; }
    .back-btn { 
      background: none; border: none; color: #fff; 
      font-size: 1.1rem; cursor: pointer; margin-bottom: 1rem;
    }
    .back-btn:hover { color: #f50; }
  </style>
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
    <!-- Library Content (Tabs) -->
    <div class="library-content" id="libraryContent">
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
          <div class="stat" id="statLikes">0<br><span>Likes</span></div>
          <div class="stat" id="statPlaylists">0<br><span>Playlists</span></div>
          <div class="stat" id="statHistory">0<br><span>History</span></div>
        </div>
      </div>

      <!-- OVERVIEW -->
      <section class="section-block lib-pane active" data-tab="overview" id="overviewPane">
        <h4 class="sub-title mb-3">Recently played</h4>
        <div class="card-row" id="recentlyPlayedContainer">
          <div class="spinner-border text-primary" role="status">
            <span class="visually-hidden">Loading...</span>
          </div>
        </div>
      </section>

      <!-- Likes -->
      <section class="section-block lib-pane" data-tab="likes">
        <div class="d-flex justify-content-between align-items-center mb-3">
          <h4 class="sub-title">Likes</h4>
        </div>
        <div class="card-row" id="likesContainer">
          <div class="spinner-border text-primary" role="status">
            <span class="visually-hidden">Loading...</span>
          </div>
        </div>
      </section>

      <!-- Playlists -->
      <section class="section-block lib-pane" data-tab="playlists">
        <div class="d-flex justify-content-between align-items-center mb-3">
          <h4 class="sub-title">Playlists</h4>
        </div>
        <div class="card-row" id="playlistsContainer">
          <div class="spinner-border text-primary" role="status">
            <span class="visually-hidden">Loading...</span>
          </div>
        </div>
      </section>

      <!-- Albums -->
      <section class="section-block lib-pane" data-tab="albums">
        <h4 class="sub-title mb-3">Albums</h4>
        <div class="card-row">
          <a href="#" class="playlist-card"><div class="playlist-img-wrapper"><img src="assets/img/ca-phe_song.jpg" class="playlist-img" alt="Cà Phê"></div><div class="playlist-title">Cà Phê</div><div class="playlist-desc">Minh</div></a>
          <a href="#" class="playlist-card"><div class="playlist-img-wrapper"><img src="assets/img/kem-duyen_song.jpg" class="playlist-img" alt="Kẻ Mê Duyên"></div><div class="playlist-title">Kẻ Mê Duyên</div><div class="playlist-desc">Hứa Kim Tuyền</div></a>
        </div>
      </section>

      <!-- Stations -->
      <section class="section-block lib-pane" data-tab="stations">
        <h4 class="sub-title mb-3">Stations</h4>
        <div class="card-row">
          <a href="#" class="playlist-card"><div class="playlist-img-wrapper"><img src="assets/img/rnh2-playlist.jpg" class="playlist-img" alt="Hip-Hop Radio"></div><div class="playlist-title">Hip-Hop Radio</div><div class="playlist-desc">Based on Travis Scott</div></a>
          <a href="#" class="playlist-card"><div class="playlist-img-wrapper"><img src="assets/img/edm2-playlist.jpg" class="playlist-img" alt="EDM Radio"></div><div class="playlist-title">EDM Radio</div><div class="playlist-desc">Based on Martin Garrix</div></a>
        </div>
      </section>

      <!-- Following -->
      <section class="section-block lib-pane" data-tab="following">
        <h4 class="sub-title mb-3">Following</h4>
        <div class="card-row" id="followingContainer">
          <div class="text-muted">Bạn chưa theo dõi ai</div>
        </div>
      </section>

      <!-- History -->
      <section class="section-block lib-pane" data-tab="history">
        <h4 class="sub-title mb-3">History</h4>
        <div class="card-row" id="historyContainer">
          <div class="spinner-border text-primary" role="status">
            <span class="visually-hidden">Loading...</span>
          </div>
        </div>
      </section>
    </div>

    <!-- Detail View (shows tracks list) -->
    <div class="detail-view" id="detailView">
      <button class="back-btn" id="backBtn">
        <i class="bi bi-arrow-left"></i> Quay lại thư viện
      </button>
      
      <div class="playlist-hero" id="detailHero">
        <div class="hero-top-left">
          <button class="hero-play-btn" id="playAllBtn">
            <i class="bi bi-play-fill"></i>
          </button>
          <div class="playlist-hero-content">
            <h1 class="playlist-hero-title" id="detailTitle">Playlist Name</h1>
            <div class="playlist-creator" id="detailCreator">Made for you</div>
          </div>
        </div>
        <div class="track-count-btn">
          <div class="track-count-number" id="detailTrackCount">0</div>
          <div class="track-count-label">TRACKS</div>
        </div>
        <div class="playlist-artwork">
          <img src="assets/img/default-playlist.jpg" alt="Artwork" class="playlist-artwork-img" id="detailArtwork">
        </div>
      </div>

      <!-- Tracks List -->
      <div class="related-tracks" id="detailTracksContainer">
        <!-- Tracks will be loaded here -->
      </div>
    </div>
  </main>	

  <script>
    let currentDetailType = null; // 'likes', 'playlist', 'history'
    let currentDetailId = null;
    let detailTracks = [];
    
    document.addEventListener('DOMContentLoaded', function() {
      loadLibraryData();
      setupTabNavigation();
      setupDetailView();
    });
    
    // Load all library data
    function loadLibraryData() {
      loadLikes();
      loadPlaylists();
      loadHistory();
    }
    
    // Load likes
    function loadLikes() {
      fetch('api/favorites', {
        method: 'GET',
        headers: { 'Content-Type': 'application/json' },
        credentials: 'include'
      })
      .then(response => response.json())
      .then(tracks => {
        const container = document.getElementById('likesContainer');
        const recentContainer = document.getElementById('recentlyPlayedContainer');
        
        document.getElementById('statLikes').innerHTML = tracks.length + '<br><span>Likes</span>';
        
        if (!tracks || tracks.length === 0) {
          container.innerHTML = '<div class="text-muted">Bạn chưa thích bài hát nào</div>';
          return;
        }
        
        container.innerHTML = '';
        recentContainer.innerHTML = '';
        
        tracks.slice(0, 8).forEach(track => {
          container.appendChild(createTrackCard(track));
          recentContainer.appendChild(createTrackCard(track));
        });
        
        // Add "View All" card if more than 8
        if (tracks.length > 8) {
          const viewAllCard = createViewAllCard('likes', tracks.length);
          container.appendChild(viewAllCard);
        }
      })
      .catch(error => {
        console.error('Error loading likes:', error);
        document.getElementById('likesContainer').innerHTML = '<div class="text-muted">Không thể tải danh sách</div>';
      });
    }
    
    // Load playlists
    function loadPlaylists() {
      fetch('api/playlists', {
        method: 'GET',
        headers: { 'Content-Type': 'application/json' },
        credentials: 'include'
      })
      .then(response => response.json())
      .then(playlists => {
        const container = document.getElementById('playlistsContainer');
        
        document.getElementById('statPlaylists').innerHTML = playlists.length + '<br><span>Playlists</span>';
        
        if (!playlists || playlists.length === 0) {
          container.innerHTML = '<div class="text-muted">Bạn chưa có playlist nào</div>';
          return;
        }
        
        container.innerHTML = '';
        playlists.forEach(playlist => {
          container.appendChild(createPlaylistCard(playlist));
        });
      })
      .catch(error => {
        console.error('Error loading playlists:', error);
        document.getElementById('playlistsContainer').innerHTML = '<div class="text-muted">Không thể tải danh sách</div>';
      });
    }
    
    // Load history
    function loadHistory() {
      fetch('api/tracks/recent', {
        method: 'GET',
        headers: { 'Content-Type': 'application/json' },
        credentials: 'include'
      })
      .then(response => response.json())
      .then(tracks => {
        const container = document.getElementById('historyContainer');
        
        document.getElementById('statHistory').innerHTML = tracks.length + '<br><span>History</span>';
        
        if (!tracks || tracks.length === 0) {
          container.innerHTML = '<div class="text-muted">Chưa có lịch sử nghe</div>';
          return;
        }
        
        container.innerHTML = '';
        tracks.slice(0, 8).forEach(track => {
          container.appendChild(createTrackCard(track));
        });
      })
      .catch(error => {
        console.error('Error loading history:', error);
        document.getElementById('historyContainer').innerHTML = '<div class="text-muted">Không thể tải lịch sử</div>';
      });
    }
    
    // Create track card
    function createTrackCard(track) {
      const card = document.createElement('div');
      card.className = 'playlist-card';
      card.dataset.trackId = track.trackId || track.id;
      card.dataset.type = 'track';
      
      const imgUrl = track.artworkUrl || track.coverImageUrl || 'assets/img/default-track.jpg';
      const trackId = track.trackId || track.id;
      
      card.innerHTML = 
        '<div class="playlist-img-wrapper">' +
          '<img src="' + imgUrl + '" class="playlist-img" alt="' + escapeHtml(track.title) + '" onerror="this.src=\'assets/img/default-track.jpg\'">' +
          '<div class="playlist-overlay">' +
            '<button class="btn-play" data-track-id="' + trackId + '">' +
              '<i class="bi bi-play-fill"></i>' +
            '</button>' +
          '</div>' +
        '</div>' +
        '<div class="playlist-title">' + escapeHtml(track.title) + '</div>' +
        '<div class="playlist-desc">' + escapeHtml(track.artist || '') + '</div>';
      
      card.querySelector('.btn-play').addEventListener('click', (e) => {
        e.preventDefault();
        e.stopPropagation();
        playTrack(track);
      });
      
      return card;
    }
    
    // Create playlist card
    function createPlaylistCard(playlist) {
      const card = document.createElement('div');
      card.className = 'playlist-card';
      card.dataset.playlistId = playlist.id;
      card.dataset.type = 'playlist';
      card.style.cursor = 'pointer';
      
      const imgUrl = playlist.artworkUrl || playlist.imagePath || 'assets/img/default-playlist.jpg';
      
      card.innerHTML = 
        '<div class="playlist-img-wrapper">' +
          '<img src="' + imgUrl + '" class="playlist-img" alt="' + escapeHtml(playlist.name) + '" onerror="this.src=\'assets/img/default-playlist.jpg\'">' +
          '<div class="playlist-overlay">' +
            '<button class="btn-play" data-playlist-id="' + playlist.id + '">' +
              '<i class="bi bi-play-fill"></i>' +
            '</button>' +
          '</div>' +
        '</div>' +
        '<div class="playlist-title">' + escapeHtml(playlist.name) + '</div>' +
        '<div class="playlist-desc">' + escapeHtml(playlist.description || '') + '</div>';
      
      // Click card to go to playlist_detail.jsp
      card.addEventListener('click', (e) => {
        if (!e.target.closest('.btn-play')) {
          window.location.href = 'playlist_detail.jsp?id=' + playlist.id;
        }
      });
      
      card.querySelector('.btn-play').addEventListener('click', (e) => {
        e.preventDefault();
        e.stopPropagation();
        playPlaylistTracks(playlist.id);
      });
      
      return card;
    }
    
    // Create view all card
    function createViewAllCard(type, count) {
      const card = document.createElement('div');
      card.className = 'playlist-card view-all-card';
      card.style.cursor = 'pointer';
      
      card.innerHTML = 
        '<div class="playlist-img-wrapper" style="background: linear-gradient(135deg, #f50 0%, #ff8c00 100%); display: flex; align-items: center; justify-content: center;">' +
          '<i class="bi bi-arrow-right" style="font-size: 3rem; color: #fff;"></i>' +
        '</div>' +
        '<div class="playlist-title">Xem tất cả</div>' +
        '<div class="playlist-desc">' + count + ' bài hát</div>';
      
      card.addEventListener('click', () => {
        if (type === 'likes') {
          openLikesDetail();
        }
      });
      
      return card;
    }
    
    // Open playlist detail
    function openPlaylistDetail(playlist) {
      currentDetailType = 'playlist';
      currentDetailId = playlist.id;
      
      document.getElementById('libraryContent').classList.add('hidden');
      document.getElementById('detailView').classList.add('active');
      
      document.getElementById('detailTitle').textContent = playlist.name;
      document.getElementById('detailCreator').textContent = playlist.description || 'Playlist của bạn';
      document.getElementById('detailArtwork').src = playlist.artworkUrl || 'assets/img/default-playlist.jpg';
      
      // Load tracks
      fetch('api/playlists/' + playlist.id + '/tracks', {
        method: 'GET',
        headers: { 'Content-Type': 'application/json' },
        credentials: 'include'
      })
      .then(response => response.json())
      .then(data => {
        detailTracks = data.tracks || [];
        document.getElementById('detailTrackCount').textContent = detailTracks.length;
        renderDetailTracks(detailTracks);
      })
      .catch(error => {
        console.error('Error loading playlist tracks:', error);
        document.getElementById('detailTracksContainer').innerHTML = '<div class="text-muted p-3">Không thể tải danh sách bài hát</div>';
      });
    }
    
    // Open likes detail
    function openLikesDetail() {
      currentDetailType = 'likes';
      currentDetailId = null;
      
      document.getElementById('libraryContent').classList.add('hidden');
      document.getElementById('detailView').classList.add('active');
      
      document.getElementById('detailTitle').textContent = 'Bài hát yêu thích';
      document.getElementById('detailCreator').textContent = 'Các bài hát bạn đã thích';
      document.getElementById('detailArtwork').src = 'assets/img/default-playlist.jpg';
      
      // Load all likes
      fetch('api/favorites', {
        method: 'GET',
        headers: { 'Content-Type': 'application/json' },
        credentials: 'include'
      })
      .then(response => response.json())
      .then(tracks => {
        detailTracks = tracks || [];
        document.getElementById('detailTrackCount').textContent = detailTracks.length;
        renderDetailTracks(detailTracks);
      })
      .catch(error => {
        console.error('Error loading likes:', error);
        document.getElementById('detailTracksContainer').innerHTML = '<div class="text-muted p-3">Không thể tải danh sách</div>';
      });
    }
    
    // Render tracks in detail view
    function renderDetailTracks(tracks) {
      const container = document.getElementById('detailTracksContainer');
      
      if (!tracks || tracks.length === 0) {
        container.innerHTML = '<div class="text-muted p-3">Không có bài hát nào</div>';
        return;
      }
      
      container.innerHTML = '';
      tracks.forEach((track, index) => {
        const item = document.createElement('div');
        item.className = 'track-item';
        item.dataset.trackId = track.trackId || track.id;
        
        const imgUrl = track.artworkUrl || track.coverImageUrl || 'assets/img/default-track.jpg';
        const isFavorited = track.favorited || false;
        const trackId = track.trackId || track.id;
        
        item.innerHTML = 
          '<img src="' + imgUrl + '" alt="Track" class="track-thumbnail" onerror="this.src=\'assets/img/default-track.jpg\'">' +
          '<div class="track-number">' + (index + 1) + '</div>' +
          '<button class="track-play-btn"><i class="bi bi-play-fill"></i></button>' +
          '<div class="track-info">' +
            '<div class="track-title">' + escapeHtml(track.title) + '</div>' +
            '<div class="track-artist">' + escapeHtml(track.artist || '') + '</div>' +
          '</div>' +
          '<div class="track-actions">' +
            '<button class="btn-track-action btn-like ' + (isFavorited ? 'liked' : '') + '" data-track-id="' + trackId + '">' +
              '<i class="bi ' + (isFavorited ? 'bi-heart-fill' : 'bi-heart') + '"></i>' +
            '</button>' +
            '<button class="btn-track-action btn-add-queue" data-track-id="' + trackId + '">' +
              '<i class="bi bi-list-ul"></i>' +
            '</button>' +
            '<div class="track-stats">' +
              '<i class="bi bi-play-fill"></i> ' + formatNumber(track.playCount || 0) +
            '</div>' +
          '</div>';
        
        // Event listeners
        item.querySelector('.track-play-btn').addEventListener('click', () => playTrack(track));
        item.querySelector('.btn-like').addEventListener('click', (e) => toggleFavorite(track.trackId || track.id, e.currentTarget));
        item.querySelector('.btn-add-queue').addEventListener('click', () => addToQueue(track));
        
        container.appendChild(item);
      });
    }
    
    // Setup detail view
    function setupDetailView() {
      document.getElementById('backBtn').addEventListener('click', () => {
        document.getElementById('detailView').classList.remove('active');
        document.getElementById('libraryContent').classList.remove('hidden');
        currentDetailType = null;
        currentDetailId = null;
      });
      
      document.getElementById('playAllBtn').addEventListener('click', () => {
        if (detailTracks.length > 0) {
          playTrack(detailTracks[0]);
          for (let i = 1; i < detailTracks.length; i++) {
            addToQueue(detailTracks[i]);
          }
          showNotification('Đang phát ' + detailTracks.length + ' bài hát');
        }
      });
    }
    
    // Tab navigation
    function setupTabNavigation() {
      const tabs = document.querySelectorAll('.library-tabs .library-tab');
      const panes = document.querySelectorAll('.lib-pane');
      
      function activate(tab) {
        tabs.forEach(a => a.classList.toggle('active', a.dataset.tab === tab));
        panes.forEach(p => p.classList.toggle('active', p.dataset.tab === tab));
      }
      
      tabs.forEach(a => a.addEventListener('click', e => {
        e.preventDefault();
        const t = a.dataset.tab;
        if (location.hash !== '#' + t) history.pushState(null, '', '#' + t);
        activate(t);
      }));
      
      window.addEventListener('hashchange', () => {
        const h = location.hash.replace('#', '').trim() || 'overview';
        activate(h);
      });
      
      const initialTab = location.hash.replace('#', '').trim() || 'overview';
      activate(initialTab);
    }
    
    // Play track
    function playTrack(track) {
      const trackData = {
        trackId: track.trackId || track.id,
        title: track.title,
        artist: track.artist,
        audioFileUrl: track.audioFileUrl || track.audioUrl,
        coverImageUrl: track.artworkUrl || track.coverImageUrl || 'assets/img/default-track.jpg',
        duration: track.duration || 0,
        uploaderUsername: track.uploaderUsername
      };
      
      if (trackData.audioFileUrl && typeof BeatFlowPlayer !== 'undefined') {
        BeatFlowPlayer.loadTrack(trackData, true);
      } else {
        showNotification('Bài hát không có file audio', 'error');
      }
    }
    
    // Play all tracks in playlist
    function playPlaylistTracks(playlistId) {
      fetch('api/playlists/' + playlistId + '/tracks', {
        method: 'GET',
        headers: { 'Content-Type': 'application/json' },
        credentials: 'include'
      })
      .then(response => response.json())
      .then(data => {
        if (data.tracks && data.tracks.length > 0) {
          playTrack(data.tracks[0]);
          for (let i = 1; i < data.tracks.length; i++) {
            addToQueue(data.tracks[i]);
          }
          showNotification('Đang phát playlist');
        }
      })
      .catch(error => {
        console.error('Error playing playlist:', error);
        showNotification('Không thể phát playlist', 'error');
      });
    }
    
    // Toggle favorite
    function toggleFavorite(trackId, button) {
      fetch('api/favorites/toggle', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ trackId: trackId }),
        credentials: 'include'
      })
      .then(response => response.json())
      .then(data => {
        if (data.success) {
          const icon = button.querySelector('i');
          if (data.favorited) {
            button.classList.add('liked');
            icon.className = 'bi bi-heart-fill';
            showNotification('Đã thêm vào yêu thích');
          } else {
            button.classList.remove('liked');
            icon.className = 'bi bi-heart';
            showNotification('Đã bỏ yêu thích');
          }
        }
      })
      .catch(error => {
        console.error('Error toggling favorite:', error);
      });
    }
    
    // Add to queue
    function addToQueue(track) {
      const trackData = {
        trackId: track.trackId || track.id,
        title: track.title,
        artist: track.artist,
        audioFileUrl: track.audioFileUrl || track.audioUrl,
        coverImageUrl: track.artworkUrl || 'assets/img/default-track.jpg',
        duration: track.duration || 0
      };
      
      if (typeof BeatFlowPlayer !== 'undefined') {
        BeatFlowPlayer.addToQueue(trackData);
        showNotification('Đã thêm "' + track.title + '" vào danh sách chờ');
      }
    }
    
    // Helper functions
    function escapeHtml(text) {
      if (!text) return '';
      const div = document.createElement('div');
      div.textContent = text;
      return div.innerHTML;
    }
    
    function formatNumber(num) {
      if (num >= 1000000) return (num / 1000000).toFixed(1) + 'M';
      if (num >= 1000) return (num / 1000).toFixed(1) + 'K';
      return num.toString();
    }
    
    function showNotification(message, type = 'success') {
      const alertClass = type === 'error' ? 'alert-danger' : 'alert-success';
      const alertDiv = document.createElement('div');
      alertDiv.className = 'alert ' + alertClass + ' alert-dismissible fade show position-fixed';
      alertDiv.style.cssText = 'bottom: 100px; right: 20px; z-index: 10001; max-width: 300px;';
      alertDiv.innerHTML = message + '<button type="button" class="btn-close" data-bs-dismiss="alert"></button>';
      document.body.appendChild(alertDiv);
      setTimeout(() => alertDiv.remove(), 3000);
    }
  </script>

  <%@ include file="player.jsp" %>
      </div>
  <!-- Footer -->
  <footer class="py-4" style="background:#0d0d0d; color:#bbb; font-size:.9rem;">
    <div class="container text-center">
      <div class="bf-footer-links">
        <div class="mb-3">
          <a href="#" class="text-secondary me-2">Trang chính thức</a> ·
          <a href="#" class="text-secondary mx-2">Bảo mật</a> ·
          <a href="#" class="text-secondary mx-2">Chính sách Cookie</a>
        </div>
        <div class="text-secondary">Ngôn ngữ: <a href="#" class="text-primary fw-bold">Tiếng Việt (VN)</a></div>
      </div>
    </div>
  </footer>

  <link rel="stylesheet" href="assets/css/next_up.css">
</body>
</html>