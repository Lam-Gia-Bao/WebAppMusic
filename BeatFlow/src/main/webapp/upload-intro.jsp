<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giới thiệu tải nhạc lên | BeatFlow</title>
    <link rel="stylesheet" href="assets/css/style.css">
    <link rel="stylesheet" href="assets/css/header.css">
    <link rel="stylesheet" href="assets/css/upload-intro.css">
</head>
<body>
    <!-- Header (same as main site) -->
    <header class="bf-header">
        <div class="bf-header-inner">
            <div class="bf-left">
                <div class="bf-logo">
                    <img src="assets/img/logo.png" alt="BeatFlow logo" class="bf-logo-img">
                    <span class="bf-logo-text">BeatFlow</span>
                </div>
                <nav class="bf-main-nav">
                    <a href="#" class="nav-link">Home</a>
                    <a href="#" class="nav-link">Feed</a>
                    <a href="#" class="nav-link">Library</a>
                </nav>
            </div>
            <div class="bf-search">
                <input class="bf-header-search" type="search" placeholder="Search for artists, bands, tracks, podcasts">
            </div>
            <div class="bf-actions">
                <a class="bf-link" href="#">Sign in</a>
                <a class="btn btn-outline-light" href="#">Create account</a>
                <a class="bf-link upload-active" href="upload-intro.jsp">Upload</a>
            </div>
        </div>
    </header>
    <div class="upload-hero">
        <div class="upload-hero-content">
            <h1>First upload to first album</h1>
            <p>Share your tracks and access the tools you need to break through and build your legacy.</p>
            <a href="#" class="btn btn-primary upload-btn">Upload your first track</a>
        </div>
    </div>
    <div class="upload-features">
        <div class="upload-feature">
            <h3>Real-time stats</h3>
            <p>See which fans are listening to your tracks and where your top fans are, all in real-time.</p>
        </div>
        <div class="upload-feature">
            <h3>Find your community</h3>
            <p>Share your work with millions of daily active listeners or share a private link with a few very special people.</p>
        </div>
        <div class="upload-feature">
            <h3>Connect directly with fans</h3>
            <p>With direct messaging and in-track comments, you can always be in touch with your fans, whether they are on your block or on the other side of the world.</p>
        </div>
    </div>
    <div class="upload-testimonials">
        <div class="upload-testimonials-title">Made here, played everywhere</div>
        <div class="upload-testimonials-desc">Join the world’s most diverse community of creators, from those sharing their first track to buzzworthy acts. No matter where you’re at in your career, BeatFlow’s what’s next.</div>
        <div class="testimonial-list">
            <div class="testimonial">
                <img src="assets/img/artist1.jpg" alt="Eli Sostre" class="testimonial-img">
                <div class="testimonial-name">Eli Sostre</div>
                <div class="testimonial-follow">479K</div>
                <div class="testimonial-quote">“BeatFlow allowed me to have a place I could instantly upload my songs and send my thoughts and feelings out to people all over the world in a simple way.”</div>
            </div>
            <div class="testimonial">
                <img src="assets/img/artist2.jpg" alt="Polari" class="testimonial-img">
                <div class="testimonial-name">Polari</div>
                <div class="testimonial-follow">62.1K</div>
                <div class="testimonial-quote">“BeatFlow is a place for artists to share their art, grow their network, and create opportunities all while increasing their personal net worth.”</div>
            </div>
            <div class="testimonial">
                <img src="assets/img/artist3.jpg" alt="Witt Lowry" class="testimonial-img">
                <div class="testimonial-name">Witt Lowry</div>
                <div class="testimonial-follow">136K</div>
                <div class="testimonial-quote">“BeatFlow is an essential tool for independent artists like myself. From the very beginning, it has provided me with a simple and effective way to share my music with the world!”</div>
            </div>
        </div>
    </div>
    <div class="upload-cta">
        <h3>Join Now</h3>
        <p>Start your journey and share your music with the world.</p>
        <a href="#" class="btn btn-primary">Join Now</a>
    </div>

    <!-- Connect / Tools section -->
    <section class="upload-connect">
        <div class="upload-connect-inner">
            <h2>Connect with fans and see who's listening</h2>
            <div class="upload-underline"></div>
            <p class="upload-lead">Uploading is just the beginning. BeatFlow gives you the tools to level up your career.</p>

            <div class="upload-connect-cols">
                <div class="connect-card">
                    <h4>Share your tracks anywhere on the web</h4>
                    <p>Use the embed player and audio cards to share your tracks wherever your audience is: from music blogs to your Twitter stream.</p>
                </div>
                <div class="connect-card">
                    <h4>Get to know and connect with your audience</h4>
                    <p>Measure your progress with stats and interact with your fans directly via comments and messages.</p>
                </div>
                <div class="connect-card">
                    <h4>Take creator tools with you anytime and anywhere</h4>
                    <p>Whether you're in the studio, at home or on a tour bus, keep your community humming with our mobile app for creators.</p>
                </div>
            </div>

            <div class="connect-graphic">
                <img src="assets/img/app-preview.png" alt="Stats preview">
            </div>

            <div class="connect-actions">
                <a class="btn-light" href="#">Try it free</a>
                <a class="learn-pro" href="#">Learn more about Pro plans</a>
            </div>
        </div>
    </section>
</body>
</html>
