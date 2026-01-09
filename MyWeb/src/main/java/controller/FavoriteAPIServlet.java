package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import service.FavoriteService;
import java.io.BufferedReader;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * API Servlet xử lý các thao tác yêu thích
 * Hỗ trợ thêm/xóa yêu thích cho playlists, artists, tracks
 */
@WebServlet(name = "FavoriteAPIServlet", urlPatterns = {"/api/favorites/*"})
public class FavoriteAPIServlet extends HttpServlet {
    private FavoriteService favoriteService;
    private Gson gson;

    @Override
    public void init() throws ServletException {
        this.favoriteService = new FavoriteService();
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

        String pathInfo = request.getPathInfo();
        
        try {
            if (pathInfo != null && pathInfo.contains("/add")) {
                // POST /api/favorites/add
                handleAddFavorite(request, response, username);
            } else if (pathInfo != null && pathInfo.contains("/remove")) {
                // POST /api/favorites/remove
                handleRemoveFavorite(request, response, username);
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

        String type = request.getParameter("type"); // "playlist", "track", "artist"
        
        try {
            if (type != null && !type.isEmpty()) {
                var favorites = favoriteService.getFavoritesByType(username, type);
                response.getWriter().write(gson.toJson(favorites));
            } else {
                var allFavorites = favoriteService.getAllFavorites(username);
                response.getWriter().write(gson.toJson(allFavorites));
            }
        } catch (Exception e) {
            sendJsonError(response, 500, "Error fetching favorites: " + e.getMessage());
        }
    }

    private void handleAddFavorite(HttpServletRequest request, HttpServletResponse response, String username) 
            throws IOException {
        try {
            String body = getRequestBody(request);
            JsonObject json = gson.fromJson(body, JsonObject.class);
            
            String type = json.get("type").getAsString(); // "playlist", "track", "artist"
            long itemId = json.get("itemId").getAsLong();
            
            boolean added = favoriteService.addFavorite(username, type, itemId);
            
            Map<String, Object> result = new HashMap<>();
            result.put("success", added);
            result.put("type", type);
            result.put("itemId", itemId);
            result.put("message", added ? "Added to favorites" : "Already in favorites");
            
            response.getWriter().write(gson.toJson(result));
        } catch (Exception e) {
            sendJsonError(response, 400, "Invalid request: " + e.getMessage());
        }
    }

    private void handleRemoveFavorite(HttpServletRequest request, HttpServletResponse response, String username) 
            throws IOException {
        try {
            String body = getRequestBody(request);
            JsonObject json = gson.fromJson(body, JsonObject.class);
            
            String type = json.get("type").getAsString();
            long itemId = json.get("itemId").getAsLong();
            
            boolean removed = favoriteService.removeFavorite(username, type, itemId);
            
            Map<String, Object> result = new HashMap<>();
            result.put("success", removed);
            result.put("type", type);
            result.put("itemId", itemId);
            result.put("message", removed ? "Removed from favorites" : "Not in favorites");
            
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
