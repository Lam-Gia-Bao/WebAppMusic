package dao;

import model.Track;
import service.Database;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class FavoriteDAO {

    public boolean isFavorited(long userId, long trackId) {
        String sql = "SELECT 1 FROM favorites WHERE user_id=? AND track_id=?";
        try (Connection c = Database.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setLong(1, userId);
            ps.setLong(2, trackId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi kiểm tra yêu thích: " + e.getMessage(), e);
        }
    }

    public void addFavorite(long userId, long trackId) {
        String sql = "INSERT IGNORE INTO favorites(user_id, track_id) VALUES(?,?)";
        try (Connection c = Database.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setLong(1, userId);
            ps.setLong(2, trackId);
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Không thể thêm yêu thích: " + e.getMessage(), e);
        }
    }

    public void removeFavorite(long userId, long trackId) {
        String sql = "DELETE FROM favorites WHERE user_id=? AND track_id=?";
        try (Connection c = Database.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setLong(1, userId);
            ps.setLong(2, trackId);
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Không thể bỏ yêu thích: " + e.getMessage(), e);
        }
    }

    public List<Track> findFavoritesByUser(long userId) {
        String sql = "SELECT t.track_id, t.title, t.artist, t.artwork_url, t.duration, t.user_id "
                + "FROM favorites f JOIN tracks t ON f.track_id = t.track_id WHERE f.user_id=? ORDER BY f.created_at DESC";
        List<Track> list = new ArrayList<>();
        try (Connection c = Database.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setLong(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Track t = new Track();
                    t.setTrackId(rs.getInt("track_id"));
                    t.setTitle(rs.getString("title"));
                    t.setArtist(rs.getString("artist"));
                    t.setArtworkUrl(rs.getString("artwork_url"));
                    t.setDuration(rs.getInt("duration"));
                    t.setUserId(rs.getInt("user_id"));
                    list.add(t);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Không thể truy vấn danh sách yêu thích: " + e.getMessage(), e);
        }
        return list;
    }
}
