package dao;

import model.Track;
import service.Database;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class HistoryDAO {

    public void addPlay(long userId, long trackId) {
        String sql = "INSERT INTO listening_history(user_id, track_id) VALUES(?, ?)";
        try (Connection c = Database.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setLong(1, userId);
            ps.setLong(2, trackId);
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Không thể lưu lịch sử nghe: " + e.getMessage(), e);
        }
    }

    public List<Track> recentPlays(long userId, int limit) {
        String sql = "SELECT t.track_id, t.title, t.artist, t.artwork_url, t.duration, t.user_id, h.played_at "
                + "FROM listening_history h JOIN tracks t ON h.track_id = t.track_id "
                + "WHERE h.user_id=? ORDER BY h.played_at DESC LIMIT ?";
        List<Track> list = new ArrayList<>();
        try (Connection c = Database.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setLong(1, userId);
            ps.setInt(2, limit);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Track t = new Track();
                    t.setTrackId(rs.getInt("track_id"));
                    t.setTitle(rs.getString("title"));
                    t.setArtist(rs.getString("artist"));
                    t.setArtworkUrl(rs.getString("artwork_url"));
                    t.setDuration(rs.getInt("duration"));
                    t.setUserId(rs.getInt("user_id"));
                    t.setCreatedAt(rs.getTimestamp("played_at"));
                    list.add(t);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Không thể lấy lịch sử nghe: " + e.getMessage(), e);
        }
        return list;
    }
}
