/**
 * BeatFlow Search Page JavaScript
 * Handles search functionality and integrates with BeatFlowPlayer
 */

document.addEventListener('DOMContentLoaded', function() {
    initSearchPage();
});

function initSearchPage() {
    // Initialize filter tabs
    initFilterTabs();
    
    // Initialize play buttons
    initPlayButtons();
    
    // Initialize search form
    initSearchForm();
}

/**
 * Initialize filter tabs
 */
function initFilterTabs() {
    const filterList = document.getElementById('filterList');
    if (!filterList) return;

    const filterItems = filterList.querySelectorAll('.filter-item');
    
    filterItems.forEach(item => {
        item.addEventListener('click', function() {
            // Remove active from all
            filterItems.forEach(f => f.classList.remove('active'));
            // Add active to clicked
            this.classList.add('active');
            
            const target = this.dataset.target;
            filterResults(target);
        });
    });
}

/**
 * Filter search results by type
 */
function filterResults(type) {
    const sections = document.querySelectorAll('.result-section, .featured');
    
    sections.forEach(section => {
        if (type === 'all') {
            section.style.display = '';
        } else {
            const sectionType = section.dataset.type;
            section.style.display = (sectionType === type) ? '' : 'none';
        }
    });
}

/**
 * Initialize play buttons for search results
 */
function initPlayButtons() {
    // Featured playlist play button
    const btnPlayLg = document.querySelector('.btn-play-lg');
    if (btnPlayLg) {
        btnPlayLg.addEventListener('click', function() {
            const playlistId = this.dataset.playlistId;
            const artist = this.dataset.playArtist;
            const title = this.dataset.playTitle;
            const thumb = this.dataset.playSrc;
            
            if (playlistId) {
                playPlaylist(playlistId);
            } else {
                // Play featured content
                showNotification('Đang phát: ' + title);
            }
        });
    }

    // Track play buttons
    document.addEventListener('click', function(e) {
        // Card play buttons
        if (e.target.closest('.btn-play')) {
            const btn = e.target.closest('.btn-play');
            const card = btn.closest('.playlist-card, .track-card');
            if (!card) return;
            
            e.preventDefault();
            e.stopPropagation();
            
            const trackId = btn.dataset.trackId || card.dataset.trackId;
            const playlistId = btn.dataset.playlistId || card.dataset.playlistId;
            
            if (trackId) {
                playTrack(trackId);
            } else if (playlistId) {
                playPlaylist(playlistId);
            }
        }
        
        // Featured track items
        if (e.target.closest('.featured-tracks li')) {
            const li = e.target.closest('.featured-tracks li');
            const trackId = li.dataset.trackId;
            if (trackId) {
                playTrack(trackId);
            }
        }
    });
}

/**
 * Play a track by ID
 */
function playTrack(trackId) {
    fetch('api/tracks/' + trackId, {
        method: 'GET',
        headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json'
        },
        credentials: 'include'
    })
    .then(response => {
        if (!response.ok) throw new Error('Failed to load track');
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
        }
    })
    .catch(error => {
        console.error('Error playing track:', error);
        showNotification('Không thể phát bài hát', 'error');
    });
}

/**
 * Play a playlist by ID
 */
function playPlaylist(playlistId) {
    fetch('api/playlists/' + playlistId + '/tracks', {
        method: 'GET',
        headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json'
        },
        credentials: 'include'
    })
    .then(response => response.json())
    .then(data => {
        if (data.tracks && data.tracks.length > 0) {
            // Load first track and queue the rest
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
                // Add rest to queue
                for (let i = 1; i < tracks.length; i++) {
                    BeatFlowPlayer.addToQueue(tracks[i]);
                }
            }
            
            showNotification('Đang phát playlist: ' + (data.name || 'Playlist'));
        } else {
            showNotification('Playlist trống', 'error');
        }
    })
    .catch(error => {
        console.error('Error playing playlist:', error);
        showNotification('Không thể phát playlist', 'error');
    });
}

/**
 * Initialize search form
 */
function initSearchForm() {
    const searchInput = document.querySelector('.search-input, .nav-search-input');
    
    if (searchInput) {
        let searchTimeout;
        
        searchInput.addEventListener('input', function() {
            clearTimeout(searchTimeout);
            searchTimeout = setTimeout(() => {
                const query = this.value.trim();
                if (query.length >= 2) {
                    performSearch(query);
                }
            }, 500);
        });
        
        searchInput.addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                clearTimeout(searchTimeout);
                const query = this.value.trim();
                if (query) {
                    performSearch(query);
                }
            }
        });
    }
}

/**
 * Perform search
 */
function performSearch(query) {
    // Update URL
    const url = new URL(window.location);
    url.searchParams.set('q', query);
    window.history.pushState({}, '', url);
    
    // Update title
    const srTitle = document.querySelector('.sr-title');
    if (srTitle) {
        srTitle.textContent = 'Search results for "' + query + '"';
    }
    
    // Search tracks
    fetch('api/search?q=' + encodeURIComponent(query), {
        method: 'GET',
        headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json'
        },
        credentials: 'include'
    })
    .then(response => response.json())
    .then(data => {
        updateSearchResults(data);
    })
    .catch(error => {
        console.error('Error searching:', error);
    });
}

/**
 * Update search results on page
 */
function updateSearchResults(data) {
    // Update counts
    const srMeta = document.querySelector('.sr-meta');
    if (srMeta) {
        const trackCount = data.tracks ? data.tracks.length : 0;
        const playlistCount = data.playlists ? data.playlists.length : 0;
        const peopleCount = data.users ? data.users.length : 0;
        srMeta.textContent = `Found ${playlistCount}+ playlists, ${trackCount}+ tracks, ${peopleCount}+ people`;
    }
    
    // Update track results
    if (data.tracks) {
        updateTrackResults(data.tracks);
    }
}

/**
 * Update track results section
 */
function updateTrackResults(tracks) {
    const tracksSection = document.querySelector('[data-type="tracks"] .card-row');
    if (!tracksSection) return;
    
    tracksSection.innerHTML = '';
    
    tracks.forEach(track => {
        const card = document.createElement('a');
        card.href = 'track?id=' + track.trackId;
        card.className = 'playlist-card';
        card.dataset.trackId = track.trackId;
        
        card.innerHTML = `
            <div class="playlist-img-wrapper">
                <img src="${track.artworkUrl || 'assets/img/default-track.jpg'}" 
                     class="playlist-img" alt="${escapeHtml(track.title)}">
                <button class="btn-play" data-track-id="${track.trackId}">
                    <i class="bi bi-play-fill"></i>
                </button>
            </div>
            <div class="playlist-title">${escapeHtml(track.title)}</div>
            <div class="playlist-desc">${escapeHtml(track.artist || '')}</div>
        `;
        
        tracksSection.appendChild(card);
    });
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
