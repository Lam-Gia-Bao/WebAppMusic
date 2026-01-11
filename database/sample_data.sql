-- =============================================
-- Sample Data cho WebAppMusic
-- Chạy script này sau khi đã chạy create_database.sql
-- =============================================

USE webappmusic;

-- =============================================
-- Sample Users (nếu chưa có)
-- Password mặc định là "123456" (đã hash SHA-256)
-- =============================================
INSERT IGNORE INTO users (username, password, email, full_name, bio, profile_image) VALUES
('demo', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 'demo@example.com', 'Demo User', 'Tài khoản demo để test', 'assets/img/user.jpg'),
('artist1', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 'artist1@example.com', 'Taylor Swift', 'Ca sĩ Pop nổi tiếng', 'assets/img/taylor-swift.png'),
('artist2', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 'artist2@example.com', 'Ed Sheeran', 'Ca sĩ kiêm nhạc sĩ', 'assets/img/ed-sheeran.jpg'),
('artist3', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 'artist3@example.com', 'Drake', 'Rapper và ca sĩ', 'assets/img/drake.jpg');

-- =============================================
-- Sample Tracks - Sử dụng ảnh local
-- =============================================
INSERT INTO tracks (user_id, title, artist, genre, tags, description, privacy, artwork_url, audio_file_url, duration, play_count, like_count) VALUES
-- Tracks của artist1 (Taylor Swift)
((SELECT user_id FROM users WHERE username='artist1'), 'Cà Phê', 'Taylor Swift', 'Pop', 'vpop,ballad,tình yêu', 'Bài hát về nỗi nhớ đêm khuya', 'public', 'assets/img/ca-phe_song.jpg', 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3', 210, 1523, 89),
((SELECT user_id FROM users WHERE username='artist1'), 'Kém Duyên', 'Taylor Swift', 'Ballad', 'vpop,buồn', 'Khi tình yêu tan vỡ', 'public', 'assets/img/kem-duyen_song.jpg', 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3', 245, 892, 56),
((SELECT user_id FROM users WHERE username='artist1'), 'Kém Duyên Drill', 'Taylor Swift', 'Pop', 'vpop,drill', 'Drill remix version', 'public', 'assets/img/kem-duyen-drill_song.jpg', 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3', 198, 2341, 134),

-- Tracks của artist2 (Ed Sheeran)
((SELECT user_id FROM users WHERE username='artist2'), 'Perfect Night', 'Ed Sheeran', 'Pop', 'pop,love,acoustic', 'A perfect love song', 'public', 'assets/img/pop-playlist.jpg', 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-4.mp3', 312, 5621, 423),
((SELECT user_id FROM users WHERE username='artist2'), 'Summer Vibes', 'Ed Sheeran', 'Pop', 'pop,summer', 'Summer anthem', 'public', 'assets/img/pop2-playlist.png', 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-5.mp3', 278, 8934, 612),
((SELECT user_id FROM users WHERE username='artist2'), 'Acoustic Dreams', 'Ed Sheeran', 'Acoustic', 'acoustic,chill,relax', 'Relaxing acoustic', 'public', 'assets/img/viet-playlist.jpg', 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-6.mp3', 185, 12453, 891),
((SELECT user_id FROM users WHERE username='artist2'), 'EDM Night', 'Ed Sheeran', 'EDM', 'edm,party', 'Party track', 'public', 'assets/img/edm-playlist.jpg', 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-7.mp3', 234, 3421, 267),

-- Tracks của artist3 (Drake)
((SELECT user_id FROM users WHERE username='artist3'), 'City Lights', 'Drake', 'Hip-hop', 'rap,hiphop,city', 'City vibes', 'public', 'assets/img/nkl-playlist.jpg', 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-8.mp3', 256, 4532, 321),
((SELECT user_id FROM users WHERE username='artist3'), 'Midnight Flow', 'Drake', 'Rap', 'rap,night', 'Midnight stories', 'public', 'assets/img/nkl2-playlist.jpg', 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-9.mp3', 289, 6721, 456),
((SELECT user_id FROM users WHERE username='artist3'), 'No Limits', 'Drake', 'Hip-hop', 'rap,freestyle', 'Freestyle session', 'public', 'assets/img/rnh-playlist.jpg', 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-10.mp3', 198, 2134, 178);

-- =============================================
-- Sample Playlists - Sử dụng ảnh local
-- =============================================
INSERT INTO playlists (user_id, name, description, artwork_url, is_public) VALUES
((SELECT user_id FROM users WHERE username='demo'), 'Nhạc Chill Cuối Tuần', 'Playlist thư giãn cho cuối tuần', 'assets/img/rnh2-playlist.jpg', TRUE),
((SELECT user_id FROM users WHERE username='demo'), 'Workout Mix', 'Nhạc tập gym sôi động', 'assets/img/edm2-playlist.jpg', TRUE),
((SELECT user_id FROM users WHERE username='artist2'), 'Best of Pop 2025', 'Tuyển tập Pop hay nhất', 'assets/img/pop-playlist.jpg', TRUE),
((SELECT user_id FROM users WHERE username='artist3'), 'Rap Việt Underground', 'Những bản rap underground đỉnh cao', 'assets/img/nkl-playlist.jpg', TRUE);

-- =============================================
-- Add tracks to playlists
-- =============================================
INSERT INTO playlist_tracks (playlist_id, track_id, position) VALUES
-- Playlist "Nhạc Chill Cuối Tuần"
(1, 3, 1), (1, 6, 2), (1, 1, 3),
-- Playlist "Workout Mix"  
(2, 4, 1), (2, 5, 2), (2, 7, 3),
-- Playlist "Best of EDM 2025"
(3, 4, 1), (3, 5, 2), (3, 6, 3), (3, 7, 4),
-- Playlist "Rap Việt Underground"
(4, 8, 1), (4, 9, 2), (4, 10, 3);

-- =============================================
-- Sample Favorites (cho user demo)
-- =============================================
INSERT INTO favorites (user_id, track_id) VALUES
((SELECT user_id FROM users WHERE username='demo'), 1),
((SELECT user_id FROM users WHERE username='demo'), 4),
((SELECT user_id FROM users WHERE username='demo'), 6),
((SELECT user_id FROM users WHERE username='demo'), 9);

-- =============================================
-- Sample Listening History (cho user demo)
-- =============================================
INSERT INTO listening_history (user_id, track_id, played_at) VALUES
((SELECT user_id FROM users WHERE username='demo'), 1, NOW() - INTERVAL 1 HOUR),
((SELECT user_id FROM users WHERE username='demo'), 4, NOW() - INTERVAL 2 HOUR),
((SELECT user_id FROM users WHERE username='demo'), 6, NOW() - INTERVAL 3 HOUR),
((SELECT user_id FROM users WHERE username='demo'), 5, NOW() - INTERVAL 1 DAY),
((SELECT user_id FROM users WHERE username='demo'), 9, NOW() - INTERVAL 2 DAY);

-- =============================================
-- Sample Follows
-- =============================================
INSERT INTO follows (follower_id, following_id) VALUES
((SELECT user_id FROM users WHERE username='demo'), (SELECT user_id FROM users WHERE username='artist1')),
((SELECT user_id FROM users WHERE username='demo'), (SELECT user_id FROM users WHERE username='artist2')),
((SELECT user_id FROM users WHERE username='demo'), (SELECT user_id FROM users WHERE username='artist3'));

SELECT 'Sample data inserted successfully!' AS Result;
SELECT CONCAT('Total tracks: ', COUNT(*)) AS Info FROM tracks;
SELECT CONCAT('Total playlists: ', COUNT(*)) AS Info FROM playlists;
SELECT CONCAT('Total users: ', COUNT(*)) AS Info FROM users;
