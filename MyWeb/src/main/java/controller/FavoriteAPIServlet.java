package controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.OptionalLong;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import service.FavoriteService;

/**
 * API Servlet xử lý các thao tác yêu thích
 * Hỗ trợ thêm/xóa yêu thích cho tracks
 */
@WebServlet(name = "FavoriteAPIServlet", urlPatterns = {"/api/favorites/*"})
public class FavoriteAPIServlet extends HttpServlet {
    private FavoriteService favoriteService;
    private UserDAO userDAO;
    private Gson gson;

    @Override
    public void init() throws ServletException {
        this.favoriteService = new FavoriteService();
        this.userDAO = new UserDAO();
        this.gson = new Gson();
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
        
        // Get userId
        OptionalLong userIdOpt = userDAO.findUserIdByUsername(username);
        if (userIdOpt.isEmpty()) {
            sendJsonError(response, 400, "User not found");
            return;
        }
        long userId = userIdOpt.getAsLong();

        String pathInfo = request.getPathInfo();
        
        try {
            if (pathInfo != null && pathInfo.contains("/toggle")) {
                // POST /api/favorites/toggle
                handleToggleFavorite(request, response, userId);
            } else if (pathInfo != null && pathInfo.contains("/add")) {
                // POST /api/favorites/add
                handleAddFavorite(request, response, userId);
            } else if (pathInfo != null && pathInfo.contains("/remove")) {
                // POST /api/favorites/remove
                handleRemoveFavorite(request, response, userId);
            } else {
                sendJsonError(response, 400, "Invalid request");
            }
        } catch (Exception e) {
            e.printStackTrace();
            sendJsonError(response, 500, "Server error: " + e.getMessage());
        }
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
        
        // Get userId
        OptionalLong userIdOpt = userDAO.findUserIdByUsername(username);
        if (userIdOpt.isEmpty()) {
            sendJsonError(response, 400, "User not found");
            return;
        }
        long userId = userIdOpt.getAsLong();
        
        String trackIdParam = request.getParameter("trackId");
        
        try {
            if (trackIdParam != null && !trackIdParam.isEmpty()) {
                // Check if specific track is favorited
                long trackId = Long.parseLong(trackIdParam);
                boolean isFavorited = favoriteService.isFavorited(userId, trackId);
                Map<String, Object> result = new HashMap<>();
                result.put("favorited", isFavorited);
                result.put("trackId", trackId);
                response.getWriter().write(gson.toJson(result));
            } else {
                // Get all favorites
                var favorites = favoriteService.getFavorites(userId);
                response.getWriter().write(gson.toJson(favorites));
            }
        } catch (Exception e) {
            sendJsonError(response, 500, "Error fetching favorites: " + e.getMessage());
        }
    }

    private void handleToggleFavorite(HttpServletRequest request, HttpServletResponse response, long userId) 
            throws IOException {
        try {
            String body = getRequestBody(request);
            JsonObject json = gson.fromJson(body, JsonObject.class);
            
            long trackId = json.get("trackId").getAsLong();
            
            boolean nowFavorited = favoriteService.toggleFavorite(userId, trackId);
            
            Map<String, Object> result = new HashMap<>();
            result.put("success", true);
            result.put("trackId", trackId);
            result.put("favorited", nowFavorited);
            result.put("message", nowFavorited ? "Đã thêm vào yêu thích" : "Đã bỏ yêu thích");
            
            response.getWriter().write(gson.toJson(result));
        } catch (Exception e) {
            sendJsonError(response, 400, "Invalid request: " + e.getMessage());
        }
    }

    private void handleAddFavorite(HttpServletRequest request, HttpServletResponse response, long userId) 
            throws IOException {
        try {
            String body = getRequestBody(request);
            JsonObject json = gson.fromJson(body, JsonObject.class);
            
            long trackId = json.get("trackId").getAsLong();
            
            favoriteService.addFavorite(userId, trackId);
            
            Map<String, Object> result = new HashMap<>();
            result.put("success", true);
            result.put("trackId", trackId);
            result.put("message", "Đã thêm vào yêu thích");
            
            response.getWriter().write(gson.toJson(result));
        } catch (Exception e) {
            sendJsonError(response, 400, "Invalid request: " + e.getMessage());
        }
    }

    private void handleRemoveFavorite(HttpServletRequest request, HttpServletResponse response, long userId) 
            throws IOException {
        try {
            String body = getRequestBody(request);
            JsonObject json = gson.fromJson(body, JsonObject.class);
            
            long trackId = json.get("trackId").getAsLong();
            
            favoriteService.removeFavorite(userId, trackId);
            
            Map<String, Object> result = new HashMap<>();
            result.put("success", true);
            result.put("trackId", trackId);
            result.put("message", "Đã bỏ yêu thích");
            
            response.getWriter().write(gson.toJson(result));
        } catch (Exception e) {
            sendJsonError(response, 400, "Invalid request: " + e.getMessage());
        }
    }

    private String getRequestBody(HttpServletRequest request) throws IOException {
        BufferedReader reader = request.getReader();
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = reader.readLine()) != null) {
            sb.append(line);
        }
        return sb.toString();
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
