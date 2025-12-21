<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Đăng nhập - BeatFlow</title>
<link rel="stylesheet" href="assets/css/login.css">
 <style>
        .login-container {
            min-height: 100vh;
            background: url("${pageContext.request.contextPath}/assets/img/backg-login.jpg") 
                        center/cover no-repeat fixed;
            position: relative;
            display: flex;
            align-items: center;
            justify-content: center;
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