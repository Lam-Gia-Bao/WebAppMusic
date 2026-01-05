package service;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Properties;

public class Database {
	private static String url;
	private static String user;
	private static String password;
	private static volatile boolean initialized = false;

	private static synchronized void init() {
		if (initialized)
			return;
		try (InputStream in = Database.class.getClassLoader().getResourceAsStream("db.properties")) {
			Properties p = new Properties();
			if (in != null)
				p.load(in);
			    // Default to project schema name to avoid unknown database errors when property file missing
			    url = p.getProperty("db.url",
				    "jdbc:mysql://localhost:3306/webappmusic?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC");
			user = p.getProperty("db.user", "root");
			password = p.getProperty("db.password", "");
			// Đăng ký driver (MySQL Connector/J 8)
			Class.forName("com.mysql.cj.jdbc.Driver");
			initialized = true;
		} catch (Exception e) {
			throw new RuntimeException("Không thể tải cấu hình DB", e);
		}
	}

	public static Connection getConnection() {
		if (!initialized)
			init();
		try {
			return DriverManager.getConnection(url, user, password);
		} catch (Exception e) {
			throw new RuntimeException("Không thể kết nối MySQL: " + e.getMessage(), e);
		}
	}
}