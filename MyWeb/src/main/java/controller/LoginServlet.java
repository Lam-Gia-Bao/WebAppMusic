// Source code is decompiled from a .class file using FernFlower decompiler (from Intellij IDEA).
package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet({"/login"})
public class LoginServlet extends HttpServlet {
   public LoginServlet() {
   }

   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      request.getRequestDispatcher("login.jsp").forward(request, response);
   }

   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      String user = request.getParameter("username");
      String pass = request.getParameter("password");
      if (user.equals("admin") && pass.equals("123")) {
         HttpSession session = request.getSession();
         session.setAttribute("user", user);
         response.sendRedirect("home");
      } else {
         response.sendRedirect("login?error=1");
      }

   }
}
