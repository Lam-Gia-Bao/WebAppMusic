package service;

import dao.UserDAO;
import util.HashUtil;

public class UserService {
	private final UserDAO dao = new UserDAO();

	public long register(String username, String email, String rawPassword) {
		if (username == null || username.isBlank())
			throw new IllegalArgumentException("Tên đăng nhập không hợp lệ");
		if (email == null || email.isBlank())
			throw new IllegalArgumentException("Email không hợp lệ");
		if (rawPassword == null || rawPassword.length() < 6)
			throw new IllegalArgumentException("Mật khẩu phải từ 6 ký tự");

		if (dao.existsByUsernameOrEmail(username.trim(), email.trim())) {
			throw new IllegalStateException("Tên đăng nhập hoặc email đã tồn tại");
		}
		String hash = HashUtil.sha256(rawPassword);
		return dao.insertUser(username.trim(), email.trim(), hash);
	}

	/**
	 * Kiểm tra đăng nhập: so sánh password raw với hash lưu trong DB.
	 */
	public boolean authenticate(String username, String rawPassword) {
		if (username == null || rawPassword == null)
			return false;
		return dao.findPasswordHashByUsername(username.trim())
				.map(stored -> {
					String trimmed = stored == null ? "" : stored.trim();
					String raw = rawPassword;
					String hashed = HashUtil.sha256(raw);
					// Nếu DB đã lưu SHA-256 (64 hex) thì so sánh với hash; nếu không, fallback so sánh plaintext để không khóa tài khoản cũ.
					boolean isSha256Hex = trimmed.length() == 64 && trimmed.matches("[0-9a-fA-F]{64}");
					return isSha256Hex ? trimmed.equalsIgnoreCase(hashed) : (trimmed.equals(raw) || trimmed.equalsIgnoreCase(hashed));
				})
				.orElse(false);
	}

	/**
	 * Update user avatar
	 */
	public boolean updateAvatar(long userId, String avatarUrl) {
		return dao.updateAvatarUrl(userId, avatarUrl);
	}

	/**
	 * Update user email
	 */
	public boolean updateEmail(long userId, String newEmail) {
		if (newEmail == null || newEmail.isBlank()) {
			throw new IllegalArgumentException("Email không hợp lệ");
		}
		return dao.updateEmail(userId, newEmail.trim());
	}

	/**
	 * Update user password
	 */
	public boolean updatePassword(long userId, String currentPassword, String newPassword, String username) {
		if (newPassword == null || newPassword.length() < 6) {
			throw new IllegalArgumentException("Mật khẩu mới phải từ 6 ký tự");
		}
		// Verify current password
		if (!authenticate(username, currentPassword)) {
			throw new IllegalArgumentException("Mật khẩu hiện tại không đúng");
		}
		String hash = HashUtil.sha256(newPassword);
		return dao.updatePassword(userId, hash);
	}

	/**
	 * Get user avatar URL
	 */
	public String getAvatarUrl(long userId) {
		return dao.getAvatarUrl(userId).orElse(null);
	}

	/**
	 * Get user email
	 */
	public String getEmail(long userId) {
		return dao.getEmailById(userId).orElse(null);
	}

	/**
	 * Get user ID by username
	 */
	public long getUserIdByUsername(String username) {
		return dao.findUserIdByUsername(username).orElse(-1L);
	}
}