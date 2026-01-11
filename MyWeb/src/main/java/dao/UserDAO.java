package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Optional;

import service.Database;

public class UserDAO {

	public boolean existsByUsernameOrEmail(String username, String email) {
		String sql = "SELECT 1 FROM users WHERE username=? OR email=? LIMIT 1";
		try (Connection c = Database.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
			ps.setString(1, username);
			ps.setString(2, email);
			try (ResultSet rs = ps.executeQuery()) {
				return rs.next();
			}
		} catch (SQLException e) {
			throw new RuntimeException("Lỗi kiểm tra tồn tại user: " + e.getMessage(), e);
		}
	}

	public long insertUser(String username, String email, String passwordHash) {
		// DB schema hiện dùng cột "password" (chứa hash). Đổi tên cột cho khớp schema.
		String sql = "INSERT INTO users(username, email, password) VALUES(?,?,?)";
		try (Connection c = Database.getConnection();
				PreparedStatement ps = c.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
			ps.setString(1, username);
			ps.setString(2, email);
			ps.setString(3, passwordHash);
			ps.executeUpdate();
			try (ResultSet keys = ps.getGeneratedKeys()) {
				if (keys.next())
					return keys.getLong(1);
			}
			return 0L;
		} catch (SQLException e) {
			throw new RuntimeException("Lỗi tạo user: " + e.getMessage(), e);
		}
	}

	public Optional<String> findPasswordHashByUsername(String username) {
		String sql = "SELECT password FROM users WHERE username=?";
		try (Connection c = Database.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
			ps.setString(1, username);
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next())
					return Optional.ofNullable(rs.getString(1));
			}
			return Optional.empty();
		} catch (SQLException e) {
			throw new RuntimeException("Lỗi truy vấn user: " + e.getMessage(), e);
		}
	}

	/**
	 * Find user ID by username
	 */
	public java.util.OptionalLong findUserIdByUsername(String username) {
		String sql = "SELECT user_id FROM users WHERE username = ?";
		try (Connection c = Database.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
			ps.setString(1, username);
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next())
					return java.util.OptionalLong.of(rs.getLong("user_id"));
			}
			return java.util.OptionalLong.empty();
		} catch (SQLException e) {
			throw new RuntimeException("Lỗi tìm user ID: " + e.getMessage(), e);
		}
	}
}