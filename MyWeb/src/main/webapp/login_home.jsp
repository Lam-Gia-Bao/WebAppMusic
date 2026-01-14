<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.HttpSession"%>
<%
// Kiểm tra phiên đăng nhập
HttpSession sess = request.getSession(false);
String username = null;
if (sess != null) {
	username = (String) sess.getAttribute("user");
}
if (username == null) {
	response.sendRedirect("login");
	return;
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1" />
<!-- Bootstrap 5 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Google Font -->
<link
	href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700;800&display=swap"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css"
	rel="stylesheet">
<link rel="stylesheet" href="assets/css/home.css?v=3">
<link rel="stylesheet" href="assets/css/next_up.css">
<title>Home</title>
</head>
<body>
	<%@ include file="header.jsp"%>

	<div class="container home-wrapper">
		<div class="row">
			<!-- Left Column: playlists -->
			<div class="col-lg-8">
				<!-- Thông báo khi thành công -->
				<%
				if (request.getAttribute("successMessage") != null) {
				%>
				<div class="alert alert-success alert-dismissible fade show"
					role="alert">
					<%=request.getAttribute("successMessage")%>
					<button type="button" class="btn-close" data-bs-dismiss="alert"
						aria-label="Close"></button>
				</div>
				<%
				}
				%>
				<!-- Thông báo lỗi -->
				<%
				if (request.getAttribute("errorMessage") != null) {
				%>
				<div class="alert alert-danger alert-dismissible fade show"
					role="alert">
					<%=request.getAttribute("errorMessage")%>
					<button type="button" class="btn-close" data-bs-dismiss="alert"
						aria-label="Close"></button>
				</div>
				<%
				}
				%>

				<h2 class="section-title">Khám phá các bản nhạc và danh sách
					phát</h2>
				
				<h4 class="sub-title">Bài hát nổi bật</h4>
				<div class="d-flex gap-4 flex-wrap mb-4" id="trackContainer">
					<!-- Tracks được load từ database qua JavaScript -->
					<div class="placeholder-spinner">
						<div class="spinner-border text-primary" role="status">
							<span class="visually-hidden">Loading...</span>
						</div>
					</div>
				</div>
				
				<h4 class="sub-title">Playlist đề cử</h4>

				<div class="d-flex gap-4 flex-wrap mb-4" id="playlistContainer">
					<!-- Playlists được load từ database qua JavaScript -->
					<div class="placeholder-spinner">
						<div class="spinner-border text-primary" role="status">
							<span class="visually-hidden">Loading...</span>
						</div>
					</div>
				</div>

				<h4 class="sub-title">Nghệ sĩ đáng chú ý</h4>
				<div class="d-flex gap-4 flex-wrap" id="artistContainer">
					<!-- Artists được load từ database qua JavaScript -->
					<div class="placeholder-spinner">
						<div class="spinner-border text-primary" role="status">
							<span class="visually-hidden">Loading...</span>
						</div>
					</div>
				</div>
			</div>
		</div>

		<!-- Right Column extracted to separate JSP -->
		<%@ include file="right_column.jsp"%>
	</div>

	<%@ include file="player.jsp"%>
	<%@ include file="footer.jsp"%>

<!-- Modal xem chi tiết playlist -->
<div class="modal fade" id="playlistModal" tabindex="-1"
	aria-labelledby="playlistModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="playlistModalLabel">Chi tiết
					Playlist</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body" id="playlistModalBody">
				<!-- Nội dung sẽ được load bằng JavaScript -->
			</div>
		</div>
	</div>
</div>

<!-- Modal thêm vào Playlist -->
<div class="modal fade" id="addToPlaylistModal" tabindex="-1" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content bg-dark text-white">
			<div class="modal-header border-secondary">
				<h5 class="modal-title">Thêm vào Playlist</h5>
				<button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
			</div>
			<div class="modal-body">
				<div id="playlistListForAdd" class="list-group list-group-flush">
					<!-- Playlists will be loaded here -->
				</div>
				<hr class="border-secondary">
				<button class="btn btn-outline-primary w-100" onclick="showCreatePlaylistForm()">
					<i class="bi bi-plus-lg me-2"></i>Tạo playlist mới
				</button>
				<div id="createPlaylistForm" class="mt-3" style="display: none;">
					<input type="text" class="form-control bg-dark text-white mb-2" id="newPlaylistName" placeholder="Tên playlist">
					<button class="btn btn-primary w-100" onclick="createPlaylistAndAdd()">Tạo và thêm</button>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- Dropdown Menu cho track (SoundCloud style) -->
<div class="dropdown-menu track-dropdown-menu" id="trackDropdownMenu" style="display: none; position: fixed; z-index: 10000;">
	<button class="dropdown-item" data-action="add-to-queue">
		<i class="bi bi-list-ul me-2"></i>Thêm vào danh sách chờ
	</button>
	<button class="dropdown-item" data-action="add-to-playlist">
		<i class="bi bi-plus-square me-2"></i>Thêm vào playlist
	</button>
	<div class="dropdown-divider"></div>
	<button class="dropdown-item" data-action="go-to-track">
		<i class="bi bi-music-note me-2"></i>Đi đến bài hát
	</button>
	<button class="dropdown-item" data-action="go-to-artist">
		<i class="bi bi-person me-2"></i>Đi đến nghệ sĩ
	</button>
	<div class="dropdown-divider"></div>
	<button class="dropdown-item" data-action="share">
		<i class="bi bi-share me-2"></i>Chia sẻ
	</button>
	<button class="dropdown-item" data-action="copy-link">
		<i class="bi bi-link-45deg me-2"></i>Sao chép liên kết
	</button>
</div>

<style>
.track-dropdown-menu {
	background: #1a1a1a;
	border: 1px solid #333;
	border-radius: 8px;
	padding: 8px 0;
	min-width: 200px;
	box-shadow: 0 4px 20px rgba(0,0,0,0.5);
}
.track-dropdown-menu .dropdown-item {
	color: #fff;
	padding: 10px 16px;
	font-size: 14px;
	display: flex;
	align-items: center;
	background: none;
	border: none;
	width: 100%;
	text-align: left;
	cursor: pointer;
}
.track-dropdown-menu .dropdown-item:hover {
	background: #333;
	color: #f50;
}
.track-dropdown-menu .dropdown-divider {
	border-color: #333;
	margin: 4px 0;
}
</style>
<script src="assets/js/app.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
		// Khởi tạo trang - Load data từ API
		document.addEventListener('DOMContentLoaded', function() {
			loadTracks();
			loadPlaylists();
			loadArtists();
			setupEventListeners();
		});

		// Load danh sách tracks từ database
		function loadTracks() {
			fetch('api/tracks', {
				method: 'GET',
				headers: {
					'Content-Type': 'application/json',
					'Accept': 'application/json'
				},
				credentials: 'include'
			})
			.then(response => {
				if (!response.ok) {
					throw new Error('Failed to load tracks');
				}
				return response.json();
			})
			.then(data => {
				renderTracks(data);
			})
			.catch(error => {
				console.error('Error loading tracks:', error);
				document.getElementById('trackContainer').innerHTML = 
					'<div class="alert alert-warning">Không thể tải danh sách bài hát</div>';
			});
		}

		// Load danh sách playlists từ database (playlists gợi ý cho home page)
		function loadPlaylists() {
			fetch('api/playlists/recommended', {
				method: 'GET',
				headers: {
					'Content-Type': 'application/json',
					'Accept': 'application/json'
				},
				credentials: 'include'
			})
			.then(response => {
				if (!response.ok) {
					throw new Error('Failed to load playlists');
				}
				return response.json();
			})
			.then(data => {
				renderPlaylists(data);
			})
			.catch(error => {
				console.error('Error loading playlists:', error);
				document.getElementById('playlistContainer').innerHTML = 
					'<div class="alert alert-warning">Không thể tải danh sách playlist</div>';
			});
		}

		// Load danh sách artists
		function loadArtists() {
			fetch('api/artists', {
				method: 'GET',
				headers: {
					'Content-Type': 'application/json',
					'Accept': 'application/json'
				},
				credentials: 'include'
			})
			.then(response => {
				if (!response.ok) {
					throw new Error('Failed to load artists');
				}
				return response.json();
			})
			.then(data => {
				renderArtists(data);
			})
			.catch(error => {
				console.error('Error loading artists:', error);
				document.getElementById('artistContainer').innerHTML = 
					'<div class="alert alert-warning">Không thể tải danh sách nghệ sĩ</div>';
			});
		}

		// Hiển thị tracks
		function renderTracks(tracks) {
			const container = document.getElementById('trackContainer');
			container.innerHTML = '';

			if (!tracks || tracks.length === 0) {
				container.innerHTML = '<div class="alert alert-info w-100">Không có bài hát nào</div>';
				return;
			}

			tracks.forEach(track => {
				const card = createTrackCard(track);
				container.appendChild(card);
			});
		}
 
		// Hiển thị playlists
		function renderPlaylists(playlists) {
			const container = document.getElementById('playlistContainer');
			container.innerHTML = '';

			if (!playlists || playlists.length === 0) {
				container.innerHTML = '<div class="alert alert-info w-100">Không có playlist nào</div>';
				return;
			}

			playlists.forEach(playlist => {
				const card = createPlaylistCard(playlist);
				container.appendChild(card);
			});
		}

		// Hiển thị artists
		function renderArtists(artists) {
			const container = document.getElementById('artistContainer');
			container.innerHTML = '';

			if (!artists || artists.length === 0) {
				container.innerHTML = '<div class="alert alert-info w-100">Không có nghệ sĩ nào</div>';
				return;
			}

			artists.forEach(artist => {
				const card = createArtistCard(artist);
				container.appendChild(card);
			});
		}

		// Tạo HTML cho track card
		function createTrackCard(track) {
			const card = document.createElement('div');
			card.className = 'playlist-card';
			card.dataset.trackId = track.trackId || track.id;

			const imgPath = track.coverImageUrl || track.artworkUrl || 'assets/img/track1.jpg';
			const isFavorited = track.favorited || false;
			const trackId = track.trackId || track.id;

			card.innerHTML = 
				'<div class="playlist-img-wrapper">' +
					'<img src="' + imgPath + '" class="playlist-img" onerror="this.src=\'assets/img/track1.jpg\'">' +
					'<div class="playlist-overlay">' +
						'<button class="btn-play" data-track-id="' + trackId + '" title="Phát bài hát">' +
							'<i class="bi bi-play-fill"></i>' +
						'</button>' +
						'<div class="playlist-actions">' +
							'<button class="btn-action btn-favorite ' + (isFavorited ? 'liked' : '') + '" data-track-id="' + trackId + '" ' +
									'title="' + (isFavorited ? 'Bỏ yêu thích' : 'Thêm vào yêu thích') + '">' +
								'<i class="bi ' + (isFavorited ? 'bi-heart-fill' : 'bi-heart') + '"></i>' +
							'</button>' +
							'<button class="btn-action btn-menu" data-track-id="' + trackId + '" ' +
									'title="Thêm tùy chọn">' +
								'<i class="bi bi-three-dots"></i>' +
							'</button>' +
						'</div>' +
					'</div>' +
				'</div>' +
				'<a href="track.jsp?id=' + trackId + '" class="playlist-title" style="text-decoration:none; color:inherit;">' + escapeHtml(track.title) + '</a>' +
				'<div class="playlist-desc">' + escapeHtml(track.artist || '') + '</div>';

			return card;
		}

		// Tạo HTML cho playlist card
		function createPlaylistCard(playlist) {
			const card = document.createElement('div');
			card.className = 'playlist-card';
			card.dataset.playlistId = playlist.id;
			card.style.cursor = 'pointer';

			const imgPath = playlist.imagePath || playlist.artworkUrl || 'assets/img/default-playlist.jpg';

			card.innerHTML = 
				'<div class="playlist-img-wrapper">' +
					'<img src="' + imgPath + '" class="playlist-img" onerror="this.src=\'assets/img/default-playlist.jpg\'">' +
					'<div class="playlist-overlay">' +
						'<button class="btn-play" data-playlist-id="' + playlist.id + '" title="Phát nhạc">' +
							'<i class="bi bi-play-fill"></i>' +
						'</button>' +
						'<div class="playlist-actions">' +
							'<button class="btn-action btn-menu" data-playlist-id="' + playlist.id + '" ' +
									'title="Thêm tùy chọn">' +
								'<i class="bi bi-three-dots"></i>' +
							'</button>' +
						'</div>' +
					'</div>' +
				'</div>' +
				'<a href="playlist_detail.jsp?id=' + playlist.id + '" class="playlist-title" style="text-decoration:none; color:inherit;">' + escapeHtml(playlist.name) + '</a>' +
				'<div class="playlist-desc">' + escapeHtml(playlist.description || '') + '</div>';

			return card;
		}

		// Tạo HTML cho artist card
		function createArtistCard(artist) {
			const card = document.createElement('div');
			card.className = 'playlist-card';
			card.dataset.artistId = artist.id;

			const imgPath = artist.imagePath || 'assets/img/default-artist.jpg';

			card.innerHTML = 
				'<div class="playlist-img-wrapper">' +
					'<img src="' + imgPath + '" class="playlist-img" onerror="this.src=\'assets/img/default-artist.jpg\'">' +
					'<div class="playlist-overlay">' +
						'<button class="btn-play" data-artist-id="' + artist.id + '" title="Phát nhạc của nghệ sĩ">' +
							'<i class="bi bi-play-fill"></i>' +
						'</button>' +
						'<div class="playlist-actions">' +
							'<button class="btn-action btn-favorite" data-artist-id="' + artist.id + '" ' +
									'title="Thêm vào yêu thích">' +
								'<i class="bi bi-heart"></i>' +
							'</button>' +
							'<button class="btn-action btn-follow" data-artist-id="' + artist.id + '" ' +
									'title="Theo dõi nghệ sĩ">' +
								'<i class="bi bi-person-plus"></i>' +
							'</button>' +
							'<button class="btn-action btn-menu" data-artist-id="' + artist.id + '" ' +
									'title="Thêm tùy chọn">' +
								'<i class="bi bi-three-dots"></i>' +
							'</button>' +
						'</div>' +
					'</div>' +
				'</div>' +
				'<div class="playlist-title">' + escapeHtml(artist.name) + '</div>' +
				'<div class="playlist-desc">New!</div>';

			return card;
		}

		// Thiết lập event listeners
		function setupEventListeners() {
			// Event delegation cho play buttons
			document.addEventListener('click', function(e) {
				// Play button
				if (e.target.closest('.btn-play')) {
					const btn = e.target.closest('.btn-play');
					const playlistId = btn.dataset.playlistId;
					const artistId = btn.dataset.artistId;
					const trackId = btn.dataset.trackId;
					e.preventDefault();
					
					if (trackId) {
						playTrack(trackId);
					} else if (playlistId) {
						playPlaylist(playlistId);
					} else if (artistId) {
						playArtist(artistId);
					}
				}

				// Favorite button - chỉ cho tracks
				if (e.target.closest('.btn-favorite')) {
					const btn = e.target.closest('.btn-favorite');
					const trackId = btn.dataset.trackId;
					e.preventDefault();

					if (trackId) {
						toggleFavorite(trackId, btn);
					}
				}

				// Follow button
				if (e.target.closest('.btn-follow')) {
					const btn = e.target.closest('.btn-follow');
					const playlistId = btn.dataset.playlistId;
					const artistId = btn.dataset.artistId;
					e.preventDefault();

					if (playlistId) {
						followPlaylist(playlistId, btn);
					} else if (artistId) {
						followArtist(artistId, btn);
					}
				}

				// Menu button
				if (e.target.closest('.btn-menu')) {
					const btn = e.target.closest('.btn-menu');
					e.preventDefault();
					showPlaylistMenu(btn);
				}
				
				// Click playlist title/desc để mở playlist detail
				if (e.target.closest('.playlist-title') || e.target.closest('.playlist-desc')) {
					const card = e.target.closest('.playlist-card');
					if (card && card.dataset.playlistId) {
						e.preventDefault();
						window.location.href = 'playlist_detail.jsp?id=' + card.dataset.playlistId;
					}
				}
			});
		}

		// Phát bài hát
		function playTrack(trackId) {
			console.log('Playing track:', trackId);
			
			// Fetch track details from API
			fetch('api/tracks/' + trackId, {
				method: 'GET',
				headers: {
					'Content-Type': 'application/json',
					'Accept': 'application/json'
				},
				credentials: 'include'
			})
			.then(response => {
				if (!response.ok) {
					throw new Error('Failed to load track');
				}
				return response.json();
			})
			.then(track => {
				console.log('Track data:', track);
				
				// Map API response to player format
				const trackData = {
					trackId: track.trackId || track.id,
					title: track.title,
					artist: track.artist,
					audioFileUrl: track.audioFileUrl || track.audioUrl || track.trackLink,
					coverImageUrl: track.artworkUrl || track.coverImageUrl || 'assets/img/default-track.jpg',
					duration: track.duration || 0,
					uploaderUsername: track.uploaderUsername
				};
				
				if (!trackData.audioFileUrl) {
					showNotification('Bài hát không có file audio', 'error');
					return;
				}
				
				// Use BeatFlowPlayer to load and play the track
				if (typeof BeatFlowPlayer !== 'undefined') {
					BeatFlowPlayer.loadTrack(trackData, true);
				} else {
					console.error('BeatFlowPlayer not initialized');
					showNotification('Lỗi: Player chưa sẵn sàng', 'error');
				}
			})
			.catch(error => {
				console.error('Error loading track:', error);
				showNotification('Không thể phát bài hát', 'error');
			});
		}

		// Thêm bài hát vào danh sách chờ
		function addTrackToQueue(trackId) {
			fetch('api/tracks/' + trackId, {
				method: 'GET',
				headers: {
					'Content-Type': 'application/json',
					'Accept': 'application/json'
				},
				credentials: 'include'
			})
			.then(response => response.json())
			.then(track => {
				const trackData = {
					trackId: track.trackId || track.id,
					title: track.title,
					artist: track.artist,
					audioFileUrl: track.audioFileUrl || track.audioUrl || track.trackLink,
					coverImageUrl: track.artworkUrl || track.coverImageUrl || 'assets/img/default-track.jpg',
					duration: track.duration || 0,
					uploaderUsername: track.uploaderUsername
				};
				
				if (typeof BeatFlowPlayer !== 'undefined') {
					BeatFlowPlayer.addToQueue(trackData);
				}
			})
			.catch(error => {
				console.error('Error adding to queue:', error);
				showNotification('Không thể thêm vào danh sách chờ', 'error');
			});
		}

		// Phát nhạc từ playlist
		function playPlaylist(playlistId) {
			console.log('Playing playlist:', playlistId);
			// Gửi request đến servlet để lưu lịch sử
			fetch('api/playlists/' + playlistId + '/play', {
				method: 'POST',
				headers: {
					'Content-Type': 'application/json'
				},
				credentials: 'include'
			})
			.then(response => response.json())
			.then(data => {
				showNotification('Đang phát: ' + data.playlistName);
				// Có thể redirect đến player page nếu cần
				// window.location.href = 'player.jsp?playlistId=' + playlistId;
			})
			.catch(error => {
				console.error('Error playing playlist:', error);
				showNotification('Lỗi khi phát playlist', 'error');
			});
		}

		// Phát nhạc từ artist
		function playArtist(artistId) {
			console.log('Playing artist:', artistId);
			fetch('api/artists/' + artistId + '/play', {
				method: 'POST',
				headers: {
					'Content-Type': 'application/json'
				},
				credentials: 'include'
			})
			.then(response => response.json())
			.then(data => {
				showNotification('Đang phát: ' + data.artistName);
			})
			.catch(error => {
				console.error('Error playing artist:', error);
				showNotification('Lỗi khi phát bài hát', 'error');
			});
		}

		// Toggle yêu thích cho track
		function toggleFavorite(trackId, button) {
			fetch('api/favorites/toggle', {
				method: 'POST',
				headers: {
					'Content-Type': 'application/json'
				},
				body: JSON.stringify({
					trackId: trackId
				}),
				credentials: 'include'
			})
			.then(response => response.json())
			.then(data => {
				if (data.success) {
					const icon = button.querySelector('i');
					if (data.favorited) {
						button.classList.add('liked');
						icon.classList.remove('bi-heart');
						icon.classList.add('bi-heart-fill');
						button.title = 'Bỏ yêu thích';
						showNotification('Đã thêm vào yêu thích');
					} else {
						button.classList.remove('liked');
						icon.classList.remove('bi-heart-fill');
						icon.classList.add('bi-heart');
						button.title = 'Thêm vào yêu thích';
						showNotification('Đã bỏ yêu thích');
					}
				} else {
					showNotification('Lỗi: ' + (data.error || 'Không thể cập nhật'), 'error');
				}
			})
			.catch(error => {
				console.error('Error toggling favorite:', error);
				showNotification('Lỗi hệ thống', 'error');
			});
		}

		// Theo dõi playlist
		function followPlaylist(playlistId, button) {
			fetch('api/playlists/' + playlistId + '/follow', {
				method: 'POST',
				headers: {
					'Content-Type': 'application/json'
				},
				credentials: 'include'
			})
			.then(response => response.json())
			.then(data => {
				if (data.success) {
					button.classList.add('followed');
					showNotification('Đã theo dõi playlist');
				} else {
					showNotification('Lỗi khi theo dõi', 'error');
				}
			})
			.catch(error => {
				console.error('Error following playlist:', error);
				showNotification('Lỗi hệ thống', 'error');
			});
		}

		// Theo dõi artist
		function followArtist(artistId, button) {
			fetch('api/artists/' + artistId + '/follow', {
				method: 'POST',
				headers: {
					'Content-Type': 'application/json'
				},
				credentials: 'include'
			})
			.then(response => response.json())
			.then(data => {
				if (data.success) {
					button.classList.add('followed');
					showNotification('Đã theo dõi nghệ sĩ');
				} else {
					showNotification('Lỗi khi theo dõi', 'error');
				}
			})
			.catch(error => {
				console.error('Error following artist:', error);
				showNotification('Lỗi hệ thống', 'error');
			});
		}

		// Hiển thị menu tùy chọn
		function showPlaylistMenu(button) {
			const menu = document.createElement('div');
			menu.className = 'playlist-menu';
			menu.innerHTML = `
				<a href="#" class="menu-item">Thêm vào playlist</a>
				<a href="#" class="menu-item">Chia sẻ</a>
				<a href="#" class="menu-item">Sao chép liên kết</a>
				<a href="#" class="menu-item">Báo cáo</a>
			`;
			// Có thể sử dụng Bootstrap dropdown hoặc custom context menu
		}

		// Hàm hiển thị thông báo
		function showNotification(message, type = 'success') {
			const alertClass = type === 'error' ? 'alert-danger' : 'alert-success';
			const alertDiv = document.createElement('div');
			alertDiv.className = 'alert ' + alertClass + ' alert-dismissible fade show position-fixed';
			alertDiv.style.top = '20px';
			alertDiv.style.right = '20px';
			alertDiv.style.zIndex = '9999';
			alertDiv.innerHTML = message + '<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>';
			document.body.appendChild(alertDiv);

			setTimeout(() => {
				alertDiv.remove();
			}, 3000);
		}

		// Escape HTML để tránh XSS
		function escapeHtml(text) {
			if (!text) return '';
			const div = document.createElement('div');
			div.textContent = text;
			return div.innerHTML;
		}

		// ========== DROPDOWN MENU CHO NÚT 3 CHẤM (SOUNDCLOUD STYLE) ==========
		let currentMenuTrackId = null;
		const trackDropdownMenu = document.getElementById('trackDropdownMenu');
		
		// Hiển thị dropdown menu
		function showTrackDropdownMenu(trackId, button) {
			currentMenuTrackId = trackId;
			
			// Position menu near button
			const rect = button.getBoundingClientRect();
			trackDropdownMenu.style.top = (rect.bottom + 5) + 'px';
			trackDropdownMenu.style.left = Math.min(rect.left, window.innerWidth - 220) + 'px';
			trackDropdownMenu.style.display = 'block';
		}
		
		// Hide dropdown when clicking outside
		document.addEventListener('click', function(e) {
			if (!e.target.closest('.btn-menu') && !e.target.closest('#trackDropdownMenu')) {
				trackDropdownMenu.style.display = 'none';
			}
		});
		
		// Dropdown menu actions
		trackDropdownMenu.addEventListener('click', function(e) {
			const item = e.target.closest('.dropdown-item');
			if (!item || !currentMenuTrackId) return;
			
			const action = item.dataset.action;
			trackDropdownMenu.style.display = 'none';
			
			switch(action) {
				case 'add-to-queue':
					addTrackToQueue(currentMenuTrackId);
					break;
				case 'add-to-playlist':
					openAddToPlaylistModal(currentMenuTrackId);
					break;
				case 'go-to-track':
					window.location.href = 'track.jsp?id=' + currentMenuTrackId;
					break;
				case 'go-to-artist':
					// TODO: Get artist ID from track
					showNotification('Đang chuyển đến nghệ sĩ...');
					break;
				case 'share':
					shareTrack(currentMenuTrackId);
					break;
				case 'copy-link':
					copyTrackLink(currentMenuTrackId);
					break;
			}
		});
		
		// Update showPlaylistMenu to use new dropdown
		function showPlaylistMenu(button) {
			const trackId = button.dataset.trackId;
			if (trackId) {
				showTrackDropdownMenu(trackId, button);
			}
		}
		
		// Thêm track vào queue
		function addTrackToQueue(trackId) {
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
		
		// Mở modal thêm vào playlist
		function openAddToPlaylistModal(trackId) {
			currentMenuTrackId = trackId;
			
			fetch('api/playlists', {
				method: 'GET',
				headers: { 'Content-Type': 'application/json' },
				credentials: 'include'
			})
			.then(response => response.json())
			.then(playlists => {
				const listContainer = document.getElementById('playlistListForAdd');
				listContainer.innerHTML = '';
				
				if (!playlists || playlists.length === 0) {
					listContainer.innerHTML = '<div class="text-muted p-3">Bạn chưa có playlist nào</div>';
				} else {
					playlists.forEach(playlist => {
						const item = document.createElement('button');
						item.className = 'list-group-item list-group-item-action bg-dark text-white border-secondary';
						item.innerHTML = '<i class="bi bi-music-note-list me-2"></i>' + escapeHtml(playlist.name);
						item.addEventListener('click', () => addToPlaylist(playlist.id, playlist.name));
						listContainer.appendChild(item);
					});
				}
				
				document.getElementById('createPlaylistForm').style.display = 'none';
				const modal = new bootstrap.Modal(document.getElementById('addToPlaylistModal'));
				modal.show();
			})
			.catch(error => {
				console.error('Error loading playlists:', error);
				showNotification('Không thể tải danh sách playlist', 'error');
			});
		}
		
		// Thêm track vào playlist
		function addToPlaylist(playlistId, playlistName) {
			if (!currentMenuTrackId) return;
			
			fetch('api/playlists/' + playlistId + '/tracks', {
				method: 'POST',
				headers: { 'Content-Type': 'application/json' },
				body: JSON.stringify({ trackId: parseInt(currentMenuTrackId) }),
				credentials: 'include'
			})
			.then(response => response.json())
			.then(data => {
				bootstrap.Modal.getInstance(document.getElementById('addToPlaylistModal')).hide();
				if (data.success !== false) {
					showNotification('Đã thêm vào "' + playlistName + '"');
				} else {
					showNotification('Lỗi: ' + (data.error || 'Không thể thêm'), 'error');
				}
			})
			.catch(error => {
				console.error('Error adding to playlist:', error);
				showNotification('Không thể thêm vào playlist', 'error');
			});
		}
		
		// Hiển thị form tạo playlist mới
		function showCreatePlaylistForm() {
			document.getElementById('createPlaylistForm').style.display = 'block';
			document.getElementById('newPlaylistName').focus();
		}
		
		// Tạo playlist mới và thêm track
		function createPlaylistAndAdd() {
			const name = document.getElementById('newPlaylistName').value.trim();
			if (!name) {
				showNotification('Vui lòng nhập tên playlist', 'error');
				return;
			}
			
			fetch('playlist/create', {
				method: 'POST',
				headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
				body: 'name=' + encodeURIComponent(name) + '&isPublic=false',
				credentials: 'include'
			})
			.then(response => response.json())
			.then(data => {
				if (data.success && data.playlistId) {
					addToPlaylist(data.playlistId, name);
				} else {
					showNotification('Lỗi tạo playlist: ' + (data.error || ''), 'error');
				}
			})
			.catch(error => {
				console.error('Error creating playlist:', error);
				showNotification('Không thể tạo playlist', 'error');
			});
		}
		
		// Chia sẻ track
		function shareTrack(trackId) {
			const url = window.location.origin + '/track.jsp?id=' + trackId;
			if (navigator.share) {
				navigator.share({
					title: 'Chia sẻ bài hát',
					url: url
				});
			} else {
				copyTrackLink(trackId);
			}
		}
		
		// Copy link track
		function copyTrackLink(trackId) {
			const url = window.location.origin + window.location.pathname.replace(/[^\/]*$/, '') + 'track.jsp?id=' + trackId;
			navigator.clipboard.writeText(url).then(() => {
				showNotification('Đã sao chép liên kết');
			}).catch(() => {
				showNotification('Không thể sao chép', 'error');
			});
		}
	</script>
</body>
</html>