// Source code is decompiled from a .class file using FernFlower decompiler (from Intellij IDEA).
package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet({"/welcome"})
public class WelcomeServlet extends HttpServlet {
   public WelcomeServlet() {
   }

   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      request.getRequestDispatcher("welcome.jsp").forward(request, response);
   }
}
