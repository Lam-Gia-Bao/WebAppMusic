package controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.google.gson.Gson;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Track;
import service.FavoriteService;
import service.TrackService;

/**
 * API Servlet xử lý các yêu cầu liên quan đến Tracks
 * Hỗ trợ: lấy danh sách, phát, thích
 */
@WebServlet(name = "TrackAPIServlet", urlPatterns = {"/api/tracks", "/api/tracks/*"})
public class TrackAPIServlet extends HttpServlet {
    private Gson gson = new Gson();
    private TrackService trackService = new TrackService();
    private FavoriteService favoriteService = new FavoriteService();
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setContentType("application/json; charset=UTF-8");
        
        HttpSession session = request.getSession(false);
        String username = session != null ? (String) session.getAttribute("user") : null;
        long userId = 0;
        if (username != null) {
            userId = userDAO.findUserIdByUsername(username).orElse(0L);
        }
        
        String pathInfo = request.getPathInfo();
        
        try {
            if (pathInfo == null || pathInfo.equals("/")) {
                // GET /api/tracks - lấy danh sách tracks trending
                int limit = 20;
                String limitParam = request.getParameter("limit");
                if (limitParam != null) {
                    try { limit = Integer.parseInt(limitParam); } catch (NumberFormatException e) {}
                }
                List<Track> tracks = trackService.getRecommendedTracks(limit);
                response.getWriter().write(gson.toJson(toTracksWithFavorite(tracks, userId)));
            } else if (pathInfo.equals("/trending")) {
                // GET /api/tracks/trending
                List<Track> tracks = trackService.getRecommendedTracks(10);
                response.getWriter().write(gson.toJson(toTracksWithFavorite(tracks, userId)));
            } else if (pathInfo.equals("/recent")) {
                // GET /api/tracks/recent - most recent uploads
                List<Track> tracks = trackService.getAllPublicTracks();
                // Already sorted by upload date in DAO
                int limit = Math.min(tracks.size(), 10);
                response.getWriter().write(gson.toJson(toTracksWithFavorite(tracks.subList(0, limit), userId)));
            } else if (pathInfo.equals("/search")) {
                // GET /api/tracks/search?q=keyword
                String keyword = request.getParameter("q");
                if (keyword != null && !keyword.isEmpty()) {
                    List<Track> tracks = trackService.searchTracks(keyword);
                    response.getWriter().write(gson.toJson(toTracksWithFavorite(tracks, userId)));
                } else {
                    sendJsonError(response, 400, "Missing search query");
                }
            } else if (pathInfo.matches("/\\d+")) {
                // GET /api/tracks/{id}
                long trackId = Long.parseLong(pathInfo.substring(1));
                Track track = trackService.getTrackById(trackId);
                if (track != null) {
                    response.getWriter().write(gson.toJson(trackToMap(track, userId)));
                } else {
                    sendJsonError(response, 404, "Track not found");
                }
            } else {
                sendJsonError(response, 400, "Invalid request");
            }
        } catch (Exception e) {
            e.printStackTrace();
            sendJsonError(response, 500, "Error: " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setContentType("application/json; charset=UTF-8");
        
        HttpSession session = request.getSession(false);
        String username = session != null ? (String) session.getAttribute("user") : null;
        
        if (username == null) {
            sendJsonError(response, 401, "Unauthorized");
            return;
        }

        String pathInfo = request.getPathInfo();
        
        try {
            if (pathInfo != null && pathInfo.contains("/play")) {
                // POST /api/tracks/{id}/play
                long trackId = extractTrackId(pathInfo);
                handlePlayTrack(response, trackId);
            } else if (pathInfo != null && pathInfo.contains("/like")) {
                // POST /api/tracks/{id}/like
                long trackId = extractTrackId(pathInfo);
                handleLikeTrack(response, username, trackId);
            } else {
                sendJsonError(response, 400, "Invalid request");
            }
        } catch (Exception e) {
            e.printStackTrace();
            sendJsonError(response, 500, "Error: " + e.getMessage());
        }
    }

    private void handlePlayTrack(HttpServletResponse response, long trackId) 
            throws IOException {
        boolean success = trackService.incrementPlayCount(trackId);
        Track track = trackService.getTrackById(trackId);
        
        Map<String, Object> result = new HashMap<>();
        result.put("success", success);
        result.put("trackId", trackId);
        if (track != null) {
            result.put("title", track.getTitle());
            result.put("artist", track.getArtist());
            result.put("audioUrl", track.getAudioFileUrl());
        }
        response.getWriter().write(gson.toJson(result));
    }

    private void handleLikeTrack(HttpServletResponse response, String username, long trackId) 
            throws IOException {
        // TODO: Implement like logic with FavoriteService
        Map<String, Object> result = new HashMap<>();
        result.put("success", true);
        result.put("trackId", trackId);
        result.put("message", "Track liked");
        response.getWriter().write(gson.toJson(result));
    }

    private long extractTrackId(String pathInfo) {
        // Extract ID from path like /123/play or /123/like
        String[] parts = pathInfo.split("/");
        for (String part : parts) {
            if (part.matches("\\d+")) {
                return Long.parseLong(part);
            }
        }
        return 0;
    }

    private void sendJsonError(HttpServletResponse response, int statusCode, String message) 
            throws IOException {
        response.setStatus(statusCode);
        Map<String, Object> error = new HashMap<>();
        error.put("success", false);
        error.put("error", message);
        response.getWriter().write(gson.toJson(error));
    }

    /**
     * Convert track to map with favorite status
     */
    private Map<String, Object> trackToMap(Track track, long userId) {
        Map<String, Object> map = new HashMap<>();
        map.put("trackId", track.getTrackId());
        map.put("title", track.getTitle());
        map.put("artist", track.getArtist());
        map.put("audioFileUrl", track.getAudioFileUrl());
        map.put("coverImageUrl", track.getArtworkUrl());
        map.put("artworkUrl", track.getArtworkUrl());
        map.put("playCount", track.getPlayCount());
        map.put("duration", track.getDuration());
        map.put("genre", track.getGenre());
        map.put("privacy", track.getPrivacy());
        map.put("userId", track.getUserId());
        // Add favorite status
        if (userId > 0) {
            map.put("favorited", favoriteService.isFavorited(userId, track.getTrackId()));
        } else {
            map.put("favorited", false);
        }
        return map;
    }

    /**
     * Convert list of tracks to list of maps with favorite status
     */
    private List<Map<String, Object>> toTracksWithFavorite(List<Track> tracks, long userId) {
        List<Map<String, Object>> result = new java.util.ArrayList<>();
        for (Track track : tracks) {
            result.add(trackToMap(track, userId));
        }
        return result;
    }
}
