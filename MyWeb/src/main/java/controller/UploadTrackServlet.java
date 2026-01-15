package controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.OptionalLong;
import java.util.UUID;

import dao.TrackDAO;
import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import model.Track;

/**
 * Servlet xử lý upload track lên server và lưu vào database
 */
@WebServlet(name = "UploadTrackServlet", urlPatterns = {"/UploadTrackServlet"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,      // 1MB
    maxFileSize = 1024 * 1024 * 100,       // 100MB
    maxRequestSize = 1024 * 1024 * 150     // 150MB total
)
public class UploadTrackServlet extends HttpServlet {
    
    // Thư mục lưu trữ cố định
    private static final String PERSISTENT_UPLOAD_DIR = "D:/Web/uploads";
    private static final String AUDIO_DIR = "audio";
    private static final String ARTWORK_DIR = "artwork";
    
    private TrackDAO trackDAO = new TrackDAO();
    private UserDAO userDAO = new UserDAO();
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        // Check session
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        String username = (String) session.getAttribute("user");
        OptionalLong userIdOpt = userDAO.findUserIdByUsername(username);
        
        if (userIdOpt.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "User not found");
            return;
        }
        
        int userId = (int) userIdOpt.getAsLong();
        
        try {
            // Tạo thư mục uploads cố định
            Path audioPath = Paths.get(PERSISTENT_UPLOAD_DIR, AUDIO_DIR);
            Path artworkPath = Paths.get(PERSISTENT_UPLOAD_DIR, ARTWORK_DIR);
            
            Files.createDirectories(audioPath);
            Files.createDirectories(artworkPath);
            
            System.out.println("[UploadTrack] Audio path: " + audioPath.toAbsolutePath());
            System.out.println("[UploadTrack] Artwork path: " + artworkPath.toAbsolutePath());
            
            // Get form fields
            String trackTitle = getPartValue(request.getPart("trackTitle"));
            String trackLink = getPartValue(request.getPart("trackLink"));
            String mainArtist = getPartValue(request.getPart("mainArtist"));
            String genre = getPartValue(request.getPart("genre"));
            String tags = getPartValue(request.getPart("tags"));
            String description = getPartValue(request.getPart("description"));
            String privacy = getPartValue(request.getPart("privacy"));
            String buyLink = getPartValue(request.getPart("buyLink"));
            String releaseDate = getPartValue(request.getPart("releaseDate"));
            String recordLabel = getPartValue(request.getPart("recordLabel"));
            String publisher = getPartValue(request.getPart("publisher"));
            
            // Handle audio file upload
            Part audioPart = request.getPart("audioFile");
            String audioFileUrl = null;
            if (audioPart != null && audioPart.getSize() > 0) {
                String audioFileName = UUID.randomUUID().toString() + "_" + getFileName(audioPart);
                Path audioFilePath = audioPath.resolve(audioFileName);
                System.out.println("[UploadTrack] Saving audio to: " + audioFilePath);
                try (InputStream input = audioPart.getInputStream()) {
                    Files.copy(input, audioFilePath, StandardCopyOption.REPLACE_EXISTING);
                }
                System.out.println("[UploadTrack] Audio saved successfully!");
                // URL dùng MediaServlet để serve file
                audioFileUrl = "media/audio/" + audioFileName;
            } else {
                System.out.println("[UploadTrack] No audio file uploaded or file is empty");
            }
            
            // Handle artwork upload
            Part artworkPart = request.getPart("artwork");
            String artworkUrl = null;
            if (artworkPart != null && artworkPart.getSize() > 0) {
                String artworkFileName = UUID.randomUUID().toString() + "_" + getFileName(artworkPart);
                Path artworkFilePath = artworkPath.resolve(artworkFileName);
                System.out.println("[UploadTrack] Saving artwork to: " + artworkFilePath);
                try (InputStream input = artworkPart.getInputStream()) {
                    Files.copy(input, artworkFilePath, StandardCopyOption.REPLACE_EXISTING);
                }
                System.out.println("[UploadTrack] Artwork saved successfully!");
                // URL dùng MediaServlet để serve file
                artworkUrl = "media/artwork/" + artworkFileName;
            }
            
            // Create Track object
            Track track = new Track();
            track.setUserId(userId);
            track.setTitle(trackTitle != null ? trackTitle : "Untitled");
            track.setTrackLink(trackLink);
            track.setArtist(mainArtist != null ? mainArtist : username);
            track.setGenre(genre);
            track.setTags(tags);
            track.setDescription(description);
            track.setPrivacy(privacy != null ? privacy : "public");
            track.setAudioFileUrl(audioFileUrl);
            track.setArtworkUrl(artworkUrl);
            track.setBuyLink(buyLink);
            track.setReleaseDate(releaseDate);
            track.setRecordLabel(recordLabel);
            track.setPublisher(publisher);
            
            // Save to database
            boolean success = trackDAO.createTrack(track);
            
            if (success) {
                // Redirect to profile page to see uploaded tracks
                // Make sure session is still valid
                session.setAttribute("uploadSuccess", "Track uploaded successfully!");
                response.sendRedirect("profile?tab=upload");
            } else {
                request.setAttribute("error", "Failed to save track to database");
                request.getRequestDispatcher("upload_track_info.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Upload error: " + e.getMessage());
            request.getRequestDispatcher("upload_track_info.jsp").forward(request, response);
        }
    }
    
    /**
     * Get text value from a Part (for form fields)
     */
    private String getPartValue(Part part) throws IOException {
        if (part == null) return null;
        // Check if it's a file or text field
        String contentDisp = part.getHeader("content-disposition");
        if (contentDisp != null && contentDisp.contains("filename=")) {
            // It's a file, not a text field
            return null;
        }
        try (InputStream is = part.getInputStream()) {
            byte[] bytes = is.readAllBytes();
            String value = new String(bytes, "UTF-8").trim();
            return value.isEmpty() ? null : value;
        }
    }
    
    /**
     * Extract filename from Part
     */
    private String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        if (contentDisp != null) {
            for (String token : contentDisp.split(";")) {
                if (token.trim().startsWith("filename")) {
                    String fileName = token.substring(token.indexOf('=') + 1).trim()
                            .replace("\"", "");
                    // Handle IE which sends full path
                    int index = fileName.lastIndexOf('\\');
                    if (index >= 0) {
                        fileName = fileName.substring(index + 1);
                    }
                    return fileName;
                }
            }
        }
        return "unknown";
    }
}
