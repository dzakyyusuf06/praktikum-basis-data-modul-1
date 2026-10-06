-- p01_lingkungan_25430101.sql
-- Password sengaja diganti penanda. JANGAN commit password asli.

-- 1. Praktikum Modul 1: Kasus Kopma
CREATE DATABASE IF NOT EXISTS kopma_101 
CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE USER IF NOT EXISTS 'mhs_101'@'localhost' IDENTIFIED BY '<password_kerja>';
GRANT ALL PRIVILEGES ON kopma_101.* TO 'mhs_101'@'localhost';

-- 2. Latihan dan Modifikasi: Akun Tamu (Hanya Hak SELECT)
CREATE USER IF NOT EXISTS 'tamu_101'@'localhost' IDENTIFIED BY '<password_tamu>';
GRANT SELECT ON kopma_101.* TO 'tamu_101'@'localhost';

-- 3. Milestone Proyek 1: Proyek Perpustakaan
CREATE DATABASE IF NOT EXISTS perpus_101 
CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE USER IF NOT EXISTS 'dev_101'@'localhost' IDENTIFIED BY '<password_dev>';
GRANT ALL PRIVILEGES ON perpus_101.* TO 'dev_101'@'localhost';

FLUSH PRIVILEGES;
