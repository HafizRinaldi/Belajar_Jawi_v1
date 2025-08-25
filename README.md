# BelajarJawi: Aplikasi Klasifikasi Huruf Jawi Berbasis AI

<img src="demo and screeshot/main_page.jpg" withd="200">

## 📖 1. Latar Belakang & Deskripsi Proyek

Aksara Jawi adalah warisan budaya tak ternilai di wilayah Nusantara, namun ketersediaan sumber daya digital untuk pembelajaran dan pelestariannya masih sangat terbatas. Kurangnya dataset yang komprehensif dan alat bantu modern menjadi tantangan utama bagi para peneliti dan peminat aksara ini.

**BelajarJawi** lahir sebagai solusi untuk tantangan tersebut. Aplikasi mobile ini dirancang untuk membantu pengguna mengenali dan mempelajari huruf-huruf Jawi tambahan melalui teknologi pengenalan gambar. Dengan memanfaatkan kecerdasan buatan, aplikasi ini berfungsi sebagai jembatan antara warisan budaya dan teknologi modern, menjadikannya alat yang relevan untuk edukasi dan pelestarian.

---

## ✨ 2. Fitur Utama

-   **Klasifikasi Real-time:** Deteksi huruf Jawi secara instan dari gambar yang diambil melalui kamera atau galeri.
-   **Akurasi Tinggi:** Ditenagai oleh model Deep Learning yang telah dilatih untuk mencapai akurasi tinggi, memastikan pengenalan yang andal.
-   **Pembelajaran Interaktif:** Setiap hasil deteksi disertai dengan **penjelasan informatif** mengenai bentuk, nama, dan penggunaan huruf, mengubah aplikasi menjadi alat belajar yang efektif.
-   **Riwayat Deteksi:** Semua hasil klasifikasi dapat disimpan ke dalam riwayat untuk dipelajari kembali di kemudian hari, lengkap dengan **waktu penyimpanan** untuk melacak kemajuan belajar.
-   **UI Modern & Intuitif:** Antarmuka yang bersih dan mudah digunakan, dirancang dengan Flutter untuk pengalaman pengguna yang mulus di berbagai perangkat.

---

## 🚀 3. Teknologi & Arsitektur

Proyek ini dibangun menggunakan tumpukan teknologi modern yang berfokus pada performa dan pengalaman pengguna.

-   **Framework:** Flutter
-   **Bahasa:** Dart
-   **Machine Learning:**
    -   **Model:** EfficientNet-B0 dengan strategi AutoAugment.
    -   **Runtime:** ONNX Runtime (`flutter_onnxruntime`) untuk inferensi *on-device* yang cepat.
-   **Database Lokal:** `sqflite` untuk manajemen data riwayat yang efisien dan persisten.
-   **Manajemen State:** State diangkat ke widget `MainNavigator` untuk mengelola data hasil prediksi terakhir dan navigasi antar halaman.
-   **UI/UX:**
    -   **Navigasi:** `animated_notch_bottom_bar` untuk navigasi yang modern dan menarik.
    -   **Asynchronous UI:** `FutureBuilder` digunakan untuk menangani state *loading*, *empty*, dan *data* secara elegan di halaman riwayat.
-   **Utilitas:** `image_picker`, `intl` (untuk format tanggal), `image`.

---

## 💡 4. Tantangan & Pembelajaran

Selama pengembangan, beberapa tantangan utama yang dihadapi antara lain:
1.  **Integrasi Model AI:** Memastikan model ONNX dapat berjalan efisien di dalam lingkungan Flutter dan menangani *pre-processing* gambar (resize, normalisasi) dengan benar sebelum inferensi.
2.  **Manajemen State Lintas Halaman:** Mengelola state hasil prediksi terakhir agar dapat diakses oleh halaman "Hasil" setelah deteksi selesai di halaman "Deteksi", yang diselesaikan dengan menggunakan *callback function* dan mengangkat state ke widget induk (`MainNavigator`).
3.  **Desain UI Responsif:** Merancang layout, terutama di halaman utama, agar tetap fungsional dan estetis di berbagai ukuran layar tanpa menyebabkan *overflow*.

Proyek ini memberikan pembelajaran mendalam tentang arsitektur aplikasi Flutter, integrasi *on-device machine learning*, dan pentingnya desain UI/UX yang baik untuk memandu pengguna.

---

## 🎥 5. Video Demo

*Rekam layar ponsel Anda saat menggunakan aplikasi untuk menunjukkan alur kerja secara penuh, lalu unggah ke YouTube sebagai "Unlisted" dan sisipkan link-nya di sini.*

**[Lihat Demo Aplikasi BelajarJawi di YouTube](URL_VIDEO_YOUTUBE_ANDA)**

---

## 📸 6. Galeri Aplikasi

| Halaman Deteksi | Halaman Hasil | Halaman Riwayat |
| :---: | :---: | :---: |
| ![Halaman Deteksi](URL_SCREENSHOT_DETEKSI) | ![Halaman Hasil](URL_SCREENSHOT_HASIL) | ![Halaman Riwayat](URL_SCREENSHOT_RIWAYAT) |

---

## ⚖️ 7. Lisensi & Ketersediaan Model

-   **Kode Sumber (Source Code):** Proyek ini dilisensikan di bawah **Lisensi MIT**. Anda bebas menggunakan, memodifikasi, dan mendistribusikan kode ini sesuai dengan syarat yang tercantum dalam file `LICENSE`.

-   **Model AI (`EfficientNet-B0-AutoAugment_bs32_lr1em03.onnx`):** Model klasifikasi yang telah dilatih adalah **aset pribadi (proprietary)** dan **tidak disertakan** dalam repositori ini. File model telah dikecualikan melalui `.gitignore`.

### Cara Menjalankan Proyek
Untuk dapat menjalankan aplikasi ini, Anda perlu menyediakan file model ONNX Anda sendiri yang kompatibel dengan input dan output yang diharapkan oleh aplikasi.

1.  Latih model klasifikasi gambar Anda sendiri.
2.  Ekspor model tersebut ke dalam format `.onnx`.
3.  Letakkan file model Anda di direktori `assets/models/` dan ganti nama `assetPath` di `home_screen.dart` agar sesuai dengan nama file model Anda.
4.  Pastikan Anda telah menambahkan `assets/models/` ke dalam file `pubspec.yaml`.

