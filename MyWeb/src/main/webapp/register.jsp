<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
    <title>Đăng ký - BeatFlow</title>
   
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/login.css">

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

    <form class="login-box" action="register" method="post">

        <img src="${pageContext.request.contextPath}/assets/img/logo.png" width="60">
        <h2>Tạo tài khoản BeatFlow</h2>

     <!-- HIỂN THỊ LỖI -->
			<c:if test="${not empty error}">
			<div class="error-box">
				${error}
			</div>
			</c:if>

        <input type="text" name="username" placeholder="Tên đăng nhập" required>
        <input type="email" name="email" placeholder="Email" required>
        <input type="password" name="password" placeholder="Mật khẩu" required>

        <button class="btn btn-primary btn-large" style="width:100%">
            Đăng ký
        </button>

        <p style="margin: 15px 0;">Hoặc đăng nhập bằng</p>

        <div class="social-login">
            <button type="button" class="btn btn-outline google">
                <img src="${pageContext.request.contextPath}/assets/img/google.png" class="zalo-icon"> Google
            </button>

            <button type="button" class="btn btn-outline facebook">
                <img src="${pageContext.request.contextPath}/assets/img/facebook.png" class="zalo-icon"> Facebook
            </button>

            <button type="button" class="btn btn-outline zalo">
                <img src="${pageContext.request.contextPath}/assets/img/zalo.png" class="zalo-icon"> Zalo
            </button>
        </div>

        <p style="margin-top:20px">
            Đã có tài khoản? <a href="login">Đăng nhập</a>
        </p>

    </form>

</div>

</body>
</html>