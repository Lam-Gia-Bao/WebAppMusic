<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>BeatFlow | Khám phá & Nghe nhạc trực tuyến</title>
    <link rel="stylesheet" href="assets/css/style.css">
</head>
<body>
    <!-- Thanh tiêu đề -->
    <header class="header">
        <div class="logo">BeatFlow</div>
        <div class="nav-buttons">
            <button class="btn-outline">Đăng nhập</button>
            <button class="btn-primary">Tạo tài khoản</button>
            <a href="#" class="link">Dành cho Nghệ sĩ</a>
        </div>
    </header>

    <!-- Khu vực giới thiệu -->
    <section class="hero">
        <div class="hero-content">
            <h1>Khám phá.<br>Được khám phá.</h1>
            <p>Tìm bản nhạc yêu thích tiếp theo của bạn, hoặc trở thành nghệ sĩ được mọi người biết đến. BeatFlow là nơi kết nối người yêu nhạc và các nghệ sĩ với nhau.</p>
            <button class="btn-primary">Bắt đầu ngay</button>
        </div>
        <div class="hero-bg"></div>
    </section>

    <!-- Thanh tìm kiếm -->
    <section class="search-section">
        <input type="text" placeholder="Tìm kiếm nghệ sĩ, bài hát, podcast...">
        <button class="btn-primary">Tải nhạc của bạn lên</button>
    </section>

    <!-- Phần xu hướng -->
    <section class="trending">
        <h3>Khám phá những gì đang thịnh hành trên cộng đồng BeatFlow</h3>
        <button class="btn-outline">Nghe danh sách phát nổi bật</button>
    </section>

    <!-- Phần ứng dụng di động -->
    <section class="apps">
        <div class="app-text">
            <h2>Âm nhạc mọi lúc mọi nơi</h2>
            <p>BeatFlow có mặt trên Web, iOS, Android, Chromecast và nhiều nền tảng khác.</p>
            <div class="app-buttons">
                <img src="assets/img/appstore.png" alt="App Store">
                <img src="assets/img/googleplay.png" alt="Google Play">
            </div>
        </div>
        <div class="app-images">
            <img src="assets/img/app-preview.png" alt="Xem trước ứng dụng">
        </div>
    </section>

    <!-- Kêu gọi nghệ sĩ -->
    <section class="creators">
        <div class="creator-text">
            <h2>Kêu gọi tất cả nghệ sĩ</h2>
            <p>Tham gia BeatFlow để chia sẻ âm nhạc của bạn, kết nối với người hâm mộ và phát triển cộng đồng của riêng bạn. Bạn còn chờ gì nữa?</p>
            <button class="btn-outline">Tìm hiểu thêm</button>
        </div>
        <div class="creator-img">
            <img src="assets/img/artist.png" alt="Nghệ sĩ">
        </div>
    </section>

    <!-- Chân trang -->
    <footer class="footer">
        <h3>Cảm ơn bạn đã lắng nghe. Hãy tham gia ngay hôm nay.</h3>
        <p>Lưu bài hát, theo dõi nghệ sĩ và tạo danh sách phát của riêng bạn. Miễn phí hoàn toàn.</p>
        <button class="btn-primary">Tạo tài khoản</button>
        <p class="small-text">Đã có tài khoản? <a href="#">Đăng nhập</a></p>
    </footer>
</body>
</html>
