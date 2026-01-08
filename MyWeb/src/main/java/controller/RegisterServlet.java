package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import service.UserService;

import java.io.IOException;

@WebServlet({ "/register" })
public class RegisterServlet extends HttpServlet {
	private UserService userService;

	@Override
	public void init() throws ServletException {
		this.userService = new UserService();
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
			// Đăng ký thành công → chuyển sang login
			request.setAttribute("message", "Đăng ký thành công! Mời đăng nhập.");
			request.getRequestDispatcher("/login.jsp").forward(request, response);
		} catch (IllegalArgumentException | IllegalStateException ex) {
			request.setAttribute("error", ex.getMessage());
			request.getRequestDispatcher("/register.jsp").forward(request, response);
		} catch (Exception ex) {
			request.setAttribute("error", "Có lỗi hệ thống: " + ex.getMessage());
			request.getRequestDispatcher("/register.jsp").forward(request, response);
		}
	}
}