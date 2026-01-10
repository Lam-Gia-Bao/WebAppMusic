package model;

/**
 * Artist Model - represents a user who uploads tracks (like SoundCloud artists)
 */
public class Artist {
    private long id;
    private String name;
    private String username;
    private String imagePath;
    private String bio;
    private int followerCount;
    private int trackCount;
    private boolean verified;

    public Artist() {}

    public Artist(long id, String name, String username, String imagePath, int followerCount, int trackCount) {
        this.id = id;
        this.name = name;
        this.username = username;
        this.imagePath = imagePath;
        this.followerCount = followerCount;
        this.trackCount = trackCount;
        this.verified = false;
    }

    // Getters
    public long getId() { return id; }
    public String getName() { return name; }
    public String getUsername() { return username; }
    public String getImagePath() { return imagePath; }
    public String getBio() { return bio; }
    public int getFollowerCount() { return followerCount; }
    public int getTrackCount() { return trackCount; }
    public boolean isVerified() { return verified; }

    // Setters
    public void setId(long id) { this.id = id; }
    public void setName(String name) { this.name = name; }
    public void setUsername(String username) { this.username = username; }
    public void setImagePath(String imagePath) { this.imagePath = imagePath; }
    public void setBio(String bio) { this.bio = bio; }
    public void setFollowerCount(int followerCount) { this.followerCount = followerCount; }
    public void setTrackCount(int trackCount) { this.trackCount = trackCount; }
    public void setVerified(boolean verified) { this.verified = verified; }
}
