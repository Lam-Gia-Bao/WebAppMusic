package service;

import java.util.Arrays;
import java.util.List;

import model.Playlist;

public class PlaylistService {
    public List<Playlist> getPlaylists(long userId) {
        // Demo data
        return Arrays.asList(
                new Playlist(1, "Chill Vibes", 12),
                new Playlist(2, "Workout Mix", 20)
        );
    }
}