package service;

import java.util.List;

import dao.TrackDAO;
import model.Track;

public class TrackService {
    private final TrackDAO trackDAO = new TrackDAO();

    /**
     * Get all tracks by user ID
     */
    public List<Track> getAllTracksByUser(long userId) {
        return trackDAO.getTracksByUserId((int) userId);
    }

    /**
     * Count tracks by user
     */
    public int countTracks(long userId) {
        return getAllTracksByUser(userId).size();
    }

    /**
     * Get all public tracks (for homepage/discover)
     */
    public List<Track> getAllPublicTracks() {
        return trackDAO.getAllPublicTracks();
    }

    /**
     * Get recommended/trending tracks
     */
    public List<Track> getRecommendedTracks(int limit) {
        List<Track> tracks = trackDAO.getAllPublicTracks();
        // Sort by play count (trending)
        tracks.sort((a, b) -> Integer.compare(b.getPlayCount(), a.getPlayCount()));
        return tracks.size() > limit ? tracks.subList(0, limit) : tracks;
    }

    /**
     * Get track by ID
     */
    public Track getTrackById(long trackId) {
        return trackDAO.getTrackById((int) trackId);
    }

    /**
     * Search tracks
     */
    public List<Track> searchTracks(String keyword) {
        return trackDAO.searchTracks(keyword);
    }

    /**
     * Search tracks with limit
     */
    public List<Track> searchTracks(String keyword, int limit) {
        List<Track> tracks = trackDAO.searchTracks(keyword);
        return tracks.size() > limit ? tracks.subList(0, limit) : tracks;
    }

    /**
     * Increment play count when track is played
     */
    public boolean incrementPlayCount(long trackId) {
        return trackDAO.incrementPlayCount((int) trackId);
    }

    /**
     * Create new track
     */
    public boolean createTrack(Track track) {
        return trackDAO.createTrack(track);
    }

    /**
     * Update track
     */
    public boolean updateTrack(Track track) {
        return trackDAO.updateTrack(track);
    }

    /**
     * Delete track
     */
    public boolean deleteTrack(long trackId) {
        return trackDAO.deleteTrack((int) trackId);
    }
}