package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Playlist;
import model.Track;
import model.User;
import service.AdminService;

/**
 * Admin Servlet - Xử lý các request cho trang quản trị
 */
@WebServlet({"/admin", "/admin/*"})
public class AdminServlet extends HttpServlet {
    
    private AdminService adminService;
    private Gson gson;
    
    @Override
    public void init() throws ServletException {
        this.adminService = new AdminService();
        this.gson = new Gson();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Kiểm tra đăng nhập và quyền admin
        if (!checkAdminAccess(request, response)) {
            return;
        }
        
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null || pathInfo.equals("/")) {
            // Hiển thị trang admin chính
            showAdminDashboard(request, response);
        } else if (pathInfo.equals("/api/stats")) {
            // API lấy thống kê
            getStats(request, response);
        } else if (pathInfo.equals("/api/users")) {
            // API lấy danh sách users
            getUsers(request, response);
        } else if (pathInfo.equals("/api/tracks")) {
            // API lấy danh sách tracks
            getTracks(request, response);
        } else if (pathInfo.equals("/api/playlists")) {
            // API lấy danh sách playlists
            getPlaylists(request, response);
        } else if (pathInfo.startsWith("/api/user/")) {
            // API lấy chi tiết user
            getUserDetail(request, response);
        } else if (pathInfo.startsWith("/api/track/")) {
            // API lấy chi tiết track
            getTrackDetail(request, response);
        } else if (pathInfo.startsWith("/api/playlist/")) {
            // API lấy chi tiết playlist
            getPlaylistDetail(request, response);
        } else if (pathInfo.equals("/api/top-tracks")) {
            // API lấy top tracks
            getTopTracks(request, response);
        } else if (pathInfo.equals("/api/active-users")) {
            // API lấy active users
            getActiveUsers(request, response);
        } else if (pathInfo.equals("/api/play-stats")) {
            // API lấy thống kê lượt nghe
            getPlayStats(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        if (!checkAdminAccess(request, response)) {
            return;
        }
        
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        
        if (pathInfo.equals("/api/user/create")) {
            createUser(request, response);
        } else if (pathInfo.equals("/api/user/update")) {
            updateUser(request, response);
        } else if (pathInfo.equals("/api/user/delete")) {
            deleteUser(request, response);
        } else if (pathInfo.equals("/api/track/update")) {
            updateTrack(request, response);
        } else if (pathInfo.equals("/api/track/delete")) {
            deleteTrack(request, response);
        } else if (pathInfo.equals("/api/playlist/update")) {
            updatePlaylist(request, response);
        } else if (pathInfo.equals("/api/playlist/delete")) {
            deletePlaylist(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
    
    /**
     * Kiểm tra quyền admin
     */
    private boolean checkAdminAccess(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        HttpSession session = request.getSession(false);
        
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return false;
        }
        
        String username = (String) session.getAttribute("user");
        if (username == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return false;
        }
        
        Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
        if (isAdmin == null || !isAdmin) {
            // Kiểm tra lại từ database
            if (!adminService.isAdmin(username)) {
                response.sendRedirect(request.getContextPath() + "/login_home.jsp");
                return false;
            }
            session.setAttribute("isAdmin", true);
        }
        
        return true;
    }
    
    /**
     * Hiển thị trang admin dashboard
     */
    private void showAdminDashboard(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/admin.jsp").forward(request, response);
    }
    
    /**
     * API lấy thống kê tổng quan
     */
    private void getStats(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        Map<String, Integer> stats = adminService.getDashboardStats();
        sendJsonResponse(response, stats);
    }
    
    /**
     * API lấy danh sách users
     */
    private void getUsers(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        List<User> users = adminService.getAllUsers();
        sendJsonResponse(response, users);
    }
    
    /**
     * API lấy danh sách tracks
     */
    private void getTracks(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        List<Track> tracks = adminService.getAllTracks();
        sendJsonResponse(response, tracks);
    }
    
    /**
     * API lấy danh sách playlists
     */
    private void getPlaylists(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        List<Playlist> playlists = adminService.getAllPlaylists();
        sendJsonResponse(response, playlists);
    }
    
    /**
     * API lấy chi tiết user
     */
    private void getUserDetail(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        try {
            String pathInfo = request.getPathInfo();
            int userId = Integer.parseInt(pathInfo.replace("/api/user/", ""));
            User user = adminService.getUserById(userId);
            
            if (user != null) {
                sendJsonResponse(response, user);
            } else {
                sendErrorResponse(response, HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy người dùng");
            }
        } catch (NumberFormatException e) {
            sendErrorResponse(response, HttpServletResponse.SC_BAD_REQUEST, "ID không hợp lệ");
        }
    }
    
    /**
     * API lấy chi tiết track
     */
    private void getTrackDetail(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        try {
            String pathInfo = request.getPathInfo();
            int trackId = Integer.parseInt(pathInfo.replace("/api/track/", ""));
            Track track = adminService.getTrackById(trackId);
            
            if (track != null) {
                sendJsonResponse(response, track);
            } else {
                sendErrorResponse(response, HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy bài hát");
            }
        } catch (NumberFormatException e) {
            sendErrorResponse(response, HttpServletResponse.SC_BAD_REQUEST, "ID không hợp lệ");
        }
    }
    
    /**
     * API lấy chi tiết playlist
     */
    private void getPlaylistDetail(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        try {
            String pathInfo = request.getPathInfo();
            long playlistId = Long.parseLong(pathInfo.replace("/api/playlist/", ""));
            Playlist playlist = adminService.getPlaylistById(playlistId);
            
            if (playlist != null) {
                sendJsonResponse(response, playlist);
            } else {
                sendErrorResponse(response, HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy playlist");
            }
        } catch (NumberFormatException e) {
            sendErrorResponse(response, HttpServletResponse.SC_BAD_REQUEST, "ID không hợp lệ");
        }
    }
    
    /**
     * API lấy top bài hát được nghe nhiều nhất
     */
    private void getTopTracks(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        String limitParam = request.getParameter("limit");
        int limit = 10;
        try {
            if (limitParam != null) {
                limit = Integer.parseInt(limitParam);
            }
        } catch (NumberFormatException ignored) {}
        
        List<Track> tracks = adminService.getTopPlayedTracks(limit);
        sendJsonResponse(response, tracks);
    }
    
    /**
     * API lấy người dùng hoạt động nhiều nhất
     */
    private void getActiveUsers(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        String limitParam = request.getParameter("limit");
        int limit = 10;
        try {
            if (limitParam != null) {
                limit = Integer.parseInt(limitParam);
            }
        } catch (NumberFormatException ignored) {}
        
        List<Map<String, Object>> users = adminService.getMostActiveUsers(limit);
        sendJsonResponse(response, users);
    }
    
    /**
     * API lấy thống kê lượt nghe theo ngày
     */
    private void getPlayStats(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        String daysParam = request.getParameter("days");
        int days = 30;
        try {
            if (daysParam != null) {
                days = Integer.parseInt(daysParam);
            }
        } catch (NumberFormatException ignored) {}
        
        List<Map<String, Object>> stats = adminService.getPlayStatsByDay(days);
        sendJsonResponse(response, stats);
    }
    
    /**
     * Tạo user mới
     */
    private void createUser(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        try {
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String fullName = request.getParameter("fullName");
            String role = request.getParameter("role");
            
            if (role == null || role.isBlank()) {
                role = "user";
            }
            
            boolean success = adminService.createUser(username, email, password, fullName, role);
            
            if (success) {
                sendSuccessResponse(response, "Tạo người dùng thành công");
            } else {
                sendErrorResponse(response, HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Không thể tạo người dùng");
            }
        } catch (IllegalArgumentException e) {
            sendErrorResponse(response, HttpServletResponse.SC_BAD_REQUEST, e.getMessage());
        }
    }
    
    /**
     * Cập nhật user
     */
    private void updateUser(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        try {
            int userId = Integer.parseInt(request.getParameter("userId"));
            
            User user = adminService.getUserById(userId);
            if (user == null) {
                sendErrorResponse(response, HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy người dùng");
                return;
            }
            
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String fullName = request.getParameter("fullName");
            String bio = request.getParameter("bio");
            String role = request.getParameter("role");
            
            if (username != null && !username.isBlank()) user.setUsername(username);
            if (email != null && !email.isBlank()) user.setEmail(email);
            if (fullName != null) user.setFullName(fullName);
            if (bio != null) user.setBio(bio);
            if (role != null && !role.isBlank()) user.setRole(role);
            
            boolean success = adminService.updateUser(user);
            
            if (success) {
                sendSuccessResponse(response, "Cập nhật người dùng thành công");
            } else {
                sendErrorResponse(response, HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Không thể cập nhật người dùng");
            }
        } catch (NumberFormatException e) {
            sendErrorResponse(response, HttpServletResponse.SC_BAD_REQUEST, "ID không hợp lệ");
        } catch (IllegalArgumentException e) {
            sendErrorResponse(response, HttpServletResponse.SC_BAD_REQUEST, e.getMessage());
        }
    }
    
    /**
     * Xóa user
     */
    private void deleteUser(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        try {
            int userId = Integer.parseInt(request.getParameter("userId"));
            boolean success = adminService.deleteUser(userId);
            
            if (success) {
                sendSuccessResponse(response, "Xóa người dùng thành công");
            } else {
                sendErrorResponse(response, HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Không thể xóa người dùng");
            }
        } catch (NumberFormatException e) {
            sendErrorResponse(response, HttpServletResponse.SC_BAD_REQUEST, "ID không hợp lệ");
        }
    }
    
    /**
     * Cập nhật track
     */
    private void updateTrack(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        try {
            int trackId = Integer.parseInt(request.getParameter("trackId"));
            
            Track track = adminService.getTrackById(trackId);
            if (track == null) {
                sendErrorResponse(response, HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy bài hát");
                return;
            }
            
            String title = request.getParameter("title");
            String artist = request.getParameter("artist");
            String genre = request.getParameter("genre");
            String tags = request.getParameter("tags");
            String description = request.getParameter("description");
            String privacy = request.getParameter("privacy");
            
            if (title != null && !title.isBlank()) track.setTitle(title);
            if (artist != null) track.setArtist(artist);
            if (genre != null) track.setGenre(genre);
            if (tags != null) track.setTags(tags);
            if (description != null) track.setDescription(description);
            if (privacy != null && !privacy.isBlank()) track.setPrivacy(privacy);
            
            boolean success = adminService.updateTrack(track);
            
            if (success) {
                sendSuccessResponse(response, "Cập nhật bài hát thành công");
            } else {
                sendErrorResponse(response, HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Không thể cập nhật bài hát");
            }
        } catch (NumberFormatException e) {
            sendErrorResponse(response, HttpServletResponse.SC_BAD_REQUEST, "ID không hợp lệ");
        } catch (IllegalArgumentException e) {
            sendErrorResponse(response, HttpServletResponse.SC_BAD_REQUEST, e.getMessage());
        }
    }
    
    /**
     * Xóa track
     */
    private void deleteTrack(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        try {
            int trackId = Integer.parseInt(request.getParameter("trackId"));
            boolean success = adminService.deleteTrack(trackId);
            
            if (success) {
                sendSuccessResponse(response, "Xóa bài hát thành công");
            } else {
                sendErrorResponse(response, HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Không thể xóa bài hát");
            }
        } catch (NumberFormatException e) {
            sendErrorResponse(response, HttpServletResponse.SC_BAD_REQUEST, "ID không hợp lệ");
        }
    }
    
    /**
     * Cập nhật playlist
     */
    private void updatePlaylist(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        try {
            long playlistId = Long.parseLong(request.getParameter("playlistId"));
            
            Playlist playlist = adminService.getPlaylistById(playlistId);
            if (playlist == null) {
                sendErrorResponse(response, HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy playlist");
                return;
            }
            
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            String isPublicStr = request.getParameter("isPublic");
            
            if (name != null && !name.isBlank()) playlist.setName(name);
            if (description != null) playlist.setDescription(description);
            if (isPublicStr != null) playlist.setPublic(Boolean.parseBoolean(isPublicStr));
            
            boolean success = adminService.updatePlaylist(playlist);
            
            if (success) {
                sendSuccessResponse(response, "Cập nhật playlist thành công");
            } else {
                sendErrorResponse(response, HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Không thể cập nhật playlist");
            }
        } catch (NumberFormatException e) {
            sendErrorResponse(response, HttpServletResponse.SC_BAD_REQUEST, "ID không hợp lệ");
        } catch (IllegalArgumentException e) {
            sendErrorResponse(response, HttpServletResponse.SC_BAD_REQUEST, e.getMessage());
        }
    }
    
    /**
     * Xóa playlist
     */
    private void deletePlaylist(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        try {
            long playlistId = Long.parseLong(request.getParameter("playlistId"));
            boolean success = adminService.deletePlaylist(playlistId);
            
            if (success) {
                sendSuccessResponse(response, "Xóa playlist thành công");
            } else {
                sendErrorResponse(response, HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Không thể xóa playlist");
            }
        } catch (NumberFormatException e) {
            sendErrorResponse(response, HttpServletResponse.SC_BAD_REQUEST, "ID không hợp lệ");
        }
    }
    
    /**
     * Gửi response JSON
     */
    private void sendJsonResponse(HttpServletResponse response, Object data) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        out.print(gson.toJson(data));
        out.flush();
    }
    
    /**
     * Gửi response thành công
     */
    private void sendSuccessResponse(HttpServletResponse response, String message) throws IOException {
        JsonObject json = new JsonObject();
        json.addProperty("success", true);
        json.addProperty("message", message);
        sendJsonResponse(response, json);
    }
    
    /**
     * Gửi response lỗi
     */
    private void sendErrorResponse(HttpServletResponse response, int statusCode, String message) throws IOException {
        response.setStatus(statusCode);
        JsonObject json = new JsonObject();
        json.addProperty("success", false);
        json.addProperty("error", message);
        sendJsonResponse(response, json);
    }
}
