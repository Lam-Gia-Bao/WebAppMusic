<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Đăng nhập - BeatFlow</title>
<link rel="stylesheet" href="assets/css/home.css">
<style>
.login-container {
	min-height: 100vh;
	background: linear-gradient(120deg, #0f2027, #203a43, #2c5364);
	display: flex;
	align-items: center;
	justify-content: center;
}

.login-box {
	background: #fff;
	width: 420px;
	border-radius: 10px;
	padding: 35px 30px;
	text-align: center;
}

.login-box h2 {
	margin-bottom: 20px;
}

.login-box input {
	width: 100%;
	padding: 12px;
	margin-bottom: 15px;
	border-radius: 8px;
	border: 1px solid #ddd;
}

.social-login {
	display: flex;
	gap: 10px;
	justify-content: center;
	margin-top: 10px;
}

.social-login button {
	flex: 1;
	border-radius: 30px;
}
.social-login .zalo-icon {
	width: 16px;
	height: 16px;
	object-fit: contain;
}
</style>
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
