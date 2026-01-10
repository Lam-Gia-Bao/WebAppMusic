package service;

import java.util.List;

import dao.FavoriteDAO;
import model.Track;

public class FavoriteService {
    private final FavoriteDAO dao = new FavoriteDAO();

    public List<Track> getFavorites(long userId) {
        return dao.findFavoritesByUser(userId);
    }

    /**
     * Check if track is favorited
     */
    public boolean isFavorited(long userId, long trackId) {
        return dao.isFavorited(userId, trackId);
    }

    /**
     * Add to favorites
     */
    public void addFavorite(long userId, long trackId) {
        dao.addFavorite(userId, trackId);
    }

    /**
     * Remove from favorites
     */
    public void removeFavorite(long userId, long trackId) {
        dao.removeFavorite(userId, trackId);
    }

    /**
     * Toggle favorite status
     */
    public boolean toggleFavorite(long userId, long trackId) {
        if (dao.isFavorited(userId, trackId)) {
            dao.removeFavorite(userId, trackId);
            return false; // now not favorited
        } else {
            dao.addFavorite(userId, trackId);
            return true; // now favorited
        }
    }
}