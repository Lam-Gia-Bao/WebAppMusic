package service;

import dao.CommentDAO;
import dao.CommentDAO.CommentView;

import java.util.List;

public class CommentService {
    private final CommentDAO dao = new CommentDAO();

    public void addComment(long userId, long trackId, String text) {
        dao.addComment(userId, trackId, text);
    }

    public List<CommentView> listComments(long trackId) {
        return dao.listComments(trackId);
    }
}
