package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.google.gson.Gson;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * API Servlet xử lý thông báo (notifications)
 */
@WebServlet(name = "NotificationAPIServlet", urlPatterns = {"/api/notifications*"})
public class NotificationAPIServlet extends HttpServlet {
    private Gson gson = new Gson();

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

        try {
            List<Map<String, Object>> notifications = getNotifications(username);
            response.getWriter().write(gson.toJson(notifications));
        } catch (Exception e) {
            sendJsonError(response, 500, "Error fetching notifications: " + e.getMessage());
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

        String action = request.getParameter("action");
        
        try {
            if ("mark-read".equals(action)) {
                long notificationId = Long.parseLong(request.getParameter("id"));
                markNotificationAsRead(username, notificationId);
                
                Map<String, Object> result = new HashMap<>();
                result.put("success", true);
                result.put("message", "Notification marked as read");
                response.getWriter().write(gson.toJson(result));
            } else {
                sendJsonError(response, 400, "Invalid action");
            }
        } catch (Exception e) {
            sendJsonError(response, 500, "Error: " + e.getMessage());
        }
    }

    private List<Map<String, Object>> getNotifications(String username) {
        // TODO: Lấy từ database
        List<Map<String, Object>> notifications = new ArrayList<>();
        
        // Sample notifications
        Map<String, Object> notif1 = new HashMap<>();
        notif1.put("id", 1);
        notif1.put("title", "Bài hát mới từ nghệ sĩ bạn theo dõi");
        notif1.put("message", "Nghệ sĩ 'Artist Name' đã phát hành bài hát mới");
        notif1.put("time", "2 giờ trước");
        notif1.put("read", false);
        notifications.add(notif1);
        
        return notifications;
    }

    private void markNotificationAsRead(String username, long notificationId) {
        // TODO: Cập nhật trong database
        System.out.println("Marking notification " + notificationId + " as read for user " + username);
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
