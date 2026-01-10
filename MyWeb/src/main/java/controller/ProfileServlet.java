package controller;

import java.io.IOException;
import java.util.Collections;
import java.util.List;
import java.util.OptionalLong;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Playlist;
import model.Track;
import service.FavoriteService;
import service.HistoryService;
import service.PlaylistService;
import service.TrackService;
import service.UploadService;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {

    private TrackService trackService;
    private FavoriteService favoriteService;
    private PlaylistService playlistService;
    private UploadService uploadService;
    private HistoryService historyService;
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        this.trackService = new TrackService();
        this.favoriteService = new FavoriteService();
        this.playlistService = new PlaylistService();
        this.uploadService = new UploadService();
        this.historyService = new HistoryService();
        this.userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Get user from session
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        String username = (String) session.getAttribute("user");
        OptionalLong userIdOpt = userDAO.findUserIdByUsername(username);
        
        if (userIdOpt.isEmpty()) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        long userId = userIdOpt.getAsLong();

        String tab = request.getParameter("tab");
        if (tab == null || tab.isBlank()) {
            tab = "all";
        }

        // Nạp dữ liệu tối ưu theo tab
        List<Track> tracks = Collections.emptyList();
        List<Track> favorites = Collections.emptyList();
        List<Playlist> playlists = Collections.emptyList();
        List<Track> uploadedTracks = Collections.emptyList();
        List<String> history = Collections.emptyList();

        switch (tab) {
            case "all":
                tracks = trackService.getAllTracksByUser(userId);
                favorites = favoriteService.getFavorites(userId);
                playlists = playlistService.getPlaylists(userId);
                uploadedTracks = uploadService.getUploadedTracks(userId);
                break;
            case "tracks":
                tracks = trackService.getAllTracksByUser(userId);
                break;
            case "playlist":
                playlists = playlistService.getPlaylists(userId);
                break;
            case "favorite":
                favorites = favoriteService.getFavorites(userId);
                break;
            case "upload":
                uploadedTracks = uploadService.getUploadedTracks(userId);
                break;
            case "history":
                history = historyService.getHistory(userId);
                break;
            default:
                // fallback: giống 'all'
                tracks = trackService.getAllTracksByUser(userId);
                favorites = favoriteService.getFavorites(userId);
        }

        // Stats
        int followers = 150;   // TODO: userService.getFollowerCount(userId);
        int following = 20;    // TODO: userService.getFollowingCount(userId);
        int tracksCount = uploadService.countUploads(userId);
        int playlistCount = playlistService.getPlaylists(userId).size();

        // Set attribute cho JSP
        request.setAttribute("tab", tab);
        request.setAttribute("username", username);
        request.setAttribute("userId", userId);

        request.setAttribute("followers", followers);
        request.setAttribute("following", following);
        request.setAttribute("tracksCount", tracksCount);
        request.setAttribute("playlistCount", playlistCount);

        request.setAttribute("tracks", tracks);
        request.setAttribute("favorites", favorites);
        request.setAttribute("playlists", playlists);
        request.setAttribute("uploads", uploadedTracks);
        request.setAttribute("history", history);
        
        // Check for upload success message
        String uploadSuccess = (String) session.getAttribute("uploadSuccess");
        if (uploadSuccess != null) {
            request.setAttribute("successMessage", uploadSuccess);
            session.removeAttribute("uploadSuccess");
        }

        // Forward
        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }
}