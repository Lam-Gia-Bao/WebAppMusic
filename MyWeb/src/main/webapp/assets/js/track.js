/**
 * BeatFlow Track Page JavaScript
 * Handles track page interactions and integrates with BeatFlowPlayer
 */

document.addEventListener('DOMContentLoaded', function() {
    initTrackPage();
});

function initTrackPage() {
    // Get track data from URL or page
    const urlParams = new URLSearchParams(window.location.search);
    const trackId = urlParams.get('id');

    // Hero play button
    const heroPlay = document.getElementById('heroPlay');
    if (heroPlay) {
        heroPlay.addEventListener('click', function() {
            if (trackId) {
                // Load track from API and play
                loadAndPlayTrack(trackId);
            } else {
                // Fallback to data attributes
                const trackData = {
                    trackId: heroPlay.dataset.trackId || 1,
                    title: heroPlay.dataset.title || 'Unknown Track',
                    artist: heroPlay.dataset.artist || 'Unknown Artist',
                    coverImageUrl: heroPlay.dataset.thumb || 'assets/img/default-track.jpg',
                    audioFileUrl: heroPlay.dataset.audio || null
                };
                
                if (trackData.audioFileUrl && typeof BeatFlowPlayer !== 'undefined') {
                    BeatFlowPlayer.loadTrack(trackData, true);
                    updateHeroPlayButton(true);
                }
            }
        });
    }

    // Load track data if ID is present
    if (trackId) {
        loadTrackDetails(trackId);
    }

    // Initialize other page features
    initCommentSection();
    initActionButtons();
}

/**
 * Load track from API and play it
 */
function loadAndPlayTrack(trackId) {
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

        if (typeof BeatFlowPlayer !== 'undefined') {
            BeatFlowPlayer.loadTrack(trackData, true);
            updateHeroPlayButton(true);
        }
    })
    .catch(error => {
        console.error('Error loading track:', error);
        showNotification('Không thể phát bài hát', 'error');
    });
}

/**
 * Load track details and update page
 */
function loadTrackDetails(trackId) {
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
        // Update page with track info
        updateTrackPage(track);
    })
    .catch(error => {
        console.error('Error loading track details:', error);
    });
}

/**
 * Update the track page with data from API
 */
function updateTrackPage(track) {
    // Update title
    const heroTitle = document.querySelector('.hero-title');
    if (heroTitle) {
        heroTitle.textContent = track.title + ' - ' + track.artist;
    }

    // Update cover image
    const heroCover = document.querySelector('.hero-cover img');
    if (heroCover && track.artworkUrl) {
        heroCover.src = track.artworkUrl;
    }

    // Update hero play button data
    const heroPlay = document.getElementById('heroPlay');
    if (heroPlay) {
        heroPlay.dataset.trackId = track.trackId;
        heroPlay.dataset.title = track.title;
        heroPlay.dataset.artist = track.artist;
        heroPlay.dataset.thumb = track.artworkUrl || 'assets/img/default-track.jpg';
        heroPlay.dataset.audio = track.audioFileUrl;
    }

    // Update document title
    document.title = track.title + ' - ' + track.artist + ' | BeatFlow';

    // Update play count
    const playStats = document.querySelector('.stats-pill span');
    if (playStats && track.playCount) {
        playStats.innerHTML = '<i class="bi bi-play-fill"></i> ' + formatNumber(track.playCount);
    }
}

/**
 * Update hero play button state
 */
function updateHeroPlayButton(isPlaying) {
    const heroPlay = document.getElementById('heroPlay');
    if (heroPlay) {
        const icon = heroPlay.querySelector('i');
        if (isPlaying) {
            icon.classList.remove('bi-play-fill');
            icon.classList.add('bi-pause-fill');
        } else {
            icon.classList.remove('bi-pause-fill');
            icon.classList.add('bi-play-fill');
        }
    }
}

/**
 * Initialize comment section
 */
function initCommentSection() {
    const cmtInput = document.querySelector('.cmt-input input');
    const sendBtn = document.querySelector('.btn-send');

    if (cmtInput && sendBtn) {
        sendBtn.addEventListener('click', function() {
            const text = cmtInput.value.trim();
            if (text) {
                submitComment(text);
                cmtInput.value = '';
            }
        });

        cmtInput.addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                sendBtn.click();
            }
        });
    }

    // Sort button
    const sortBtn = document.getElementById('sortBtn');
    if (sortBtn) {
        sortBtn.addEventListener('click', function() {
            // Toggle sort dropdown
            const currentText = sortBtn.textContent;
            if (currentText.includes('Newest')) {
                sortBtn.innerHTML = 'Sorted by: Oldest <i class="bi bi-chevron-down"></i>';
            } else {
                sortBtn.innerHTML = 'Sorted by: Newest <i class="bi bi-chevron-down"></i>';
            }
        });
    }
}

/**
 * Submit a comment
 */
