<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Đăng nhập - BeatFlow</title>
<link rel="stylesheet" href="assets/css/welcome.css">
<link rel="stylesheet" href="assets/css/login.css">
</head>
<body>
	<div class="login-container">
		<form class="login-box" action="login" method="post">
			<img src="assets/img/logo.png" width="60">
			<h2>Đăng nhập BeatFlow</h2>
			<input type="text" name="username" placeholder="Tên đăng nhập"
				required> <input type="password" name="password"
				placeholder="Mật khẩu" required>
			<button class="btn btn-primary btn-large" style="width: 100%">Đăng
				nhập</button>
			<p style="margin: 15px 0;">Hoặc đăng nhập bằng</p>
			<div class="social-login">
				<button type="button" class="btn btn-outline google">
					<img src="assets/img/google.png" class="zalo-icon"></i> Google
				</button>
				<button type="button" class="btn btn-outline facebook">
					<img src="assets/img/facebook.png" class="zalo-icon"></i> Facebook
				</button>
				<button type="button" class="btn btn-outline zalo">
					<img src="assets/img/zalo.png" class="zalo-icon"> Zalo
				</button>
			</div>
			<p style="margin-top: 20px">
				Chưa có tài khoản? <a href="register">Đăng ký</a>
			</p>
		</form>
	</div>
</body>
</html>
