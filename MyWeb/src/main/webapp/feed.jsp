<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1" />
<!-- Bootstrap 5 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Google Font -->
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700;800&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
<link rel="stylesheet" href="assets/css/home.css?v=3">
<link rel="stylesheet" href="assets/css/next_up.css">
<link rel="stylesheet" href="assets/css/feed.css">
<title>Feed</title>
</head>
<body>
	<%@ include file="header.jsp" %>
	<script>
		// Change active nav to "Tin tức" for feed page
		document.addEventListener('DOMContentLoaded', function() {
			const navLinks = document.querySelectorAll('.site-nav .nav-link');
			navLinks.forEach(link => {
				link.classList.remove('active');
				if (link.textContent.trim() === 'Tin tức') {
					link.classList.add('active');
				}
			});
		});
	</script>

	<div class="container home-wrapper">

		<!-- Two Column Layout -->
		<div class="row">
			<!-- Left Column: Playlists -->
			<div class="col-lg-8">
				<!-- MAIN TITLE -->
				<!-- Feed Header -->
				<div class="feed-header">
					<h2 class="section-title">Nghe những bài đăng mới nhất từ ​​những người bạn đang theo dõi:</h2>
					<div class="feed-filter">
						<span>Đăng lại</span>
						<label class="feed-toggle">
							<input type="checkbox" checked>
							<span class="toggle-slider"></span>
						</label>
					</div>
				</div>

				<!-- Feed Posts -->
				<div class="feed-posts">
					<!-- Posts sẽ được load từ API -->
					<div class="text-center text-muted p-4" id="feedLoading">
						<i class="bi bi-music-note-beamed" style="font-size: 2rem;"></i>
						<p>Đang tải bài đăng...</p>
					</div>
				</div>
			</div>

			<!-- Right Column: Artists You Should Follow & Listening History -->
			<%@ include file="right_column.jsp" %>
		</div>

		</div>

	<%@ include file="player.jsp" %>
	<%@ include file="footer.jsp" %>
	<script src="assets/js/app.js"></script>
	
	<!-- Add to Playlist Modal -->
	<div class="modal fade" id="addToPlaylistModal" tabindex="-1" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content bg-dark text-white">
				<div class="modal-header border-secondary">
					<h5 class="modal-title">Thêm vào Playlist</h5>
					<button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
				</div>
				<div class="modal-body">
					<div id="playlistList" class="list-group list-group-flush">
						<!-- Playlists will be loaded here -->
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<script>
		let currentTrackId = null;
		
		document.addEventListener('DOMContentLoaded', function() {
			loadFeedPosts();
			setupFeedEventListeners();
		});
		
		// Load posts từ API (tracks gần đây)
		function loadFeedPosts() {
			fetch('api/tracks/recent', {
				method: 'GET',
				headers: { 'Content-Type': 'application/json' },
				credentials: 'include'
			})
			.then(response => response.json())
			.then(tracks => {
				renderFeedPosts(tracks);
			})
			.catch(error => {
				console.error('Error loading feed:', error);
			});
		}
		
		// Render posts
		function renderFeedPosts(tracks) {
			const container = document.querySelector('.feed-posts');
			if (!container) return;
			
			// Xóa loading indicator
			const loadingDiv = document.getElementById('feedLoading');
			if (loadingDiv) loadingDiv.remove();
			
			if (!tracks || tracks.length === 0) {
				container.innerHTML = '<div class="text-center text-muted p-4"><i class="bi bi-music-note-beamed" style="font-size: 2rem;"></i><p>Chưa có bài đăng nào</p></div>';
				return;
			}
			
			container.innerHTML = '';
			tracks.forEach((track, index) => {
				const post = createFeedPost(track, index);
				container.appendChild(post);
			});
		}
		
		// Tạo HTML cho mỗi post
		function createFeedPost(track, index) {
			const post = document.createElement('div');
			post.className = 'feed-post';
			const trackId = track.trackId || track.id;
			post.dataset.trackId = trackId;
			
			const imgUrl = track.artworkUrl || track.coverImageUrl || 'assets/img/default-track.jpg';
			const isFavorited = track.favorited || false;
			const timeAgo = getTimeAgo(track.createdAt);
			
			post.innerHTML = 
				'<div class="post-header">' +
					'<img src="assets/img/profile_avatar.jpg" alt="User" class="post-avatar">' +
					'<div class="post-user-info">' +
						'<span class="post-username">' + escapeHtml(track.uploaderUsername || 'Anonymous') + '</span>' +
						'<span class="post-time">đã đăng một bài hát ' + timeAgo + '</span>' +
					'</div>' +
				'</div>' +
				'<div class="post-content">' +
					'<img src="' + imgUrl + '" alt="Track" class="post-cover" onerror="this.src=\'assets/img/default-track.jpg\'">' +
					'<div class="post-player">' +
						'<div class="player-top">' +
							'<button class="post-play-btn" data-track-id="' + trackId + '">' +
								'<i class="bi bi-play-fill"></i>' +
							'</button>' +
							'<div class="track-info">' +
								'<div class="track-artist">' + escapeHtml(track.artist || '') + '</div>' +
								'<a href="track.jsp?id=' + trackId + '" class="track-title" style="text-decoration:none; color:inherit;">' + escapeHtml(track.title) + '</a>' +
							'</div>' +
							'<div class="post-tag"># ' + escapeHtml(track.genre || 'Music') + '</div>' +
						'</div>' +
						'<div class="track-waveform">' +
							'<div class="waveform-track">' +
								'<div class="waveform-progress"></div>' +
								'<div class="waveform-thumb"></div>' +
							'</div>' +
							'<div class="track-duration">' + formatDuration(track.duration || 0) + '</div>' +
						'</div>' +
						'<div class="post-actions">' +
							'<div class="action-buttons">' +
								'<button class="post-action-btn btn-like ' + (isFavorited ? 'liked' : '') + '" data-track-id="' + trackId + '">' +
									'<i class="bi ' + (isFavorited ? 'bi-heart-fill' : 'bi-heart') + '"></i>' +
									'<span>' + formatNumber(track.likeCount || 0) + '</span>' +
								'</button>' +
								'<button class="post-action-btn btn-repost" data-track-id="' + trackId + '">' +
									'<i class="bi bi-repeat"></i>' +
									'<span>0</span>' +
								'</button>' +
								'<button class="post-action-btn btn-share" data-track-id="' + trackId + '">' +
									'<i class="bi bi-share"></i>' +
								'</button>' +
								'<button class="post-action-btn btn-add-playlist" data-track-id="' + trackId + '">' +
									'<i class="bi bi-plus-square"></i>' +
								'</button>' +
								'<button class="post-action-btn btn-add-queue" data-track-id="' + trackId + '">' +
									'<i class="bi bi-list-ul"></i>' +
								'</button>' +
							'</div>' +
							'<div class="post-stats">' +
								'<span class="plays"><i class="bi bi-play-fill"></i> ' + formatNumber(track.playCount || 0) + '</span>' +
							'</div>' +
						'</div>' +
					'</div>' +
				'</div>';
			
			return post;
		}
		
		// Setup event listeners
		function setupFeedEventListeners() {
			document.addEventListener('click', function(e) {
				// Play button
				if (e.target.closest('.post-play-btn')) {
					const btn = e.target.closest('.post-play-btn');
					const trackId = btn.dataset.trackId;
					if (trackId) playTrackById(trackId, btn);
				}
				
				// Like button
				if (e.target.closest('.btn-like')) {
					const btn = e.target.closest('.btn-like');
					const trackId = btn.dataset.trackId;
					if (trackId) toggleFavorite(trackId, btn);
				}
				
				// Add to playlist button
				if (e.target.closest('.btn-add-playlist')) {
					const btn = e.target.closest('.btn-add-playlist');
					const trackId = btn.dataset.trackId;
					if (trackId) openAddToPlaylistModal(trackId);
				}
				
				// Add to queue button
				if (e.target.closest('.btn-add-queue')) {
					const btn = e.target.closest('.btn-add-queue');
					const trackId = btn.dataset.trackId;
					if (trackId) addToQueue(trackId);
				}
			});
		}
		
		// Play track
		function playTrackById(trackId, btn) {
			fetch('api/tracks/' + trackId, {
				method: 'GET',
				headers: { 'Content-Type': 'application/json' },
				credentials: 'include'
			})
			.then(response => response.json())
			.then(track => {
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
					// Update button icon
					btn.querySelector('i').className = 'bi bi-pause-fill';
				} else {
					showNotification('Bài hát không có file audio', 'error');
				}
			})
			.catch(error => {
				console.error('Error playing track:', error);
				showNotification('Không thể phát bài hát', 'error');
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
				showNotification('Lỗi khi cập nhật yêu thích', 'error');
			});
		}
		
		// Open add to playlist modal
		function openAddToPlaylistModal(trackId) {
			currentTrackId = trackId;
			
			fetch('api/playlists', {
				method: 'GET',
				headers: { 'Content-Type': 'application/json' },
				credentials: 'include'
			})
			.then(response => response.json())
			.then(playlists => {
				const listContainer = document.getElementById('playlistList');
				listContainer.innerHTML = '';
				
				if (playlists.length === 0) {
					listContainer.innerHTML = '<div class="text-muted p-3">Bạn chưa có playlist nào</div>';
				} else {
					playlists.forEach(playlist => {
						const item = document.createElement('button');
						item.className = 'list-group-item list-group-item-action bg-dark text-white border-secondary';
						item.innerHTML = '<i class="bi bi-music-note-list me-2"></i>' + escapeHtml(playlist.name);
						item.addEventListener('click', () => addTrackToPlaylist(playlist.id, playlist.name));
						listContainer.appendChild(item);
					});
				}
				
				const modal = new bootstrap.Modal(document.getElementById('addToPlaylistModal'));
				modal.show();
			})
			.catch(error => {
				console.error('Error loading playlists:', error);
				showNotification('Không thể tải danh sách playlist', 'error');
			});
		}
		
		// Add track to playlist
		function addTrackToPlaylist(playlistId, playlistName) {
			if (!currentTrackId) return;
			
			fetch('api/playlists/' + playlistId + '/tracks', {
				method: 'POST',
				headers: { 'Content-Type': 'application/json' },
				body: JSON.stringify({ trackId: parseInt(currentTrackId) }),
				credentials: 'include'
			})
			.then(response => response.json())
			.then(data => {
				bootstrap.Modal.getInstance(document.getElementById('addToPlaylistModal')).hide();
				showNotification('Đã thêm vào "' + playlistName + '"');
			})
			.catch(error => {
				console.error('Error adding to playlist:', error);
				showNotification('Không thể thêm vào playlist', 'error');
			});
		}
		
		// Add to queue
		function addToQueue(trackId) {
			fetch('api/tracks/' + trackId, {
				method: 'GET',
				headers: { 'Content-Type': 'application/json' },
				credentials: 'include'
			})
			.then(response => response.json())
			.then(track => {
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
			})
			.catch(error => {
				console.error('Error adding to queue:', error);
				showNotification('Không thể thêm vào danh sách chờ', 'error');
			});
		}
		
		// Helper functions
		function escapeHtml(text) {
			if (!text) return '';
			const div = document.createElement('div');
			div.textContent = text;
			return div.innerHTML;
		}
		
		function formatDuration(seconds) {
			const mins = Math.floor(seconds / 60);
			const secs = seconds % 60;
			return mins + ':' + (secs < 10 ? '0' : '') + secs;
		}
		
		function formatNumber(num) {
			if (num >= 1000000) return (num / 1000000).toFixed(1) + 'M';
			if (num >= 1000) return (num / 1000).toFixed(1) + 'K';
			return num.toString();
		}
		
		function getTimeAgo(dateString) {
			if (!dateString) return 'gần đây';
			const date = new Date(dateString);
			const now = new Date();
			const diff = now - date;
			const days = Math.floor(diff / (1000 * 60 * 60 * 24));
			if (days === 0) return 'hôm nay';
			if (days === 1) return 'hôm qua';
			if (days < 7) return days + ' ngày trước';
			if (days < 30) return Math.floor(days / 7) + ' tuần trước';
			return Math.floor(days / 30) + ' tháng trước';
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
</body>
</html>