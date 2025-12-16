// Helper function to wait for element
function waitForElement(selector, timeout = 5000) {
  return new Promise((resolve) => {
    const startTime = Date.now();
    const checkElement = () => {
      const element = document.querySelector(selector);
      if (element) {
        resolve(element);
      } else if (Date.now() - startTime < timeout) {
        requestAnimationFrame(checkElement);
      } else {
        resolve(null);
      }
    };
    checkElement();
  });
}

// Initialize after all DOM is ready
function initializeApp() {
  // Profile dropdown
  const dropdownButton = document.getElementById('dropdownMenuButton');
  const dropdownMenu = document.getElementById('dropdownMenu');

  // Notifications dropdown
  const notificationsButton = document.getElementById('notificationsMenuButton');
  const notificationsMenu = document.getElementById('notificationsMenu');

  // Messages dropdown
  const messagesButton = document.getElementById('messagesMenuButton');
  const messagesMenu = document.getElementById('messagesMenu');

  if (dropdownButton && dropdownMenu) {
    dropdownButton.addEventListener('click', function(e) {
      e.stopPropagation();
      dropdownMenu.classList.toggle('show');
      if (messagesMenu) messagesMenu.classList.remove('show');
      if (notificationsMenu) notificationsMenu.classList.remove('show');
    });
  }

  if (notificationsButton && notificationsMenu) {
    notificationsButton.addEventListener('click', function(e) {
      e.stopPropagation();
      notificationsMenu.classList.toggle('show');
      if (dropdownMenu) dropdownMenu.classList.remove('show');
      if (messagesMenu) messagesMenu.classList.remove('show');
    });
  }

  if (messagesButton && messagesMenu) {
    messagesButton.addEventListener('click', function(e) {
      e.stopPropagation();
      messagesMenu.classList.toggle('show');
      if (dropdownMenu) dropdownMenu.classList.remove('show');
      if (notificationsMenu) notificationsMenu.classList.remove('show');
    });
  }

  // Close dropdowns when clicking outside
  document.addEventListener('click', function(e) {
    if (dropdownMenu && !dropdownMenu.contains(e.target) && e.target !== dropdownButton) {
      dropdownMenu.classList.remove('show');
    }
    if (notificationsMenu && !notificationsMenu.contains(e.target) && e.target !== notificationsButton) {
      notificationsMenu.classList.remove('show');
    }
    if (messagesMenu && !messagesMenu.contains(e.target) && e.target !== messagesButton) {
      messagesMenu.classList.remove('show');
    }
  });

  // Handle playlist action menus
  const allActionButtons = document.querySelectorAll('.btn-action');
  allActionButtons.forEach(button => {
    button.addEventListener('click', function(e) {
      const icon = this.querySelector('i');
      const isThreeDots = icon && icon.classList.contains('bi-three-dots');
      if (isThreeDots) {
        e.stopPropagation();
        const actionDiv = this.parentElement;
        const playlistCard = actionDiv.closest('.playlist-card');
        if (!playlistCard) return;

        const titleEl = playlistCard.querySelector('.playlist-title');
        const artistEl = playlistCard.querySelector('.playlist-desc');
        const imgEl = playlistCard.querySelector('.playlist-img');
        const title = titleEl ? titleEl.textContent : '';
        const artist = artistEl ? artistEl.textContent : '';
        const imgSrc = imgEl ? imgEl.src : '';

        let menu = actionDiv.querySelector('.action-menu-dropdown');
        if (!menu) {
          menu = document.createElement('div');
          menu.className = 'action-menu-dropdown';
          menu.innerHTML = `
            <div class="action-menu-preview">
              <img src="${imgSrc}" alt="Preview">
              <div class="action-menu-play-icon">
                <i class="bi bi-play-fill"></i>
              </div>
            </div>
            <div class="action-menu-info">
              <div class="action-menu-title">${title}</div>
              <div class="action-menu-artist">${artist}</div>
            </div>
            <a href="#" class="action-menu-item">
              <i class="bi bi-repeat"></i>
              <span>Đăng lại</span>
            </a>
            <a href="#" class="action-menu-item">
              <i class="bi bi-share"></i>
              <span>Chia sẻ</span>
            </a>
            <a href="#" class="action-menu-item">
              <i class="bi bi-bookmark"></i>
              <span>Thêm vào playlist</span>
            </a>
            <a href="#" class="action-menu-item">
              <i class="bi bi-justify"></i>
              <span>Thêm vào danh sách chờ</span>
            </a>
          `;
          actionDiv.appendChild(menu);
        }
        menu.classList.toggle('show');
      }
    });
  });

  // Close action menus when clicking outside
  document.addEventListener('click', function(e) {
    const allMenus = document.querySelectorAll('.action-menu-dropdown.show');
    allMenus.forEach(menu => {
      if (!menu.contains(e.target) && !e.target.closest('.btn-action')) {
        menu.classList.remove('show');
      }
    });
  });

  // Handle history action menus
  const historyActionButtons = document.querySelectorAll('.history-action-btn');
  historyActionButtons.forEach(button => {
    button.addEventListener('click', function(e) {
      const icon = this.querySelector('i');
      const isThreeDots = icon && icon.classList.contains('bi-three-dots');
      if (isThreeDots) {
        e.stopPropagation();
        const historyItem = this.closest('.history-item');
        if (!historyItem) return;

        let menu = historyItem.querySelector('.history-menu-dropdown');
        if (!menu) {
          menu = document.createElement('div');
          menu.className = 'history-menu-dropdown';
          menu.innerHTML = `
            <a href="#" class="action-menu-item">
              <i class="bi bi-repeat"></i>
              <span>Đăng lại</span>
            </a>
            <a href="#" class="action-menu-item">
              <i class="bi bi-share"></i>
              <span>Chia sẻ</span>
            </a>
            <a href="#" class="action-menu-item">
              <i class="bi bi-justify"></i>
              <span>Thêm vào danh sách chờ</span>
            </a>
            <a href="#" class="action-menu-item">
              <i class="bi bi-bookmark"></i>
              <span>Thêm vào playlist</span>
            </a>
            <a href="#" class="action-menu-item">
              <i class="bi bi-broadcast"></i>
              <span>Thêm vào đài phát thanh</span>
            </a>
          `;
          historyItem.style.position = 'relative';
          historyItem.appendChild(menu);
        }
        menu.classList.toggle('show');
      }
    });
  });

  // Close history menus when clicking outside
  document.addEventListener('click', function(e) {
    const historyMenus = document.querySelectorAll('.history-menu-dropdown.show');
    historyMenus.forEach(menu => {
      if (!menu.contains(e.target) && !e.target.closest('.history-action-btn')) {
        menu.classList.remove('show');
      }
    });
  });

  // Next Up Panel Toggle
  const nextUpButton = document.getElementById('nextUpButton');
  const nextUpPanel = document.getElementById('nextUpPanel');
  const closeNextUp = document.getElementById('closeNextUp');

  if (nextUpButton && nextUpPanel) {
    nextUpButton.addEventListener('click', function(e) {
      e.stopPropagation();
      nextUpPanel.classList.toggle('show');
    });
  }

  if (closeNextUp && nextUpPanel) {
    closeNextUp.addEventListener('click', function() {
      nextUpPanel.classList.remove('show');
    });
  }

  // Close Next Up when clicking outside
  document.addEventListener('click', function(e) {
    if (nextUpPanel && nextUpButton && !nextUpPanel.contains(e.target) && !nextUpButton.contains(e.target)) {
      nextUpPanel.classList.remove('show');
    }
  });

  // Handle Next Up item dropdown menus
  const nextUpActionButtons = document.querySelectorAll('.next-up-action-btn');
  nextUpActionButtons.forEach(button => {
    button.addEventListener('click', function(e) {
      const icon = this.querySelector('i');
      const isThreeDots = icon && icon.classList.contains('bi-three-dots');
      if (isThreeDots) {
        e.stopPropagation();
        const nextUpItem = this.closest('.next-up-item');
        if (!nextUpItem) return;

        let menu = nextUpItem.querySelector('.next-up-dropdown');
        if (!menu) {
          menu = document.createElement('div');
          menu.className = 'next-up-dropdown';
          menu.innerHTML = `
            <a href="#" class="action-menu-item">
              <i class="bi bi-heart"></i>
              <span>Thích</span>
            </a>
            <a href="#" class="action-menu-item">
              <i class="bi bi-repeat"></i>
              <span>Đăng lại</span>
            </a>
            <a href="#" class="action-menu-item">
              <i class="bi bi-share"></i>
              <span>Chia sẻ</span>
            </a>
            <a href="#" class="action-menu-item">
              <i class="bi bi-justify"></i>
              <span>Thêm vào danh sách chờ</span>
            </a>
            <a href="#" class="action-menu-item">
              <i class="bi bi-x-lg"></i>
              <span>Xóa khỏi danh sách chờ</span>
            </a>
            <a href="#" class="action-menu-item">
              <i class="bi bi-bookmark"></i>
              <span>Thêm vào playlist</span>
            </a>
            <a href="#" class="action-menu-item">
              <i class="bi bi-broadcast"></i>
              <span>Thêm vào đài phát thanh</span>
            </a>
          `;
          nextUpItem.appendChild(menu);
        }
        menu.classList.toggle('show');
      }
    });
  });

  // Close Next Up dropdown menus when clicking outside
  document.addEventListener('click', function(e) {
    const nextUpMenus = document.querySelectorAll('.next-up-dropdown.show');
    nextUpMenus.forEach(menu => {
      if (!menu.contains(e.target) && !e.target.closest('.next-up-action-btn')) {
        menu.classList.remove('show');
      }
    });

    // Close track dropdown menus when clicking outside
    const trackMenus = document.querySelectorAll('.track-dropdown-menu.show');
    trackMenus.forEach(menu => {
      if (!menu.contains(e.target) && !e.target.closest('.btn-track-menu')) {
        menu.classList.remove('show');
      }
    });
  });

  // Track dropdown menu handlers
  const trackMenuButtons = document.querySelectorAll('.btn-track-menu');
  trackMenuButtons.forEach(button => {
    button.addEventListener('click', function(e) {
      e.stopPropagation();
      const dropdown = this.nextElementSibling;
      if (dropdown && dropdown.classList.contains('track-dropdown-menu')) {
        // Close all other dropdowns
        document.querySelectorAll('.track-dropdown-menu.show').forEach(menu => {
          if (menu !== dropdown) {
            menu.classList.remove('show');
          }
        });
        
        // Toggle dropdown and position it
        dropdown.classList.toggle('show');
        
        if (dropdown.classList.contains('show')) {
          const rect = button.getBoundingClientRect();
          dropdown.style.top = (rect.bottom + 8) + 'px';
          dropdown.style.left = (rect.right - 200) + 'px';
        }
      }
    });
  });

}

// Start initialization when DOM is ready
document.addEventListener('DOMContentLoaded', initializeApp);
