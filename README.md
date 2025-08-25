# BelajarJawi: Aplikasi Klasifikasi Huruf Jawi Berbasis AI

<p align="center">
  <img src="Logo_Belajar_Jawi.png" width="200">
</p>

### 📖 1. Latar Belakang & Deskripsi Proyek

[cite_start]Aksara Jawi adalah warisan budaya tak ternilai di wilayah Nusantara, dengan peninggalan bersejarah berusia hingga 600 tahun[cite: 24]. [cite_start]Namun, upaya pelestariannya di era digital menghadapi tantangan besar: kelangkaan dataset aksara Jawi yang komprehensif dan tersedia untuk umum[cite: 32, 53]. [cite_start]Keterbatasan ini menghambat pengembangan teknologi krusial seperti *Optical Character Recognition* (OCR)[cite: 26].

**BelajarJawi** lahir sebagai solusi dan implementasi praktis dari penelitian yang berhasil mengatasi masalah ini. Aplikasi ini memanfaatkan **kecerdasan buatan (*deep learning*)** yang telah terbukti andal untuk mengenali huruf Jawi. Dengan "otak" berupa model AI yang canggih, aplikasi ini berfungsi sebagai jembatan antara warisan budaya dan teknologi modern, menjadikannya alat yang relevan untuk edukasi dan pelestarian.

---

### 🧠 2. Inti Teknologi: Kekuatan Deep Learning

Keunggulan utama aplikasi ini terletak pada implementasi model *deep learning* yang didasarkan pada metodologi penelitian yang solid dan teruji.

#### A. Solusi untuk Kelangkaan Data
[cite_start]Masalah utama dalam pengenalan aksara Jawi adalah dataset yang sangat terbatas, terkadang hanya berisi 10 sampel per karakter[cite: 29]. [cite_start]Penelitian yang mendasari aplikasi ini menawarkan solusi inovatif dengan melakukan **augmentasi dataset**[cite: 54, 55]. [cite_start]Caranya adalah dengan memanfaatkan dataset aksara Arab dan Urdu yang sudah ada dan kaya fitur (**HMBD, AHAWP, dan HUCD**) [cite: 8, 74][cite_start], kemudian secara cerdas memodifikasinya untuk menciptakan 6 karakter Jawi tambahan dalam 22 bentuk tulisan yang berbeda (terpisah, awal, tengah, dan akhir)[cite: 159, 184].

#### B. Validasi Performa dengan Akurasi Tinggi
[cite_start]Efektivitas dataset hasil augmentasi ini divalidasi dengan melatih dua arsitektur *deep learning* terkemuka[cite: 10, 215]:
* [cite_start]**InceptionV3:** Mencapai akurasi **95%**[cite: 551].
* [cite_start]**ResNet34:** Menunjukkan performa terbaik dengan akurasi **96%**[cite: 11, 611].

[cite_start]Keberhasilan ini membuktikan secara ilmiah bahwa model *deep learning* mampu mengenali karakter Jawi dengan sangat akurat dan konsisten, bahkan untuk karakter dengan bentuk yang mirip[cite: 12].

#### C. Implementasi pada Aplikasi
Berbekal validasi tersebut, aplikasi **BelajarJawi** mengimplementasikan model **EfficientNet-B0**, sebuah arsitektur *state-of-the-art* yang dikenal sangat efisien dan akurat, menjadikannya pilihan ideal untuk inferensi cepat langsung di perangkat pengguna (*on-device*).

---

### ✨ 3. Fitur Utama

