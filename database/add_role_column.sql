USE webappmusic;

-- Add role column if not exists
ALTER TABLE users ADD COLUMN IF NOT EXISTS role VARCHAR(20) DEFAULT 'user' AFTER bio;

-- Insert sample users (password: 123456, SHA-256 hash)
INSERT INTO users (username, password, email, full_name, profile_image, bio, role) VALUES
('admin', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 'admin@webappmusic.com', 'Administrator', 'assets/img/profile_avatar.jpg', 'System Administrator', 'admin'),
('demo', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 'demo@webappmusic.com', 'Demo User', 'assets/img/profile_avatar.jpg', 'This is a demo account', 'user'),
('john_doe', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 'john@example.com', 'John Doe', 'assets/img/profile_avatar.jpg', 'Music lover and producer', 'user'),
('jane_smith', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 'jane@example.com', 'Jane Smith', 'assets/img/profile_avatar.jpg', 'Singer and songwriter', 'user'),
('dj_producer', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 'dj@example.com', 'DJ Producer', 'assets/img/profile_avatar.jpg', 'Electronic music producer', 'user'),
('rapper_vn', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 'rapper@example.com', 'Rapper VN', 'assets/img/profile_avatar.jpg', 'Vietnamese rapper', 'user'),
('indie_artist', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 'indie@example.com', 'Indie Artist', 'assets/img/profile_avatar.jpg', 'Independent music artist', 'user'),
('music_fan', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 'fan@example.com', 'Music Fan', 'assets/img/profile_avatar.jpg', 'I love listening to music!', 'user'),
('beat_maker', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 'beats@example.com', 'Beat Maker', 'assets/img/profile_avatar.jpg', 'Creating beats since 2020', 'user'),
('vocal_queen', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 'vocal@example.com', 'Vocal Queen', 'assets/img/profile_avatar.jpg', 'Professional vocalist', 'user')
ON DUPLICATE KEY UPDATE role = VALUES(role);