package service;

import java.util.List;

import dao.TrackDAO;
import model.Track;

public class UploadService {
    private final TrackDAO trackDAO = new TrackDAO();
    
    /**
     * Get all tracks uploaded by user (as Track objects)
     */
    public List<Track> getUploadedTracks(long userId) {
        return trackDAO.getTracksByUserId((int) userId);
    }
    
    /**
     * Get uploads as simple strings (for backward compatibility)
     */
    public List<String> getUploads(long userId) {
        List<Track> tracks = getUploadedTracks(userId);
        return tracks.stream()
                .map(t -> t.getTitle() + " - " + t.getArtist())
                .toList();
    }
    
    /**
     * Count uploads by user
     */
    public int countUploads(long userId) {
        return getUploadedTracks(userId).size();
    }
}