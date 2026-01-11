-- =============================================
-- Update existing data với ảnh local
-- Chạy script này nếu đã có data trong DB
-- =============================================

USE webappmusic;

-- Update profile images cho users
UPDATE users SET profile_image = 'assets/img/user.jpg' WHERE username = 'demo';
UPDATE users SET profile_image = 'assets/img/taylor-swift.png', full_name = 'Taylor Swift' WHERE username = 'artist1';
UPDATE users SET profile_image = 'assets/img/ed-sheeran.jpg', full_name = 'Ed Sheeran' WHERE username = 'artist2';
UPDATE users SET profile_image = 'assets/img/drake.jpg', full_name = 'Drake' WHERE username = 'artist3';

-- Update artwork cho tracks
UPDATE tracks SET artwork_url = 'assets/img/ca-phe_song.jpg' WHERE track_id = 1;
UPDATE tracks SET artwork_url = 'assets/img/kem-duyen_song.jpg' WHERE track_id = 2;
UPDATE tracks SET artwork_url = 'assets/img/kem-duyen-drill_song.jpg' WHERE track_id = 3;
UPDATE tracks SET artwork_url = 'assets/img/pop-playlist.jpg' WHERE track_id = 4;
UPDATE tracks SET artwork_url = 'assets/img/pop2-playlist.png' WHERE track_id = 5;
UPDATE tracks SET artwork_url = 'assets/img/viet-playlist.jpg' WHERE track_id = 6;
UPDATE tracks SET artwork_url = 'assets/img/edm-playlist.jpg' WHERE track_id = 7;
UPDATE tracks SET artwork_url = 'assets/img/nkl-playlist.jpg' WHERE track_id = 8;
UPDATE tracks SET artwork_url = 'assets/img/nkl2-playlist.jpg' WHERE track_id = 9;
UPDATE tracks SET artwork_url = 'assets/img/rnh-playlist.jpg' WHERE track_id = 10;

-- Update artwork cho playlists
UPDATE playlists SET artwork_url = 'assets/img/rnh2-playlist.jpg' WHERE playlist_id = 1;
UPDATE playlists SET artwork_url = 'assets/img/edm2-playlist.jpg' WHERE playlist_id = 2;
UPDATE playlists SET artwork_url = 'assets/img/pop-playlist.jpg' WHERE playlist_id = 3;
UPDATE playlists SET artwork_url = 'assets/img/nkl-playlist.jpg' WHERE playlist_id = 4;

-- Kiểm tra kết quả
SELECT 'Users updated:' as Info;
SELECT user_id, username, full_name, profile_image FROM users;

SELECT 'Tracks updated:' as Info;
SELECT track_id, title, artist, artwork_url FROM tracks;

SELECT 'Playlists updated:' as Info;
SELECT playlist_id, name, artwork_url FROM playlists;
