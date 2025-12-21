document.addEventListener('DOMContentLoaded', () => {
  const drop = document.getElementById('dropzone');
  const fileInput = document.getElementById('fileInput');
  const closeCircle = document.querySelector('.close-circle');

  if (drop && fileInput) {
    drop.addEventListener('dragenter', e => {
      e.preventDefault();
      drop.style.borderColor = '#5a5a5a';
    });

    drop.addEventListener('dragover', e => {
      e.preventDefault();
    });

    drop.addEventListener('dragleave', e => {
      e.preventDefault();
      drop.style.borderColor = '';
    });

    drop.addEventListener('drop', e => {
      e.preventDefault();
      drop.style.borderColor = '';
      const { files } = e.dataTransfer;
      if (files && files.length) handleFiles(files);
    });

    fileInput.addEventListener('change', e => {
      const { files } = e.target;
      if (files && files.length) handleFiles(files);
    });
  }

  function handleFiles(files) {
    if (files && files.length > 0) {
      // Store selected files in sessionStorage
      const fileNames = Array.from(files).map(f => f.name);
      sessionStorage.setItem('selectedAudioFiles', JSON.stringify(fileNames));
      
      // Redirect to track info page
      window.location.href = 'upload_track_info.jsp';
    }
  }

  if (closeCircle) {
    closeCircle.addEventListener('click', () => {
      window.history.back();
    });
  }

  const micPanel = document.getElementById('micPanel');
  const micArrow = document.getElementById('micArrow');
  window.toggleMicPanel = function toggleMicPanel() {
    if (!micPanel || !micArrow) return;

    if (micPanel.style.display === 'block') {
      micPanel.style.display = 'none';
      micArrow.classList.remove('bi-chevron-up');
      micArrow.classList.add('bi-chevron-down');
    } else {
      micPanel.style.display = 'block';
      micArrow.classList.remove('bi-chevron-down');
      micArrow.classList.add('bi-chevron-up');
    }
  };
});
