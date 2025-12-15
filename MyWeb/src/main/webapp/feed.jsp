<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ include file="header.jsp" %>
						</div>
					</div>
				</div>
				<div class="dropdown-container">
					<button class="btn-icon-nav" id="messagesMenuButton">
						<i class="bi bi-envelope"></i>
					</button>
					<!-- Messages Dropdown -->
					<div class="messages-dropdown" id="messagesMenu">
						<div class="messages-header">
							<h5>Tin nhắn</h5>
						</div>
						<div class="messages-body">
							<p class="no-messages">Bạn chưa có tin nhắn nào.</p>
						</div>
						<div class="messages-footer">
							<a href="#" class="view-all-link">Xem tất cả tin nhắn</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</nav>

	<div class="container home-wrapper">

		<!-- Two Column Layout -->
		<div class="row">
			<!-- Left Column: Playlists -->
			<div class="col-lg-8">
				<!-- MAIN TITLE -->
				<!-- Feed Header -->
				<div class="feed-header">
					<h2 class="section-title">Hear the latest posts from the people you're following:</h2>
					<div class="feed-filter">
						<span>Reposts</span>
						<label class="feed-toggle">
							<input type="checkbox" checked>
							<span class="toggle-slider"></span>
						</label>
					</div>
				</div>

				<!-- Feed Posts -->
				<div class="feed-posts">
					<!-- Post 1 -->
					<div class="feed-post">
						<div class="post-header">
							<img src="assets/img/avt_travis-scott.jpg" alt="Artist" class="post-avatar">
							<div class="post-user-info">
								<span class="post-username">Htingale</span>
								<span class="post-time">posted a track 3 days ago</span>
							</div>
						</div>

						<div class="post-content">
							<img src="assets/img/edm-playlist.jpg" alt="Track" class="post-cover">
							<div class="post-track-info">
								<button class="post-play-btn">
									<i class="bi bi-play-fill"></i>
								</button>
								<div class="track-details">
									<h4 class="track-artist">Htingale</h4>
									<p class="track-title">rasuto kurisumasu</p>
								</div>
								<div class="track-waveform">
									<svg viewBox="0 0 400 50" class="waveform-svg">
										<path d="M 5 25 L 10 15 L 15 30 L 20 20 L 25 28 L 30 18 L 35 32 L 40 22 L 45 26 L 50 16 L 55 30 L 60 19 L 65 31 L 70 21 L 75 27 L 80 17 L 85 29 L 90 23 L 95 25 L 100 15 L 105 28 L 110 20 L 115 32 L 120 18 L 125 30 L 130 22 L 135 26 L 140 16 L 145 29 L 150 24 L 155 25" stroke="white" stroke-width="1" fill="none" opacity="0.6"/>
									</svg>
								</div>
								<span class="track-duration">3:23</span>
							</div>
						</div>

						<div class="post-actions">
							<button class="post-action-btn">
								<i class="bi bi-heart"></i>
								<span>37</span>
							</button>
							<button class="post-action-btn">
								<i class="bi bi-repeat"></i>
								<span>3</span>
							</button>
							<button class="post-action-btn">
								<i class="bi bi-share"></i>
							</button>
							<button class="post-action-btn">
								<i class="bi bi-bookmark"></i>
							</button>
							<button class="post-action-btn">
								<i class="bi bi-three-dots"></i>
							</button>
							<div class="post-stats">
								<span class="plays">▶ 1,121</span>
								<span class="comments">💬 1</span>
							</div>
						</div>
					</div>

					<!-- Post 2 -->
					<div class="feed-post">
						<div class="post-header">
							<img src="assets/img/avt_travis-scott.jpg" alt="Artist" class="post-avatar">
							<div class="post-user-info">
								<span class="post-username">Hensonn</span>
								<span class="post-time">posted a track 7 days ago</span>
							</div>
							<span class="post-tag"># Electronic</span>
						</div>

						<div class="post-content">
							<img src="assets/img/nkl2-playlist.jpg" alt="Track" class="post-cover">
							<div class="post-track-info">
								<button class="post-play-btn">
									<i class="bi bi-play-fill"></i>
								</button>
								<div class="track-details">
									<h4 class="track-artist">Hensonn</h4>
									<p class="track-title">taca taca bro (unreleased)</p>
								</div>
								<div class="track-waveform">
									<svg viewBox="0 0 400 50" class="waveform-svg">
										<path d="M 5 25 L 10 15 L 15 30 L 20 20 L 25 28 L 30 18 L 35 32 L 40 22 L 45 26 L 50 16 L 55 30 L 60 19 L 65 31 L 70 21 L 75 27 L 80 17 L 85 29 L 90 23 L 95 25 L 100 15 L 105 28 L 110 20 L 115 32 L 120 18 L 125 30 L 130 22 L 135 26 L 140 16 L 145 29 L 150 24 L 155 25" stroke="#4a9eff" stroke-width="1" fill="none" opacity="0.8"/>
									</svg>
								</div>
								<span class="track-duration">3:05</span>
							</div>
						</div>

						<div class="post-actions">
							<button class="post-action-btn">
								<i class="bi bi-heart"></i>
								<span>87</span>
							</button>
							<button class="post-action-btn">
								<i class="bi bi-repeat"></i>
								<span>3</span>
							</button>
							<button class="post-action-btn">
								<i class="bi bi-share"></i>
							</button>
							<button class="post-action-btn">
								<i class="bi bi-bookmark"></i>
							</button>
							<button class="post-action-btn">
								<i class="bi bi-three-dots"></i>
							</button>
							<div class="post-stats">
								<span class="plays">▶ 1,573</span>
								<span class="comments">💬 9</span>
							</div>
						</div>
					</div>

					<!-- Post 3 -->
					<div class="feed-post">
						<div class="post-header">
							<img src="assets/img/avt_travis-scott.jpg" alt="Artist" class="post-avatar">
							<div class="post-user-info">
								<span class="post-username">Htingale</span>
								<span class="post-time">posted a track 8 days ago</span>
								<span class="post-caption">gol cuska ra day.</span>
							</div>
							<span class="post-tag"># Deep House</span>
						</div>

						<div class="post-content">
							<img src="assets/img/pop-playlist.jpg" alt="Track" class="post-cover">
							<div class="post-track-info">
								<button class="post-play-btn">
									<i class="bi bi-play-fill"></i>
								</button>
								<div class="track-details">
									<h4 class="track-artist">Htingale</h4>
									<p class="track-title">winter song</p>
								</div>
								<div class="track-waveform">
									<svg viewBox="0 0 400 50" class="waveform-svg">
										<path d="M 5 25 L 10 15 L 15 30 L 20 20 L 25 28 L 30 18 L 35 32 L 40 22 L 45 26 L 50 16 L 55 30 L 60 19 L 65 31 L 70 21 L 75 27 L 80 17 L 85 29 L 90 23 L 95 25 L 100 15 L 105 28 L 110 20 L 115 32 L 120 18 L 125 30 L 130 22 L 135 26 L 140 16 L 145 29 L 150 24 L 155 25" stroke="white" stroke-width="1" fill="none" opacity="0.6"/>
									</svg>
								</div>
								<span class="track-duration">4:15</span>
							</div>
						</div>

						<div class="post-actions">
							<button class="post-action-btn">
								<i class="bi bi-heart"></i>
								<span>52</span>
							</button>
							<button class="post-action-btn">
								<i class="bi bi-repeat"></i>
								<span>2</span>
							</button>
							<button class="post-action-btn">
								<i class="bi bi-share"></i>
							</button>
							<button class="post-action-btn">
								<i class="bi bi-bookmark"></i>
							</button>
							<button class="post-action-btn">
								<i class="bi bi-three-dots"></i>
							</button>
							<div class="post-stats">
								<span class="plays">▶ 892</span>
								<span class="comments">💬 4</span>
							</div>
						</div>
					</div>
				</div>
			</div>

			<!-- Right Column: Artists You Should Follow -->
			<div class="col-lg-4">
				<h2 class="section-title artist-section-title">Các nghệ sĩ
					thịnh hành</h2>
				<button class="btn-refresh-artists mb-3">
					<span>Làm mới danh sách</span>
				</button>

				<!-- Artist Cards -->
				<div class="artists-list">
					<div class="artist-card">
						<img src="assets/img/avt_travis-scott.jpg" alt="Travis Scott"
							class="artist-avatar">
						<div class="artist-info">
							<div class="artist-name">
								Travis Scott <i class="bi bi-patch-check-fill verified-icon"></i>
							</div>
							<div class="artist-stats">
								<span><i class="bi bi-people-fill"></i> 5.56M</span> <span><i
									class="bi bi-music-note-beamed"></i> 174</span>
							</div>
						</div>
						<button class="btn-follow">Theo dõi</button>
					</div>

					<div class="artist-card">
						<img src="assets/img/avt_bad-bunny.jpg" alt="Bad Bunny"
							class="artist-avatar">
						<div class="artist-info">
							<div class="artist-name">
								Bad Bunny <i class="bi bi-patch-check-fill verified-icon"></i>
							</div>
							<div class="artist-stats">
								<span><i class="bi bi-people-fill"></i> 2.51M</span> <span><i
									class="bi bi-music-note-beamed"></i> 167</span>
							</div>
						</div>
						<button class="btn-follow">Theo dõi</button>
					</div>

					<div class="artist-card">
						<img src="assets/img/avt_doja-cat.png" alt="Doja Cat"
							class="artist-avatar">
						<div class="artist-info">
							<div class="artist-name">
								DOJA CAT <i class="bi bi-patch-check-fill verified-icon"></i>
							</div>
							<div class="artist-stats">
								<span><i class="bi bi-people-fill"></i> 1.73M</span> <span><i
									class="bi bi-music-note-beamed"></i> 164</span>
							</div>
						</div>
						<button class="btn-follow">Theo dõi</button>
					</div>
				</div>

				<!-- Listening History Section -->
				<div class="listening-history-section mt-5">
					<div class="d-flex justify-content-between align-items-center mb-3">
						<h4 class="history-title">Lịch sử nghe nhạc</h4>
						<a href="#" class="view-all-link-small">View all</a>
					</div>

					<!-- History Items -->
					<div class="history-list">
						<div class="history-item">
							<div class="history-thumb-wrap">
								<img src="assets/img/ca-phe_song.jpg" alt="Song thumbnail"
									class="history-thumbnail">
								<button class="history-play-btn">
									<i class="bi bi-play-fill"></i>
								</button>
							</div>
							<div class="history-info">
								<div class="history-artist">Lil Liem</div>
								<div class="history-song-title">uocgianhaynoiyeutoi</div>
								<div class="history-stats">
									<span><i class="bi bi-play-fill"></i> 353K</span> <span><i
										class="bi bi-heart-fill"></i> 3,527</span> <span><i
										class="bi bi-repeat"></i> 88</span> <span><i
										class="bi bi-chat"></i> 78</span>
								</div>
							</div>
							<div class="history-actions">
								<button class="history-action-btn" title="Like">
									<i class="bi bi-heart"></i>
								</button>
								<button class="history-action-btn" title="More">
									<i class="bi bi-three-dots"></i>
								</button>
							</div>
						</div>

						<div class="history-item">
							<div class="history-thumb-wrap">
								<img src="assets/img/kem-duyen_song.jpg" alt="Song thumbnail"
									class="history-thumbnail">
								<button class="history-play-btn">
									<i class="bi bi-play-fill"></i>
								</button>
							</div>
							<div class="history-info">
								<div class="history-artist">n1ay</div>
								<div class="history-song-title">KÈM DUYÊN (remix by Higo)
									(reup on ...</div>
								<div class="history-stats">
									<span><i class="bi bi-play-fill"></i> 127K</span> <span><i
										class="bi bi-heart-fill"></i> 964</span> <span><i
										class="bi bi-repeat"></i> 10</span> <span><i
										class="bi bi-chat"></i> 9</span>
								</div>
							</div>
							<div class="history-actions">
								<button class="history-action-btn" title="Like">
									<i class="bi bi-heart"></i>
								</button>
								<button class="history-action-btn" title="More">
									<i class="bi bi-three-dots"></i>
								</button>
							</div>
						</div>

						<div class="history-item">
							<div class="history-thumb-wrap">
								<img src="assets/img/kem-duyen-drill_song.jpg" alt="Song thumbnail"
									class="history-thumbnail">
								<button class="history-play-btn">
									<i class="bi bi-play-fill"></i>
								</button>
							</div>
							<div class="history-info">
								<div class="history-artist">Sevenlow</div>
								<div class="history-song-title">Kem duyen drill mix tiktok</div>
								<div class="history-stats">
									<span><i class="bi bi-play-fill"></i> 95.5K</span> <span><i
										class="bi bi-heart-fill"></i> 851</span> <span><i
										class="bi bi-repeat"></i> 9</span> <span><i class="bi bi-chat"></i>
										7</span>
								</div>
							</div>
							<div class="history-actions">
								<button class="history-action-btn" title="Like">
									<i class="bi bi-heart"></i>
								</button>
								<button class="history-action-btn" title="More">
									<i class="bi bi-three-dots"></i>
								</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<!-- App scripts -->
		<script src="assets/js/app.js"></script>
	<%@ include file="footer.jsp" %>
	</div>
	
	<%@ include file="player.jsp" %>

</body>
</html>