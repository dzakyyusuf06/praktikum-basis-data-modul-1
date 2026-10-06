# Dokumen Kebutuhan Data - Koperasi Mahasiswa Sejahtera (Kopma)

## 1. Latar Belakang dan Aktivitas Organisasi
Koperasi Mahasiswa (Kopma) Sejahtera mengelola aktivitas penjualan barang kebutuhan mahasiswa berupa alat tulis, makanan ringan, dan minuman di lingkungan kampus. Transaksi dapat melayani anggota koperasi maupun pembeli umum. Anggota aktif berhak memperoleh potongan harga (diskon) sebesar 5% pada setiap transaksi. Sistem basis data ini dirancang untuk mengatasi permasalahan pencatatan stok fisik yang tidak sinkron, riwayat harga barang historis pada nota transaksi yang hilang, serta memudahkan pencarian data anggota yang lupa membawa kartu fisik.

---

## 2. Aktor dan Proses Bisnis

| Kode | Proses Bisnis | Aktor | Pemicu (*Trigger*) |
| :--- | :--- | :--- | :--- |
| PB-01 | Mendaftarkan anggota baru | Kasir (atas permintaan mahasiswa) | Mahasiswa mengajukan pendaftaran anggota baru |
| PB-02 | Mencatat transaksi penjualan | Kasir | Pembeli melakukan pembayaran barang di kasir |
| PB-03 | Memesan barang ke pemasok | Petugas Gudang | Jumlah stok barang di gudang berada di bawah batas minimum |
| PB-04 | Menerima barang dari pemasok | Petugas Gudang | Barang pesanan tiba bersama faktur dari pihak pemasok |
| PB-05 | Menyusun laporan bulanan | Ketua Koperasi | Siklus pergantian awal bulan kalender |

---

## 3. Dokumen Sumber yang Dianalisis
Dokumen sumber utama yang dianalisis adalah **Nota Penjualan Kopma**, dengan anotasi elemen data sebagai berikut:
* **Identitas Transaksi**: Nomor Nota (`no_nota`), Tanggal & Jam Transaksi (`tanggal_waktu`).
* **Relasi Petugas & Pembeli**: Kasir bertugas (`id_kasir`), Anggota/Pelanggan (`no_anggota`).
* **Rincian Barang**: Nama/Kode Barang (`kode_barang`), Jumlah Beli (`qty`), Harga Satuan saat Transaksi (`harga_satuan`).
* **Nilai Turunan (*Calculated*)**: Subtotal per baris (`qty * harga_satuan`), Jumlah Kotor, Diskon Anggota 5%, dan Total Bersih.
* **Data Pembayaran**: Nominal Bayar Tunai (`bayar`) dan Uang Kembalian (`kembali`).

---

## 4. Entitas Kandidat dan Elemen Data Utama

| Entitas Kandidat | Elemen Data Utama | Dokumen Sumber |
| :--- | :--- | :--- |
| **Anggota** | Nomor anggota, NIM, nama lengkap, program studi, nomor HP, status aktif | Formulir pendaftaran anggota |
| **Barang** | Kode barang, nama barang, kategori, harga jual, stok tersedia, batas minimum stok | Daftar inventaris barang, faktur |
| **Penjualan** | Nomor nota, tanggal-jam, ID kasir, nomor anggota (opsional), nominal bayar | Nota penjualan |
| **Detail Penjualan** | Nomor nota, kode barang, qty, harga satuan saat transaksi | Nota penjualan |
| **Petugas** | Kode petugas, nama petugas, peran (kasir / petugas gudang / ketua) | Wawancara internal |
| **Pemasok** | Kode pemasok, nama pemasok, nomor telepon, alamat | Faktur pemasok |
| **Pembelian** | Nomor faktur, tanggal, kode pemasok, rincian barang, kuantitas masuk, harga beli | Faktur pemasok |

---

## 5. Aturan Bisnis (*Business Rules*)

