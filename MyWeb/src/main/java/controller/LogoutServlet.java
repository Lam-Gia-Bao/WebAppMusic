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
 * Servlet xử lý đăng xuất người dùng
 * Hỗ trợ đăng xuất qua GET, POST, và API (JSON)
 */
@WebServlet(name = "LogoutServlet", urlPatterns = {"/logout"})
public class LogoutServlet extends HttpServlet {
    private Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        performLogout(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Kiểm xem request có phải JSON API không
        String contentType = request.getContentType();
        if (contentType != null && contentType.contains("application/json")) {
            // Trả về JSON response
            performLogoutJson(request, response);
        } else {
            // Redirect thông thường
            performLogout(request, response);
        }
    }

    private void performLogout(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        // Lấy session hiện tại
        HttpSession session = request.getSession(false);
        String username = null;
        
        if (session != null) {
            username = (String) session.getAttribute("user");
            // Log hoạt động đăng xuất nếu cần
            logLogoutActivity(username);
            // Xóa session
            session.invalidate();
        }
        
        // Redirect đến trang đăng nhập
        response.sendRedirect(request.getContextPath() + "/login");
    }

    private void performLogoutJson(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        response.setContentType("application/json; charset=UTF-8");
        
        try {
            HttpSession session = request.getSession(false);
            String username = null;
            
            if (session != null) {
                username = (String) session.getAttribute("user");
                logLogoutActivity(username);
                session.invalidate();
            }
            
            Map<String, Object> result = new HashMap<>();
            result.put("success", true);
            result.put("message", "Logged out successfully");
            
            response.getWriter().write(gson.toJson(result));
        } catch (Exception e) {
            response.setStatus(500);
            Map<String, Object> error = new HashMap<>();
            error.put("success", false);
            error.put("message", "Error during logout: " + e.getMessage());
            response.getWriter().write(gson.toJson(error));
        }
    }

    private void logLogoutActivity(String username) {
        // Có thể lưu vào database nếu cần theo dõi hoạt động đăng xuất
        if (username != null) {
            System.out.println("[LOGOUT] User: " + username + " - Time: " + new java.util.Date());
        }
    }
}
