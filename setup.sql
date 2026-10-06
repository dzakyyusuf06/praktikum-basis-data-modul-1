-- Modul 1: Lingkungan Kerja MariaDB
CREATE DATABASE kopma_db;
CREATE USER 'kasir_kopma'@'localhost' IDENTIFIED BY 'Rahasia123!';
GRANT ALL PRIVILEGES ON kopma_db.* TO 'kasir_kopma'@'localhost';
ALTER USER 'root'@'localhost' IDENTIFIED BY 'Admin123!';
FLUSH PRIVILEGES;
