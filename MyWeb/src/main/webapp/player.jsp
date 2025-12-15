<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- Fixed Music Player Bar -->
<div class="fixed-player-bar">
	<div class="player-container">
		<!-- Previous/Play/Next Controls -->
		<div class="player-controls-left">
			<button class="player-btn">
				<i class="bi bi-skip-backward-fill"></i>
			</button>
			<button class="player-btn player-play-btn">
				<i class="bi bi-play-fill"></i>
			</button>
			<button class="player-btn">
				<i class="bi bi-skip-forward-fill"></i>
			</button>
		</div>
		
		<!-- Progress Bar -->
		<div class="player-progress-section">
			<span class="player-time">0:00</span>
			<div class="player-progress-bar">
				<div class="player-progress-fill"></div>
			</div>
			<span class="player-time">3:04</span>
		</div>
		
		<!-- Song Info Center -->
		<div class="player-song-info">
			<img src="assets/img/ca-phe_song.jpg" alt="Now Playing" class="player-song-thumb">
			<div class="player-song-details">
				<div class="player-song-title">Lil Liem</div>
				<div class="player-song-artist">uocgianhaynoiyeutoi</div>
			</div>
		</div>
		
		<!-- Volume & More Controls -->
		<div class="player-controls-right">
			<button class="player-btn">
				<i class="bi bi-shuffle"></i>
			</button>
			<button class="player-btn">
				<i class="bi bi-chat"></i>
			</button>
			<div class="player-volume-control">
				<i class="bi bi-volume-up"></i>
				<input type="range" class="player-volume-slider" min="0" max="100" value="50">
			</div>
			<button class="player-btn" id="nextUpButton">
				<i class="bi bi-justify"></i>
			</button>
		</div>
	</div>
</div>

<!-- Next Up Panel -->
<div class="next-up-panel" id="nextUpPanel">
	<div class="next-up-header">
		<h3>Next up</h3>
		<div class="next-up-header-actions">
			<button class="next-up-clear">Clear</button>
			<button class="next-up-close" id="closeNextUp">
				<i class="bi bi-x-lg"></i>
			</button>
		</div>
	</div>
	<div class="next-up-content">
		<!-- Queue Items -->
		<div class="next-up-item">
			<div class="next-up-thumb-wrap">
				<img src="assets/img/avt_travis-scott.jpg" alt="Song" class="next-up-thumb">
				<button class="next-up-play-btn">
					<i class="bi bi-play-fill"></i>
				</button>
			</div>
			<div class="next-up-info">
				<div class="next-up-artist">LeeHi 이하이</div>
				<div class="next-up-song">LeeHi (이하이) - ONLY</div>
			</div>
			<div class="next-up-time">4:00</div>
			<div class="next-up-actions">
				<button class="next-up-action-btn">
					<i class="bi bi-heart"></i>
				</button>
				<button class="next-up-action-btn">
					<i class="bi bi-three-dots"></i>
				</button>
			</div>
		</div>

		<div class="next-up-item active">
			<div class="next-up-thumb-wrap">
				<img src="assets/img/kem-duyen-drill_song.jpg" alt="Song" class="next-up-thumb">
				<button class="next-up-play-btn">
					<i class="bi bi-play-fill"></i>
				</button>
			</div>
			<div class="next-up-info">
				<div class="next-up-artist">Sevenlow</div>
				<div class="next-up-song">Kem duyen drill mix tiktok</div>
			</div>
			<div class="next-up-time">4:00</div>
			<div class="next-up-actions">
				<button class="next-up-action-btn active">
					<i class="bi bi-heart-fill"></i>
				</button>
				<button class="next-up-action-btn">
					<i class="bi bi-three-dots"></i>
				</button>
			</div>
		</div>
	</div>
</div>
