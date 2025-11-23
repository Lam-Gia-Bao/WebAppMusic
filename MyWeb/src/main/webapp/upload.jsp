<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>
<html lang="vi">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width,initial-scale=1" />
<title>Upload</title>

<!-- Bootstrap 5 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Bootstrap Icons -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"
	rel="stylesheet">
<link rel="stylesheet" href="assets/css/upload.css">
</head>
<body>

	<!-- close top-right -->
	<div class="close-circle" title="Close">
		<i class="bi bi-x"></i>
	</div>

	<!-- top bar -->
	<div class="topbar">
		<div class="container-fluid">
			<div class="brand">
				<!-- dùng image bạn upload làm logo (nếu cần) -->
				<img src="assets/img/logo.png" alt="logo"> <span
					style="margin-left: 6px; font-weight: 700;">Đăng tải</span>
			</div>
		</div>
	</div>

	<!-- page content -->
	<div class="page">

		<div class="upload-header mb-2">
			<h1 class="upload-title">Tải lên tập tin âm thanh của bạn.</h1>
			<div class="upload-sub">Để có chất lượng tốt nhất, hãy sử dụng
				các định dạng WAV, FLAC, AIFF hoặc ALAC. Dung lượng tệp tối đa là
				4GB khi chưa nén.</div>
		</div>

		<!-- Upload dashed area -->
		<div class="upload-box" id="dropzone">
			<div class="upload-inner">
				<!-- illustration: dùng file bạn up (đã có path) -->
				<img class="upload-illustration" src="assets/img/logo.png"
					alt="cloud icon">

				<div class="upload-hint">Kéo và thả tệp âm thanh của bạn ở đây
					để đăng tải.</div>

				<div>
					<label class="choose-btn" for="fileInput">Chọn tệp âm thanh</label> <input
						id="fileInput" type="file" accept="audio/*" multiple
						style="display: none;">
				</div>
			</div>
		</div>

		<!-- Record with microphone block -->
		<div class="mic-container">

			<!-- Header + Arrow -->
			<div
				class="mic-header d-flex justify-content-between align-items-center"
				onclick="toggleMicPanel()">

				<div class="d-flex align-items-center">
					<i class="bi bi-mic-fill mic-icon"></i>
				</div>

				<div class="text-center flex-grow-1 mic-title">
					Hoặc ghi lại âm thanh với microphone
					<div class="mic-sub">Tải lên bản ghi âm, cập nhật, tin tức hoặc phần giới thiệu cho các bản phát hành mới.</div>
				</div>

				<i id="micArrow" class="bi bi-chevron-down arrow-icon"></i>
			</div>

			<!-- Collapsible Panel -->
			<div id="micPanel" class="mic-panel">
				<hr class="mic-divider">

				<div class="mic-record-wrapper">
					<button class="record-btn">
						<i class="bi bi-record-circle"></i> Bắt đầu ghi âm
					</button>
					<div class="mic-timer">0:00</div>
				</div>

				<div class="mic-actions">
					<i class="bi bi-check-lg"></i> <i
						class="bi bi-arrow-counterclockwise"></i> <i
						class="bi bi-arrow-clockwise"></i> <i class="bi bi-trash"></i>
				</div>
			</div>

		</div>

		<!-- Footer -->
		<footer class="py-4"
			style="background: #0d0d0d; color: #bbb; font-size: 0.9rem;">
			<div class="container text-center">
				<div class="bf-footer-links">
					<div class="mb-3">
						<a href="#" class="text-secondary me-2">Trang chính thức</a> · <a
							href="#" class="text-secondary mx-2">Bảo mật</a> · <a href="#"
							class="text-secondary mx-2">Chính sách Cookie</a> · <a href="#"
							class="text-secondary mx-2">Trình quản lý Cookie</a> · <a
							href="#" class="text-secondary mx-2">Xuất bản</a> · <a href="#"
							class="text-secondary mx-2">Nguồn nghệ sĩ</a> · <a href="#"
							class="text-secondary mx-2">Tin tức</a> · <a href="#"
							class="text-secondary mx-2">Biểu đồ</a> · <a href="#"
							class="text-secondary mx-2">Uy tín</a>
					</div>
					<div class="text-secondary">
						Ngôn ngữ: <a href="#" class="text-primary fw-bold">Tiếng Việt
							(VN)</a>
					</div>
				</div>
			</div>
		</footer>

	</div>

	<!-- Optional JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

	<script>
    // Basic drag & drop visual behavior + file open
    const drop = document.getElementById('dropzone');
    const fileInput = document.getElementById('fileInput');

    drop.addEventListener('dragenter', e => { e.preventDefault(); drop.style.borderColor = '#5a5a5a'; });
    drop.addEventListener('dragover', e => { e.preventDefault(); });
    drop.addEventListener('dragleave', e => { e.preventDefault(); drop.style.borderColor = '' ;});
    drop.addEventListener('drop', e => {
      e.preventDefault();
      drop.style.borderColor = '';
      const files = e.dataTransfer.files;
      if(files && files.length) handleFiles(files);
    });

    fileInput.addEventListener('change', e => {
      const files = e.target.files;
      if(files && files.length) handleFiles(files);
    });

    function handleFiles(files){
      // demo: chỉ log tên file, bạn thay bằng upload ajax nếu cần
      const list = Array.from(files).map(f => f.name).join(', ');
      alert('Selected files:\\n' + list);
    }

    // close button (demo)
    document.querySelector('.close-circle').addEventListener('click', () => {
      // nếu là modal trong thực tế: đóng modal. Ở đây: redirect ra trang khác
      window.history.back();
    });

    function toggleMicPanel() {
        const panel = document.getElementById("micPanel");
        const arrow = document.getElementById("micArrow");

        if (panel.style.display === "block") {
            panel.style.display = "none";
            arrow.classList.remove("bi-chevron-up");
            arrow.classList.add("bi-chevron-down");
        } else {
            panel.style.display = "block";
            arrow.classList.remove("bi-chevron-down");
            arrow.classList.add("bi-chevron-up");
        }
    }
  </script>
</body>
</html>
