package controller;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import service.HistoryService;
import dao.TrackDAO;

import java.io.IOException;
import java.util.OptionalLong;

@WebServlet(name = "TrackPlayServlet", urlPatterns = {"/track/play"})
public class TrackPlayServlet extends HttpServlet {
    private HistoryService historyService;
    private TrackDAO trackDAO;
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        this.historyService = new HistoryService();
        this.trackDAO = new TrackDAO();
        this.userDAO = new UserDAO();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        long trackId = parseLong(req.getParameter("trackId"));
        if (trackId <= 0) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Thiếu trackId");
            return;
        }
        trackDAO.incrementPlayCount((int) trackId);

        HttpSession session = req.getSession(false);
        String username = session == null ? null : (String) session.getAttribute("user");
        if (username != null) {
            OptionalLong userIdOpt = userDAO.findUserIdByUsername(username);
            userIdOpt.ifPresent(userId -> historyService.addPlay(userId, trackId));
        }
        resp.setStatus(HttpServletResponse.SC_OK);
    }

    private long parseLong(String val) {
        try { return Long.parseLong(val); } catch (Exception e) { return -1; }
    }
}
