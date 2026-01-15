<%-- Disable EL in script sections by using backslash escape --%>
<!-- Hidden Audio Element -->
<audio id="audioPlayer" preload="metadata"></audio>

<!-- Fixed Music Player Bar -->
<div class="fixed-player-bar" id="fixedPlayerBar">
	<div class="player-container">
		<!-- Previous/Play/Next Controls -->
		<div class="player-controls-left">
			<button class="player-btn" id="prevBtn" title="Bài trước">
				<i class="bi bi-skip-backward-fill"></i>
			</button>
			<button class="player-btn player-play-btn" id="mainPlayBtn" title="Phát/Dừng">
				<i class="bi bi-play-fill" id="playIcon"></i>
			</button>
			<button class="player-btn" id="nextBtn" title="Bài tiếp">
				<i class="bi bi-skip-forward-fill"></i>
			</button>
		</div>
		
		<!-- Progress Bar -->
		<div class="player-progress-section">
			<span class="player-time" id="currentTime">0:00</span>
			<div class="player-progress-bar" id="progressBar">
				<div class="player-progress-fill" id="progressFill"></div>
				<div class="player-progress-handle" id="progressHandle"></div>
			</div>
			<span class="player-time" id="durationTime">0:00</span>
		</div>
		
		<!-- Song Info Center -->
		<div class="player-song-info" id="playerSongInfo">
			<a href="#" id="trackDetailLink" class="player-thumb-link">
				<img src="assets/img/default-track.jpg" alt="Now Playing" class="player-song-thumb" id="playerThumb">
			</a>
			<div class="player-song-details">
				<a href="#" id="trackTitleLink" class="player-song-title" title="Xem chi tiết bài hát">Chưa có bài hát</a>
				<a href="#" id="artistLink" class="player-song-artist" title="Xem profile nghệ sĩ">--</a>
			</div>
		</div>
		
		<!-- Volume & More Controls -->
		<div class="player-controls-right">
			<button class="player-btn" id="shuffleBtn" title="Trộn bài">
				<i class="bi bi-shuffle"></i>
			</button>
			<button class="player-btn" id="repeatBtn" title="Lặp lại">
				<i class="bi bi-repeat"></i>
			</button>
			<div class="player-volume-control">
				<button class="player-btn" id="volumeBtn" title="Âm lượng">
					<i class="bi bi-volume-up" id="volumeIcon"></i>
				</button>
				<input type="range" class="player-volume-slider" id="volumeSlider" min="0" max="100" value="50">
			</div>
			<button class="player-btn" id="nextUpButton" title="Danh sách chờ">
				<i class="bi bi-justify"></i>
			</button>
		</div>
	</div>
</div>

<!-- Next Up Panel -->
<div class="next-up-panel" id="nextUpPanel">
	<div class="next-up-header">
		<h3>Danh sách chờ</h3>
		<div class="next-up-header-actions">
			<button class="next-up-clear" id="clearQueueBtn">Xóa tất cả</button>
			<button class="next-up-close" id="closeNextUp">
				<i class="bi bi-x-lg"></i>
			</button>
		</div>
	</div>
	<div class="next-up-content" id="queueList">
		<!-- Queue items will be dynamically generated -->
		<div class="queue-empty-message">
			<i class="bi bi-music-note-list"></i>
			<p>Danh sách chờ trống</p>
			<span>Thêm bài hát vào danh sách chờ để phát</span>
		</div>
	</div>
</div>

<!-- Audio Player JavaScript Module -->
<script>
// =====================================================
// BEATFLOW AUDIO PLAYER MODULE
// =====================================================

