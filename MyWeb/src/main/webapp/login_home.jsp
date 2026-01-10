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
<link rel="stylesheet" href="assets/css/home.css?v=2">
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
				<h4 class="sub-title">Đề cử theo sở thích của bạn</h4>

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

<script src="assets/js/app.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
		// Khởi tạo trang - Load playlists từ API
		document.addEventListener('DOMContentLoaded', function() {
			loadPlaylists();
			loadArtists();
			setupEventListeners();
		});

		// Load danh sách playlists từ database
		function loadPlaylists() {
			fetch('api/playlists', {
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

		// Tạo HTML cho playlist card
		function createPlaylistCard(playlist) {
			const card = document.createElement('div');
			card.className = 'playlist-card';
			card.dataset.playlistId = playlist.id;

			const imgPath = playlist.imagePath || 'assets/img/default-playlist.jpg';

			card.innerHTML = `
				<div class="playlist-img-wrapper">
					<img src="\${imgPath}" class="playlist-img" onerror="this.src='assets/img/default-playlist.jpg'">
					<div class="playlist-overlay">
						<button class="btn-play" data-playlist-id="\${playlist.id}" title="Phát nhạc">
							<i class="bi bi-play-fill"></i>
						</button>
						<div class="playlist-actions">
							<button class="btn-action btn-favorite" data-playlist-id="\${playlist.id}" 
									title="Thêm vào yêu thích">
								<i class="bi bi-heart"></i>
							</button>
							<button class="btn-action btn-follow" data-playlist-id="\${playlist.id}" 
									title="Theo dõi">
								<i class="bi bi-person-plus"></i>
							</button>
							<button class="btn-action btn-menu" data-playlist-id="\${playlist.id}" 
									title="Thêm tùy chọn">
								<i class="bi bi-three-dots"></i>
							</button>
						</div>
					</div>
				</div>
				<div class="playlist-title">\${escapeHtml(playlist.name)}</div>
				<div class="playlist-desc">\${escapeHtml(playlist.description || '')}</div>
			`;

			return card;
		}

		// Tạo HTML cho artist card
		function createArtistCard(artist) {
			const card = document.createElement('div');
			card.className = 'playlist-card';
			card.dataset.artistId = artist.id;

			const imgPath = artist.imagePath || 'assets/img/default-artist.jpg';

			card.innerHTML = `
				<div class="playlist-img-wrapper">
					<img src="\${imgPath}" class="playlist-img" onerror="this.src='assets/img/default-artist.jpg'">
					<div class="playlist-overlay">
						<button class="btn-play" data-artist-id="\${artist.id}" title="Phát nhạc của nghệ sĩ">
							<i class="bi bi-play-fill"></i>
						</button>
						<div class="playlist-actions">
							<button class="btn-action btn-favorite" data-artist-id="\${artist.id}" 
									title="Thêm vào yêu thích">
								<i class="bi bi-heart"></i>
							</button>
							<button class="btn-action btn-follow" data-artist-id="\${artist.id}" 
									title="Theo dõi nghệ sĩ">
								<i class="bi bi-person-plus"></i>
							</button>
							<button class="btn-action btn-menu" data-artist-id="\${artist.id}" 
									title="Thêm tùy chọn">
								<i class="bi bi-three-dots"></i>
							</button>
						</div>
					</div>
				</div>
				<div class="playlist-title">\${escapeHtml(artist.name)}</div>
				<div class="playlist-desc">New!</div>
			`;

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
					e.preventDefault();
					
					if (playlistId) {
						playPlaylist(playlistId);
					} else if (artistId) {
						playArtist(artistId);
					}
				}

				// Favorite button
				if (e.target.closest('.btn-favorite')) {
					const btn = e.target.closest('.btn-favorite');
					const playlistId = btn.dataset.playlistId;
					const artistId = btn.dataset.artistId;
					e.preventDefault();

					if (playlistId) {
						addToFavorite('playlist', playlistId, btn);
					} else if (artistId) {
						addToFavorite('artist', artistId, btn);
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

		// Thêm vào yêu thích
		function addToFavorite(type, id, button) {
			fetch('api/favorites/add', {
				method: 'POST',
				headers: {
					'Content-Type': 'application/json'
				},
				body: JSON.stringify({
					type: type,
					itemId: id
				}),
				credentials: 'include'
			})
			.then(response => response.json())
			.then(data => {
				if (data.success) {
					button.classList.add('liked');
					showNotification('Đã thêm vào yêu thích');
				} else {
					showNotification('Lỗi khi thêm yêu thích', 'error');
				}
			})
			.catch(error => {
				console.error('Error adding to favorites:', error);
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
	</script>
</body>
</html>