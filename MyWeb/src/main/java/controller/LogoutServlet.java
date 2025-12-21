// Source code is decompiled from a .class file using FernFlower decompiler (from Intellij IDEA).
package controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet({"/logout"})
public class LogoutServlet extends HttpServlet {
   public LogoutServlet() {
   }

   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
      request.getSession().invalidate();
      response.sendRedirect("welcome");
   }
}
