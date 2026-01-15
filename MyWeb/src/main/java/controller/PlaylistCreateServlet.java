package controller;

import java.io.IOException;
import java.util.OptionalLong;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import service.PlaylistService;

@WebServlet(name = "PlaylistCreateServlet", urlPatterns = {"/playlist/create"})
public class PlaylistCreateServlet extends HttpServlet {
    private PlaylistService playlistService;
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        this.playlistService = new PlaylistService();
        this.userDAO = new UserDAO();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        String username = session == null ? null : (String) session.getAttribute("user");
        if (username == null) {
            resp.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }
        OptionalLong userIdOpt = userDAO.findUserIdByUsername(username);
        if (userIdOpt.isEmpty()) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        long userId = userIdOpt.getAsLong();

        String name = req.getParameter("name");
        String description = req.getParameter("description");
        boolean isPublic = Boolean.parseBoolean(req.getParameter("isPublic"));
        String artwork = req.getParameter("artworkUrl");
        // Lấy danh sách trackId nếu có (ví dụ: trackIds=1,2,3)
        String trackIdsParam = req.getParameter("trackIds");
        java.util.List<Long> trackIds = new java.util.ArrayList<>();
        if (trackIdsParam != null && !trackIdsParam.isBlank()) {
            for (String tid : trackIdsParam.split(",")) {
                try {
                    trackIds.add(Long.parseLong(tid.trim()));
                } catch (NumberFormatException ignore) {}
            }
        }

        if (name == null || name.isBlank()) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Tên playlist không hợp lệ");
            return;
        }

        try {
            long newPlaylistId = playlistService.createPlaylist(userId, name.trim(), description == null ? "" : description.trim(), isPublic, artwork, trackIds);
            
            System.out.println("[PlaylistCreateServlet] Created playlist ID: " + newPlaylistId + " for user: " + userId);
            
            if (newPlaylistId > 0) {
                // Trả về JSON success cho fetch request
                resp.setContentType("application/json");
                resp.setCharacterEncoding("UTF-8");
                resp.getWriter().write("{\"success\":true,\"playlistId\":" + newPlaylistId + "}");
            } else {
                resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                resp.setContentType("application/json");
                resp.getWriter().write("{\"success\":false,\"error\":\"Không thể tạo playlist\"}");
            }
        } catch (Exception e) {
            System.err.println("[PlaylistCreateServlet] Error: " + e.getMessage());
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.setContentType("application/json");
            resp.getWriter().write("{\"success\":false,\"error\":\"" + e.getMessage().replace("\"", "'") + "\"}");
        }
    }
}
