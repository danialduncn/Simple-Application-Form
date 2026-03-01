CREATE DATABASE IF NOT EXISTS simple_application_form
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

CREATE USER IF NOT EXISTS 'app_user'@'%' IDENTIFIED BY 'app_password';
GRANT ALL PRIVILEGES ON simple_application_form.* TO 'app_user'@'%';
FLUSH PRIVILEGES;
