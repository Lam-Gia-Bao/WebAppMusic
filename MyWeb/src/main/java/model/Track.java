package model;

import java.sql.Timestamp;

/**
 * Track Model Class
 * Represents a music track in the WebAppMusic application
 */
public class Track {
    private int trackId;
    private int userId;
    private String title;
    private String trackLink;
    private String artist;
    private String genre;
    private String tags;
    private String description;
    private String privacy; // public, private, schedule
    private String artworkUrl;
    private String audioFileUrl;
    private int duration; // in seconds
    private int playCount;
    private int likeCount;
    private String buyLink;
    private String releaseDate;
    private String recordLabel;
    private String publisher;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    // User information (for display purposes)
    private String uploaderUsername;

    // Constructors
    public Track() {}

    public Track(String title, String artist) {
        this.title = title;
        this.artist = artist;
    }

    // Getters
    public int getTrackId() {
        return trackId;
    }

    public int getUserId() {
        return userId;
    }

    public String getTitle() {
        return title;
    }

    public String getTrackLink() {
        return trackLink;
    }

    public String getArtist() {
        return artist;
    }

    public String getGenre() {
        return genre;
    }

    public String getTags() {
        return tags;
    }

    public String getDescription() {
        return description;
    }

    public String getPrivacy() {
        return privacy;
    }

    public String getArtworkUrl() {
        return artworkUrl;
    }

    public String getAudioFileUrl() {
        return audioFileUrl;
    }

    public int getDuration() {
        return duration;
    }

    public int getPlayCount() {
        return playCount;
    }

    public int getLikeCount() {
        return likeCount;
    }

    public String getBuyLink() {
        return buyLink;
    }

    public String getReleaseDate() {
        return releaseDate;
    }

    public String getRecordLabel() {
        return recordLabel;
    }

    public String getPublisher() {
        return publisher;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public String getUploaderUsername() {
        return uploaderUsername;
    }

    // Setters
    public void setTrackId(int trackId) {
        this.trackId = trackId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setTrackLink(String trackLink) {
        this.trackLink = trackLink;
    }

    public void setArtist(String artist) {
        this.artist = artist;
    }

    public void setGenre(String genre) {
        this.genre = genre;
    }

    public void setTags(String tags) {
        this.tags = tags;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setPrivacy(String privacy) {
        this.privacy = privacy;
    }

    public void setArtworkUrl(String artworkUrl) {
        this.artworkUrl = artworkUrl;
    }

    public void setAudioFileUrl(String audioFileUrl) {
        this.audioFileUrl = audioFileUrl;
    }

    public void setDuration(int duration) {
        this.duration = duration;
    }

    public void setPlayCount(int playCount) {
        this.playCount = playCount;
    }

    public void setLikeCount(int likeCount) {
        this.likeCount = likeCount;
    }

    public void setBuyLink(String buyLink) {
        this.buyLink = buyLink;
    }

    public void setReleaseDate(String releaseDate) {
        this.releaseDate = releaseDate;
    }

    public void setRecordLabel(String recordLabel) {
        this.recordLabel = recordLabel;
    }

    public void setPublisher(String publisher) {
        this.publisher = publisher;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }

    public void setUploaderUsername(String uploaderUsername) {
        this.uploaderUsername = uploaderUsername;
    }

    @Override
    public String toString() {
        return "Track{" +
                "trackId=" + trackId +
                ", title='" + title + '\'' +
                ", artist='" + artist + '\'' +
                ", genre='" + genre + '\'' +
                '}';
    }
}
