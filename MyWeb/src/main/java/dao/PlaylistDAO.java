package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Playlist;
import service.Database;

public class PlaylistDAO {

	public List<Playlist> findByUserId(long userId) {
		String sql = "SELECT playlist_id, name, description, artwork_url, is_public FROM playlists WHERE user_id=?";
		List<Playlist> list = new ArrayList<>();
		try (Connection c = Database.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
			ps.setLong(1, userId);
			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					list.add(mapRow(rs));
				}
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		return list;
	}

	public List<Playlist> findRecommended(int limit) {
		String sql = "SELECT playlist_id, name, description, artwork_url, is_public FROM playlists WHERE is_public = TRUE ORDER BY created_at DESC LIMIT ?";
		List<Playlist> list = new ArrayList<>();
		try (Connection c = Database.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
			ps.setInt(1, limit);
			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					list.add(mapRow(rs));
				}
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		return list;
	}

	public Playlist findById(long playlistId) {
		String sql = "SELECT playlist_id, name, description, artwork_url, is_public FROM playlists WHERE playlist_id=?";
		try (Connection c = Database.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
			ps.setLong(1, playlistId);
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					return mapRow(rs);
				}
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		return null;
	}

	public List<String> findTracksInPlaylist(long playlistId) {
		String sql = "SELECT t.title FROM playlist_tracks pt JOIN tracks t ON pt.track_id = t.track_id WHERE pt.playlist_id=? ORDER BY pt.position ASC, pt.added_at DESC";
		List<String> tracks = new ArrayList<>();
		try (Connection c = Database.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
			ps.setLong(1, playlistId);
			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					tracks.add(rs.getString("title"));
				}
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		return tracks;
	}

	public void addTrackToPlaylist(long playlistId, long trackId) {
		String insert = "INSERT INTO playlist_tracks(playlist_id, track_id) VALUES(?, ?) ON DUPLICATE KEY UPDATE track_id = track_id";
		try (Connection c = Database.getConnection(); PreparedStatement ps = c.prepareStatement(insert)) {
			ps.setLong(1, playlistId);
			ps.setLong(2, trackId);
			ps.executeUpdate();
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	public long createPlaylist(long userId, String name, String description, boolean isPublic, String artworkUrl) {
		String sql = "INSERT INTO playlists (user_id, name, description, is_public, artwork_url) VALUES (?, ?, ?, ?, ?)";
		try (Connection c = Database.getConnection(); 
			 PreparedStatement ps = c.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
			ps.setLong(1, userId);
			ps.setString(2, name);
			ps.setString(3, description);
			ps.setBoolean(4, isPublic);
			ps.setString(5, artworkUrl);
			int rows = ps.executeUpdate();
			if (rows > 0) {
				try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
					if (generatedKeys.next()) {
						return generatedKeys.getLong(1);
					}
				}
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		return -1;
	}

	private Playlist mapRow(ResultSet rs) throws SQLException {
		return new Playlist(
				rs.getLong("playlist_id"),
				rs.getString("name"),
				rs.getString("description"),
				rs.getString("artwork_url"),
				rs.getBoolean("is_public"),
				0
		);
	}
}