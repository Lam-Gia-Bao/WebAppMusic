// Source code is decompiled from a .class file using FernFlower decompiler (from Intellij IDEA).
package controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import service.AdminService;
import service.UserService;

@WebServlet({"/login"})
public class LoginServlet extends HttpServlet {
   private UserService userService;
   private AdminService adminService;

   @Override
   public void init() throws ServletException {
      this.userService = new UserService();
      this.adminService = new AdminService();
   }

   @Override
   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      request.getRequestDispatcher("login.jsp").forward(request, response);
   }

   @Override
   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      String user = request.getParameter("username");
      String pass = request.getParameter("password");

      if (userService.authenticate(user, pass)) {
         HttpSession session = request.getSession(true);
         session.setAttribute("user", user);
         
         // Kiểm tra nếu là admin
         boolean isAdmin = adminService.isAdmin(user);
         session.setAttribute("isAdmin", isAdmin);
         session.setAttribute("userRole", adminService.getUserRole(user));
         
         // Điều hướng sau đăng nhập: admin về trang admin, user về trang home
         if (isAdmin) {
            response.sendRedirect("admin");
         } else {
            response.sendRedirect("login_home.jsp");
         }
      } else {
         request.setAttribute("error", "Sai tên đăng nhập hoặc mật khẩu");
         request.getRequestDispatcher("login.jsp").forward(request, response);
      }
   }
}
