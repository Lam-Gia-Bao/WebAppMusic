<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BeatFlow | Khám phá & Nghe nhạc</title>
    <link rel="stylesheet" href="assets/css/style.css">
</head>
<body>
    <!-- Thanh header -->
    <header class="bf-header">
        <div class="bf-header-inner">
            <div class="bf-logo">
                <img src="assets/img/logo.png" alt="BeatFlow logo" class="bf-logo-img">
                <span class="bf-logo-text">BeatFlow</span>
            </div>
            <nav class="bf-nav">
                <button class="btn btn-ghost">Đăng nhập</button>
                <button class="btn btn-primary">Tạo tài khoản</button>
                <a class="bf-link" href="#">Dành cho Nghệ sĩ</a>
            </nav>
        </div>
    </header>

    <!-- Hero Banner-->
 	<section class="bf-hero">
        <div class="bf-hero-bg"></div>

        <div class="bf-hero-content">
            <h1>Tìm kiếm.<br>Được mọi người tìm kiếm.</h1>
            <p>
                Tìm kiếm bản nhạc, danh sách phát mà bạn yêu thích hoặc trở thành nghệ sĩ được mọi người biết đến.
                <br>BeatFlow là một cộng đồng nơi người hâm mộ và nghệ sĩ cùng nhau khám phá và kết nối thông qua âm nhạc.
            </p>

            <div class="bf-hero-btns">
                <button class="btn btn-primary">Bắt đầu</button>
                <button class="btn btn-outline-light">Tìm hiểu thêm</button>
            </div>
        </div>
   	</section>

    <!-- Search bar -->
    <section class="bf-search-wrap">
        <div class="bf-search-inner">
            <input class="bf-search-input" type="search" placeholder="Tìm nghệ sĩ, ban nhạc, bài hát, podcast...">
            <span class="bf-or">hoặc</span>
            <button class="btn btn-primary">Tải nhạc lên</button>
        </div>
    </section>

    <!-- Trending -->
    <section class="bf-trending">
        <div class="bf-trending-inner">
            <p class="bf-trending-title">Nghe những gì đang thịnh hành miễn phí trên cộng đồng BeatFlow</p>
            <button class="btn btn-primary">Khám phá danh sách phát nổi bật</button>
        </div>
    </section>

    <!-- Apps -->
    <section class="bf-apps">
        <div class="bf-apps-container">
            <div class="bf-apps-right">
                <img src="assets/img/app-preview.png" alt="App preview" class="app-preview">
            </div>
            <div class="bf-apps-left">
                <h2>Không bao giờ ngừng nghe</h2>
                <div class="bf-apps-underline"></div>
                <p class="bf-apps-lead">BeatFlow có mặt trên Web, iOS, Android, Chromecast và nhiều nền tảng khác.</p>
                <div class="bf-store-buttons">
                    <img src="assets/img/appstore.png" alt="App Store" class="store-badge">
                    <img src="assets/img/googleplay.png" alt="Google Play" class="store-badge">
                </div>
            </div>
        </div>
    </section>

    <!-- Creators -->
    <section class="bf-creators">
    <div class="bf-creators-container">
        <div class="bf-creators-left">
            <h2>Kêu gọi tất cả nghệ sĩ</h2>
            <p>
                Tham gia BeatFlow để kết nối với người hâm mộ, chia sẻ âm nhạc và mở rộng cộng đồng của bạn. 
                Bạn còn chờ gì?
            </p>
            <button class="btn btn-outline">Tìm hiểu thêm</button>
        </div>

        <div class="bf-creators-right">
            <img src="assets/img/artist.png" alt="Artist" class="artist-image">
        </div>
    </div>
</section>

    <!-- Call to action -->
    <section class="bf-cta-join">
        <div class="bf-cta-inner">
            <h3>Cảm ơn bạn đã lắng nghe. Hãy tham gia ngay.</h3>
            <p>Lưu bài, theo dõi nghệ sĩ và tạo danh sách phát. Hoàn toàn miễn phí.</p>
            <button class="btn btn-primary">Tạo tài khoản</button>
            <p class="small">Đã có tài khoản? <a href="#">Đăng nhập</a></p>
        </div>
    </section>

    <!-- Footer -->
    <footer class="bf-footer">
        <div class="bf-footer-inner">
            <div class="bf-footer-links">
                <a href="#">Giới thiệu</a>
                <a href="#">Trợ giúp</a>
                <a href="#">Điều khoản & Quyền riêng tư</a>
                <a href="#">Liên hệ</a>
            </div>
            <div class="bf-footer-copyright">
                <small>© <span id="year"></span> BeatFlow. All rights reserved.</small>
            </div>
        </div>
    </footer>

    <script>
        // small script to set year and simple dot slider effect
        document.getElementById('year').innerText = new Date().getFullYear();
        // slider dots simple demo (non-animated)
        const dots = document.querySelectorAll('.bf-slider-dots .dot');
        dots.forEach((d,i) => d.addEventListener('click',()=>{
            dots.forEach(x=>x.classList.remove('active'));
            dots[i].classList.add('active');
        }));
    </script>
</body>
</html>
