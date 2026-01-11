package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Playlist;
import model.Track;
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

	public List<Track> findTracksWithDetails(long playlistId) {
		String sql = """
			SELECT t.track_id, t.user_id, t.title, t.track_link, t.artist, t.genre, t.tags,
			       t.description, t.privacy, t.artwork_url, t.audio_file_url, t.duration,
			       t.play_count, t.like_count, t.buy_link, t.release_date, t.record_label,
			       t.publisher, t.created_at, t.updated_at, u.username as uploader_username
			FROM playlist_tracks pt
			JOIN tracks t ON pt.track_id = t.track_id
			LEFT JOIN users u ON t.user_id = u.user_id
			WHERE pt.playlist_id = ?
			ORDER BY pt.position ASC, pt.added_at DESC
		""";
		List<Track> tracks = new ArrayList<>();
		try (Connection c = Database.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
			ps.setLong(1, playlistId);
			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
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
					tracks.add(track);
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