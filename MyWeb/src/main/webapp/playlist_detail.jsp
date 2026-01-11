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
						<!-- Related Tracks List -->
						<div class="related-tracks">
							<div class="track-item">
								<img src="assets/img/avt_travis-scott.jpg" alt="Artist" class="track-thumbnail">
								<div class="track-number">1</div>
								<button class="track-play-btn"><i class="bi bi-play-fill"></i></button>
								<div class="track-info">
									<div class="track-title">JVKE (Luminous Echoes)</div>
									<div class="track-artist">her</div>
								</div>
								<div class="track-actions">
									<button class="btn-track-action"><i class="bi bi-heart"></i></button>
									<button class="btn-track-action"><i class="bi bi-arrow-repeat"></i></button>
									<button class="btn-track-action"><i class="bi bi-share"></i></button>
									<%@ include file="track_dropdown_menu.jsp" %>
									<div class="track-stats">
										<i class="bi bi-play-fill"></i> 856K
									</div>
								</div>
							</div>

							<div class="track-item">
								<img src="assets/img/avt_bad-bunny.jpg" alt="Artist" class="track-thumbnail">
								<div class="track-number">2</div>
								<button class="track-play-btn"><i class="bi bi-play-fill"></i></button>
								<div class="track-info">
									<div class="track-title">DAISY </div>
									<div class="track-artist">From the start - Speed up</div>
								</div>
								<div class="track-actions">
									<button class="btn-track-action"><i class="bi bi-heart"></i></button>
									<button class="btn-track-action"><i class="bi bi-arrow-repeat"></i></button>
									<button class="btn-track-action"><i class="bi bi-share"></i></button>
									<%@ include file="track_dropdown_menu.jsp" %>
									<div class="track-stats">
										<i class="bi bi-play-fill"></i> 374M
									</div>
								</div>
							</div>

							<div class="track-item">
								<img src="assets/img/avt_doja-cat.png" alt="Artist" class="track-thumbnail">
								<div class="track-number">3</div>
								<button class="track-play-btn"><i class="bi bi-play-fill"></i></button>
								<div class="track-info">
									<div class="track-title">j*ckG</div>
									<div class="track-artist">golden hour + this is what heartbreak feels like [chilled] - JVKE</div>
								</div>
								<div class="track-actions">
									<button class="btn-track-action"><i class="bi bi-heart"></i></button>
									<button class="btn-track-action"><i class="bi bi-arrow-repeat"></i></button>
									<button class="btn-track-action"><i class="bi bi-share"></i></button>
									<%@ include file="track_dropdown_menu.jsp" %>
									<div class="track-stats">
										<i class="bi bi-play-fill"></i> 566K
									</div>
								</div>
							</div>

							<div class="track-item">
								<img src="assets/img/avt_travis-scott.jpg" alt="Artist" class="track-thumbnail">
								<div class="track-number">4</div>
								<button class="track-play-btn"><i class="bi bi-play-fill"></i></button>
								<div class="track-info">
									<div class="track-title">iTDubzTi</div>
									<div class="track-artist">Harry Styles - As It Was (Slowed)</div>
								</div>
								<div class="track-actions">
									<button class="btn-track-action"><i class="bi bi-heart"></i></button>
									<button class="btn-track-action"><i class="bi bi-arrow-repeat"></i></button>
									<button class="btn-track-action"><i class="bi bi-share"></i></button>
									<%@ include file="track_dropdown_menu.jsp" %>
									<div class="track-stats">
										<i class="bi bi-play-fill"></i> 176K
									</div>
								</div>
							</div>

							<div class="track-item">
								<img src="assets/img/avt_bad-bunny.jpg" alt="Artist" class="track-thumbnail">
								<div class="track-number">5</div>
								<button class="track-play-btn"><i class="bi bi-play-fill"></i></button>
								<div class="track-info">
									<div class="track-title">furthermore</div>
									<div class="track-artist">d4vd - here with me (slowed + reverb)</div>
								</div>
								<div class="track-actions">
									<button class="btn-track-action"><i class="bi bi-heart"></i></button>
									<button class="btn-track-action"><i class="bi bi-arrow-repeat"></i></button>
									<button class="btn-track-action"><i class="bi bi-share"></i></button>
									<%@ include file="track_dropdown_menu.jsp" %>
									<div class="track-stats">
										<i class="bi bi-play-fill"></i> 879K
									</div>
								</div>
							</div>

							<div class="track-item">
								<img src="assets/img/avt_doja-cat.png" alt="Artist" class="track-thumbnail">
								<div class="track-number">6</div>
								<button class="track-play-btn"><i class="bi bi-play-fill"></i></button>
								<div class="track-info">
									<div class="track-title">M E L V S S A</div>
									<div class="track-artist">JVKE - Golden Hour</div>
								</div>
								<div class="track-actions">
									<button class="btn-track-action"><i class="bi bi-heart"></i></button>
									<button class="btn-track-action"><i class="bi bi-arrow-repeat"></i></button>
									<button class="btn-track-action"><i class="bi bi-share"></i></button>
									<%@ include file="track_dropdown_menu.jsp" %>
									<div class="track-stats">
										<i class="bi bi-play-fill"></i> 723M
									</div>
								</div>
							</div>
						</div>
					</div>

					<div class="col-lg-4">
						<!-- Sidebar -->
						<div class="playlist-sidebar">
							<!-- Made For -->
							<div class="sidebar-section">
								<div class="made-for">
									<img src="assets/img/profile_avatar.jpg" alt="User" class="made-for-avatar">
									<span>Được tạo bởi Bảo Lâm</span>
								</div>
							</div>

							<!-- Artists Featured -->
							<div class="sidebar-section">
								<h3 class="sidebar-title">Các nghệ sĩ nổi bật</h3>
								
								<div class="artist-item">
									<img src="assets/img/avt_travis-scott.jpg" alt="Artist" class="artist-avatar">
									<div class="artist-info">
										<div class="artist-name">JVKE (Luminous Echoes)</div>
										<div class="artist-stats">
											<span><i class="bi bi-people-fill"></i> 716</span>
											<span><i class="bi bi-music-note-beamed"></i> 45</span>
										</div>
									</div>
									<button class="btn-follow">Follow</button>
								</div>

								<div class="artist-item">
									<img src="assets/img/avt_bad-bunny.jpg" alt="Artist" class="artist-avatar">
									<div class="artist-info">
										<div class="artist-name">DAISY ||</div>
										<div class="artist-stats">
											<span><i class="bi bi-people-fill"></i> 2,340</span>
											<span><i class="bi bi-music-note-beamed"></i> 15</span>
										</div>
									</div>
									<button class="btn-follow">Follow</button>
								</div>

								<div class="artist-item">
									<img src="assets/img/avt_doja-cat.png" alt="Artist" class="artist-avatar">
									<div class="artist-info">
										<div class="artist-name">j*ckG</div>
										<div class="artist-stats">
											<span><i class="bi bi-people-fill"></i> 776</span>
											<span><i class="bi bi-music-note-beamed"></i> 32</span>
										</div>
									</div>
									<button class="btn-follow">Follow</button>
								</div>
							</div>
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
		// Playlist Detail Page JavaScript
		document.addEventListener('DOMContentLoaded', function() {
			initPlaylistDetailPage();
		});

		function initPlaylistDetailPage() {
			// Hero play button - play all tracks
			const heroPlayBtn = document.querySelector('.hero-play-btn');
			if (heroPlayBtn) {
				heroPlayBtn.addEventListener('click', function() {
					playAllTracks();
				});
			}

			// Track play buttons
			document.querySelectorAll('.track-play-btn').forEach(btn => {
				btn.addEventListener('click', function(e) {
					e.preventDefault();
					e.stopPropagation();
					const trackItem = this.closest('.track-item');
					const trackId = trackItem.dataset.trackId;
					if (trackId) {
						playTrackById(trackId);
					}
				});
			});

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
	</script>
</body>
</html>
