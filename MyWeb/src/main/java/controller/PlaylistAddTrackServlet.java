package controller;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import service.PlaylistService;

import java.io.IOException;
import java.util.OptionalLong;

@WebServlet(name = "PlaylistAddTrackServlet", urlPatterns = {"/playlist/add"})
public class PlaylistAddTrackServlet extends HttpServlet {
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

        long playlistId = parseLong(req.getParameter("playlistId"));
        long trackId = parseLong(req.getParameter("trackId"));
        Integer position = req.getParameter("position") != null ? Integer.parseInt(req.getParameter("position")) : null;

        if (playlistId <= 0 || trackId <= 0) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Thiếu playlistId hoặc trackId");
            return;
        }

        playlistService.addTrackToPlaylist(playlistId, trackId, position);
        String back = req.getHeader("Referer");
        resp.sendRedirect(back != null ? back : req.getContextPath() + "/profile.jsp");
    }

    private long parseLong(String val) {
        try { return Long.parseLong(val); } catch (Exception e) { return -1; }
    }
}
