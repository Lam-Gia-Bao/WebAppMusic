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

/**
 * API Servlet xử lý tin nhắn (messages)
 */
@WebServlet(name = "MessageAPIServlet", urlPatterns = {"/api/messages", "/api/messages/*"})
public class MessageAPIServlet extends HttpServlet {
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
                // Lấy danh sách tin nhắn
                List<Map<String, Object>> messages = getMessages(username);
                response.getWriter().write(gson.toJson(messages));
            } else {
                // Lấy chi tiết tin nhắn
                long messageId = extractMessageId(pathInfo);
                Map<String, Object> message = getMessageDetail(username, messageId);
                if (message != null) {
                    response.getWriter().write(gson.toJson(message));
                } else {
                    sendJsonError(response, 404, "Message not found");
                }
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

        String action = request.getParameter("action");
        
        try {
            if ("send".equals(action)) {
                String recipientUsername = request.getParameter("recipient");
                String content = request.getParameter("content");
                
                boolean sent = sendMessage(username, recipientUsername, content);
                
                Map<String, Object> result = new HashMap<>();
                result.put("success", sent);
                result.put("message", sent ? "Message sent" : "Failed to send message");
                response.getWriter().write(gson.toJson(result));
            } else if ("mark-read".equals(action)) {
                long messageId = Long.parseLong(request.getParameter("id"));
                markMessageAsRead(username, messageId);
                
                Map<String, Object> result = new HashMap<>();
                result.put("success", true);
                result.put("message", "Message marked as read");
                response.getWriter().write(gson.toJson(result));
            } else {
                sendJsonError(response, 400, "Invalid action");
            }
        } catch (Exception e) {
            sendJsonError(response, 500, "Error: " + e.getMessage());
        }
    }

    private List<Map<String, Object>> getMessages(String username) {
        // TODO: Lấy từ database
        List<Map<String, Object>> messages = new ArrayList<>();
        
        // Sample messages
        Map<String, Object> msg1 = new HashMap<>();
        msg1.put("id", 1);
        msg1.put("senderName", "User 1");
        msg1.put("content", "Xin chào, bạn khỏe không?");
        msg1.put("time", "1 giờ trước");
        msg1.put("read", false);
        messages.add(msg1);
        
        return messages;
    }

    private Map<String, Object> getMessageDetail(String username, long messageId) {
        // TODO: Lấy từ database
        Map<String, Object> message = new HashMap<>();
        message.put("id", messageId);
        message.put("senderName", "User 1");
        message.put("senderUsername", "user1");
        message.put("content", "Tin nhắn chi tiết");
        message.put("time", "1 giờ trước");
        message.put("read", true);
        return message;
    }

    private boolean sendMessage(String senderUsername, String recipientUsername, String content) {
        // TODO: Lưu vào database
        System.out.println("Sending message from " + senderUsername + " to " + recipientUsername + ": " + content);
        return true;
    }

    private void markMessageAsRead(String username, long messageId) {
        // TODO: Cập nhật trong database
        System.out.println("Marking message " + messageId + " as read for user " + username);
    }

    private long extractMessageId(String pathInfo) {
        String[] parts = pathInfo.split("/");
        if (parts.length > 1 && parts[1].matches("\\d+")) {
            return Long.parseLong(parts[1]);
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
