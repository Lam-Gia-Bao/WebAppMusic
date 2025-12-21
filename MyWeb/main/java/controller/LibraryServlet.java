package controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "LibraryServlet", urlPatterns = {"/library"})
public class LibraryServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String tab = request.getParameter("tab");
        if (tab == null || tab.isBlank()) {
            tab = "overview";
        }

        request.setAttribute("tab", tab);
        // Forward sang JSP gốc ngoài webapp
        request.getRequestDispatcher("/library.jsp").forward(request, response);
    }
}