-- =============================================
-- Add role column to users table for Admin functionality
-- =============================================

USE webappmusic;

-- Add role column to users table (check if not exists)
SET @column_exists = (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS 
                      WHERE TABLE_SCHEMA = 'webappmusic' 
                      AND TABLE_NAME = 'users' 
                      AND COLUMN_NAME = 'role');

SET @sql = IF(@column_exists = 0, 
    'ALTER TABLE users ADD COLUMN role ENUM(''user'', ''admin'') DEFAULT ''user'' AFTER bio',
    'SELECT ''Column role already exists''');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Update existing admin user to have admin role (cập nhật user có username là 'admin')
UPDATE users SET role = 'admin' WHERE username = 'admin';

-- Nếu bạn muốn set một user khác làm admin, thay đổi username ở đây:
-- UPDATE users SET role = 'admin' WHERE username = 'your_admin_username';
-- UPDATE users SET role = 'admin' WHERE user_id = 1;

-- =============================================
-- Verify the change
-- =============================================
DESCRIBE users;
SELECT user_id, username, email, role FROM users;
