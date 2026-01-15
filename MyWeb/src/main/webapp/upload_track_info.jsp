<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>
<html lang="vi">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width,initial-scale=1" />
<title>Thông tin bài hát</title>

<!-- Bootstrap 5 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Bootstrap Icons -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"
	rel="stylesheet">
<link rel="stylesheet" href="assets/css/upload.css">
<link rel="stylesheet" href="assets/css/track_info.css">
</head>
<body>

	<!-- Close button top-right -->
	<div class="close-circle" title="Đóng" onclick="window.location.href='upload.jsp'">
		<i class="bi bi-x"></i>
	</div>

	<!-- Top bar -->
	<div class="topbar">
		<div class="container-fluid">
			<div class="brand">
				<img src="assets/img/logo.png" alt="logo"> 
				<span style="margin-left: 6px; font-weight: 700;">Thông tin bài hát</span>
			</div>
		</div>
	</div>

	<!-- Page content -->
	<div class="track-info-container">
		<form id="trackInfoForm" action="UploadTrackServlet" method="post" enctype="multipart/form-data">
			
			<!-- Left Column - Artwork Upload & Advanced Details -->
			<div class="left-column">
				<!-- Artwork Upload -->
				<div class="artwork-upload" id="artworkUpload">
					<input type="file" id="artworkInput" name="artwork" accept="image/*" style="display: none;">
					<label for="artworkInput" class="artwork-label">
						<i class="bi bi-image"></i>
						<div class="artwork-text">Thêm ảnh bìa</div>
					</label>
				</div>
				
				<!-- Audio File Upload -->
				<div class="audio-file-section" style="margin-top: 20px;">
					<label class="track-label" style="color: #999; font-size: 14px;">
						<i class="bi bi-music-note-beamed"></i> File âm thanh <span class="required">*</span>
					</label>
					<input type="file" id="audioFileInput" name="audioFile" accept="audio/*" 
						class="form-control" style="background: #1a1a1a; border: 1px solid #333; color: #fff; margin-top: 8px;" required>
					<small style="color: #666; font-size: 11px;">MP3, WAV, FLAC, AIFF, M4A</small>
				</div>
				
				<!-- Advanced Details -->
				<div class="advanced-section">
					<div class="advanced-header" onclick="toggleAdvanced()">
						<div class="advanced-title">
							<i class="bi bi-file-text"></i>
							<span>Thông tin nâng cao</span>
						</div>
						<i id="advancedArrow" class="bi bi-chevron-down"></i>
					</div>
					<div class="advanced-subtitle">Link mua, hãng thu, ngày phát hành, nhà xuất bản...</div>
					
					<div id="advancedPanel" class="advanced-panel">
						<hr class="advanced-divider">
						
						<!-- Buy/Download link -->
						<div class="form-group-track">
							<label class="track-label">Link mua/tải về</label>
							<input type="text" name="buyLink" class="track-input" 
								placeholder="https://">
						</div>

						<!-- Release Date -->
						<div class="form-group-track">
							<label class="track-label">Ngày phát hành</label>
							<input type="date" name="releaseDate" class="track-input">
						</div>

						<!-- Record Label -->
						<div class="form-group-track">
							<label class="track-label">Hãng thu âm</label>
							<input type="text" name="recordLabel" class="track-input" 
								placeholder="Nhập tên hãng thu">
						</div>

						<!-- Publisher -->
						<div class="form-group-track">
							<label class="track-label">Nhà xuất bản</label>
							<input type="text" name="publisher" class="track-input" 
								placeholder="Nhập tên nhà xuất bản">
						</div>
					</div>
				</div>
			</div>

			<!-- Right Column - Track Details & Upload Button -->
			<div class="right-column">
				
				<!-- Track Title -->
				<div class="form-group-track">
					<label class="track-label">
						Tên bài hát <span class="required">*</span>
					</label>
					<input type="text" name="trackTitle" class="track-input" 
						placeholder="Đặt tên cho bài hát của bạn" required>
				</div>

				<!-- Track Link -->
				<div class="form-group-track">
					<label class="track-label">Đường dẫn bài hát</label>
					<div class="track-link-wrapper">
						<span class="track-link-prefix">https://beatflow.com/track/</span>
						<input type="text" name="trackLink" class="track-link-input" 
							placeholder="ten-bai-hat">
					</div>
				</div>

				<!-- Main Artist -->
				<div class="form-group-track">
					<label class="track-label">
						Nghệ sĩ chính <i class="bi bi-question-circle help-icon"></i>
					</label>
					<input type="text" name="mainArtist" class="track-input" 
						placeholder="Thêm nghệ sĩ">
					<div class="artist-hint">Mẹo: Dùng dấu phẩy để thêm nhiều nghệ sĩ.</div>
				</div>

				<!-- Genre -->
				<div class="form-group-track">
					<label class="track-label">Thể loại</label>
					<div class="dropdown-wrapper">
						<input type="text" name="genre" class="track-input dropdown-input" 
							placeholder="Thêm hoặc tìm thể loại" readonly>
						<i class="bi bi-chevron-down dropdown-arrow"></i>
					</div>
				</div>

				<!-- Tags -->
				<div class="form-group-track">
					<label class="track-label">
						Thẻ tag <i class="bi bi-question-circle help-icon"></i>
					</label>
					<input type="text" name="tags" class="track-input" 
						placeholder="Thêm phong cách, tâm trạng, nhịp độ...">
				</div>

				<!-- Description -->
				<div class="form-group-track">
					<label class="track-label">Mô tả</label>
					<textarea name="description" class="track-textarea" rows="3"
						placeholder="Mô tả bài hát của bạn"></textarea>
					<div class="description-hint">Bài hát có mô tả thường được nghe và tương tác nhiều hơn.</div>
				</div>

				<!-- Track Privacy -->
				<div class="form-group-track">
					<label class="track-label">Quyền riêng tư</label>
					<div class="privacy-options">
						<label class="privacy-option">
							<input type="radio" name="privacy" value="public" checked>
							<span class="privacy-radio"></span>
							<span class="privacy-label-text">Công khai</span>
						</label>
						<label class="privacy-option">
							<input type="radio" name="privacy" value="private">
							<span class="privacy-radio"></span>
							<span class="privacy-label-text">Riêng tư</span>
						</label>
						<label class="privacy-option">
							<input type="radio" name="privacy" value="schedule">
							<span class="privacy-radio"></span>
							<span class="privacy-label-text">Lên lịch</span>
						</label>
					</div>
				</div>

				<!-- Upload Button -->
				<div class="upload-button-wrapper">
					<button type="submit" class="upload-submit-btn">Tải lên</button>
				</div>

				<!-- Terms -->
				<div class="terms-text">
					Khi tải lên, bạn xác nhận rằng âm thanh của bạn tuân thủ 
					<a href="#" class="terms-link">Điều khoản sử dụng</a> và không vi phạm quyền của người khác.
				</div>

			</div>

		</form>
	</div>

	<!-- Bootstrap JS -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
	
	<script>
		// Artwork preview
		document.getElementById('artworkInput').addEventListener('change', function(e) {
			const file = e.target.files[0];
			if (file) {
				const reader = new FileReader();
				reader.onload = function(event) {
					const artworkUpload = document.getElementById('artworkUpload');
					artworkUpload.style.backgroundImage = 'url(' + event.target.result + ')';
					artworkUpload.style.backgroundSize = 'cover';
					artworkUpload.style.backgroundPosition = 'center';
					artworkUpload.querySelector('.artwork-label').style.opacity = '0';
				};
				reader.readAsDataURL(file);
			}
		});

		// Toggle advanced details
		function toggleAdvanced() {
			const panel = document.getElementById('advancedPanel');
			const arrow = document.getElementById('advancedArrow');
			
			if (panel.style.display === 'block') {
				panel.style.display = 'none';
				arrow.classList.remove('bi-chevron-up');
				arrow.classList.add('bi-chevron-down');
			} else {
				panel.style.display = 'block';
				arrow.classList.remove('bi-chevron-down');
				arrow.classList.add('bi-chevron-up');
			}
		}

		// Form submission - actually submit the form to server
		document.getElementById('trackInfoForm').addEventListener('submit', function(e) {
			// Get the audio file from sessionStorage file name and validate
			const submitBtn = this.querySelector('.upload-submit-btn');
			submitBtn.disabled = true;
			submitBtn.textContent = 'Đang tải lên...';
			
			// Let form submit naturally to the server
			// Do NOT call e.preventDefault() - we want the form to submit
		});
	</script>
</body>
</html>
