package controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.EmailService;
import service.UserService;

@WebServlet({ "/register" })
public class RegisterServlet extends HttpServlet {
	private UserService userService;
	private EmailService emailService;

	@Override
	public void init() throws ServletException {
		this.userService = new UserService();
		this.emailService = new EmailService();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.getRequestDispatcher("/register.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String username = request.getParameter("username");
		String email = request.getParameter("email");
		String password = request.getParameter("password");

		try {
			long id = userService.register(username, email, password);
			
			// Gửi email chào mừng (chạy trong thread riêng để không block)
			final String userEmail = email;
			final String userName = username;
			new Thread(() -> {
				try {
					emailService.sendWelcomeEmail(userEmail, userName);
					System.out.println("Welcome email sent to: " + userEmail);
				} catch (Exception emailEx) {
					System.err.println("Failed to send welcome email: " + emailEx.getMessage());
					emailEx.printStackTrace();
				}
			}).start();
			
			// Đăng ký thành công → hiện popup trên trang register
			request.setAttribute("success", true);
			request.setAttribute("successEmail", email);
			request.setAttribute("message", "Đăng ký thành công! Email xác nhận đã được gửi đến " + email);
			request.getRequestDispatcher("/register.jsp").forward(request, response);
		} catch (IllegalArgumentException | IllegalStateException ex) {
			request.setAttribute("error", ex.getMessage());
			request.getRequestDispatcher("/register.jsp").forward(request, response);
		} catch (Exception ex) {
			request.setAttribute("error", "Có lỗi hệ thống: " + ex.getMessage());
			request.getRequestDispatcher("/register.jsp").forward(request, response);
		}
	}
}