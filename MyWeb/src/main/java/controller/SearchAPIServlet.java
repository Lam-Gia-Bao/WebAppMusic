package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.google.gson.Gson;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import service.PlaylistService;
import service.TrackService;

/**
 * API Servlet xử lý tìm kiếm (search)
 */
@WebServlet(name = "SearchAPIServlet", urlPatterns = {"/api/search/*"})
public class SearchAPIServlet extends HttpServlet {
    private TrackService trackService;
    private PlaylistService playlistService;
    private Gson gson = new Gson();

    @Override
    public void init() throws ServletException {
        this.trackService = new TrackService();
        this.playlistService = new PlaylistService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setContentType("application/json; charset=UTF-8");
        
        HttpSession session = request.getSession(false);
        String username = session != null ? (String) session.getAttribute("user") : null;
        
        String pathInfo = request.getPathInfo();
        String query = request.getParameter("q");
        String type = request.getParameter("type"); // "track", "playlist", "artist", "all"
        
        try {
            if (pathInfo != null && pathInfo.contains("/suggestions")) {
                // GET /api/search/suggestions?q=keyword
                if (query != null && !query.isEmpty()) {
                    List<Map<String, Object>> suggestions = getSearchSuggestions(query);
                    response.getWriter().write(gson.toJson(suggestions));
                } else {
                    sendJsonError(response, 400, "Query parameter required");
                }
            } else {
                // GET /api/search?q=keyword&type=...
                if (query != null && !query.isEmpty()) {
                    Map<String, Object> results = performSearch(query, type);
                    response.getWriter().write(gson.toJson(results));
                } else {
                    sendJsonError(response, 400, "Query parameter required");
                }
            }
        } catch (Exception e) {
            sendJsonError(response, 500, "Error: " + e.getMessage());
        }
    }

    private List<Map<String, Object>> getSearchSuggestions(String query) {
        List<Map<String, Object>> suggestions = new ArrayList<>();
        
        try {
            // Tìm bài hát
            var tracks = trackService.searchTracks(query, 5);
            for (var track : tracks) {
                Map<String, Object> suggestion = new HashMap<>();
                suggestion.put("id", track.getTrackId());
                suggestion.put("name", track.getTitle());
                suggestion.put("type", "track");
                suggestion.put("image", track.getArtworkUrl());
                suggestions.add(suggestion);
            }
            
            // Tìm playlist
            var playlists = playlistService.searchPlaylists(query, 5);
            for (var playlist : playlists) {
                Map<String, Object> suggestion = new HashMap<>();
                suggestion.put("id", playlist.getId());
                suggestion.put("name", playlist.getName());
                suggestion.put("type", "playlist");
                suggestion.put("image", playlist.getImagePath());
                suggestions.add(suggestion);
            }
        } catch (Exception e) {
            System.err.println("Error getting search suggestions: " + e.getMessage());
        }
        
        return suggestions;
    }

    private Map<String, Object> performSearch(String query, String type) {
        Map<String, Object> results = new HashMap<>();
        
        try {
            if (type == null || type.equals("all") || type.equals("track")) {
                var tracks = trackService.searchTracks(query, 50);
                results.put("tracks", tracks);
            }
            
            if (type == null || type.equals("all") || type.equals("playlist")) {
                var playlists = playlistService.searchPlaylists(query, 50);
                results.put("playlists", playlists);
            }
            
            if (type == null || type.equals("all") || type.equals("artist")) {
                // TODO: Implement artist search
                results.put("artists", new ArrayList<>());
            }
        } catch (Exception e) {
            System.err.println("Error performing search: " + e.getMessage());
        }
        
        return results;
    }

    private void sendJsonError(HttpServletResponse response, int statusCode, String message) 
            throws IOException {
        response.setStatus(statusCode);
        Map<String, Object> error = new HashMap<>();
        error.put("success", false);
        error.put("error", message);
        response.getWriter().write(gson.toJson(error));
    }
}
