<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html lang="vi">

<head>
<meta charset="UTF-8">
<title>BeatFlow | Đăng nhập</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/styles.css">

<style>
.login-container {
	width: 380px;
	margin: 120px auto;
	padding: 30px;
	background-color: #181818;
	border-radius: 10px;
	box-shadow: 0 4px 20px rgba(0, 0, 0, 0.5);
}

.login-title {
	text-align: center;
	font-size: 26px;
	font-weight: bold;
	margin-bottom: 25px;
	color: #ff5500;
}

.login-group {
	margin-bottom: 18px;
}

.login-group label {
	font-size: 14px;
	font-weight: bold;
}

.login-group input {
	width: 100%;
	padding: 12px;
	margin-top: 6px;
	border-radius: 6px;
	border: none;
	background: #0d0d0d;
	color: white;
}

.btn-login {
	width: 100%;
	padding: 12px;
	background-color: #ff5500;
	color: white;
	border: none;
	border-radius: 6px;
	font-size: 16px;
	margin-top: 10px;
	cursor: pointer;
}

.btn-login:hover {
	background-color: #e04a00;
}

.error {
	text-align: center;
	color: #ff3333;
	margin-top: 12px;
}

.login-link {
	text-align: center;
	margin-top: 15px;
}

.login-link a {
	color: #ff5500;
	text-decoration: none;
}

.login-link a:hover {
	text-decoration: underline;
}
/* Logo trên form login */
.login-logo {
	text-align: center;
	margin-bottom: 15px;
}

.login-logo img {
	width: 90px;
	height: 90px;
	border-radius: 12px;
	object-fit: cover;
}

.login-title {
	text-align: center;
	font-size: 26px;
	margin-bottom: 20px;
	color: #ffffff;
}
</style>
</head>

<body>

	<div class="login-container">
		div class="login-logo"> <img
			src="${pageContext.request.contextPath}/assets/images/logo.png"
			alt="BeatFlow Logo">
	</div>
	<div class="login-title">Đăng nhập BeatFlow</div>
	<div class="social-login">
		<a href="#" class="social-btn google"> <img
			src="${pageContext.request.contextPath}/assets/img/google.png">
			Đăng nhập với Google
		</a> <a href="#" class="social-btn facebook"> <img
			src="${pageContext.request.contextPath}/assets/images/facebook.png">
			Đăng nhập với Facebook
		</a> <a href="#" class="social-btn zalo"> <img
			src="${pageContext.request.contextPath}/assets/images/zalo.png">
			Đăng nhập với Zalo
		</a>
	</div>

	<div class="divider">hoặc</div>

	<form action="login" method="post">

		<div class="login-group">
			<label>Tên đăng nhập</label> <input type="text" name="username"
				required>
		</div>

		<div class="login-group">
			<label>Mật khẩu</label> <input type="password" name="password"
				required>
		</div>

		<button type="submit" class="btn-login">Đăng nhập</button>

		<%
		if (request.getAttribute("error") != null) {
		%>
		<div class="error"><%=request.getAttribute("error")%></div>
		<%
		}
		%>

	</form>

	<div class="login-link">
		<p>
			Chưa có tài khoản? <a href="#">Đăng ký</a>
		</p>
	</div>

	</div>

</body>

</html>
