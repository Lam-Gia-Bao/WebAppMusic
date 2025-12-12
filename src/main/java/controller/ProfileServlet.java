package controller;

import java.io.IOException;
import java.util.Collections;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Playlist;
import service.FavoriteService;
import service.HistoryService;
import service.PlaylistService;
import service.TrackService;
import service.UploadService;

@WebServlet(name = "ProfileServlet", urlPatterns = {"/profile"})
public class ProfileServlet extends HttpServlet {

    private TrackService trackService;
    private FavoriteService favoriteService;
    private PlaylistService playlistService;
    private UploadService uploadService;
    private HistoryService historyService;

    @Override
    public void init() throws ServletException {
        // Khởi tạo service (có thể lấy từ DI container nếu dùng Spring, v.v.)
        this.trackService = new TrackService();
        this.favoriteService = new FavoriteService();
        this.playlistService = new PlaylistService();
        this.uploadService = new UploadService();
        this.historyService = new HistoryService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Lấy user đang xem (ví dụ từ session hoặc path)
        // Ở đây demo cứng userId = 1 và username = "Takezo"
        long userId = 1L;
        String username = "Takezo";

        String tab = request.getParameter("tab");
        if (tab == null || tab.isBlank()) {
            tab = "all";
        }

        // Nạp dữ liệu tối ưu theo tab
        List<String> tracks = Collections.emptyList();
        List<String> favorites = Collections.emptyList();
        List<Playlist> playlists = Collections.emptyList();
        List<String> uploads = Collections.emptyList();
        List<String> history = Collections.emptyList();

        switch (tab) {
            case "all":
                tracks = trackService.getAllTracksByUser(userId);
                favorites = favoriteService.getFavorites(userId);
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
                uploads = uploadService.getUploads(userId);
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
        int followers = 150;   // ví dụ: userService.getFollowerCount(userId);
        int following = 20;    // ví dụ: userService.getFollowingCount(userId);
        int tracksCount = tracks != null ? tracks.size() : trackService.countTracks(userId);

        // Set attribute cho JSP
        request.setAttribute("tab", tab);
        request.setAttribute("username", username);

        request.setAttribute("followers", followers);
        request.setAttribute("following", following);
        request.setAttribute("tracksCount", tracksCount);

        request.setAttribute("tracks", tracks);
        request.setAttribute("favorites", favorites);
        request.setAttribute("playlists", playlists);
        request.setAttribute("uploads", uploads);
        request.setAttribute("history", history);

        // Forward
        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }
}