-   **Klasifikasi Real-time:** Deteksi huruf Jawi secara instan dari gambar yang diambil melalui kamera atau galeri.
-   [cite_start]**Akurasi Tinggi:** Ditenagai oleh model *Deep Learning* yang dilatih berdasarkan metodologi riset yang terbukti mencapai akurasi hingga 96%[cite: 11], memastikan pengenalan yang andal.
-   **Pembelajaran Interaktif:** Setiap hasil deteksi disertai dengan **penjelasan informatif** mengenai bentuk, nama, dan penggunaan huruf, mengubah aplikasi menjadi alat belajar yang efektif.
-   **Riwayat Deteksi:** Semua hasil klasifikasi dapat disimpan ke dalam riwayat untuk dipelajari kembali di kemudian hari.
-   **UI Modern & Intuitif:** Antarmuka yang bersih dan mudah digunakan, dirancang dengan Flutter untuk pengalaman pengguna yang mulus.

---

### 🚀 4. Teknologi & Arsitektur

Proyek ini dibangun menggunakan tumpukan teknologi modern yang berfokus pada performa dan pengalaman pengguna.

-   **Framework:** Flutter
-   **Bahasa:** Dart
-   **Deep Learning (On-Device AI):**
    -   **Model:** `EfficientNet-B0` dengan strategi AutoAugment.
    -   [cite_start]**Dasar Ilmiah:** Model ini dilatih menggunakan metodologi dan dataset yang diinspirasi oleh penelitian yang membuktikan keberhasilan klasifikasi aksara Jawi dengan akurasi hingga 96%[cite: 11].
    -   **Runtime:** ONNX Runtime (`flutter_onnxruntime`) untuk inferensi *on-device* yang cepat.
-   **Database Lokal:** `sqflite` untuk manajemen data riwayat yang efisien dan persisten.
-   **Manajemen State:** State diangkat ke widget `MainNavigator` untuk mengelola data hasil prediksi terakhir dan navigasi antar halaman.
-   **UI/UX:**
    -   **Navigasi:** `animated_notch_bottom_bar`.
    -   **Asynchronous UI:** `FutureBuilder`.
-   **Utilitas:** `image_picker`, `intl`, `image`.

---

### 💡 5. Tantangan & Pembelajaran

-   **Integrasi Model AI:** Memastikan model ONNX berjalan efisien di lingkungan Flutter.
-   [cite_start]**Akurasi pada Kasus Sulit:** Menangani kemiripan visual antar karakter Jawi, terutama dalam bentuk sambung, yang diidentifikasi dalam penelitian sebagai tantangan utama[cite: 494].
-   **Manajemen State Lintas Halaman:** Mengelola state hasil prediksi antar halaman.
-   **Desain UI Responsif:** Merancang layout yang fungsional di berbagai ukuran layar.

---

### 🎥 6. Video Demo

*Rekam layar ponsel Anda saat menggunakan aplikasi untuk menunjukkan alur kerja secara penuh, lalu unggah ke YouTube sebagai "Unlisted" dan sisipkan link-nya di sini.*

**[Lihat Demo Aplikasi BelajarJawi di YouTube](URL_VIDEO_YOUTUBE_ANDA)**

---

### 📸 7. Galeri Aplikasi

| Halaman Deteksi | Halaman Hasil | Halaman Riwayat |
| :---: | :---: | :---: |
| <img src="demo and screenshot/main_page.gif" width="200"> | <img src="demo and screenshot/history_page.png" width="200"> | <img src="demo and screenshot/result_page.png" width="200"> |

---

### ⚖️ 8. Lisensi & Ketersediaan Model

-   **Kode Sumber (Source Code):** Proyek ini dilisensikan di bawah **Lisensi MIT**.
-   **Model AI:** Model klasifikasi yang telah dilatih adalah **aset pribadi (proprietary)** dan tidak disertakan dalam repositori ini.

#### Cara Menjalankan Proyek
Untuk dapat menjalankan aplikasi ini, Anda perlu menyediakan file model ONNX Anda sendiri.
1.  Latih model klasifikasi gambar Anda sendiri.
2.  Ekspor model tersebut ke dalam format `.onnx`.
3.  Letakkan file model Anda di direktori `assets/models/` dan ganti nama `assetPath` di `home_screen.dart`.
4.  Pastikan Anda telah menambahkan `assets/models/` ke dalam file `pubspec.yaml`.
