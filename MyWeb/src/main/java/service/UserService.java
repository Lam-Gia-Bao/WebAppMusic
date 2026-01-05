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
}