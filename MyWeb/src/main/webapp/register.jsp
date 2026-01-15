<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Đăng ký - BeatFlow</title>
   
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/login.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">

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
        
        /* Success Modal */
        .success-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.7);
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 9999;
            animation: fadeIn 0.3s ease;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
        
        .success-modal {
            background: white;
            border-radius: 20px;
            padding: 40px;
            text-align: center;
            max-width: 400px;
            width: 90%;
            animation: slideUp 0.4s ease;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
        }
        
        @keyframes slideUp {
            from { transform: translateY(50px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }
        
        .success-icon {
            width: 80px;
            height: 80px;
            background: linear-gradient(135deg, #00c853, #69f0ae);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            animation: bounce 0.6s ease;
        }
        
        @keyframes bounce {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.1); }
        }
        
        .success-icon i {
            font-size: 40px;
            color: white;
        }
        
        .success-modal h2 {
            color: #333;
            margin-bottom: 10px;
            font-size: 24px;
        }
        
        .success-modal p {
            color: #666;
            margin-bottom: 20px;
            line-height: 1.6;
        }
        
        .success-modal .email-highlight {
            color: #f50;
            font-weight: bold;
        }
        
        .success-modal .btn-login {
            background: linear-gradient(135deg, #f50 0%, #ff8c00 100%);
            color: white;
            border: none;
            padding: 12px 40px;
            border-radius: 25px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            transition: transform 0.2s, box-shadow 0.2s;
        }
        
        .success-modal .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 20px rgba(255, 85, 0, 0.4);
        }
        
        .success-modal .email-note {
            font-size: 13px;
            color: #999;
            margin-top: 15px;
        }
        
        .success-modal .email-note i {
            color: #f50;
        }
    </style>
</head>

<body>

<div class="login-container">

    <form class="login-box" action="register" method="post">

        <img src="${pageContext.request.contextPath}/assets/img/logo.png" width="60">
        <h2>Tạo tài khoản BeatFlow</h2>

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

<!-- Success Modal -->
<% if (request.getAttribute("success") != null && (Boolean) request.getAttribute("success")) { %>
<div class="success-overlay" id="successModal">
    <div class="success-modal">
        <div class="success-icon">
            <i class="bi bi-check-lg"></i>
        </div>
        <h2>Đăng ký thành công!</h2>
        <p>
            Chào mừng bạn đến với <strong>BeatFlow</strong>!<br>
            Email xác nhận đã được gửi đến<br>
            <span class="email-highlight"><%= request.getAttribute("successEmail") %></span>
        </p>
        <a href="login" class="btn-login">Đăng nhập ngay</a>
        <p class="email-note">
            <i class="bi bi-envelope-check"></i> Kiểm tra hộp thư của bạn!
        </p>
    </div>
</div>
<% } %>

</body>
</html>