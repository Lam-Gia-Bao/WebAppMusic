package service;

import java.util.List;
import java.util.Map;

import dao.AdminDAO;
import model.Playlist;
import model.Track;
import model.User;
import util.HashUtil;

/**
 * Admin Service - Business logic cho các thao tác quản trị
 */
public class AdminService {
    
    private final AdminDAO adminDAO;
    
    public AdminService() {
        this.adminDAO = new AdminDAO();
    }

    // ==================== USER MANAGEMENT ====================

    /**
     * Lấy tất cả người dùng
     */
    public List<User> getAllUsers() {
        return adminDAO.getAllUsers();
    }

    /**
     * Lấy người dùng theo ID
     */
    public User getUserById(int userId) {
        return adminDAO.getUserById(userId);
    }

    /**
     * Cập nhật thông tin người dùng
     */
    public boolean updateUser(User user) {
        if (user.getUsername() == null || user.getUsername().isBlank()) {
            throw new IllegalArgumentException("Tên người dùng không được để trống");
        }
        if (user.getEmail() == null || user.getEmail().isBlank()) {
            throw new IllegalArgumentException("Email không được để trống");
        }
        return adminDAO.updateUser(user);
    }

    /**
     * Xóa người dùng
     */
    public boolean deleteUser(int userId) {
        return adminDAO.deleteUser(userId);
    }

    /**
     * Thêm người dùng mới
     */
    public boolean createUser(String username, String email, String rawPassword, String fullName, String role) {
        if (username == null || username.isBlank()) {
            throw new IllegalArgumentException("Tên người dùng không được để trống");
        }
        if (email == null || email.isBlank()) {
            throw new IllegalArgumentException("Email không được để trống");
        }
        if (rawPassword == null || rawPassword.length() < 6) {
            throw new IllegalArgumentException("Mật khẩu phải có ít nhất 6 ký tự");
        }
        
        String passwordHash = HashUtil.sha256(rawPassword);
        return adminDAO.createUser(username.trim(), email.trim(), passwordHash, fullName, role);
    }

    /**
     * Kiểm tra xem user có phải admin không
     * Fallback: nếu username là 'admin' thì coi như admin
     */
    public boolean isAdmin(String username) {
        if (username == null) return false;
        
        // Fallback: kiểm tra username là 'admin' (trong trường hợp column role chưa được thêm)
        if ("admin".equalsIgnoreCase(username)) {
            return true;
        }
        
        // Kiểm tra từ database
        String role = adminDAO.getUserRole(username);
        return "admin".equalsIgnoreCase(role);
    }

    /**
     * Lấy role của user
     */
    public String getUserRole(String username) {
        if (username == null) return "user";
        
        // Fallback: nếu username là 'admin' thì trả về role admin
        if ("admin".equalsIgnoreCase(username)) {
            return "admin";
        }
        
        return adminDAO.getUserRole(username);
    }

    // ==================== TRACK MANAGEMENT ====================

    /**
     * Lấy tất cả bài hát
     */
    public List<Track> getAllTracks() {
        return adminDAO.getAllTracks();
    }

    /**
     * Lấy track theo ID
     */
    public Track getTrackById(int trackId) {
        return adminDAO.getTrackById(trackId);
    }

    /**
     * Cập nhật track
     */
    public boolean updateTrack(Track track) {
        if (track.getTitle() == null || track.getTitle().isBlank()) {
            throw new IllegalArgumentException("Tiêu đề bài hát không được để trống");
        }
        return adminDAO.updateTrack(track);
    }

    /**
     * Xóa track
     */
    public boolean deleteTrack(int trackId) {
        return adminDAO.deleteTrack(trackId);
    }

    /**
     * Lấy top bài hát được nghe nhiều nhất
     */
    public List<Track> getTopPlayedTracks(int limit) {
        return adminDAO.getTopPlayedTracks(limit);
    }

    // ==================== PLAYLIST MANAGEMENT ====================

    /**
     * Lấy tất cả playlist
     */
    public List<Playlist> getAllPlaylists() {
        return adminDAO.getAllPlaylists();
    }

    /**
     * Lấy playlist theo ID
     */
    public Playlist getPlaylistById(long playlistId) {
        return adminDAO.getPlaylistById(playlistId);
    }

    /**
     * Cập nhật playlist
     */
    public boolean updatePlaylist(Playlist playlist) {
        if (playlist.getName() == null || playlist.getName().isBlank()) {
            throw new IllegalArgumentException("Tên playlist không được để trống");
        }
        return adminDAO.updatePlaylist(playlist);
    }

    /**
     * Xóa playlist
     */
    public boolean deletePlaylist(long playlistId) {
        return adminDAO.deletePlaylist(playlistId);
    }

    // ==================== STATISTICS ====================

    /**
     * Lấy thống kê tổng quan
     */
    public Map<String, Integer> getDashboardStats() {
        Map<String, Integer> stats = new java.util.HashMap<>();
        stats.put("totalUsers", adminDAO.getTotalUsers());
        stats.put("totalTracks", adminDAO.getTotalTracks());
        stats.put("totalPlaylists", adminDAO.getTotalPlaylists());
        stats.put("totalPlays", adminDAO.getTotalPlays());
        return stats;
    }

    /**
     * Lấy thống kê người dùng hoạt động nhiều nhất
     */
    public List<Map<String, Object>> getMostActiveUsers(int limit) {
        return adminDAO.getMostActiveUsers(limit);
    }

    /**
     * Lấy thống kê lượt nghe theo ngày
     */
    public List<Map<String, Object>> getPlayStatsByDay(int days) {
        return adminDAO.getPlayStatsByDay(days);
    }

    /**
     * Lấy thống kê người dùng mới theo ngày
     */
    public List<Map<String, Object>> getNewUsersByDay(int days) {
        return adminDAO.getNewUsersByDay(days);
    }
}
