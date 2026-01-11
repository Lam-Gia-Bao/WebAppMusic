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
import service.FavoriteService;

@WebServlet(name = "FavoriteServlet", urlPatterns = {"/favorite"})
public class FavoriteServlet extends HttpServlet {
    private FavoriteService favoriteService;
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        this.favoriteService = new FavoriteService();
        this.userDAO = new UserDAO();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json; charset=UTF-8");
        
        HttpSession session = req.getSession(false);
        String username = session == null ? null : (String) session.getAttribute("user");
        if (username == null) {
            resp.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            resp.getWriter().write("{\"success\":false,\"error\":\"Unauthorized\"}");
            return;
        }
        OptionalLong userIdOpt = userDAO.findUserIdByUsername(username);
        if (userIdOpt.isEmpty()) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            resp.getWriter().write("{\"success\":false,\"error\":\"User not found\"}");
            return;
        }

        long trackId = parseLong(req.getParameter("trackId"));
        String action = req.getParameter("action"); // add/remove
        if (trackId <= 0 || action == null) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            resp.getWriter().write("{\"success\":false,\"error\":\"Missing parameters\"}");
            return;
        }
        
        try {
            boolean fav = action.equalsIgnoreCase("add") || action.equalsIgnoreCase("favorite") || action.equalsIgnoreCase("true");
            if (fav) {
                favoriteService.addFavorite(userIdOpt.getAsLong(), trackId);
                resp.getWriter().write("{\"success\":true,\"favorited\":true,\"message\":\"Đã thêm vào yêu thích\"}");
            } else {
                favoriteService.removeFavorite(userIdOpt.getAsLong(), trackId);
                resp.getWriter().write("{\"success\":true,\"favorited\":false,\"message\":\"Đã bỏ yêu thích\"}");
            }
        } catch (Exception e) {
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.getWriter().write("{\"success\":false,\"error\":\"" + e.getMessage().replace("\"", "'") + "\"}");
        }
    }

    private long parseLong(String val) {
        try { return Long.parseLong(val); } catch (Exception e) { return -1; }
    }
}
