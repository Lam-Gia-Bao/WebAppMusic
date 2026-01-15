package controller;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.UUID;

import com.google.gson.JsonObject;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import service.FavoriteService;
import service.PlaylistService;
import service.UserService;

@WebServlet({ "/api/profile", "/api/profile/*" })
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,      // 1MB
    maxFileSize = 1024 * 1024 * 5,        // 5MB
    maxRequestSize = 1024 * 1024 * 10     // 10MB
)
public class ProfileAPIServlet extends HttpServlet {
    
    private UserService userService;
    private FavoriteService favoriteService;
    private PlaylistService playlistService;
    private UserDAO userDAO;
    
    @Override
    public void init() throws ServletException {
        this.userService = new UserService();
        this.favoriteService = new FavoriteService();
        this.playlistService = new PlaylistService();
        this.userDAO = new UserDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json; charset=UTF-8");
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            sendError(response, 401, "Chưa đăng nhập");
            return;
        }
        
        String username = (String) session.getAttribute("user");
        long userId = userService.getUserIdByUsername(username);
        
        JsonObject json = new JsonObject();
        json.addProperty("success", true);
        json.addProperty("username", username);
        json.addProperty("email", userService.getEmail(userId));
        json.addProperty("avatarUrl", userService.getAvatarUrl(userId));
        
