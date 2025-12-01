<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Đăng nhập - BeatFlow</title>
<link rel="stylesheet" href="assets/css/home.css">

<style>
.login-container {
	min-height: 100vh;
	background: url("assets/img/backg-login.jpg") center/cover no-repeat fixed;
	position: relative;
	display: flex;
	align-items: center;
	justify-content: center;
}

.login-container::before {
	content: "";
	position: absolute;
	inset: 0;
	backdrop-filter: blur(3px);
	background: rgba(0, 0, 0, 0.45);
}

.login-box {
	position: relative;
	background: rgba(255, 255, 255, 0.95);
	width: 420px;
	border-radius: 14px;
	padding: 35px 30px;
	text-align: center;
	box-shadow: 0 12px 35px rgba(0, 0, 0, 0.25);
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

/* THÔNG BÁO LỖI */
.error-box {
	background: #ffdddd;
	border: 1px solid #ff7777;
	padding: 10px;
	border-radius: 8px;
	color: #b30000;
	font-weight: 600;
	margin-bottom: 15px;
}
</style>
</head>

<body>
	<div class="login-container">

		<form class="login-box" action="login" method="post">
			<img src="assets/img/logo.png" width="60">
			<h2>Đăng nhập BeatFlow</h2>

			<!-- HIỂN THỊ LỖI -->
			<%
			if (request.getAttribute("error") != null) {
			%>
			<div class="error-box">
				<%=request.getAttribute("error")%>
			</div>
			<%
			}
			%>

			<input type="text" name="username" placeholder="Tên đăng nhập"
				required> <input type="password" name="password"
				placeholder="Mật khẩu" required>

			<button class="btn btn-primary btn-large" style="width: 100%">Đăng
				nhập</button>

			<p style="margin: 15px 0;">Hoặc đăng nhập bằng</p>
			<div class="social-login">
				<button type="button" class="btn btn-outline google">
					<img src="assets/img/google.png" class="zalo-icon"> Google
				</button>
				<button type="button" class="btn btn-outline facebook">
					<img src="assets/img/facebook.png" class="zalo-icon">
					Facebook
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
