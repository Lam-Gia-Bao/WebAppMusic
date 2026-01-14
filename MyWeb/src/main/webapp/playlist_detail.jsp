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
<link rel="stylesheet" href="assets/css/playlist_detail.css">
<title>Playlist Detail - BeatFlow</title>
</head>
<body>
	<%@ include file="header.jsp" %>

	<div class="playlist-detail-wrapper">
		<div class="container">
		<div class="row">
			<!-- Main Content -->
			<div class="col-12">
				<!-- Playlist Header -->
				<div class="playlist-hero">
					<div class="hero-top-left">
						<button class="hero-play-btn">
							<i class="bi bi-play-fill"></i>
						</button>
						<div class="playlist-hero-content">
							<h1 class="playlist-hero-title">Related tracks: her</h1>
							<div class="playlist-meta">
								<span class="badge-private"><i class="bi bi-lock-fill"></i> PRIVATE</span>
							</div>
							<div class="playlist-creator">Made for Bảo Lâm</div>
						</div>
					</div>
					<div class="track-count-btn">
						<div class="track-count-number">21</div>
						<div class="track-count-label">TRACKS</div>
						<div class="track-count-time">1:09:31</div>
					</div>
					<div class="playlist-artwork">
						<img src="assets/img/viet-playlist.jpg" alt="Playlist artwork" class="playlist-artwork-img">
					</div>
				</div>

				<!-- Action Buttons -->
				<div class="playlist-actions">
					<button class="btn-action-large liked">
						<i class="bi bi-heart-fill"></i>
						<span>Thích</span>
					</button>
					<button class="btn-action-large">
						<i class="bi bi-share"></i>
						<span>Chia sẻ</span>
					</button>
					<button class="btn-action-large">
						<i class="bi bi-justify"></i>
						<span>Thêm vào danh sách chờ</span>
					</button>
					<button class="btn-action-large">
						<i class="bi bi-bookmark"></i>
						<span>Thêm vào playlist</span>
					</button>
				</div>

				<!-- Content with Sidebar Layout -->
				<div class="row">
					<div class="col-lg-8">
						<!-- Related Tracks List (will be loaded dynamically) -->
						<div class="related-tracks" id="tracksContainer">
							<div class="text-center p-4">
								<div class="spinner-border text-primary" role="status">
									<span class="visually-hidden">Loading...</span>
								</div>
								<p class="text-muted mt-2">Đang tải danh sách bài hát...</p>
							</div>
						</div>
					</div>

					<div class="col-lg-4">
						<div class="playlist-sidebar" id="playlistSidebar">
							<!-- Sidebar content will be loaded dynamically -->
						</div>
					</div>
				</div>
			</div>
		</div>
		</div>
	</div>

	<%@ include file="player.jsp" %>
	<%@ include file="footer.jsp" %>
	<script src="assets/js/app.js"></script>
	<script>
		let playlistData = null;
		let playlistTracks = [];

		// Playlist Detail Page JavaScript
		document.addEventListener('DOMContentLoaded', function() {
			loadPlaylistDetail();
			initPlaylistDetailPage();
		});

		// Load playlist data từ API
		function loadPlaylistDetail() {
			const urlParams = new URLSearchParams(window.location.search);
			const playlistId = urlParams.get('id');
			
			console.log('Playlist ID from URL:', playlistId);
			console.log('Current URL:', window.location.href);
			
			if (!playlistId) {
				document.getElementById('tracksContainer').innerHTML = '<div class="text-danger p-4"><i class="bi bi-exclamation-triangle"></i> Không có ID playlist trong URL</div>';
				document.querySelector('.playlist-hero-title').textContent = 'Playlist không tồn tại';
				document.querySelector('.track-count-number').textContent = '0';
				document.querySelector('.track-count-time').textContent = '0:00';
				return;
			}

			console.log('Loading playlist ID:', playlistId);
			
			// Load playlist info và tracks
			fetch('api/playlists/' + playlistId + '/tracks', {
				method: 'GET',
				headers: { 'Content-Type': 'application/json' },
				credentials: 'include'
			})
			.then(response => {
				console.log('API response status:', response.status);
				if (!response.ok) {
					throw new Error('HTTP error! status: ' + response.status);
				}
				return response.json();
			})
			.then(data => {
				console.log('API data:', data);
				
				// Check if API returned error
				if (data.success === false) {
					throw new Error(data.error || 'Unknown error');
				}
				
				playlistData = data;
				playlistTracks = data.tracks || [];
				
				// Update header
				document.querySelector('.playlist-hero-title').textContent = data.name || 'Playlist';
				document.querySelector('.playlist-creator').textContent = data.description || 'Playlist của bạn';
				document.querySelector('.track-count-number').textContent = playlistTracks.length;
				
				// Calculate total duration
				const totalSeconds = playlistTracks.reduce((sum, t) => sum + (t.duration || 0), 0);
				document.querySelector('.track-count-time').textContent = formatDuration(totalSeconds);
				
				// Update artwork - use playlist artwork or first track artwork
				const artworkImg = document.querySelector('.playlist-artwork-img');
				if (data.artworkUrl) {
					artworkImg.src = data.artworkUrl;
				} else if (playlistTracks.length > 0 && playlistTracks[0].artworkUrl) {
					artworkImg.src = playlistTracks[0].artworkUrl;
				}
				
				// Render tracks
				renderPlaylistTracks(playlistTracks);
			})
			.catch(error => {
				console.error('Error loading playlist:', error);
				document.getElementById('tracksContainer').innerHTML = '<div class="text-muted p-4">Không thể tải playlist: ' + error.message + '</div>';
			});
		}

		// Render tracks list
		function renderPlaylistTracks(tracks) {
			const container = document.getElementById('tracksContainer');
			
			if (!tracks || tracks.length === 0) {
				container.innerHTML = '<div class="text-muted p-4">Playlist này chưa có bài hát nào</div>';
				return;
			}
			
			container.innerHTML = '';
			tracks.forEach((track, index) => {
				const trackItem = createTrackItem(track, index + 1);
				container.appendChild(trackItem);
			});
		}

		// Create track item HTML
		function createTrackItem(track, number) {
			const div = document.createElement('div');
			div.className = 'track-item';
			div.dataset.trackId = track.trackId || track.id;
			
			const imgUrl = track.artworkUrl || 'assets/img/default-track.jpg';
			const isFavorited = track.favorited || false;
			const trackId = track.trackId || track.id;
			
			div.innerHTML = 
				'<img src="' + imgUrl + '" alt="Track" class="track-thumbnail" onerror="this.src=\'assets/img/default-track.jpg\'">' +
				'<div class="track-number">' + number + '</div>' +
				'<button class="track-play-btn" data-track-id="' + trackId + '"><i class="bi bi-play-fill"></i></button>' +
				'<div class="track-info">' +
					'<div class="track-title">' + escapeHtml(track.title) + '</div>' +
					'<div class="track-artist">' + escapeHtml(track.artist || '') + '</div>' +
				'</div>' +
				'<div class="track-actions">' +
					'<button class="btn-track-action btn-like ' + (isFavorited ? 'liked' : '') + '" data-track-id="' + trackId + '">' +
						'<i class="bi ' + (isFavorited ? 'bi-heart-fill' : 'bi-heart') + '"></i>' +
					'</button>' +
					'<button class="btn-track-action btn-add-queue" data-track-id="' + trackId + '">' +
						'<i class="bi bi-plus-lg"></i>' +
					'</button>' +
					'<button class="btn-track-action btn-menu" data-track-id="' + trackId + '">' +
						'<i class="bi bi-three-dots"></i>' +
					'</button>' +
					'<div class="track-stats">' +
						'<i class="bi bi-play-fill"></i> ' + formatNumber(track.playCount || 0) +
					'</div>' +
				'</div>';
			
			// Event listeners
			div.querySelector('.track-play-btn').addEventListener('click', (e) => {
				e.stopPropagation();
				playTrackById(track.trackId || track.id);
			});
			
			div.querySelector('.btn-like').addEventListener('click', (e) => {
				e.stopPropagation();
				toggleFavorite(track.trackId || track.id, e.target.closest('.btn-like'));
			});
			
			div.querySelector('.btn-add-queue').addEventListener('click', (e) => {
				e.stopPropagation();
				addToQueue(track.trackId || track.id);
			});
			
			return div;
		}

		function initPlaylistDetailPage() {
			// Hero play button - play all tracks
			const heroPlayBtn = document.querySelector('.hero-play-btn');
			if (heroPlayBtn) {
				heroPlayBtn.addEventListener('click', function() {
					playAllTracks();
				});
			}

			// Add to queue button
			const addToQueueBtn = document.querySelector('.btn-action-large .bi-justify')?.closest('button');
			if (addToQueueBtn) {
				addToQueueBtn.addEventListener('click', function() {
					addAllToQueue();
				});
			}
		}

		function playAllTracks() {
			const urlParams = new URLSearchParams(window.location.search);
			const playlistId = urlParams.get('id');
			
			if (playlistId) {
				fetch('api/playlists/' + playlistId + '/tracks', {
					method: 'GET',
					headers: { 'Content-Type': 'application/json' },
					credentials: 'include'
				})
				.then(response => response.json())
				.then(data => {
					if (data.tracks && data.tracks.length > 0) {
						const tracks = data.tracks.map(track => ({
							trackId: track.trackId || track.id,
							title: track.title,
							artist: track.artist,
							audioFileUrl: track.audioFileUrl || track.audioUrl,
							coverImageUrl: track.artworkUrl || 'assets/img/default-track.jpg',
							duration: track.duration || 0
						}));
						
						if (typeof BeatFlowPlayer !== 'undefined') {
							BeatFlowPlayer.loadTrack(tracks[0], true);
							for (let i = 1; i < tracks.length; i++) {
								BeatFlowPlayer.addToQueue(tracks[i]);
							}
						}
						showNotification('Đang phát playlist');
					}
				})
				.catch(error => {
					console.error('Error loading playlist:', error);
					showNotification('Không thể phát playlist', 'error');
				});
			}
		}

		function playTrackById(trackId) {
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
					duration: track.duration || 0,
					uploaderUsername: track.uploaderUsername
				};
				
				if (trackData.audioFileUrl && typeof BeatFlowPlayer !== 'undefined') {
					BeatFlowPlayer.loadTrack(trackData, true);
				} else {
					showNotification('Bài hát không có file audio', 'error');
				}
			})
			.catch(error => {
				console.error('Error playing track:', error);
				showNotification('Không thể phát bài hát', 'error');
			});
		}

		function addAllToQueue() {
			const urlParams = new URLSearchParams(window.location.search);
			const playlistId = urlParams.get('id');
			
			if (playlistId) {
				fetch('api/playlists/' + playlistId + '/tracks', {
					method: 'GET',
					headers: { 'Content-Type': 'application/json' },
					credentials: 'include'
				})
				.then(response => response.json())
				.then(data => {
					if (data.tracks && data.tracks.length > 0 && typeof BeatFlowPlayer !== 'undefined') {
						data.tracks.forEach(track => {
							const trackData = {
								trackId: track.trackId || track.id,
								title: track.title,
								artist: track.artist,
								audioFileUrl: track.audioFileUrl || track.audioUrl,
								coverImageUrl: track.artworkUrl || 'assets/img/default-track.jpg',
								duration: track.duration || 0
							};
							BeatFlowPlayer.addToQueue(trackData);
						});
						showNotification('Đã thêm ' + data.tracks.length + ' bài vào danh sách chờ');
					}
				})
				.catch(error => {
					console.error('Error adding to queue:', error);
					showNotification('Không thể thêm vào danh sách chờ', 'error');
				});
			}
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

		// Toggle favorite
		function toggleFavorite(trackId, button) {
			fetch('api/favorites/toggle', {
				method: 'POST',
				headers: { 'Content-Type': 'application/json' },
				body: JSON.stringify({ trackId: parseInt(trackId) }),
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

		// Add single track to queue
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
			const hours = Math.floor(seconds / 3600);
			const mins = Math.floor((seconds % 3600) / 60);
			const secs = seconds % 60;
			if (hours > 0) {
				return hours + ':' + (mins < 10 ? '0' : '') + mins + ':' + (secs < 10 ? '0' : '') + secs;
			}
			return mins + ':' + (secs < 10 ? '0' : '') + secs;
		}

		function formatNumber(num) {
			if (num >= 1000000) return (num / 1000000).toFixed(1) + 'M';
			if (num >= 1000) return (num / 1000).toFixed(1) + 'K';
			return num.toString();
		}
	</script>
</body>
</html>