        response.getWriter().write(json.toString());
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json; charset=UTF-8");
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            sendError(response, 401, "Chưa đăng nhập");
            return;
        }
        
        String username = (String) session.getAttribute("user");
        long userId = userService.getUserIdByUsername(username);
        
        String pathInfo = request.getPathInfo();
        
        try {
            if (pathInfo == null || pathInfo.equals("/")) {
                // General profile update
                handleProfileUpdate(request, response, userId, username);
            } else if (pathInfo.equals("/avatar")) {
                handleAvatarUpload(request, response, userId);
            } else if (pathInfo.equals("/password")) {
                handlePasswordChange(request, response, userId, username);
            } else if (pathInfo.equals("/email")) {
                handleEmailChange(request, response, userId);
            } else {
                sendError(response, 404, "Không tìm thấy API");
            }
        } catch (IllegalArgumentException e) {
            sendError(response, 400, e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            sendError(response, 500, "Lỗi hệ thống: " + e.getMessage());
        }
    }
    
    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json; charset=UTF-8");
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            sendError(response, 401, "Chưa đăng nhập");
            return;
        }
        
        String username = (String) session.getAttribute("user");
        long userId = userService.getUserIdByUsername(username);
        
        String pathInfo = request.getPathInfo();
        
        try {
            if (pathInfo != null && pathInfo.startsWith("/favorite/")) {
                // Delete favorite: /api/profile/favorite/{trackId}
                long trackId = Long.parseLong(pathInfo.substring("/favorite/".length()));
                favoriteService.removeFavorite(userId, trackId);
                sendSuccess(response, "Đã xóa khỏi yêu thích");
                
            } else if (pathInfo != null && pathInfo.startsWith("/playlist/")) {
                // Delete playlist: /api/profile/playlist/{playlistId}
                long playlistId = Long.parseLong(pathInfo.substring("/playlist/".length()));
                if (playlistService.isOwner(playlistId, userId)) {
                    playlistService.deletePlaylist(playlistId, userId);
                    sendSuccess(response, "Đã xóa playlist");
                } else {
                    sendError(response, 403, "Bạn không có quyền xóa playlist này");
                }
                
            } else {
                sendError(response, 404, "Không tìm thấy API");
            }
        } catch (NumberFormatException e) {
            sendError(response, 400, "ID không hợp lệ");
        } catch (Exception e) {
            e.printStackTrace();
            sendError(response, 500, "Lỗi hệ thống: " + e.getMessage());
        }
    }
    
    private void handleProfileUpdate(HttpServletRequest request, HttpServletResponse response, long userId, String username)
            throws IOException {
        // Can be extended for other profile fields
        sendSuccess(response, "Cập nhật thành công");
    }
    
    private void handleAvatarUpload(HttpServletRequest request, HttpServletResponse response, long userId)
            throws IOException, ServletException {
        Part filePart = request.getPart("avatar");
        if (filePart == null || filePart.getSize() == 0) {
            sendError(response, 400, "Chưa chọn file ảnh");
            return;
        }
        
        String contentType = filePart.getContentType();
        if (contentType == null || !contentType.startsWith("image/")) {
            sendError(response, 400, "File phải là hình ảnh");
            return;
        }
        
        // Get file extension
        String fileName = getFileName(filePart);
        String ext = "";
        if (fileName != null && fileName.contains(".")) {
            ext = fileName.substring(fileName.lastIndexOf("."));
        } else {
            ext = ".jpg";
        }
        
        // Generate unique filename
        String newFileName = "avatar_" + userId + "_" + UUID.randomUUID().toString().substring(0, 8) + ext;
        
        // Save to assets/img/avatars/
        String uploadDir = getServletContext().getRealPath("/assets/img/avatars");
        Path uploadPath = Paths.get(uploadDir);
        if (!Files.exists(uploadPath)) {
            Files.createDirectories(uploadPath);
        }
        
        Path filePath = uploadPath.resolve(newFileName);
        try (InputStream input = filePart.getInputStream()) {
            Files.copy(input, filePath, StandardCopyOption.REPLACE_EXISTING);
        }
        
        // Update DB
        String avatarUrl = "assets/img/avatars/" + newFileName;
        userService.updateAvatar(userId, avatarUrl);
        
        // Cập nhật session để header hiển thị avatar mới
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.setAttribute("avatar", avatarUrl);
        }
        
        JsonObject json = new JsonObject();
        json.addProperty("success", true);
        json.addProperty("message", "Đã cập nhật avatar");
        json.addProperty("avatarUrl", avatarUrl);
        response.getWriter().write(json.toString());
    }
    
    private void handlePasswordChange(HttpServletRequest request, HttpServletResponse response, long userId, String username)
            throws IOException {
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        
        if (currentPassword == null || currentPassword.isBlank()) {
            sendError(response, 400, "Vui lòng nhập mật khẩu hiện tại");
            return;
        }
        if (newPassword == null || newPassword.length() < 6) {
            sendError(response, 400, "Mật khẩu mới phải từ 6 ký tự");
            return;
        }
        if (!newPassword.equals(confirmPassword)) {
            sendError(response, 400, "Xác nhận mật khẩu không khớp");
            return;
        }
        
        userService.updatePassword(userId, currentPassword, newPassword, username);
        sendSuccess(response, "Đã đổi mật khẩu thành công");
    }
    
    private void handleEmailChange(HttpServletRequest request, HttpServletResponse response, long userId)
            throws IOException {
        String newEmail = request.getParameter("email");
        
        if (newEmail == null || newEmail.isBlank() || !newEmail.contains("@")) {
            sendError(response, 400, "Email không hợp lệ");
            return;
        }
        
        userService.updateEmail(userId, newEmail);
        sendSuccess(response, "Đã cập nhật email");
    }
    
    private String getFileName(Part part) {
        String header = part.getHeader("content-disposition");
        if (header == null) return null;
        for (String token : header.split(";")) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length() - 1);
            }
        }
        return null;
    }
    
    private void sendSuccess(HttpServletResponse response, String message) throws IOException {
        JsonObject json = new JsonObject();
        json.addProperty("success", true);
        json.addProperty("message", message);
        response.getWriter().write(json.toString());
    }
    
    private void sendError(HttpServletResponse response, int status, String message) throws IOException {
        response.setStatus(status);
        JsonObject json = new JsonObject();
        json.addProperty("success", false);
        json.addProperty("error", message);
        response.getWriter().write(json.toString());
    }
}
