package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import model.Playlist;
import model.Track;
import model.User;
import service.Database;

/**
 * Admin DAO - Data Access Object cho các thao tác quản trị
 */
public class AdminDAO {

    // ==================== USER MANAGEMENT ====================

    /**
     * Lấy tất cả người dùng
     */
    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT user_id, username, email, full_name, profile_image, bio, role, created_at, updated_at FROM users ORDER BY created_at DESC";
        
        try (Connection conn = Database.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setFullName(rs.getString("full_name"));
                user.setProfileImage(rs.getString("profile_image"));
                user.setBio(rs.getString("bio"));
                user.setRole(rs.getString("role"));
                user.setCreatedAt(rs.getTimestamp("created_at"));
                user.setUpdatedAt(rs.getTimestamp("updated_at"));
                users.add(user);
            }
        } catch (SQLException e) {
            System.err.println("Error getting all users: " + e.getMessage());
            e.printStackTrace();
        }
        return users;
    }

    /**
     * Lấy người dùng theo ID
     */
    public User getUserById(int userId) {
        String sql = "SELECT user_id, username, email, full_name, profile_image, bio, role, created_at, updated_at FROM users WHERE user_id = ?";
        
        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setFullName(rs.getString("full_name"));
                user.setProfileImage(rs.getString("profile_image"));
                user.setBio(rs.getString("bio"));
                user.setRole(rs.getString("role"));
                user.setCreatedAt(rs.getTimestamp("created_at"));
                user.setUpdatedAt(rs.getTimestamp("updated_at"));
                return user;
            }
        } catch (SQLException e) {
            System.err.println("Error getting user by ID: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Cập nhật thông tin người dùng
     */
    public boolean updateUser(User user) {
        String sql = "UPDATE users SET username = ?, email = ?, full_name = ?, bio = ?, role = ? WHERE user_id = ?";
        
        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getFullName());
            stmt.setString(4, user.getBio());
            stmt.setString(5, user.getRole());
            stmt.setInt(6, user.getUserId());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error updating user: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Xóa người dùng
     */
    public boolean deleteUser(int userId) {
        String sql = "DELETE FROM users WHERE user_id = ?";
        
        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error deleting user: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Thêm người dùng mới
     */
    public boolean createUser(String username, String email, String passwordHash, String fullName, String role) {
        String sql = "INSERT INTO users (username, email, password, full_name, role) VALUES (?, ?, ?, ?, ?)";
        
        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, username);
            stmt.setString(2, email);
            stmt.setString(3, passwordHash);
            stmt.setString(4, fullName);
            stmt.setString(5, role);
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error creating user: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Kiểm tra role của user
     */
    public String getUserRole(String username) {
        String sql = "SELECT role FROM users WHERE username = ?";
        
        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getString("role");
            }
        } catch (SQLException e) {
            System.err.println("Error getting user role: " + e.getMessage());
            e.printStackTrace();
        }
        return "user";
    }

    /**
     * Đếm tổng số người dùng
     */
    public int getTotalUsers() {
        String sql = "SELECT COUNT(*) FROM users";
        
        try (Connection conn = Database.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("Error counting users: " + e.getMessage());
            e.printStackTrace();
        }
        return 0;
    }

    // ==================== TRACK MANAGEMENT ====================

    /**
     * Lấy tất cả bài hát
     */
    public List<Track> getAllTracks() {
        List<Track> tracks = new ArrayList<>();
        String sql = "SELECT t.*, u.username as uploader_username FROM tracks t " +
                     "LEFT JOIN users u ON t.user_id = u.user_id ORDER BY t.created_at DESC";
        
        try (Connection conn = Database.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                tracks.add(extractTrackFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting all tracks: " + e.getMessage());
            e.printStackTrace();
        }
        return tracks;
    }

    /**
     * Lấy track theo ID
     */
    public Track getTrackById(int trackId) {
        String sql = "SELECT t.*, u.username as uploader_username FROM tracks t " +
                     "LEFT JOIN users u ON t.user_id = u.user_id WHERE t.track_id = ?";
        
        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, trackId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return extractTrackFromResultSet(rs);
            }
        } catch (SQLException e) {
            System.err.println("Error getting track by ID: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Cập nhật track
     */
    public boolean updateTrack(Track track) {
        String sql = "UPDATE tracks SET title = ?, artist = ?, genre = ?, tags = ?, " +
                     "description = ?, privacy = ? WHERE track_id = ?";
        
        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, track.getTitle());
            stmt.setString(2, track.getArtist());
            stmt.setString(3, track.getGenre());
            stmt.setString(4, track.getTags());
            stmt.setString(5, track.getDescription());
            stmt.setString(6, track.getPrivacy());
            stmt.setInt(7, track.getTrackId());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error updating track: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Xóa track
     */
    public boolean deleteTrack(int trackId) {
        String sql = "DELETE FROM tracks WHERE track_id = ?";
        
        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, trackId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error deleting track: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Đếm tổng số bài hát
     */
    public int getTotalTracks() {
        String sql = "SELECT COUNT(*) FROM tracks";
        
        try (Connection conn = Database.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("Error counting tracks: " + e.getMessage());
            e.printStackTrace();
        }
        return 0;
    }

    /**
     * Lấy top bài hát được nghe nhiều nhất
     */
    public List<Track> getTopPlayedTracks(int limit) {
        List<Track> tracks = new ArrayList<>();
        String sql = "SELECT t.*, u.username as uploader_username FROM tracks t " +
                     "LEFT JOIN users u ON t.user_id = u.user_id " +
                     "ORDER BY t.play_count DESC LIMIT ?";
        
        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, limit);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                tracks.add(extractTrackFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting top played tracks: " + e.getMessage());
            e.printStackTrace();
        }
        return tracks;
    }

    // ==================== PLAYLIST MANAGEMENT ====================

    /**
     * Lấy tất cả playlist
     */
    public List<Playlist> getAllPlaylists() {
        List<Playlist> playlists = new ArrayList<>();
        String sql = "SELECT p.playlist_id, p.name, p.description, p.artwork_url, p.is_public, " +
                     "p.user_id, u.username, p.created_at, " +
                     "(SELECT COUNT(*) FROM playlist_tracks pt WHERE pt.playlist_id = p.playlist_id) as track_count " +
                     "FROM playlists p LEFT JOIN users u ON p.user_id = u.user_id ORDER BY p.created_at DESC";
        
        try (Connection conn = Database.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Playlist playlist = new Playlist();
                playlist.setId(rs.getLong("playlist_id"));
                playlist.setName(rs.getString("name"));
                playlist.setDescription(rs.getString("description"));
                playlist.setArtworkUrl(rs.getString("artwork_url"));
                playlist.setPublic(rs.getBoolean("is_public"));
                playlist.setTrackCount(rs.getInt("track_count"));
                playlist.setUserId(rs.getLong("user_id"));
                playlist.setOwnerUsername(rs.getString("username"));
                playlist.setCreatedAt(rs.getTimestamp("created_at"));
                playlists.add(playlist);
            }
        } catch (SQLException e) {
            System.err.println("Error getting all playlists: " + e.getMessage());
            e.printStackTrace();
        }
        return playlists;
    }

    /**
     * Lấy playlist theo ID
     */
    public Playlist getPlaylistById(long playlistId) {
        String sql = "SELECT p.playlist_id, p.name, p.description, p.artwork_url, p.is_public, " +
                     "p.user_id, u.username, p.created_at, " +
                     "(SELECT COUNT(*) FROM playlist_tracks pt WHERE pt.playlist_id = p.playlist_id) as track_count " +
                     "FROM playlists p LEFT JOIN users u ON p.user_id = u.user_id WHERE p.playlist_id = ?";
        
        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setLong(1, playlistId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                Playlist playlist = new Playlist();
                playlist.setId(rs.getLong("playlist_id"));
                playlist.setName(rs.getString("name"));
                playlist.setDescription(rs.getString("description"));
                playlist.setArtworkUrl(rs.getString("artwork_url"));
                playlist.setPublic(rs.getBoolean("is_public"));
                playlist.setTrackCount(rs.getInt("track_count"));
                playlist.setUserId(rs.getLong("user_id"));
                playlist.setOwnerUsername(rs.getString("username"));
                playlist.setCreatedAt(rs.getTimestamp("created_at"));
                return playlist;
            }
        } catch (SQLException e) {
            System.err.println("Error getting playlist by ID: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Cập nhật playlist
     */
    public boolean updatePlaylist(Playlist playlist) {
        String sql = "UPDATE playlists SET name = ?, description = ?, is_public = ? WHERE playlist_id = ?";
        
        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, playlist.getName());
            stmt.setString(2, playlist.getDescription());
            stmt.setBoolean(3, playlist.isPublic());
            stmt.setLong(4, playlist.getId());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error updating playlist: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Xóa playlist
     */
    public boolean deletePlaylist(long playlistId) {
        String sql = "DELETE FROM playlists WHERE playlist_id = ?";
        
        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setLong(1, playlistId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error deleting playlist: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Đếm tổng số playlist
     */
    public int getTotalPlaylists() {
        String sql = "SELECT COUNT(*) FROM playlists";
        
        try (Connection conn = Database.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("Error counting playlists: " + e.getMessage());
            e.printStackTrace();
        }
        return 0;
    }

    // ==================== STATISTICS ====================

    /**
     * Lấy thống kê người dùng hoạt động nhiều nhất (dựa trên lịch sử nghe)
     */
    public List<Map<String, Object>> getMostActiveUsers(int limit) {
        List<Map<String, Object>> result = new ArrayList<>();
        String sql = "SELECT u.user_id, u.username, u.profile_image, COUNT(h.history_id) as activity_count " +
                     "FROM users u LEFT JOIN listening_history h ON u.user_id = h.user_id " +
                     "GROUP BY u.user_id ORDER BY activity_count DESC LIMIT ?";
        
        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, limit);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Map<String, Object> data = new HashMap<>();
                data.put("userId", rs.getInt("user_id"));
                data.put("username", rs.getString("username"));
                data.put("profileImage", rs.getString("profile_image"));
                data.put("activityCount", rs.getInt("activity_count"));
                result.add(data);
            }
        } catch (SQLException e) {
            System.err.println("Error getting most active users: " + e.getMessage());
            e.printStackTrace();
        }
        return result;
    }

    /**
     * Lấy thống kê lượt nghe theo ngày trong 30 ngày gần nhất
     */
    public List<Map<String, Object>> getPlayStatsByDay(int days) {
        List<Map<String, Object>> result = new ArrayList<>();
        String sql = "SELECT DATE(played_at) as play_date, COUNT(*) as play_count " +
                     "FROM listening_history " +
                     "WHERE played_at >= DATE_SUB(CURDATE(), INTERVAL ? DAY) " +
                     "GROUP BY DATE(played_at) ORDER BY play_date ASC";
        
        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, days);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Map<String, Object> data = new HashMap<>();
                data.put("date", rs.getString("play_date"));
                data.put("count", rs.getInt("play_count"));
                result.add(data);
            }
        } catch (SQLException e) {
            System.err.println("Error getting play stats by day: " + e.getMessage());
            e.printStackTrace();
        }
        return result;
    }

    /**
     * Lấy thống kê người dùng mới theo ngày
     */
    public List<Map<String, Object>> getNewUsersByDay(int days) {
        List<Map<String, Object>> result = new ArrayList<>();
        String sql = "SELECT DATE(created_at) as reg_date, COUNT(*) as user_count " +
                     "FROM users " +
                     "WHERE created_at >= DATE_SUB(CURDATE(), INTERVAL ? DAY) " +
                     "GROUP BY DATE(created_at) ORDER BY reg_date ASC";
        
        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, days);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Map<String, Object> data = new HashMap<>();
                data.put("date", rs.getString("reg_date"));
                data.put("count", rs.getInt("user_count"));
                result.add(data);
            }
        } catch (SQLException e) {
            System.err.println("Error getting new users by day: " + e.getMessage());
            e.printStackTrace();
        }
        return result;
    }

    /**
     * Tổng số lượt nghe
     */
    public int getTotalPlays() {
        String sql = "SELECT SUM(play_count) FROM tracks";
        
        try (Connection conn = Database.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("Error counting total plays: " + e.getMessage());
            e.printStackTrace();
        }
        return 0;
    }

    // ==================== HELPER METHODS ====================

    private Track extractTrackFromResultSet(ResultSet rs) throws SQLException {
        Track track = new Track();
        track.setTrackId(rs.getInt("track_id"));
        track.setUserId(rs.getInt("user_id"));
        track.setTitle(rs.getString("title"));
        track.setTrackLink(rs.getString("track_link"));
        track.setArtist(rs.getString("artist"));
        track.setGenre(rs.getString("genre"));
        track.setTags(rs.getString("tags"));
        track.setDescription(rs.getString("description"));
        track.setPrivacy(rs.getString("privacy"));
        track.setArtworkUrl(rs.getString("artwork_url"));
        track.setAudioFileUrl(rs.getString("audio_file_url"));
        track.setDuration(rs.getInt("duration"));
        track.setPlayCount(rs.getInt("play_count"));
        track.setLikeCount(rs.getInt("like_count"));
        track.setBuyLink(rs.getString("buy_link"));
        track.setReleaseDate(rs.getString("release_date"));
        track.setRecordLabel(rs.getString("record_label"));
        track.setPublisher(rs.getString("publisher"));
        track.setCreatedAt(rs.getTimestamp("created_at"));
        track.setUpdatedAt(rs.getTimestamp("updated_at"));
        track.setUploaderUsername(rs.getString("uploader_username"));
        return track;
    }
}
