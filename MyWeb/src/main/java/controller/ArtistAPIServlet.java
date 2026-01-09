package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.google.gson.Gson;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * API Servlet xử lý các yêu cầu liên quan đến Artists
 * Hỗ trợ các thao tác: lấy danh sách, phát, theo dõi
 */
@WebServlet(name = "ArtistAPIServlet", urlPatterns = {"/api/artists*"})
public class ArtistAPIServlet extends HttpServlet {
    private Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
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
            if (pathInfo == null || pathInfo.equals("/")) {
                // GET /api/artists - lấy danh sách artists được đề xuất
                var artists = getRecommendedArtists(username);
                response.getWriter().write(gson.toJson(artists));
            } else {
                sendJsonError(response, 400, "Invalid request");
            }
        } catch (Exception e) {
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
                long artistId = extractArtistId(pathInfo, "/play");
                handlePlayArtist(response, artistId);
            } else if (pathInfo != null && pathInfo.contains("/follow")) {
                long artistId = extractArtistId(pathInfo, "/follow");
                handleFollowArtist(response, username, artistId);
            } else {
                sendJsonError(response, 400, "Invalid request");
            }
        } catch (Exception e) {
            sendJsonError(response, 500, "Error: " + e.getMessage());
        }
    }

    private Object getRecommendedArtists(String username) {
        // TODO: Implement get recommended artists from database
        return new java.util.ArrayList<>();
    }

    private void handlePlayArtist(HttpServletResponse response, long artistId) 
            throws IOException {
        Map<String, Object> result = new HashMap<>();
        result.put("success", true);
        result.put("artistId", artistId);
        result.put("artistName", "Artist Name");
        result.put("message", "Artist playlist is now playing");
        response.getWriter().write(gson.toJson(result));
    }

    private void handleFollowArtist(HttpServletResponse response, String username, long artistId) 
            throws IOException {
        // TODO: Implement follow artist logic
        Map<String, Object> result = new HashMap<>();
        result.put("success", true);
        result.put("artistId", artistId);
        result.put("message", "Artist followed");
        response.getWriter().write(gson.toJson(result));
    }

    private long extractArtistId(String pathInfo, String action) {
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
        response.getWriter().write(gson.toJson(error));
    }
}
