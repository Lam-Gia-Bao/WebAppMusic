<%-- Right Column: Trending Artists and Listening History --%>
<div class="col-lg-4">
    <h2 class="section-title artist-section-title">Các nghệ sĩ thịnh hành</h2>
    <button class="btn-refresh-artists mb-3">
        <span>Làm mới danh sách</span>
    </button>

    <!-- Artist Cards -->
    <div class="artists-list">
        <div class="artist-card">
            <img src="assets/img/avt_travis-scott.jpg" alt="Travis Scott" class="artist-avatar">
            <div class="artist-info">
                <div class="artist-name">
                    Travis Scott <i class="bi bi-patch-check-fill verified-icon"></i>
                </div>
                <div class="artist-stats">
                    <span><i class="bi bi-people-fill"></i> 5.56M</span>
                    <span><i class="bi bi-music-note-beamed"></i> 174</span>
                </div>
            </div>
            <button class="btn-follow">Theo dõi</button>
        </div>

        <div class="artist-card">
            <img src="assets/img/avt_bad-bunny.jpg" alt="Bad Bunny" class="artist-avatar">
            <div class="artist-info">
                <div class="artist-name">
                    Bad Bunny <i class="bi bi-patch-check-fill verified-icon"></i>
                </div>
                <div class="artist-stats">
                    <span><i class="bi bi-people-fill"></i> 2.51M</span>
                    <span><i class="bi bi-music-note-beamed"></i> 167</span>
                </div>
            </div>
            <button class="btn-follow">Theo dõi</button>
        </div>

        <div class="artist-card">
            <img src="assets/img/avt_doja-cat.png" alt="Doja Cat" class="artist-avatar">
            <div class="artist-info">
                <div class="artist-name">
                    DOJA CAT <i class="bi bi-patch-check-fill verified-icon"></i>
                </div>
                <div class="artist-stats">
                    <span><i class="bi bi-people-fill"></i> 1.73M</span>
                    <span><i class="bi bi-music-note-beamed"></i> 164</span>
                </div>
            </div>
            <button class="btn-follow">Theo dõi</button>
        </div>
    </div>

    <!-- Listening History Section -->
    <div class="listening-history-section mt-5">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h4 class="history-title">Lịch sử nghe nhạc</h4>
            <a href="#" class="view-all-link-small">Xem tất cả</a>
        </div>

        <!-- History Items -->
        <div class="history-list">
            <div class="history-item">
                <div class="history-thumb-wrap">
                    <img src="assets/img/ca-phe_song.jpg" alt="Song thumbnail" class="history-thumbnail">
                    <button class="history-play-btn">
                        <i class="bi bi-play-fill"></i>
                    </button>
                </div>
                <div class="history-info">
                    <div class="history-artist">Lil Liem</div>
                    <div class="history-song-title">uocgianhaynoiyeutoi</div>
                    <div class="history-stats">
                        <span><i class="bi bi-play-fill"></i> 353K</span>
                        <span><i class="bi bi-heart-fill"></i> 3,527</span>
                        <span><i class="bi bi-repeat"></i> 88</span>
                        <span><i class="bi bi-chat"></i> 78</span>
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
                    <img src="assets/img/kem-duyen_song.jpg" alt="Song thumbnail" class="history-thumbnail">
                    <button class="history-play-btn">
                        <i class="bi bi-play-fill"></i>
                    </button>
                </div>
                <div class="history-info">
                    <div class="history-artist">n1ay</div>
                    <div class="history-song-title">KÈM DUYÊN (remix by Higo) (reup on ...</div>
                    <div class="history-stats">
                        <span><i class="bi bi-play-fill"></i> 127K</span>
                        <span><i class="bi bi-heart-fill"></i> 964</span>
                        <span><i class="bi bi-repeat"></i> 10</span>
                        <span><i class="bi bi-chat"></i> 9</span>
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
                    <img src="assets/img/kem-duyen-drill_song.jpg" alt="Song thumbnail" class="history-thumbnail">
                    <button class="history-play-btn">
                        <i class="bi bi-play-fill"></i>
                    </button>
                </div>
                <div class="history-info">
                    <div class="history-artist">Sevenlow</div>
                    <div class="history-song-title">Kem duyen drill mix tiktok</div>
                    <div class="history-stats">
                        <span><i class="bi bi-play-fill"></i> 95.5K</span>
                        <span><i class="bi bi-heart-fill"></i> 851</span>
                        <span><i class="bi bi-repeat"></i> 9</span>
                        <span><i class="bi bi-chat"></i> 7</span>
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