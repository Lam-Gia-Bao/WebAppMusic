package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Artist;
import service.Database;

/**
 * Artist DAO - queries users who have uploaded tracks (artists)
 */
public class ArtistDAO {

    /**
     * Get recommended/popular artists (users with most tracks/followers)
     */
    public List<Artist> findRecommended(int limit) {
        List<Artist> artists = new ArrayList<>();
        String sql = "SELECT u.user_id, u.username, u.full_name, u.profile_image, u.bio, " +
                     "(SELECT COUNT(*) FROM tracks t WHERE t.user_id = u.user_id) as track_count, " +
                     "(SELECT COUNT(*) FROM follows f WHERE f.following_id = u.user_id) as follower_count " +
                     "FROM users u " +
                     "WHERE EXISTS (SELECT 1 FROM tracks t WHERE t.user_id = u.user_id) " +
                     "ORDER BY track_count DESC, follower_count DESC " +
                     "LIMIT ?";
        
        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, limit);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                artists.add(mapRow(rs));
            }
            
        } catch (SQLException e) {
            System.err.println("Error getting recommended artists: " + e.getMessage());
            e.printStackTrace();
        }
        return artists;
    }

    /**
     * Get artist by ID
     */
    public Artist findById(long userId) {
        String sql = "SELECT u.user_id, u.username, u.full_name, u.profile_image, u.bio, " +
                     "(SELECT COUNT(*) FROM tracks t WHERE t.user_id = u.user_id) as track_count, " +
                     "(SELECT COUNT(*) FROM follows f WHERE f.following_id = u.user_id) as follower_count " +
                     "FROM users u WHERE u.user_id = ?";
        
        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setLong(1, userId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return mapRow(rs);
            }
            
        } catch (SQLException e) {
            System.err.println("Error getting artist by ID: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Search artists by name/username
     */
    public List<Artist> search(String keyword, int limit) {
        List<Artist> artists = new ArrayList<>();
        String sql = "SELECT u.user_id, u.username, u.full_name, u.profile_image, u.bio, " +
                     "(SELECT COUNT(*) FROM tracks t WHERE t.user_id = u.user_id) as track_count, " +
                     "(SELECT COUNT(*) FROM follows f WHERE f.following_id = u.user_id) as follower_count " +
                     "FROM users u " +
                     "WHERE (u.username LIKE ? OR u.full_name LIKE ?) " +
                     "ORDER BY track_count DESC " +
                     "LIMIT ?";
        
        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            String pattern = "%" + keyword + "%";
            stmt.setString(1, pattern);
            stmt.setString(2, pattern);
            stmt.setInt(3, limit);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                artists.add(mapRow(rs));
            }
            
        } catch (SQLException e) {
            System.err.println("Error searching artists: " + e.getMessage());
            e.printStackTrace();
        }
        return artists;
    }

    private Artist mapRow(ResultSet rs) throws SQLException {
        Artist artist = new Artist();
        artist.setId(rs.getLong("user_id"));
        artist.setUsername(rs.getString("username"));
        artist.setName(rs.getString("full_name") != null ? rs.getString("full_name") : rs.getString("username"));
        artist.setImagePath(rs.getString("profile_image"));
        artist.setBio(rs.getString("bio"));
        artist.setTrackCount(rs.getInt("track_count"));
        artist.setFollowerCount(rs.getInt("follower_count"));
        return artist;
    }
}
