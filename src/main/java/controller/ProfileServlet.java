package controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.*;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String tab = request.getParameter("tab");
        if (tab == null) tab = "all";
        request.setAttribute("tab", tab);

        // Giả lập dữ liệu — sau kết nối DB tôi viết DAO riêng
        List<String> tracks = Arrays.asList("Lofi Midnight Rain", "Sad Piano Type Beat");
        List<String> favorites = Arrays.asList("Em Gì Ơi Lofi");
        List<String> uploads = Arrays.asList("My Own Beat");
        List<String> history = Arrays.asList("Sad Piano");
        List<String> playlists = Arrays.asList("Chill Night", "Deep Focus Beats");

        request.setAttribute("tracks", tracks);
        request.setAttribute("favorites", favorites);
        request.setAttribute("uploads", uploads);
        request.setAttribute("history", history);
        request.setAttribute("playlists", playlists);

        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }
}
