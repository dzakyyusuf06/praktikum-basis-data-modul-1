-- p01_lingkungan_25430101.sql
-- Password sengaja diganti penanda. JANGAN commit password asli.

-- 1. Inisialisasi Database dan Akun Kerja Praktikum (Modul 1)
CREATE DATABASE IF NOT EXISTS kopma_101
CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE USER IF NOT EXISTS 'mhs_101'@'localhost' IDENTIFIED BY '<password_kerja>';
GRANT ALL PRIVILEGES ON kopma_101.* TO 'mhs_101'@'localhost';

-- 2. Latihan dan Modifikasi: Akun Tamu (Hanya Hak SELECT)
CREATE USER IF NOT EXISTS 'tamu_101'@'localhost' IDENTIFIED BY '<password_kerja>';
GRANT SELECT ON kopma_101.* TO 'tamu_101'@'localhost';

-- 3. Milestone Proyek Mandiri: Basis Data Perpustakaan
CREATE DATABASE IF NOT EXISTS perpus_101
CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE USER IF NOT EXISTS 'dev_101'@'localhost' IDENTIFIED BY '<password_kerja>';
GRANT ALL PRIVILEGES ON perpus_101.* TO 'dev_101'@'localhost';

FLUSH PRIVILEGES;

-- Perintah Git yang Digunakan:
-- git init
-- git add README.md p01_lingkungan_25430101.sql
-- git commit -m "p01: inisialisasi repositori dan skrip lingkungan"
-- git remote add origin https://github.com/redyellowman10-hue/praktikum-basis-data-modul-1.git
-- git push -u origin main
