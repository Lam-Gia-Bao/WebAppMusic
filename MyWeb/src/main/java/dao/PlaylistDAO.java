package dao;

import model.Playlist;
import service.Database;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PlaylistDAO {

	public List<Playlist> findByUserId(long userId) {
		String sql = "SELECT id, name, COALESCE(track_count,0) AS track_count FROM playlists WHERE user_id=?";
		List<Playlist> list = new ArrayList<>();
		try (Connection c = Database.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
			ps.setLong(1, userId);
			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					list.add(new Playlist(rs.getLong("id"), rs.getString("name"), rs.getInt("track_count")));
				}
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		return list;
	}

	public List<String> findTracksInPlaylist(long playlistId) {
		String sql = "SELECT title FROM playlist_tracks WHERE playlist_id=? ORDER BY created_at DESC";
		List<String> tracks = new ArrayList<>();
		try (Connection c = Database.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
			ps.setLong(1, playlistId);
			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next())
					tracks.add(rs.getString("title"));
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		return tracks;
	}

	public void addTrackToPlaylist(long playlistId, String title) {
		String insert = "INSERT INTO playlist_tracks(playlist_id, title) VALUES(?, ?)";
		String updateCount = "UPDATE playlists SET track_count = COALESCE(track_count,0) + 1 WHERE id=?";
		try (Connection c = Database.getConnection();
				PreparedStatement ps = c.prepareStatement(insert);
				PreparedStatement up = c.prepareStatement(updateCount)) {
			ps.setLong(1, playlistId);
			ps.setString(2, title);
			ps.executeUpdate();
			up.setLong(1, playlistId);
			up.executeUpdate();
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
}