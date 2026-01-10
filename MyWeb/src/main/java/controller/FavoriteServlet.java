package controller;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import service.FavoriteService;

import java.io.IOException;
import java.util.OptionalLong;

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

        long trackId = parseLong(req.getParameter("trackId"));
        String action = req.getParameter("action"); // add/remove
        if (trackId <= 0 || action == null) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Thiếu tham số");
            return;
        }
        boolean fav = action.equalsIgnoreCase("add") || action.equalsIgnoreCase("favorite") || action.equalsIgnoreCase("true");
        favoriteService.toggleFavorite(userIdOpt.getAsLong(), trackId, fav);
        resp.setStatus(HttpServletResponse.SC_OK);
    }

    private long parseLong(String val) {
        try { return Long.parseLong(val); } catch (Exception e) { return -1; }
    }
}
