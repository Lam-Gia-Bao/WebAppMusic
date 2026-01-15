package model;

import java.sql.Timestamp;

public class Playlist {
    private long id;
    private String name;
    private String description;
    private String artworkUrl;
    private String imagePath;
    private boolean isPublic;
    private int trackCount;
    private long userId;
    private String ownerUsername;
    private Timestamp createdAt;

    public Playlist() {}

    public Playlist(long id, String name, String description, String artworkUrl, boolean isPublic, int trackCount) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.artworkUrl = artworkUrl;
        this.imagePath = artworkUrl;
        this.isPublic = isPublic;
        this.trackCount = trackCount;
    }

    public long getId() { return id; }
    public String getName() { return name; }
    public String getDescription() { return description; }
    public String getArtworkUrl() { return artworkUrl; }
    public String getImagePath() { return imagePath; }
    public boolean isPublic() { return isPublic; }
    public int getTrackCount() { return trackCount; }
    public long getUserId() { return userId; }
    public String getOwnerUsername() { return ownerUsername; }
    public Timestamp getCreatedAt() { return createdAt; }

    public void setId(long id) { this.id = id; }
    public void setName(String name) { this.name = name; }
    public void setDescription(String description) { this.description = description; }
    public void setArtworkUrl(String artworkUrl) { 
        this.artworkUrl = artworkUrl; 
        this.imagePath = artworkUrl;
    }
    public void setImagePath(String imagePath) { 
        this.imagePath = imagePath; 
        this.artworkUrl = imagePath;
    }
    public void setPublic(boolean aPublic) { isPublic = aPublic; }
    public void setTrackCount(int trackCount) { this.trackCount = trackCount; }
    public void setUserId(long userId) { this.userId = userId; }
    public void setOwnerUsername(String ownerUsername) { this.ownerUsername = ownerUsername; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}