const BeatFlowPlayer = (function() {
	// Private variables
	let audio = null;
	let playlist = [];
	let currentIndex = -1;
	let isPlaying = false;
	let isShuffle = false;
	let repeatMode = 0; // 0: no repeat, 1: repeat all, 2: repeat one
	let volume = 0.5;
	let isMuted = false;
	let previousVolume = 0.5;
	let isDragging = false;

	// DOM Elements
	let elements = {};

	// Initialize the player
	function init() {
		audio = document.getElementById('audioPlayer');
		if (!audio) {
			console.error('Audio element not found');
			return;
		}

		// Cache DOM elements
		elements = {
			playBtn: document.getElementById('mainPlayBtn'),
			playIcon: document.getElementById('playIcon'),
			prevBtn: document.getElementById('prevBtn'),
			nextBtn: document.getElementById('nextBtn'),
			progressBar: document.getElementById('progressBar'),
			progressFill: document.getElementById('progressFill'),
			progressHandle: document.getElementById('progressHandle'),
			currentTime: document.getElementById('currentTime'),
			durationTime: document.getElementById('durationTime'),
			playerThumb: document.getElementById('playerThumb'),
			trackTitleLink: document.getElementById('trackTitleLink'),
			artistLink: document.getElementById('artistLink'),
			trackDetailLink: document.getElementById('trackDetailLink'),
			shuffleBtn: document.getElementById('shuffleBtn'),
			repeatBtn: document.getElementById('repeatBtn'),
			volumeBtn: document.getElementById('volumeBtn'),
			volumeIcon: document.getElementById('volumeIcon'),
			volumeSlider: document.getElementById('volumeSlider'),
			nextUpBtn: document.getElementById('nextUpButton'),
			nextUpPanel: document.getElementById('nextUpPanel'),
			closeNextUp: document.getElementById('closeNextUp'),
			clearQueueBtn: document.getElementById('clearQueueBtn'),
			queueList: document.getElementById('queueList')
		};

		// Set initial volume
		audio.volume = volume;
		if (elements.volumeSlider) {
			elements.volumeSlider.value = volume * 100;
		}

		// Bind events
		bindEvents();

		// Load saved state from localStorage
		loadSavedState();

		console.log('BeatFlow Player initialized');
	}

	// Bind all event listeners
	function bindEvents() {
		// Audio events
		audio.addEventListener('loadedmetadata', onMetadataLoaded);
		audio.addEventListener('timeupdate', onTimeUpdate);
		audio.addEventListener('ended', onTrackEnded);
		audio.addEventListener('error', onError);
		audio.addEventListener('canplay', onCanPlay);
		audio.addEventListener('waiting', onWaiting);
		audio.addEventListener('playing', onPlaying);

		// Play/Pause button
		if (elements.playBtn) {
			elements.playBtn.addEventListener('click', togglePlay);
		}

		// Previous/Next buttons
		if (elements.prevBtn) {
			elements.prevBtn.addEventListener('click', playPrevious);
		}
		if (elements.nextBtn) {
			elements.nextBtn.addEventListener('click', playNext);
		}

		// Progress bar - click and drag
		if (elements.progressBar) {
			elements.progressBar.addEventListener('click', seekTo);
			elements.progressBar.addEventListener('mousedown', startDrag);
			document.addEventListener('mousemove', onDrag);
			document.addEventListener('mouseup', endDrag);
		}

		// Shuffle button
		if (elements.shuffleBtn) {
			elements.shuffleBtn.addEventListener('click', toggleShuffle);
		}

		// Repeat button
		if (elements.repeatBtn) {
			elements.repeatBtn.addEventListener('click', toggleRepeat);
		}

		// Volume controls
		if (elements.volumeBtn) {
			elements.volumeBtn.addEventListener('click', toggleMute);
		}
		if (elements.volumeSlider) {
			elements.volumeSlider.addEventListener('input', onVolumeChange);
		}

		// Next Up panel
		if (elements.nextUpBtn) {
			elements.nextUpBtn.addEventListener('click', function(e) {
				e.stopPropagation();
				toggleNextUpPanel();
			});
		}
		if (elements.closeNextUp) {
			elements.closeNextUp.addEventListener('click', function(e) {
				e.stopPropagation();
				closeNextUpPanel();
			});
		}
		if (elements.clearQueueBtn) {
			elements.clearQueueBtn.addEventListener('click', function(e) {
				e.stopPropagation();
				clearQueue();
			});
		}

		// Click outside to close Next Up panel
		document.addEventListener('click', function(e) {
			if (elements.nextUpPanel && 
				elements.nextUpPanel.classList.contains('show') &&
				!elements.nextUpPanel.contains(e.target) && 
				!elements.nextUpBtn.contains(e.target)) {
				elements.nextUpPanel.classList.remove('show');
			}
		});

		// Keyboard shortcuts
		document.addEventListener('keydown', handleKeyboard);
	}

	// Load a track and optionally play it
	function loadTrack(track, autoPlay = true) {
		if (!track || !track.audioFileUrl) {
			console.error('Invalid track or missing audio URL');
			showPlayerNotification('Không thể phát bài hát này', 'error');
			return;
		}

		// Update audio source
		audio.src = track.audioFileUrl;
		audio.load();

		// Update UI
		updatePlayerUI(track);

		// Add to queue if not already there
		const existingIndex = playlist.findIndex(t => t.trackId === track.trackId);
		if (existingIndex === -1) {
			playlist.push(track);
			currentIndex = playlist.length - 1;
		} else {
			currentIndex = existingIndex;
		}

		// Save state
		saveState();

		// Update queue display
		updateQueueDisplay();

		if (autoPlay) {
			play();
		}
	}

	// Update player UI with track info
	function updatePlayerUI(track) {
		if (elements.playerThumb) {
			elements.playerThumb.src = track.coverImageUrl || track.artworkUrl || 'assets/img/default-track.jpg';
			elements.playerThumb.onerror = function() {
				this.src = 'assets/img/default-track.jpg';
			};
		}
		if (elements.trackTitleLink) {
			elements.trackTitleLink.textContent = track.title || 'Unknown Track';
			elements.trackTitleLink.href = 'track.jsp?id=' + (track.trackId || track.id);
			elements.trackTitleLink.title = track.title;
		}
		if (elements.artistLink) {
			elements.artistLink.textContent = track.artist || 'Unknown Artist';
			elements.artistLink.href = 'profile.jsp?user=' + (track.uploaderUsername || track.artist);
			elements.artistLink.title = 'Xem profile: ' + (track.artist || '');
		}
		if (elements.trackDetailLink) {
			elements.trackDetailLink.href = 'track.jsp?id=' + (track.trackId || track.id);
		}

		// Update document title
		document.title = (track.title || 'BeatFlow') + ' - ' + (track.artist || 'Music');
	}

	// Play audio
	function play() {
		const playPromise = audio.play();
		if (playPromise !== undefined) {
			playPromise.then(() => {
				isPlaying = true;
				updatePlayButton();
				recordPlayHistory();
			}).catch(error => {
				console.error('Playback error:', error);
				showPlayerNotification('Không thể phát bài hát', 'error');
			});
		}
	}

	// Pause audio
	function pause() {
		audio.pause();
		isPlaying = false;
		updatePlayButton();
	}

	// Toggle play/pause
	function togglePlay() {
		if (audio.src && audio.src !== window.location.href) {
			if (isPlaying) {
				pause();
			} else {
				play();
			}
		} else if (playlist.length > 0) {
			// If no track loaded, play first in queue
			playTrackAtIndex(0);
		}
	}

	// Update play button icon
	function updatePlayButton() {
		if (elements.playIcon) {
			if (isPlaying) {
				elements.playIcon.classList.remove('bi-play-fill');
				elements.playIcon.classList.add('bi-pause-fill');
			} else {
				elements.playIcon.classList.remove('bi-pause-fill');
				elements.playIcon.classList.add('bi-play-fill');
			}
		}
	}

	// Play previous track
	function playPrevious() {
		if (audio.currentTime > 3) {
			// If more than 3 seconds into track, restart it
			audio.currentTime = 0;
		} else if (playlist.length > 0) {
			let newIndex;
			if (isShuffle) {
				newIndex = Math.floor(Math.random() * playlist.length);
			} else {
				newIndex = currentIndex - 1;
				if (newIndex < 0) {
					newIndex = repeatMode > 0 ? playlist.length - 1 : 0;
				}
			}
			playTrackAtIndex(newIndex);
		}
	}

	// Play next track
	function playNext() {
		if (playlist.length === 0) return;

		let newIndex;
		if (isShuffle) {
			newIndex = Math.floor(Math.random() * playlist.length);
		} else {
			newIndex = currentIndex + 1;
			if (newIndex >= playlist.length) {
				if (repeatMode > 0) {
					newIndex = 0;
				} else {
					return; // End of playlist
				}
			}
		}
		playTrackAtIndex(newIndex);
	}

	// Play track at specific index
	function playTrackAtIndex(index) {
		if (index >= 0 && index < playlist.length) {
			currentIndex = index;
			loadTrack(playlist[index], true);
		}
	}

	// Seek to position
	function seekTo(e) {
		if (!audio.duration) return;
		const rect = elements.progressBar.getBoundingClientRect();
		const percent = (e.clientX - rect.left) / rect.width;
		audio.currentTime = percent * audio.duration;
	}

	// Start dragging progress
	function startDrag(e) {
		isDragging = true;
		elements.progressBar.classList.add('dragging');
	}

	// Handle drag movement
	function onDrag(e) {
		if (!isDragging || !audio.duration) return;
		const rect = elements.progressBar.getBoundingClientRect();
		let percent = (e.clientX - rect.left) / rect.width;
		percent = Math.max(0, Math.min(1, percent));
		elements.progressFill.style.width = (percent * 100) + '%';
		if (elements.progressHandle) {
			elements.progressHandle.style.left = (percent * 100) + '%';
		}
		elements.currentTime.textContent = formatTime(percent * audio.duration);
	}

	// End dragging
	function endDrag(e) {
		if (!isDragging) return;
		isDragging = false;
		elements.progressBar.classList.remove('dragging');
		
		const rect = elements.progressBar.getBoundingClientRect();
		let percent = (e.clientX - rect.left) / rect.width;
		percent = Math.max(0, Math.min(1, percent));
		if (audio.duration) {
			audio.currentTime = percent * audio.duration;
		}
	}

	// Toggle shuffle mode
	function toggleShuffle() {
		isShuffle = !isShuffle;
		elements.shuffleBtn.classList.toggle('active', isShuffle);
		saveState();
		showPlayerNotification(isShuffle ? 'Đã bật trộn bài' : 'Đã tắt trộn bài');
	}

	// Toggle repeat mode
	function toggleRepeat() {
		repeatMode = (repeatMode + 1) % 3;
		elements.repeatBtn.classList.toggle('active', repeatMode > 0);
		
		const repeatIcon = elements.repeatBtn.querySelector('i');
		if (repeatMode === 2) {
			repeatIcon.classList.remove('bi-repeat');
			repeatIcon.classList.add('bi-repeat-1');
		} else {
			repeatIcon.classList.remove('bi-repeat-1');
			repeatIcon.classList.add('bi-repeat');
		}

		saveState();
		const messages = ['Đã tắt lặp lại', 'Lặp lại danh sách', 'Lặp lại bài hát'];
		showPlayerNotification(messages[repeatMode]);
	}

	// Toggle mute
	function toggleMute() {
		isMuted = !isMuted;
		if (isMuted) {
			previousVolume = volume;
			audio.volume = 0;
			elements.volumeSlider.value = 0;
		} else {
			audio.volume = previousVolume;
			elements.volumeSlider.value = previousVolume * 100;
		}
		updateVolumeIcon();
	}

	// Handle volume change
	function onVolumeChange(e) {
		volume = e.target.value / 100;
		audio.volume = volume;
		isMuted = volume === 0;
		updateVolumeIcon();
		saveState();
	}

	// Update volume icon
	function updateVolumeIcon() {
		if (!elements.volumeIcon) return;
		elements.volumeIcon.classList.remove('bi-volume-up', 'bi-volume-down', 'bi-volume-mute');
		
		if (isMuted || volume === 0) {
			elements.volumeIcon.classList.add('bi-volume-mute');
		} else if (volume < 0.5) {
			elements.volumeIcon.classList.add('bi-volume-down');
		} else {
			elements.volumeIcon.classList.add('bi-volume-up');
		}
	}

	// Toggle Next Up panel
	function toggleNextUpPanel() {
		if (elements.nextUpPanel) {
			elements.nextUpPanel.classList.toggle('show');
			if (elements.nextUpPanel.classList.contains('show')) {
				updateQueueDisplay();
			}
		}
	}

	// Close Next Up panel
	function closeNextUpPanel() {
		if (elements.nextUpPanel) {
			elements.nextUpPanel.classList.remove('show');
		}
	}

	// Clear queue
	function clearQueue() {
		const currentTrack = playlist[currentIndex];
		playlist = currentTrack ? [currentTrack] : [];
		currentIndex = currentTrack ? 0 : -1;
		updateQueueDisplay();
		saveState();
		showPlayerNotification('Đã xóa danh sách chờ');
	}

	// Update queue display
	function updateQueueDisplay() {
		if (!elements.queueList) return;

		if (playlist.length === 0) {
			elements.queueList.innerHTML = '<div class="queue-empty-message">' +
				'<i class="bi bi-music-note-list"></i>' +
				'<p>Danh sách chờ trống</p>' +
				'<span>Thêm bài hát vào danh sách chờ để phát</span>' +
			'</div>';
			return;
		}

		let html = '';
		playlist.forEach(function(track, index) {
			const isActive = index === currentIndex ? 'active' : '';
			const playIcon = (index === currentIndex && isPlaying) ? 'bi-pause-fill' : 'bi-play-fill';
			const imgSrc = track.coverImageUrl || track.artworkUrl || 'assets/img/default-track.jpg';
			
			html += '<div class="next-up-item ' + isActive + '" data-index="' + index + '">' +
				'<div class="next-up-thumb-wrap">' +
					'<img src="' + imgSrc + '" alt="' + escapeHtml(track.title) + '" class="next-up-thumb" onerror="this.src=\'assets/img/default-track.jpg\'">' +
					'<button class="next-up-play-btn" data-index="' + index + '">' +
						'<i class="bi ' + playIcon + '"></i>' +
					'</button>' +
				'</div>' +
				'<div class="next-up-info">' +
					'<div class="next-up-song">' + escapeHtml(track.title) + '</div>' +
					'<div class="next-up-artist">' + escapeHtml(track.artist || '') + '</div>' +
				'</div>' +
				'<div class="next-up-time">' + formatTime(track.duration || 0) + '</div>' +
				'<div class="next-up-actions">' +
					'<button class="next-up-action-btn queue-remove-btn" data-index="' + index + '" title="Xóa khỏi danh sách">' +
						'<i class="bi bi-x-lg"></i>' +
					'</button>' +
				'</div>' +
			'</div>';
		});
		
		elements.queueList.innerHTML = html;
		elements.queueList.querySelectorAll('.next-up-play-btn').forEach(btn => {
			btn.addEventListener('click', (e) => {
				e.stopPropagation();
				const index = parseInt(btn.dataset.index);
				playTrackAtIndex(index);
			});
		});

		elements.queueList.querySelectorAll('.queue-remove-btn').forEach(btn => {
			btn.addEventListener('click', (e) => {
				e.stopPropagation();
				const index = parseInt(btn.dataset.index);
				removeFromQueue(index);
			});
		});

		elements.queueList.querySelectorAll('.next-up-item').forEach(item => {
			item.addEventListener('click', () => {
				const index = parseInt(item.dataset.index);
				playTrackAtIndex(index);
			});
		});
	}

	// Remove track from queue
	function removeFromQueue(index) {
		if (index < 0 || index >= playlist.length) return;

		playlist.splice(index, 1);
		
		if (index < currentIndex) {
			currentIndex--;
		} else if (index === currentIndex) {
			if (playlist.length === 0) {
				currentIndex = -1;
				pause();
				resetPlayerUI();
			} else {
				currentIndex = Math.min(currentIndex, playlist.length - 1);
				loadTrack(playlist[currentIndex], isPlaying);
			}
		}
		
		updateQueueDisplay();
		saveState();
	}

	// Reset player UI
	function resetPlayerUI() {
		if (elements.playerThumb) elements.playerThumb.src = 'assets/img/default-track.jpg';
		if (elements.trackTitleLink) elements.trackTitleLink.textContent = 'Chưa có bài hát';
		if (elements.artistLink) elements.artistLink.textContent = '--';
		if (elements.currentTime) elements.currentTime.textContent = '0:00';
		if (elements.durationTime) elements.durationTime.textContent = '0:00';
		if (elements.progressFill) elements.progressFill.style.width = '0%';
		document.title = 'BeatFlow';
	}

	// Add track to queue
	function addToQueue(track) {
		if (!track) return;
		
		// Check if already in queue
		const exists = playlist.some(t => t.trackId === track.trackId);
		if (!exists) {
			playlist.push(track);
			updateQueueDisplay();
			saveState();
			showPlayerNotification('Đã thêm vào danh sách chờ: ' + track.title);
		} else {
			showPlayerNotification('Bài hát đã có trong danh sách chờ');
		}
	}

	// Audio event handlers
	function onMetadataLoaded() {
		if (elements.durationTime) {
			elements.durationTime.textContent = formatTime(audio.duration);
		}
	}

	function onTimeUpdate() {
		if (isDragging) return;
		
		const percent = audio.duration ? (audio.currentTime / audio.duration) * 100 : 0;
		if (elements.progressFill) {
			elements.progressFill.style.width = percent + '%';
		}
		if (elements.progressHandle) {
			elements.progressHandle.style.left = percent + '%';
		}
		if (elements.currentTime) {
			elements.currentTime.textContent = formatTime(audio.currentTime);
		}
	}

	function onTrackEnded() {
		if (repeatMode === 2) {
			// Repeat one
			audio.currentTime = 0;
			play();
		} else {
			playNext();
		}
	}

	function onError(e) {
		console.error('Audio error:', e);
		showPlayerNotification('Lỗi phát nhạc', 'error');
	}

	function onCanPlay() {
		// Track is ready to play
	}

	function onWaiting() {
		// Show loading indicator if needed
	}

	function onPlaying() {
		isPlaying = true;
		updatePlayButton();
		updateQueueDisplay();
	}

	// Keyboard shortcuts
	function handleKeyboard(e) {
		// Don't trigger if typing in input
		if (e.target.tagName === 'INPUT' || e.target.tagName === 'TEXTAREA') return;
		
		switch(e.code) {
			case 'Space':
				e.preventDefault();
				togglePlay();
				break;
			case 'ArrowLeft':
				if (e.shiftKey) {
					playPrevious();
				} else {
					audio.currentTime = Math.max(0, audio.currentTime - 10);
				}
				break;
			case 'ArrowRight':
				if (e.shiftKey) {
					playNext();
				} else {
					audio.currentTime = Math.min(audio.duration, audio.currentTime + 10);
				}
				break;
			case 'ArrowUp':
				e.preventDefault();
				volume = Math.min(1, volume + 0.1);
				audio.volume = volume;
				elements.volumeSlider.value = volume * 100;
				updateVolumeIcon();
				break;
			case 'ArrowDown':
				e.preventDefault();
				volume = Math.max(0, volume - 0.1);
				audio.volume = volume;
				elements.volumeSlider.value = volume * 100;
				updateVolumeIcon();
				break;
			case 'KeyM':
				toggleMute();
				break;
			case 'KeyS':
				toggleShuffle();
				break;
			case 'KeyR':
				toggleRepeat();
				break;
		}
	}

	// Record play history
	function recordPlayHistory() {
		const currentTrack = playlist[currentIndex];
		if (!currentTrack) return;

		fetch('api/tracks/' + currentTrack.trackId + '/play', {
			method: 'POST',
			headers: { 'Content-Type': 'application/json' },
			credentials: 'include'
		}).catch(err => console.log('Could not record play:', err));
	}

	// Save state to localStorage
	function saveState() {
		try {
			const state = {
				playlist: playlist,
				currentIndex: currentIndex,
				volume: volume,
				isShuffle: isShuffle,
				repeatMode: repeatMode,
				currentTime: audio ? audio.currentTime : 0
			};
			localStorage.setItem('beatflow_player_state', JSON.stringify(state));
		} catch (e) {
			console.log('Could not save player state');
		}
	}

	// Load saved state
	function loadSavedState() {
		try {
			const saved = localStorage.getItem('beatflow_player_state');
			if (saved) {
				const state = JSON.parse(saved);
				
				if (state.volume !== undefined) {
					volume = state.volume;
					audio.volume = volume;
					elements.volumeSlider.value = volume * 100;
					updateVolumeIcon();
				}
				
				if (state.isShuffle !== undefined) {
					isShuffle = state.isShuffle;
					elements.shuffleBtn.classList.toggle('active', isShuffle);
				}
				
				if (state.repeatMode !== undefined) {
					repeatMode = state.repeatMode;
					elements.repeatBtn.classList.toggle('active', repeatMode > 0);
					if (repeatMode === 2) {
						const repeatIcon = elements.repeatBtn.querySelector('i');
						repeatIcon.classList.remove('bi-repeat');
						repeatIcon.classList.add('bi-repeat-1');
					}
				}

				if (state.playlist && state.playlist.length > 0) {
					playlist = state.playlist;
					currentIndex = state.currentIndex >= 0 ? state.currentIndex : 0;
					const currentTrack = playlist[currentIndex];
					if (currentTrack) {
						updatePlayerUI(currentTrack);
						audio.src = currentTrack.audioFileUrl;
						if (state.currentTime) {
							audio.addEventListener('loadedmetadata', function onLoad() {
								audio.currentTime = state.currentTime;
								audio.removeEventListener('loadedmetadata', onLoad);
							});
						}
					}
					updateQueueDisplay();
				}
			}
		} catch (e) {
			console.log('Could not load player state');
		}
	}

	// Helper: Format time
	function formatTime(seconds) {
		if (!seconds || isNaN(seconds)) return '0:00';
		const mins = Math.floor(seconds / 60);
		const secs = Math.floor(seconds % 60);
		return mins + ':' + (secs < 10 ? '0' : '') + secs;
	}

	// Helper: Escape HTML
	function escapeHtml(text) {
		if (!text) return '';
		const div = document.createElement('div');
		div.textContent = text;
		return div.innerHTML;
	}

	// Helper: Show notification
	function showPlayerNotification(message, type = 'success') {
		const alertClass = type === 'error' ? 'alert-danger' : 'alert-success';
		const alertDiv = document.createElement('div');
		alertDiv.className = 'alert ' + alertClass + ' alert-dismissible fade show position-fixed player-notification';
		alertDiv.style.cssText = 'bottom: 100px; right: 20px; z-index: 10001; max-width: 300px;';
		alertDiv.innerHTML = message + '<button type="button" class="btn-close" data-bs-dismiss="alert"></button>';
		document.body.appendChild(alertDiv);
		setTimeout(() => alertDiv.remove(), 3000);
	}

	// Public API
	return {
		init: init,
		loadTrack: loadTrack,
		play: play,
		pause: pause,
		togglePlay: togglePlay,
		playNext: playNext,
		playPrevious: playPrevious,
		addToQueue: addToQueue,
		getPlaylist: function() { return playlist; },
		getCurrentTrack: function() { return playlist[currentIndex]; },
		isPlaying: function() { return isPlaying; }
	};
})();

// Initialize player when DOM is ready
document.addEventListener('DOMContentLoaded', function() {
	BeatFlowPlayer.init();
});
</script>
