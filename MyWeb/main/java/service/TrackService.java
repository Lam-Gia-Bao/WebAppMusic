package service;

import java.util.Arrays;
import java.util.List;

public class TrackService {
    public List<String> getAllTracksByUser(long userId) {
        // Demo data
        return Arrays.asList("Track A", "Track B", "Track C");
    }
    public int countTracks(long userId) {
        return getAllTracksByUser(userId).size();
    }
}