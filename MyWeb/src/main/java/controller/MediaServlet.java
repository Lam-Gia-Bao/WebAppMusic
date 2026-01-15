package controller;

import java.io.IOException;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet để serve file media (audio, artwork) từ thư mục lưu trữ cố định
 * URL pattern: /media/audio/{filename} hoặc /media/artwork/{filename}
 */
@WebServlet(name = "MediaServlet", urlPatterns = {"/media/*"})
public class MediaServlet extends HttpServlet {
    
    // Thư mục lưu trữ cố định - phải khớp với UploadTrackServlet
    private static final String PERSISTENT_UPLOAD_DIR = "D:/Web/uploads";
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null || pathInfo.equals("/")) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }
        
        // pathInfo sẽ là /audio/filename hoặc /artwork/filename
        // Loại bỏ dấu / đầu tiên
        String relativePath = pathInfo.substring(1);
        
        // Xây dựng đường dẫn file
        Path filePath = Paths.get(PERSISTENT_UPLOAD_DIR, relativePath);
        
        // Kiểm tra file tồn tại và là file hợp lệ
        if (!Files.exists(filePath) || !Files.isRegularFile(filePath)) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "File not found");
            return;
        }
        
        // Bảo mật: đảm bảo file nằm trong thư mục cho phép
        Path normalizedPath = filePath.normalize();
        Path baseDir = Paths.get(PERSISTENT_UPLOAD_DIR).normalize();
        if (!normalizedPath.startsWith(baseDir)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied");
            return;
        }
        
        // Xác định content type
        String contentType = getServletContext().getMimeType(filePath.toString());
        if (contentType == null) {
            // Mặc định cho audio
            String fileName = filePath.getFileName().toString().toLowerCase();
            if (fileName.endsWith(".mp3")) {
                contentType = "audio/mpeg";
            } else if (fileName.endsWith(".wav")) {
                contentType = "audio/wav";
            } else if (fileName.endsWith(".ogg")) {
                contentType = "audio/ogg";
            } else if (fileName.endsWith(".flac")) {
                contentType = "audio/flac";
            } else if (fileName.endsWith(".m4a")) {
                contentType = "audio/mp4";
            } else if (fileName.endsWith(".jpg") || fileName.endsWith(".jpeg")) {
                contentType = "image/jpeg";
            } else if (fileName.endsWith(".png")) {
                contentType = "image/png";
            } else if (fileName.endsWith(".gif")) {
                contentType = "image/gif";
            } else if (fileName.endsWith(".webp")) {
                contentType = "image/webp";
            } else {
                contentType = "application/octet-stream";
            }
        }
        
        // Set response headers
        response.setContentType(contentType);
        response.setContentLengthLong(Files.size(filePath));
        
        // Cho phép cache
        response.setHeader("Cache-Control", "public, max-age=86400"); // 1 day
        
        // Hỗ trợ Range requests cho streaming audio
        String rangeHeader = request.getHeader("Range");
        if (rangeHeader != null && rangeHeader.startsWith("bytes=")) {
            handleRangeRequest(request, response, filePath, contentType);
        } else {
            // Stream file bình thường
            try (OutputStream out = response.getOutputStream()) {
                Files.copy(filePath, out);
            }
        }
    }
    
    /**
     * Xử lý Range request để hỗ trợ seek trong audio player
     */
    private void handleRangeRequest(HttpServletRequest request, HttpServletResponse response, 
            Path filePath, String contentType) throws IOException {
        
        long fileSize = Files.size(filePath);
        String rangeHeader = request.getHeader("Range");
        
        // Parse range header: bytes=start-end hoặc bytes=start-
        String rangeValue = rangeHeader.substring(6); // Bỏ "bytes="
        String[] ranges = rangeValue.split("-");
        
        long start = 0;
        long end = fileSize - 1;
        
        try {
            if (ranges.length > 0 && !ranges[0].isEmpty()) {
                start = Long.parseLong(ranges[0]);
            }
            if (ranges.length > 1 && !ranges[1].isEmpty()) {
                end = Long.parseLong(ranges[1]);
            }
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_REQUESTED_RANGE_NOT_SATISFIABLE);
            return;
        }
        
        // Validate range
        if (start > end || start >= fileSize) {
            response.sendError(HttpServletResponse.SC_REQUESTED_RANGE_NOT_SATISFIABLE);
            return;
        }
        
        if (end >= fileSize) {
            end = fileSize - 1;
        }
        
        long contentLength = end - start + 1;
        
        // Set response headers cho partial content
        response.setStatus(HttpServletResponse.SC_PARTIAL_CONTENT);
        response.setContentType(contentType);
        response.setHeader("Accept-Ranges", "bytes");
        response.setHeader("Content-Range", "bytes " + start + "-" + end + "/" + fileSize);
        response.setContentLengthLong(contentLength);
        
        // Stream partial content
        try (OutputStream out = response.getOutputStream()) {
            byte[] buffer = new byte[8192];
            long remaining = contentLength;
            
            try (var inputStream = Files.newInputStream(filePath)) {
                inputStream.skip(start);
                
                while (remaining > 0) {
                    int toRead = (int) Math.min(buffer.length, remaining);
                    int read = inputStream.read(buffer, 0, toRead);
                    if (read == -1) break;
                    out.write(buffer, 0, read);
                    remaining -= read;
                }
            }
        }
    }
}
