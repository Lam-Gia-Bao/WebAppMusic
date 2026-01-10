-- =============================================
-- Sample Data cho WebAppMusic
-- Chạy script này sau khi đã chạy create_database.sql
-- =============================================

USE webappmusic;

-- =============================================
-- Sample Users (nếu chưa có)
-- Password mặc định là "123456" (đã hash SHA-256)
-- =============================================
INSERT IGNORE INTO users (username, password, email, full_name, bio) VALUES
('demo', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 'demo@example.com', 'Demo User', 'Tài khoản demo để test'),
('artist1', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 'artist1@example.com', 'Nghệ Sĩ 1', 'Ca sĩ indie Việt Nam'),
('artist2', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 'artist2@example.com', 'DJ Producer', 'Producer nhạc điện tử'),
('artist3', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 'artist3@example.com', 'Rapper VN', 'Underground rapper');

-- =============================================
-- Sample Tracks
-- Sử dụng audio URL giả (có thể thay bằng file thật sau)
-- =============================================
INSERT INTO tracks (user_id, title, artist, genre, tags, description, privacy, artwork_url, audio_file_url, duration, play_count, like_count) VALUES
-- Tracks của artist1
((SELECT user_id FROM users WHERE username='artist1'), 'Đêm Nay Em Ở Đâu', 'Nghệ Sĩ 1', 'Pop', 'vpop,ballad,tình yêu', 'Bài hát về nỗi nhớ đêm khuya', 'public', 'https://picsum.photos/seed/track1/300/300', 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3', 210, 1523, 89),
((SELECT user_id FROM users WHERE username='artist1'), 'Mưa Trên Cuộc Tình', 'Nghệ Sĩ 1', 'Ballad', 'vpop,buồn,mưa', 'Khi tình yêu tan vỡ như cơn mưa', 'public', 'https://picsum.photos/seed/track2/300/300', 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3', 245, 892, 56),
((SELECT user_id FROM users WHERE username='artist1'), 'Nắng Ấm Xa Dần', 'Nghệ Sĩ 1', 'Pop', 'vpop,acoustic', 'Acoustic version đặc biệt', 'public', 'https://picsum.photos/seed/track3/300/300', 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3', 198, 2341, 134),

-- Tracks của artist2 (EDM/Electronic)
((SELECT user_id FROM users WHERE username='artist2'), 'Midnight Vibes', 'DJ Producer', 'Electronic', 'edm,house,club', 'Deep house track for late nights', 'public', 'https://picsum.photos/seed/track4/300/300', 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-4.mp3', 312, 5621, 423),
((SELECT user_id FROM users WHERE username='artist2'), 'Summer Festival', 'DJ Producer', 'EDM', 'edm,festival,summer', 'Festival anthem 2025', 'public', 'https://picsum.photos/seed/track5/300/300', 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-5.mp3', 278, 8934, 612),
((SELECT user_id FROM users WHERE username='artist2'), 'Chill Sunset', 'DJ Producer', 'Lo-fi', 'lofi,chill,relax', 'Perfect for studying', 'public', 'https://picsum.photos/seed/track6/300/300', 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-6.mp3', 185, 12453, 891),
((SELECT user_id FROM users WHERE username='artist2'), 'Bass Drop', 'DJ Producer', 'Dubstep', 'dubstep,bass,heavy', 'Warning: Heavy bass!', 'public', 'https://picsum.photos/seed/track7/300/300', 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-7.mp3', 234, 3421, 267),

-- Tracks của artist3 (Rap/Hip-hop)
((SELECT user_id FROM users WHERE username='artist3'), 'Đường Phố Gọi Tên', 'Rapper VN', 'Hip-hop', 'rap,viet,underground', 'Underground vibes', 'public', 'https://picsum.photos/seed/track8/300/300', 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-8.mp3', 256, 4532, 321),
((SELECT user_id FROM users WHERE username='artist3'), 'Thành Phố Không Ngủ', 'Rapper VN', 'Rap', 'rap,city,night', 'Saigon midnight stories', 'public', 'https://picsum.photos/seed/track9/300/300', 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-9.mp3', 289, 6721, 456),
((SELECT user_id FROM users WHERE username='artist3'), 'Flow Không Giới Hạn', 'Rapper VN', 'Hip-hop', 'rap,flow,freestyle', 'Freestyle session', 'public', 'https://picsum.photos/seed/track10/300/300', 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-10.mp3', 198, 2134, 178);

-- =============================================
-- Sample Playlists
-- =============================================
INSERT INTO playlists (user_id, name, description, artwork_url, is_public) VALUES
((SELECT user_id FROM users WHERE username='demo'), 'Nhạc Chill Cuối Tuần', 'Playlist thư giãn cho cuối tuần', 'https://picsum.photos/seed/pl1/300/300', TRUE),
((SELECT user_id FROM users WHERE username='demo'), 'Workout Mix', 'Nhạc tập gym sôi động', 'https://picsum.photos/seed/pl2/300/300', TRUE),
((SELECT user_id FROM users WHERE username='artist2'), 'Best of EDM 2025', 'Tuyển tập EDM hay nhất', 'https://picsum.photos/seed/pl3/300/300', TRUE),
((SELECT user_id FROM users WHERE username='artist3'), 'Rap Việt Underground', 'Những bản rap underground đỉnh cao', 'https://picsum.photos/seed/pl4/300/300', TRUE);

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
