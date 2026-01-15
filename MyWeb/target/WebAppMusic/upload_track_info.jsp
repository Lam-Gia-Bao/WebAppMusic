<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>
<html lang="vi">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width,initial-scale=1" />
<title>Track Info</title>

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
	<div class="close-circle" title="Close" onclick="window.location.href='upload.jsp'">
		<i class="bi bi-x"></i>
	</div>

	<!-- Top bar -->
	<div class="topbar">
		<div class="container-fluid">
			<div class="brand">
				<img src="assets/img/logo.png" alt="logo"> 
				<span style="margin-left: 6px; font-weight: 700;">Track info</span>
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
						<div class="artwork-text">Add new artwork</div>
					</label>
				</div>
				
				<!-- Audio File Upload -->
				<div class="audio-file-section" style="margin-top: 20px;">
					<label class="track-label" style="color: #999; font-size: 14px;">
						<i class="bi bi-music-note-beamed"></i> Audio File <span class="required">*</span>
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
							<span>Advanced details</span>
						</div>
						<i id="advancedArrow" class="bi bi-chevron-down"></i>
					</div>
					<div class="advanced-subtitle">Buy link, record label, release date, publisher...</div>
					
					<div id="advancedPanel" class="advanced-panel">
						<hr class="advanced-divider">
						
						<!-- Buy/Download link -->
						<div class="form-group-track">
							<label class="track-label">Buy/Download link</label>
							<input type="text" name="buyLink" class="track-input" 
								placeholder="https://">
						</div>

						<!-- Release Date -->
						<div class="form-group-track">
							<label class="track-label">Release Date</label>
							<input type="date" name="releaseDate" class="track-input">
						</div>

						<!-- Record Label -->
						<div class="form-group-track">
							<label class="track-label">Record Label</label>
							<input type="text" name="recordLabel" class="track-input" 
								placeholder="Enter label name">
						</div>

						<!-- Publisher -->
						<div class="form-group-track">
							<label class="track-label">Publisher</label>
							<input type="text" name="publisher" class="track-input" 
								placeholder="Enter publisher">
						</div>
					</div>
				</div>
			</div>

			<!-- Right Column - Track Details & Upload Button -->
			<div class="right-column">
				
				<!-- Track Title -->
				<div class="form-group-track">
					<label class="track-label">
						Track title <span class="required">*</span>
					</label>
					<input type="text" name="trackTitle" class="track-input" 
						placeholder="Name your track" required>
				</div>

				<!-- Track Link -->
				<div class="form-group-track">
					<label class="track-label">Track link</label>
					<div class="track-link-wrapper">
						<span class="track-link-prefix">https://soundcloud.com/hamza-shahid-</span>
						<input type="text" name="trackLink" class="track-link-input" 
							placeholder="714730142">
					</div>
				</div>

				<!-- Main Artist -->
				<div class="form-group-track">
					<label class="track-label">
						Main Artist(s) <i class="bi bi-question-circle help-icon"></i>
					</label>
					<input type="text" name="mainArtist" class="track-input" 
						placeholder="Add artists">
					<div class="artist-hint">Tip: Use commas to add multiple artist names.</div>
				</div>

				<!-- Genre -->
				<div class="form-group-track">
					<label class="track-label">Genre</label>
					<div class="dropdown-wrapper">
						<input type="text" name="genre" class="track-input dropdown-input" 
							placeholder="Add or search for genre" readonly>
						<i class="bi bi-chevron-down dropdown-arrow"></i>
					</div>
				</div>

				<!-- Tags -->
				<div class="form-group-track">
					<label class="track-label">
						Tags <i class="bi bi-question-circle help-icon"></i>
					</label>
					<input type="text" name="tags" class="track-input" 
						placeholder="Add styles, moods, tempo...">
				</div>

				<!-- Description -->
				<div class="form-group-track">
					<label class="track-label">Description</label>
					<textarea name="description" class="track-textarea" rows="3"
						placeholder="Describe your track"></textarea>
					<div class="description-hint">Tracks with descriptions tend to get more plays and engagements.</div>
				</div>

				<!-- Track Privacy -->
				<div class="form-group-track">
					<label class="track-label">Track Privacy</label>
					<div class="privacy-options">
						<label class="privacy-option">
							<input type="radio" name="privacy" value="public" checked>
							<span class="privacy-radio"></span>
							<span class="privacy-label-text">Public</span>
						</label>
						<label class="privacy-option">
							<input type="radio" name="privacy" value="private">
							<span class="privacy-radio"></span>
							<span class="privacy-label-text">Private</span>
						</label>
						<label class="privacy-option">
							<input type="radio" name="privacy" value="schedule">
							<span class="privacy-radio"></span>
							<span class="privacy-label-text">Schedule</span>
						</label>
					</div>
				</div>

				<!-- Upload Button -->
				<div class="upload-button-wrapper">
					<button type="submit" class="upload-submit-btn">Upload</button>
				</div>

				<!-- Terms -->
				<div class="terms-text">
					By uploading, you confirm that your sounds comply with our 
					<a href="#" class="terms-link">Terms of Use</a> and you don't infringe anyone else's rights.
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
			submitBtn.textContent = 'Uploading...';
			
			// Let form submit naturally to the server
			// Do NOT call e.preventDefault() - we want the form to submit
		});
	</script>
</body>
</html>
