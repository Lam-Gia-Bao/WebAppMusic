package service;

import java.util.ArrayList;
import java.util.List;

import dao.PlaylistDAO;
import model.Playlist;

public class PlaylistService {
	private final PlaylistDAO dao = new PlaylistDAO();

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

	public void addTrackToPlaylist(long playlistId, long trackId) {
		dao.addTrackToPlaylist(playlistId, trackId);
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
	public long createPlaylist(long userId, String name, String description, boolean isPublic, String artworkUrl) {
		return dao.createPlaylist(userId, name, description, isPublic, artworkUrl);
	}

	/**
	 * Search playlists
	 */
	public List<Playlist> searchPlaylists(String keyword, int limit) {
		// TODO: Implement search in DAO
		return new ArrayList<>();
	}
}