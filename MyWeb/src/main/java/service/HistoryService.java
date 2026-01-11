package service;

import java.util.Arrays;
import java.util.List;

public class HistoryService {
    public List<String> getHistory(long userId) {
        // Demo data
        return Arrays.asList("Played X", "Played Y", "Played Z");
    }

    public void recordPlaylistListen(String username, long playlistId) {
        // Placeholder: no playlist history table yet
    }

    /**
     * Record track play in listening_history
     */
    public boolean addPlay(long userId, long trackId) {
        // TODO: Implement database insert to listening_history table
        return true;
    }
}