package model;

public class Playlist {
    private long id;
    private String name;
    private int trackCount;

    public Playlist() {}

    public Playlist(long id, String name, int trackCount) {
        this.id = id;
        this.name = name;
        this.trackCount = trackCount;
    }

    public long getId() { return id; }
    public String getName() { return name; }
    public int getTrackCount() { return trackCount; }

    public void setId(long id) { this.id = id; }
    public void setName(String name) { this.name = name; }
    public void setTrackCount(int trackCount) { this.trackCount = trackCount; }
}