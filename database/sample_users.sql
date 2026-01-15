-- =============================================
-- Sample Users Data for WebAppMusic
-- Run this script to add test users
-- =============================================

USE webappmusic;

-- First, add role column if not exists
ALTER TABLE users ADD COLUMN IF NOT EXISTS role VARCHAR(20) DEFAULT 'user' AFTER bio;

-- Insert sample users (password is hashed version of '123456')
-- Using SHA-256 hash for password '123456'
INSERT INTO users (username, password, email, full_name, profile_image, bio, role) VALUES
('admin', 'e10adc3949ba59abbe56e057f20f883e', 'admin@webappmusic.com', 'Administrator', 'assets/img/profile_avatar.jpg', 'System Administrator', 'admin'),
('demo', 'e10adc3949ba59abbe56e057f20f883e', 'demo@webappmusic.com', 'Demo User', 'assets/img/profile_avatar.jpg', 'This is a demo account', 'user'),
('john_doe', 'e10adc3949ba59abbe56e057f20f883e', 'john@example.com', 'John Doe', 'assets/img/profile_avatar.jpg', 'Music lover and producer', 'user'),
('jane_smith', 'e10adc3949ba59abbe56e057f20f883e', 'jane@example.com', 'Jane Smith', 'assets/img/profile_avatar.jpg', 'Singer and songwriter', 'user'),
('dj_producer', 'e10adc3949ba59abbe56e057f20f883e', 'dj@example.com', 'DJ Producer', 'assets/img/profile_avatar.jpg', 'Electronic music producer', 'user'),
('rapper_vn', 'e10adc3949ba59abbe56e057f20f883e', 'rapper@example.com', 'Rapper VN', 'assets/img/profile_avatar.jpg', 'Vietnamese rapper', 'user'),
('indie_artist', 'e10adc3949ba59abbe56e057f20f883e', 'indie@example.com', 'Indie Artist', 'assets/img/profile_avatar.jpg', 'Independent music artist', 'user'),
('music_fan', 'e10adc3949ba59abbe56e057f20f883e', 'fan@example.com', 'Music Fan', 'assets/img/profile_avatar.jpg', 'I love listening to music!', 'user'),
('beat_maker', 'e10adc3949ba59abbe56e057f20f883e', 'beats@example.com', 'Beat Maker', 'assets/img/profile_avatar.jpg', 'Creating beats since 2020', 'user'),
('vocal_queen', 'e10adc3949ba59abbe56e057f20f883e', 'vocal@example.com', 'Vocal Queen', 'assets/img/profile_avatar.jpg', 'Professional vocalist', 'user')
ON DUPLICATE KEY UPDATE role = VALUES(role);

-- Verify inserted data
SELECT user_id, username, email, full_name, role, created_at FROM users ORDER BY user_id;
