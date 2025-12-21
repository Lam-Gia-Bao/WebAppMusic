-- =============================================
-- WebAppMusic Database Creation Script
-- MySQL Database
-- =============================================

-- Create database
CREATE DATABASE IF NOT EXISTS webappmusic CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE webappmusic;

-- =============================================
-- Table: users
-- =============================================
CREATE TABLE IF NOT EXISTS users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    full_name VARCHAR(100),
    profile_image VARCHAR(255),
    bio TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_username (username),
    INDEX idx_email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================================
-- Table: tracks
-- =============================================
CREATE TABLE IF NOT EXISTS tracks (
    track_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    title VARCHAR(200) NOT NULL,
    track_link VARCHAR(255),
    artist VARCHAR(200),
    genre VARCHAR(100),
    tags VARCHAR(500),
    description TEXT,
    privacy ENUM('public', 'private', 'schedule') DEFAULT 'public',
    artwork_url VARCHAR(255),
    audio_file_url VARCHAR(255) NOT NULL,
    duration INT, -- duration in seconds
    play_count INT DEFAULT 0,
    like_count INT DEFAULT 0,
    buy_link VARCHAR(255),
    release_date DATE,
    record_label VARCHAR(100),
    publisher VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    INDEX idx_user_id (user_id),
    INDEX idx_title (title),
    INDEX idx_genre (genre),
    INDEX idx_privacy (privacy),
    INDEX idx_created_at (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================================
-- Table: playlists
-- =============================================
CREATE TABLE IF NOT EXISTS playlists (
    playlist_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    name VARCHAR(200) NOT NULL,
    description TEXT,
    artwork_url VARCHAR(255),
    is_public BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    INDEX idx_user_id (user_id),
    INDEX idx_name (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================================
-- Table: playlist_tracks
-- =============================================
CREATE TABLE IF NOT EXISTS playlist_tracks (
    playlist_track_id INT AUTO_INCREMENT PRIMARY KEY,
    playlist_id INT NOT NULL,
    track_id INT NOT NULL,
    position INT DEFAULT 0,
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (playlist_id) REFERENCES playlists(playlist_id) ON DELETE CASCADE,
    FOREIGN KEY (track_id) REFERENCES tracks(track_id) ON DELETE CASCADE,
    UNIQUE KEY unique_playlist_track (playlist_id, track_id),
    INDEX idx_playlist_id (playlist_id),
    INDEX idx_track_id (track_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================================
-- Table: favorites
-- =============================================
CREATE TABLE IF NOT EXISTS favorites (
    favorite_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    track_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (track_id) REFERENCES tracks(track_id) ON DELETE CASCADE,
    UNIQUE KEY unique_user_track (user_id, track_id),
    INDEX idx_user_id (user_id),
    INDEX idx_track_id (track_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================================
-- Table: listening_history
-- =============================================
CREATE TABLE IF NOT EXISTS listening_history (
    history_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    track_id INT NOT NULL,
    played_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (track_id) REFERENCES tracks(track_id) ON DELETE CASCADE,
    INDEX idx_user_id (user_id),
    INDEX idx_track_id (track_id),
    INDEX idx_played_at (played_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================================
-- Table: follows
-- =============================================
CREATE TABLE IF NOT EXISTS follows (
    follow_id INT AUTO_INCREMENT PRIMARY KEY,
    follower_id INT NOT NULL,
    following_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (follower_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (following_id) REFERENCES users(user_id) ON DELETE CASCADE,
    UNIQUE KEY unique_follow (follower_id, following_id),
    INDEX idx_follower_id (follower_id),
    INDEX idx_following_id (following_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================================
-- Table: comments
-- =============================================
CREATE TABLE IF NOT EXISTS comments (
    comment_id INT AUTO_INCREMENT PRIMARY KEY,
    track_id INT NOT NULL,
    user_id INT NOT NULL,
    comment_text TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (track_id) REFERENCES tracks(track_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    INDEX idx_track_id (track_id),
    INDEX idx_user_id (user_id),
    INDEX idx_created_at (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================================
-- Insert Sample Data
-- =============================================

-- Sample users (password: 'password123' - should be hashed in production)
INSERT INTO users (username, password, email, full_name, bio) VALUES
('john_doe', 'password123', 'john@example.com', 'John Doe', 'Music lover and producer'),
('jane_smith', 'password123', 'jane@example.com', 'Jane Smith', 'Singer and songwriter'),
('admin', 'admin123', 'admin@webappmusic.com', 'Admin User', 'System Administrator');

-- Sample tracks
INSERT INTO tracks (user_id, title, artist, genre, tags, description, privacy, play_count, like_count) VALUES
(1, 'Summer Vibes', 'John Doe', 'Electronic', 'summer,chill,electronic', 'A chill summer track', 'public', 1500, 120),
(1, 'Night Drive', 'John Doe', 'Synthwave', 'night,drive,synthwave', 'Perfect for night drives', 'public', 2300, 180),
(2, 'Acoustic Dreams', 'Jane Smith', 'Acoustic', 'acoustic,indie,calm', 'Simple acoustic melody', 'public', 890, 75);

-- Sample playlists
INSERT INTO playlists (user_id, name, description, is_public) VALUES
(1, 'My Favorites', 'Collection of my favorite tracks', TRUE),
(2, 'Chill Mix', 'Relaxing music for studying', TRUE);

-- Sample playlist tracks
INSERT INTO playlist_tracks (playlist_id, track_id, position) VALUES
(1, 1, 1),
(1, 2, 2),
(2, 3, 1);

-- Sample favorites
INSERT INTO favorites (user_id, track_id) VALUES
(1, 2),
(2, 1),
(2, 3);

-- Sample listening history
INSERT INTO listening_history (user_id, track_id) VALUES
(1, 1),
(1, 2),
(2, 3);

-- =============================================
-- Verify Tables Created
-- =============================================
SHOW TABLES;