* **AB-01**: Setiap nota penjualan wajib memiliki nomor transaksi yang unik dan minimal mencatat satu baris barang.
* **AB-02**: Penjualan diizinkan tanpa identitas anggota (pelanggan umum); potongan harga 5% hanya diberikan jika transaksi menyertakan nomor anggota dengan status keanggotaan aktif.
* **AB-03**: Stok barang fisik tidak boleh bernilai negatif; transaksi penjualan wajib ditolak oleh sistem jika kuantitas pembelian melebihi stok yang tersedia.
* **AB-04**: Nilai harga jual yang dicatat pada detail penjualan merupakan harga riil saat transaksi berlangsung dan tidak berubah meskipun harga pokok barang di master katalog mengalami perubahan.
* **AB-05**: NIM anggota bersifat unik; pencarian profil keanggotaan di kasir dapat dilakukan melalui nomor anggota maupun NIM mahasiswa.
* **AB-06**: Surat pesanan pengadaan barang otomatis dibuat saat jumlah persediaan barang berada di bawah batas minimum stok yang ditetapkan.

---

## 6. Kebutuhan Informasi

| Kode | Kebutuhan Informasi Manajerial | Data yang Diperlukan |
| :--- | :--- | :--- |
| KI-01 | Rekapitulasi omzet dan total transaksi harian serta bulanan | Penjualan, Detail Penjualan |
| KI-02 | Laporan 5 barang terlaris per bulan berdasarkan total kuantitas | Detail Penjualan, Barang |
| KI-03 | Laporan daftar barang dengan stok kritis (di bawah ambang batas minimum) | Master Barang |
| KI-04 | Laporan 10 profil anggota dengan volume belanja terbesar per bulan | Penjualan, Detail Penjualan, Anggota |

---

## 7. Matriks CRUD (Proses vs Entitas)

| Kode Proses | Anggota | Barang | Penjualan | Detail Penjualan | Pemasok | Pembelian |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: |
| **PB-01 (Daftar Anggota)** | **C** | - | - | - | - | - |
| **PB-02 (Catat Penjualan)** | **R** | **R, U** | **C** | **C** | - | - |
| **PB-03 (Pesan ke Pemasok)** | - | **R** | - | - | **R** | **C** |
| **PB-04 (Terima Barang)** | - | **U** | - | - | **R** | **U** |
| **PB-05 (Laporan Bulanan)** | **R** | **R** | **R** | **R** | - | **R** |

---

## 8. Kamus Data Awal

| Elemen Data | Arti / Deskripsi | Contoh Nilai | Aturan Validasi | Penanggung Jawab |
| :--- | :--- | :--- | :--- | :--- |
| `no_anggota` | Nomor identitas anggota koperasi | `A-0457` | Format unik: A-4 digit angka | Ketua Koperasi |
| `nim_anggota` | Nomor Induk Mahasiswa anggota | `25430101` | Format unik, 8-10 digit numerik | Ketua Koperasi |
| `no_hp_anggota` | Nomor kontak seluler anggota | `081234567890` | Format nomor telepon valid, privasi terbatas | Ketua Koperasi |
| `no_nota_penjualan` | Kode struk transaksi kasir | `PJ-2609-0042` | Format unik tiap transaksi | Kasir |
| `harga_satuan_transaksi` | Nilai satuan saat pembayaran | `4000` | Numerik integer >= 0 (satuan Rupiah) | Kasir |
| `stok_barang` | Jumlah sisa unit fisik di gudang | `35` | Numerik bulat >= 0 (Aturan AB-03) | Petugas Gudang |

---

## 9. Kebutuhan Non-Fungsional Data
* **Volume dan Retensi Transaksi**: Sistem mampu menangani rata-rata transaksi harian hingga ±150 nota per hari. Data histori transaksi wajib disimpan sekurang-kurangnya selama 5 tahun sebelum diarsipkan.
* **Privasi dan Keamanan**: Nomor HP serta informasi pribadi anggota dilindungi secara ketat, hanya dapat diakses oleh peran manajerial (Ketua Koperasi) sesuai ketentuan Undang-Undang Perlindungan Data Pribadi (UU PDP).

---

## 10. Isu Kualitas Data yang Diantisipasi
* **Kelengkapan (*Completeness*)**: Mencegah adanya baris detail transaksi tanpa nomor nota induk atau tanpa kode barang yang valid.
* **Akurasi & Integritas (*Accuracy & Consistency*)**: Pengurangan stok barang dilakukan secara otomatis melalui mekanisme transaksi basis data (bersifat atomik) untuk mencegah terjadinya selisih stok riil di gudang.