function submitComment(text) {
    const urlParams = new URLSearchParams(window.location.search);
    const trackId = urlParams.get('id');

    if (!trackId) {
        showNotification('Không thể gửi bình luận', 'error');
        return;
    }

    fetch('api/comments', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            trackId: trackId,
            content: text
        }),
        credentials: 'include'
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            showNotification('Đã đăng bình luận');
            // Add comment to UI
            addCommentToUI(data.comment || { content: text });
        } else {
            showNotification(data.error || 'Không thể đăng bình luận', 'error');
        }
    })
    .catch(error => {
        console.error('Error submitting comment:', error);
        showNotification('Lỗi khi gửi bình luận', 'error');
    });
}

/**
 * Add a new comment to the UI
 */
function addCommentToUI(comment) {
    const commentsContainer = document.querySelector('.track-main');
    const cmtSort = document.querySelector('.cmt-sort');
    
    if (!commentsContainer || !cmtSort) return;

    const commentDiv = document.createElement('div');
    commentDiv.className = 'comment';
    commentDiv.innerHTML = `
        <img src="assets/img/profile_avatar.jpg" class="cmt-avt big" alt="">
        <div class="cmt-body">
            <div class="cmt-meta"><span class="name">Bạn</span> <span class="time">· vừa xong</span></div>
            <div class="cmt-text">${escapeHtml(comment.content)}</div>
            <div class="cmt-actions-row">
                <button class="mini"><i class="bi bi-heart"></i> 0</button>
                <button class="mini">Reply</button>
            </div>
        </div>
    `;

    // Insert after cmt-sort
    cmtSort.insertAdjacentElement('afterend', commentDiv);
}

/**
 * Initialize action buttons (like, repost, share)
 */
function initActionButtons() {
    // Like button
    const likeBtn = document.querySelector('.cmt-actions .btn-act:first-child');
    if (likeBtn) {
        likeBtn.addEventListener('click', function() {
            toggleLike(this);
        });
    }

    // Share button
    const shareBtn = document.querySelector('.cmt-actions .btn-act:nth-child(3)');
    if (shareBtn) {
        shareBtn.addEventListener('click', function() {
            shareTrack();
        });
    }

    // Follow button
    const followBtn = document.querySelector('.btn-follow');
    if (followBtn) {
        followBtn.addEventListener('click', function() {
            toggleFollow(this);
        });
    }
}

/**
 * Toggle like on track
 */
function toggleLike(button) {
    const urlParams = new URLSearchParams(window.location.search);
    const trackId = urlParams.get('id');

    if (!trackId) return;

    fetch('api/favorites/toggle', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ trackId: trackId }),
        credentials: 'include'
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            const icon = button.querySelector('i');
            if (data.favorited) {
                icon.classList.remove('bi-heart');
                icon.classList.add('bi-heart-fill');
                button.classList.add('active');
                showNotification('Đã thêm vào yêu thích');
            } else {
                icon.classList.remove('bi-heart-fill');
                icon.classList.add('bi-heart');
                button.classList.remove('active');
                showNotification('Đã bỏ yêu thích');
            }
        }
    })
    .catch(error => {
        console.error('Error toggling like:', error);
    });
}

/**
 * Share track
 */
function shareTrack() {
    if (navigator.share) {
        navigator.share({
            title: document.title,
            url: window.location.href
        }).catch(err => console.log('Share cancelled'));
    } else {
        // Fallback: copy to clipboard
        navigator.clipboard.writeText(window.location.href)
            .then(() => showNotification('Đã sao chép liên kết'))
            .catch(() => showNotification('Không thể sao chép liên kết', 'error'));
    }
}

/**
 * Toggle follow
 */
function toggleFollow(button) {
    const isFollowing = button.classList.contains('following');
    
    if (isFollowing) {
        button.classList.remove('following');
        button.textContent = 'Follow';
        showNotification('Đã bỏ theo dõi');
    } else {
        button.classList.add('following');
        button.textContent = 'Following';
        showNotification('Đã theo dõi');
    }
}

/**
 * Format number for display
 */
function formatNumber(num) {
    if (num >= 1000000) {
        return (num / 1000000).toFixed(2) + 'M';
    } else if (num >= 1000) {
        return (num / 1000).toFixed(1) + 'K';
    }
    return num.toString();
}

/**
 * Escape HTML
 */
function escapeHtml(text) {
    if (!text) return '';
    const div = document.createElement('div');
    div.textContent = text;
    return div.innerHTML;
}

/**
 * Show notification
 */
function showNotification(message, type = 'success') {
    const alertClass = type === 'error' ? 'alert-danger' : 'alert-success';
    const alertDiv = document.createElement('div');
    alertDiv.className = 'alert ' + alertClass + ' alert-dismissible fade show position-fixed';
    alertDiv.style.cssText = 'bottom: 100px; right: 20px; z-index: 10001; max-width: 300px;';
    alertDiv.innerHTML = message + '<button type="button" class="btn-close" data-bs-dismiss="alert"></button>';
    document.body.appendChild(alertDiv);
    setTimeout(() => alertDiv.remove(), 3000);
}
