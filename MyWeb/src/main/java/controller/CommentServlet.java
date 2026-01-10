package controller;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import service.CommentService;

import java.io.IOException;
import java.util.OptionalLong;

@WebServlet(name = "CommentServlet", urlPatterns = {"/comment"})
public class CommentServlet extends HttpServlet {
    private CommentService commentService;
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        this.commentService = new CommentService();
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
        String text = req.getParameter("text");
        if (trackId <= 0 || text == null || text.isBlank()) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Thiếu nội dung bình luận");
            return;
        }
        commentService.addComment(userIdOpt.getAsLong(), trackId, text.trim());
        String back = req.getHeader("Referer");
        resp.sendRedirect(back != null ? back : req.getContextPath() + "/track.jsp?id=" + trackId);
    }

    private long parseLong(String val) {
        try { return Long.parseLong(val); } catch (Exception e) { return -1; }
    }
}
