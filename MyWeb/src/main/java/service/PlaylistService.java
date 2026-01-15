package service;

import java.util.ArrayList;
import java.util.List;

import dao.PlaylistDAO;
import dao.TrackDAO;
import model.Playlist;
import model.Track;

public class PlaylistService {
	private final PlaylistDAO dao = new PlaylistDAO();
	private final TrackDAO trackDAO = new TrackDAO();

	public List<Playlist> getPlaylists(long userId) {
		return dao.findByUserId(userId);
	}

	public List<Playlist> getRecommendedPlaylists(String username, int limit) {
		return dao.findRecommended(limit);
	}

	public Playlist getPlaylistById(long playlistId) {
		return dao.findById(playlistId);
	}

	public java.util.List<String> getTracksInPlaylist(long playlistId) {
		return dao.findTracksInPlaylist(playlistId);
	}

	/**
	 * Get full Track objects in a playlist
	 */
	public List<Track> getPlaylistTracks(long playlistId) {
		return dao.findTracksWithDetails(playlistId);
	}

	       public void addTrackToPlaylist(long playlistId, long trackId) {
		       dao.addTrackToPlaylist(playlistId, trackId);
		       // Nếu playlist chưa có hình, cập nhật artwork bằng hình của bài hát đầu tiên
		       Playlist playlist = dao.findById(playlistId);
		       if (playlist != null && (playlist.getArtworkUrl() == null || playlist.getArtworkUrl().isBlank())) {
			       Track track = trackDAO.getTrackById((int) trackId);
			       if (track != null && track.getArtworkUrl() != null && !track.getArtworkUrl().isBlank()) {
				       // Cập nhật artwork cho playlist
				       dao.updatePlaylist(playlistId, playlist.getUserId(), playlist.getName(), playlist.getDescription(), playlist.isPublic(), track.getArtworkUrl());
			       }
		       }
	}

	/**
	 * Add track to playlist at specific position
	 */
	public void addTrackToPlaylist(long playlistId, long trackId, Integer position) {
		// TODO: Implement position support in DAO
		dao.addTrackToPlaylist(playlistId, trackId);
	}

	public boolean followPlaylist(String username, long playlistId) {
		// No follow table for playlists yet; return success to avoid breaking UI.
		return true;
	}

	/**
	 * Create a new playlist
	 */
	       public long createPlaylist(long userId, String name, String description, boolean isPublic, String artworkUrl, List<Long> trackIds) {
		       String finalArtwork = artworkUrl;
		       // Nếu không có artworkUrl, lấy artwork của bài hát đầu tiên (nếu có track)
		       if ((artworkUrl == null || artworkUrl.isBlank()) && trackIds != null && !trackIds.isEmpty()) {
			       Track firstTrack = trackDAO.getTrackById(trackIds.get(0).intValue());
			       if (firstTrack != null && firstTrack.getArtworkUrl() != null && !firstTrack.getArtworkUrl().isBlank()) {
				       finalArtwork = firstTrack.getArtworkUrl();
			       }
		       }
		       long playlistId = dao.createPlaylist(userId, name, description, isPublic, finalArtwork);
		       // Thêm các track vào playlist nếu có
		       if (playlistId > 0 && trackIds != null) {
			       for (Long tid : trackIds) {
				       dao.addTrackToPlaylist(playlistId, tid);
			       }
		       }
		       return playlistId;
	}

	/**
	 * Search playlists
	 */
	public List<Playlist> searchPlaylists(String keyword, int limit) {
		// TODO: Implement search in DAO
		return new ArrayList<>();
	}

	/**
	 * Delete a playlist (only owner can delete)
	 */
	public boolean deletePlaylist(long playlistId, long userId) {
		return dao.deletePlaylist(playlistId, userId);
	}

	/**
	 * Remove a track from playlist
	 */
	public boolean removeTrackFromPlaylist(long playlistId, long trackId) {
		return dao.removeTrackFromPlaylist(playlistId, trackId);
	}

	/**
	 * Update playlist info
	 */
	public boolean updatePlaylist(long playlistId, long userId, String name, String description, boolean isPublic, String artworkUrl) {
		return dao.updatePlaylist(playlistId, userId, name, description, isPublic, artworkUrl);
	}

	/**
	 * Check if user owns the playlist
	 */
	public boolean isOwner(long playlistId, long userId) {
		return dao.getPlaylistOwnerId(playlistId) == userId;
	}
}