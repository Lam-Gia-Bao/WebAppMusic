package dao;

import service.Database;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CommentDAO {

    public void addComment(long userId, long trackId, String text) {
        String sql = "INSERT INTO comments(track_id, user_id, comment_text) VALUES(?,?,?)";
        try (Connection c = Database.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setLong(1, trackId);
            ps.setLong(2, userId);
            ps.setString(3, text);
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Không thể thêm bình luận: " + e.getMessage(), e);
        }
    }

    public List<CommentView> listComments(long trackId) {
        String sql = "SELECT c.comment_id, c.comment_text, c.created_at, u.username "
                + "FROM comments c JOIN users u ON c.user_id = u.user_id "
                + "WHERE c.track_id=? ORDER BY c.created_at DESC";
        List<CommentView> list = new ArrayList<>();
        try (Connection c = Database.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setLong(1, trackId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    CommentView cv = new CommentView();
                    cv.setCommentId(rs.getLong("comment_id"));
                    cv.setText(rs.getString("comment_text"));
                    cv.setCreatedAt(rs.getTimestamp("created_at"));
                    cv.setUsername(rs.getString("username"));
                    list.add(cv);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Không thể lấy danh sách bình luận: " + e.getMessage(), e);
        }
        return list;
    }

    public static class CommentView {
        private long commentId;
        private String username;
        private String text;
        private Timestamp createdAt;

        public long getCommentId() { return commentId; }
        public String getUsername() { return username; }
        public String getText() { return text; }
        public Timestamp getCreatedAt() { return createdAt; }

        public void setCommentId(long commentId) { this.commentId = commentId; }
        public void setUsername(String username) { this.username = username; }
        public void setText(String text) { this.text = text; }
        public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
    }
}
