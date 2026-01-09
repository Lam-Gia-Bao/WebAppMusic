package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.google.gson.Gson;
import service.PlaylistService;
import service.FavoriteService;
import service.HistoryService;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * API Servlet xử lý các yêu cầu liên quan đến Playlists
 * Hỗ trợ các thao tác: lấy danh sách, phát, yêu thích, theo dõi
 */
@WebServlet(name = "PlaylistAPIServlet", urlPatterns = {"/api/playlists*"})
public class PlaylistAPIServlet extends HttpServlet {
    private PlaylistService playlistService;
    private FavoriteService favoriteService;
    private HistoryService historyService;
    private Gson gson;

    @Override
    public void init() throws ServletException {
        this.playlistService = new PlaylistService();
        this.favoriteService = new FavoriteService();
        this.historyService = new HistoryService();
        this.gson = new Gson();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setContentType("application/json; charset=UTF-8");
        
        // Kiểm tra session
        HttpSession session = request.getSession(false);
        String username = session != null ? (String) session.getAttribute("user") : null;
        
        if (username == null) {
            sendJsonError(response, 401, "Unauthorized");
            return;
        }

        String pathInfo = request.getPathInfo();
        
        try {
            if (pathInfo == null || pathInfo.equals("/")) {
                // GET /api/playlists - lấy danh sách playlists
                var playlists = playlistService.getRecommendedPlaylists(username, 20);
                response.getWriter().write(gson.toJson(playlists));
            } else {
                sendJsonError(response, 400, "Invalid request");
            }
        } catch (Exception e) {
            e.printStackTrace();
            sendJsonError(response, 500, "Server error: " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setContentType("application/json; charset=UTF-8");
        
        // Kiểm tra session
        HttpSession session = request.getSession(false);
        String username = session != null ? (String) session.getAttribute("user") : null;
        
        if (username == null) {
            sendJsonError(response, 401, "Unauthorized");
            return;
        }

        String pathInfo = request.getPathInfo();
        
        try {
            if (pathInfo != null && pathInfo.contains("/play")) {
                // POST /api/playlists/{id}/play - phát playlist
                long playlistId = extractPlaylistId(pathInfo, "/play");
                handlePlayPlaylist(response, username, playlistId);
            } else if (pathInfo != null && pathInfo.contains("/follow")) {
                // POST /api/playlists/{id}/follow - theo dõi playlist
                long playlistId = extractPlaylistId(pathInfo, "/follow");
                handleFollowPlaylist(response, username, playlistId);
            } else {
                sendJsonError(response, 400, "Invalid request");
            }
        } catch (Exception e) {
            e.printStackTrace();
            sendJsonError(response, 500, "Server error: " + e.getMessage());
        }
    }

    private void handlePlayPlaylist(HttpServletResponse response, String username, long playlistId) 
            throws IOException {
        try {
            var playlist = playlistService.getPlaylistById(playlistId);
            if (playlist == null) {
                sendJsonError(response, 404, "Playlist not found");
                return;
            }

            // Lưu vào lịch sử nghe
            historyService.recordPlaylistListen(username, playlistId);

            Map<String, Object> result = new HashMap<>();
            result.put("success", true);
            result.put("playlistId", playlistId);
            result.put("playlistName", playlist.getName());
            result.put("message", "Playlist is now playing");

            response.getWriter().write(gson.toJson(result));
        } catch (Exception e) {
            sendJsonError(response, 500, "Error playing playlist: " + e.getMessage());
        }
    }

    private void handleFollowPlaylist(HttpServletResponse response, String username, long playlistId) 
            throws IOException {
        try {
            boolean followed = playlistService.followPlaylist(username, playlistId);
            
            Map<String, Object> result = new HashMap<>();
            result.put("success", followed);
            result.put("playlistId", playlistId);
            result.put("message", followed ? "Playlist followed" : "Playlist unfollow");

            response.getWriter().write(gson.toJson(result));
        } catch (Exception e) {
            sendJsonError(response, 500, "Error following playlist: " + e.getMessage());
        }
    }

    private long extractPlaylistId(String pathInfo, String action) {
        // Từ "/123/play" hay "/123/follow" lấy ra ID 123
        String[] parts = pathInfo.split("/");
        for (int i = 0; i < parts.length - 1; i++) {
            if (parts[i].matches("\\d+")) {
                return Long.parseLong(parts[i]);
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
        error.put("status", statusCode);
        response.getWriter().write(gson.toJson(error));
    }
}
