package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.OptionalLong;

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
import service.HistoryService;
import service.PlaylistService;
import service.TrackService;

/**
 * API Servlet xử lý các yêu cầu liên quan đến Playlists
 * Hỗ trợ các thao tác: lấy danh sách, phát, yêu thích, theo dõi
 */
@WebServlet(name = "PlaylistAPIServlet", urlPatterns = {"/api/playlists", "/api/playlists/*"})
public class PlaylistAPIServlet extends HttpServlet {
    private PlaylistService playlistService;
    private FavoriteService favoriteService;
    private HistoryService historyService;
    private TrackService trackService;
    private UserDAO userDAO;
    private Gson gson;

    @Override
    public void init() throws ServletException {
        this.playlistService = new PlaylistService();
        this.favoriteService = new FavoriteService();
        this.historyService = new HistoryService();
        this.trackService = new TrackService();
        this.userDAO = new UserDAO();
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
        
        // Get userId for current user
        OptionalLong userIdOpt = userDAO.findUserIdByUsername(username);
        if (userIdOpt.isEmpty()) {
            sendJsonError(response, 400, "User not found");
            return;
        }
        long userId = userIdOpt.getAsLong();
        
        try {
            if (pathInfo == null || pathInfo.equals("/")) {
                // GET /api/playlists - lấy playlists của user đang đăng nhập
                var playlists = playlistService.getPlaylists(userId);
                response.getWriter().write(gson.toJson(playlists));
            } else if (pathInfo.equals("/recommended")) {
                // GET /api/playlists/recommended - lấy playlists gợi ý
                var playlists = playlistService.getRecommendedPlaylists(username, 20);
                response.getWriter().write(gson.toJson(playlists));
            } else if (pathInfo.matches("/\\d+/tracks")) {
                // GET /api/playlists/{id}/tracks - lấy danh sách tracks của playlist
                long playlistId = extractPlaylistIdFromPath(pathInfo);
                handleGetPlaylistTracks(response, playlistId);
            } else if (pathInfo.matches("/\\d+")) {
                // GET /api/playlists/{id} - lấy thông tin playlist
                long playlistId = Long.parseLong(pathInfo.substring(1));
                var playlist = playlistService.getPlaylistById(playlistId);
                if (playlist != null) {
                    response.getWriter().write(gson.toJson(playlist));
                } else {
                    sendJsonError(response, 404, "Playlist not found");
                }
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
            if (pathInfo != null && pathInfo.matches("/\\d+/tracks")) {
                // POST /api/playlists/{id}/tracks - thêm track vào playlist
                long playlistId = extractPlaylistIdFromPath(pathInfo);
                handleAddTrackToPlaylist(request, response, username, playlistId);
            } else if (pathInfo != null && pathInfo.contains("/play")) {
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

    private void handleAddTrackToPlaylist(HttpServletRequest request, HttpServletResponse response, 
            String username, long playlistId) throws IOException {
        try {
            // Đọc JSON body
            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = request.getReader().readLine()) != null) {
                sb.append(line);
            }
            Map<String, Object> body = gson.fromJson(sb.toString(), Map.class);
            
            if (body == null || !body.containsKey("trackId")) {
                sendJsonError(response, 400, "Missing trackId");
                return;
            }
            
            // Xử lý trackId - có thể là String hoặc Number
            long trackId;
            Object trackIdObj = body.get("trackId");
            if (trackIdObj instanceof Number) {
                trackId = ((Number) trackIdObj).longValue();
            } else {
                trackId = Long.parseLong(trackIdObj.toString());
            }
            
            // Xử lý position - có thể là String hoặc Number
            Integer position = null;
            if (body.containsKey("position") && body.get("position") != null) {
                Object posObj = body.get("position");
                if (posObj instanceof Number) {
                    position = ((Number) posObj).intValue();
                } else {
                    position = Integer.parseInt(posObj.toString());
                }
            }
            
            // Thêm track vào playlist
            playlistService.addTrackToPlaylist(playlistId, trackId, position);
            
            Map<String, Object> result = new HashMap<>();
            result.put("success", true);
            result.put("playlistId", playlistId);
            result.put("trackId", trackId);
            result.put("message", "Track added to playlist");
            
            response.getWriter().write(gson.toJson(result));
        } catch (Exception e) {
            e.printStackTrace();
            sendJsonError(response, 500, "Error adding track to playlist: " + e.getMessage());
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

    private long extractPlaylistIdFromPath(String pathInfo) {
        // Từ "/123/tracks" lấy ra ID 123
        String[] parts = pathInfo.split("/");
        for (String part : parts) {
            if (part.matches("\\d+")) {
                return Long.parseLong(part);
            }
        }
        return 0;
    }

    private void handleGetPlaylistTracks(HttpServletResponse response, long playlistId) 
            throws IOException {
        try {
            var playlist = playlistService.getPlaylistById(playlistId);
            if (playlist == null) {
                sendJsonError(response, 404, "Playlist not found");
                return;
            }

            // Lấy danh sách tracks của playlist
            List<Track> tracks = playlistService.getPlaylistTracks(playlistId);
            
            // Tạo response với thông tin playlist và tracks
            Map<String, Object> result = new HashMap<>();
            result.put("success", true);
            result.put("playlistId", playlistId);
            result.put("name", playlist.getName());
            result.put("description", playlist.getDescription());
            result.put("artworkUrl", playlist.getArtworkUrl());
            result.put("isPublic", playlist.isPublic());
            
            // Convert tracks to maps
            List<Map<String, Object>> trackList = new ArrayList<>();
            for (Track track : tracks) {
                Map<String, Object> trackMap = new HashMap<>();
                trackMap.put("trackId", track.getTrackId());
                trackMap.put("title", track.getTitle());
                trackMap.put("artist", track.getArtist());
                trackMap.put("audioFileUrl", track.getAudioFileUrl());
                trackMap.put("artworkUrl", track.getArtworkUrl());
                trackMap.put("duration", track.getDuration());
                trackMap.put("uploaderUsername", track.getUploaderUsername());
                trackMap.put("playCount", track.getPlayCount());
                trackMap.put("likeCount", track.getLikeCount());
                trackList.add(trackMap);
            }
            result.put("tracks", trackList);
            result.put("trackCount", trackList.size());

            response.getWriter().write(gson.toJson(result));
        } catch (Exception e) {
            sendJsonError(response, 500, "Error getting playlist tracks: " + e.getMessage());
        }
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
