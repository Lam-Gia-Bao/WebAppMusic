package service;

import java.util.List;

import dao.ArtistDAO;
import model.Artist;

/**
 * Artist Service - business logic for artists
 */
public class ArtistService {
    private final ArtistDAO dao = new ArtistDAO();

    /**
     * Get recommended artists for home page
     */
    public List<Artist> getRecommendedArtists(String username, int limit) {
        return dao.findRecommended(limit);
    }

    /**
     * Get artist by ID
     */
    public Artist getArtistById(long artistId) {
        return dao.findById(artistId);
    }

    /**
     * Search artists
     */
    public List<Artist> searchArtists(String keyword, int limit) {
        return dao.search(keyword, limit);
    }

    /**
     * Follow an artist (stub - needs follows table logic)
     */
    public boolean followArtist(String username, long artistId) {
        // TODO: Implement follow logic with follows table
        return true;
    }

    /**
     * Unfollow an artist
     */
    public boolean unfollowArtist(String username, long artistId) {
        // TODO: Implement unfollow logic
        return true;
    }
}
