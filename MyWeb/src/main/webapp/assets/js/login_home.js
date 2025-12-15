document.addEventListener('DOMContentLoaded', () => {
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
    dropdownButton.addEventListener('click', e => {
      e.stopPropagation();
      dropdownMenu.classList.toggle('show');
      if (messagesMenu) messagesMenu.classList.remove('show');
      if (notificationsMenu) notificationsMenu.classList.remove('show');
    });
  }

  if (notificationsButton && notificationsMenu) {
    notificationsButton.addEventListener('click', e => {
      e.stopPropagation();
      notificationsMenu.classList.toggle('show');
      if (dropdownMenu) dropdownMenu.classList.remove('show');
      if (messagesMenu) messagesMenu.classList.remove('show');
    });
  }

  if (messagesButton && messagesMenu) {
    messagesButton.addEventListener('click', e => {
      e.stopPropagation();
      messagesMenu.classList.toggle('show');
      if (dropdownMenu) dropdownMenu.classList.remove('show');
      if (notificationsMenu) notificationsMenu.classList.remove('show');
    });
  }

  document.addEventListener('click', e => {
    if (dropdownMenu && dropdownButton && !dropdownMenu.contains(e.target) && e.target !== dropdownButton) {
      dropdownMenu.classList.remove('show');
    }
    if (notificationsMenu && notificationsButton && !notificationsMenu.contains(e.target) && e.target !== notificationsButton) {
      notificationsMenu.classList.remove('show');
    }
    if (messagesMenu && messagesButton && !messagesMenu.contains(e.target) && e.target !== messagesButton) {
      messagesMenu.classList.remove('show');
    }
  });

  // Handle playlist action menus
  const allActionButtons = document.querySelectorAll('.btn-action');
  allActionButtons.forEach(button => {
    button.addEventListener('click', function (e) {
      const icon = this.querySelector('i');
      const isThreeDots = icon && icon.classList.contains('bi-three-dots');
      if (!isThreeDots) return;

      e.stopPropagation();
      const actionDiv = this.parentElement;
      const playlistCard = actionDiv ? actionDiv.closest('.playlist-card') : null;
      if (!actionDiv || !playlistCard) return;

      const title = (playlistCard.querySelector('.playlist-title') || {}).textContent || '';
      const artist = (playlistCard.querySelector('.playlist-desc') || {}).textContent || '';
      const imgSrc = (playlistCard.querySelector('.playlist-img') || {}).src || '';

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
            <span>Repost</span>
          </a>
          <a href="#" class="action-menu-item">
            <i class="bi bi-share"></i>
            <span>Share</span>
          </a>
          <a href="#" class="action-menu-item">
            <i class="bi bi-link-45deg"></i>
            <span>Copy Link</span>
          </a>
          <a href="#" class="action-menu-item">
            <i class="bi bi-clock-history"></i>
            <span>Add to Next up</span>
          </a>
        `;
        actionDiv.appendChild(menu);
      }
      menu.classList.toggle('show');
    });
  });

  document.addEventListener('click', e => {
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
    button.addEventListener('click', function (e) {
      const icon = this.querySelector('i');
      const isThreeDots = icon && icon.classList.contains('bi-three-dots');
      if (!isThreeDots) return;

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
            <span>Repost</span>
          </a>
          <a href="#" class="action-menu-item">
            <i class="bi bi-share"></i>
            <span>Share</span>
          </a>
          <a href="#" class="action-menu-item">
            <i class="bi bi-link-45deg"></i>
            <span>Copy Link</span>
          </a>
          <a href="#" class="action-menu-item">
            <i class="bi bi-clock-history"></i>
            <span>Add to Next up</span>
          </a>
          <a href="#" class="action-menu-item">
            <i class="bi bi-bookmark"></i>
            <span>Add to Playlist</span>
          </a>
          <a href="#" class="action-menu-item">
            <i class="bi bi-broadcast"></i>
            <span>Station</span>
          </a>
        `;
        historyItem.style.position = 'relative';
        historyItem.appendChild(menu);
      }
      menu.classList.toggle('show');
    });
  });

  document.addEventListener('click', e => {
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
    nextUpButton.addEventListener('click', e => {
      e.stopPropagation();
      nextUpPanel.classList.toggle('show');
    });
  }

  if (closeNextUp && nextUpPanel) {
    closeNextUp.addEventListener('click', () => {
      nextUpPanel.classList.remove('show');
    });
  }

  document.addEventListener('click', e => {
    if (nextUpPanel && nextUpButton && !nextUpPanel.contains(e.target) && !nextUpButton.contains(e.target)) {
      nextUpPanel.classList.remove('show');
    }
  });

  const nextUpActionButtons = document.querySelectorAll('.next-up-action-btn');
  nextUpActionButtons.forEach(button => {
    button.addEventListener('click', function (e) {
      const icon = this.querySelector('i');
      const isThreeDots = icon && icon.classList.contains('bi-three-dots');
      if (!isThreeDots) return;

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
            <span>Like</span>
          </a>
          <a href="#" class="action-menu-item">
            <i class="bi bi-repeat"></i>
            <span>Repost</span>
          </a>
          <a href="#" class="action-menu-item">
            <i class="bi bi-share"></i>
            <span>Share</span>
          </a>
          <a href="#" class="action-menu-item">
            <i class="bi bi-clock-history"></i>
            <span>Add to Next up</span>
          </a>
          <a href="#" class="action-menu-item">
            <i class="bi bi-x-lg"></i>
            <span>Remove from Next up</span>
          </a>
          <a href="#" class="action-menu-item">
            <i class="bi bi-bookmark"></i>
            <span>Add to Playlist</span>
          </a>
          <a href="#" class="action-menu-item">
            <i class="bi bi-broadcast"></i>
            <span>Station</span>
          </a>
        `;
        nextUpItem.appendChild(menu);
      }
      menu.classList.toggle('show');
    });
  });

  document.addEventListener('click', e => {
    const nextUpMenus = document.querySelectorAll('.next-up-dropdown.show');
    nextUpMenus.forEach(menu => {
      if (!menu.contains(e.target) && !e.target.closest('.next-up-action-btn')) {
        menu.classList.remove('show');
      }
    });
  });
});
