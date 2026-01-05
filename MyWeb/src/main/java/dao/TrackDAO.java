package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import model.Track;
import service.Database;

/**
 * Track DAO (Data Access Object)
 * Handles all database operations for Track entity
 */
public class TrackDAO {
    
    /**
     * Create a new track in the database
     */
    public boolean createTrack(Track track) {
        String sql = "INSERT INTO tracks (user_id, title, track_link, artist, genre, tags, description, " +
                     "privacy, artwork_url, audio_file_url, buy_link, release_date, record_label, publisher) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setInt(1, track.getUserId());
            stmt.setString(2, track.getTitle());
            stmt.setString(3, track.getTrackLink());
            stmt.setString(4, track.getArtist());
            stmt.setString(5, track.getGenre());
            stmt.setString(6, track.getTags());
            stmt.setString(7, track.getDescription());
            stmt.setString(8, track.getPrivacy());
            stmt.setString(9, track.getArtworkUrl());
            stmt.setString(10, track.getAudioFileUrl());
            stmt.setString(11, track.getBuyLink());
            stmt.setString(12, track.getReleaseDate());
            stmt.setString(13, track.getRecordLabel());
            stmt.setString(14, track.getPublisher());
            
            int rowsAffected = stmt.executeUpdate();
            
            if (rowsAffected > 0) {
                ResultSet rs = stmt.getGeneratedKeys();
                if (rs.next()) {
                    track.setTrackId(rs.getInt(1));
                }
                return true;
            }
            
        } catch (SQLException e) {
            System.err.println("Error creating track: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }
    
    /**
     * Get track by ID
     */
    public Track getTrackById(int trackId) {
        String sql = "SELECT t.*, u.username as uploader_username FROM tracks t " +
                     "INNER JOIN users u ON t.user_id = u.user_id " +
                     "WHERE t.track_id = ?";
        
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
     * Get all public tracks
     */
    public List<Track> getAllPublicTracks() {
        List<Track> tracks = new ArrayList<>();
        String sql = "SELECT t.*, u.username as uploader_username FROM tracks t " +
                     "INNER JOIN users u ON t.user_id = u.user_id " +
                     "WHERE t.privacy = 'public' " +
                     "ORDER BY t.created_at DESC";
        
        try (Connection conn = Database.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                tracks.add(extractTrackFromResultSet(rs));
            }
            
        } catch (SQLException e) {
            System.err.println("Error getting all public tracks: " + e.getMessage());
            e.printStackTrace();
        }
        return tracks;
    }
    
    /**
     * Get tracks by user ID
     */
    public List<Track> getTracksByUserId(int userId) {
        List<Track> tracks = new ArrayList<>();
        String sql = "SELECT t.*, u.username as uploader_username FROM tracks t " +
                     "INNER JOIN users u ON t.user_id = u.user_id " +
                     "WHERE t.user_id = ? " +
                     "ORDER BY t.created_at DESC";
        
        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                tracks.add(extractTrackFromResultSet(rs));
            }
            
        } catch (SQLException e) {
            System.err.println("Error getting tracks by user ID: " + e.getMessage());
            e.printStackTrace();
        }
        return tracks;
    }
    
    /**
     * Search tracks by keyword
     */
    public List<Track> searchTracks(String keyword) {
        List<Track> tracks = new ArrayList<>();
        String sql = "SELECT t.*, u.username as uploader_username FROM tracks t " +
                     "INNER JOIN users u ON t.user_id = u.user_id " +
                     "WHERE (t.title LIKE ? OR t.artist LIKE ? OR t.tags LIKE ?) " +
                     "AND t.privacy = 'public' " +
                     "ORDER BY t.play_count DESC";
        
        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            String searchPattern = "%" + keyword + "%";
            stmt.setString(1, searchPattern);
            stmt.setString(2, searchPattern);
            stmt.setString(3, searchPattern);
            
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                tracks.add(extractTrackFromResultSet(rs));
            }
            
        } catch (SQLException e) {
            System.err.println("Error searching tracks: " + e.getMessage());
            e.printStackTrace();
        }
        return tracks;
    }
    
    /**
     * Update track
     */
    public boolean updateTrack(Track track) {
        String sql = "UPDATE tracks SET title = ?, artist = ?, genre = ?, tags = ?, " +
                     "description = ?, privacy = ?, artwork_url = ? WHERE track_id = ?";
        
        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, track.getTitle());
            stmt.setString(2, track.getArtist());
            stmt.setString(3, track.getGenre());
            stmt.setString(4, track.getTags());
            stmt.setString(5, track.getDescription());
            stmt.setString(6, track.getPrivacy());
            stmt.setString(7, track.getArtworkUrl());
            stmt.setInt(8, track.getTrackId());
            
            return stmt.executeUpdate() > 0;
            
        } catch (SQLException e) {
            System.err.println("Error updating track: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }
    
    /**
     * Delete track
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
     * Increment play count
     */
    public boolean incrementPlayCount(int trackId) {
        String sql = "UPDATE tracks SET play_count = play_count + 1 WHERE track_id = ?";
        
        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, trackId);
            return stmt.executeUpdate() > 0;
            
        } catch (SQLException e) {
            System.err.println("Error incrementing play count: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }
    
    /**
     * Helper method to extract Track object from ResultSet
     */
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
