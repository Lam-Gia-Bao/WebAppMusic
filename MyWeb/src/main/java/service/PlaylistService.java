package service;

import dao.PlaylistDAO;
import model.Playlist;

import java.util.List;

public class PlaylistService {
	private final PlaylistDAO dao = new PlaylistDAO();

	public List<Playlist> getPlaylists(long userId) {
		return dao.findByUserId(userId);
	}

	public java.util.List<String> getTracksInPlaylist(long playlistId) {
		return dao.findTracksInPlaylist(playlistId);
	}

	public void addTrackToPlaylist(long playlistId, String trackTitle) {
		dao.addTrackToPlaylist(playlistId, trackTitle);
	}
}