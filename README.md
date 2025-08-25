# BelajarJawi: Aplikasi Klasifikasi Huruf Jawi Berbasis AI

<p align="center">
  <img src="Logo_Belajar_Jawi.png" width="200">
</p>

## 1. Latar Belakang & Deskripsi Proyek

[cite_start]Aksara Jawi adalah warisan budaya tak ternilai di wilayah Nusantara, khususnya di Aceh, yang ditemukan pada berbagai peninggalan kuno seperti nisan, mata uang, dan manuskrip Islam yang berusia hingga 600 tahun[cite: 24]. [cite_start]Upaya pelestarian melalui digitalisasi sangat penting [cite: 25][cite_start], namun terhambat oleh tantangan besar: kelangkaan dataset aksara Jawi yang komprehensif dan tersedia secara online[cite: 31, 32]. [cite_start]Keterbatasan ini menghambat kemajuan penelitian dan pengembangan teknologi krusial seperti *Optical Character Recognition* (OCR)[cite: 26].

**BelajarJawi** lahir sebagai jembatan antara penelitian akademis dan aplikasi praktis untuk mengatasi masalah ini. [cite_start]Aplikasi ini merupakan implementasi nyata dari penelitian **"Augmentation of Additional Arabic Dataset for Jawi Writing and Classification Using Deep Learning"**, yang merupakan hasil publikasi dari saya dan tim peneliti[cite: 3]. [cite_start]Penelitian kami berhasil menciptakan dataset baru dan membuktikan efektivitas model *deep learning* untuk klasifikasi aksara Jawi[cite: 7]. Dengan "otak" berupa model AI yang canggih, aplikasi ini memungkinkan pengguna untuk mengenali dan mempelajari huruf Jawi tambahan secara instan, mengubah ponsel cerdas menjadi alat edukasi dan pelestarian budaya yang ampuh.

---

## 2. 🧠 Inti Teknologi: Kekuatan Deep Learning

Keunggulan utama aplikasi ini terletak pada implementasi model *deep learning* yang dilatih berdasarkan metodologi dari penelitian yang saya dan tim publikasikan.

### A. Masalah: Ketiadaan Dataset Jawi
[cite_start]Penelitian di bidang pengenalan aksara Jawi sangat terkendala karena dataset yang ada hanya berisi sedikit sampel (sekitar 10 sampel per karakter) dan tidak tersedia secara online[cite: 29, 32]. [cite_start]Tanpa data yang beragam dan bervolume besar, melatih model *deep learning* yang akurat hampir mustahil dilakukan[cite: 30].

### B. Solusi Inovatif: Augmentasi Dataset
[cite_start]Penelitian kami menawarkan solusi kreatif dengan melakukan **augmentasi dataset**[cite: 54]. [cite_start]Caranya adalah dengan memanfaatkan dataset aksara Arab dan Urdu yang sudah ada dan kaya fitur, yaitu **HMBD, AHAWP, dan HUCD**[cite: 8, 157]. Prosesnya meliputi:
* [cite_start]**Pra-pemrosesan & Segmentasi:** Gambar-gambar dari dataset sumber diproses untuk meningkatkan kualitas dan memisahkan karakter dari latar belakang[cite: 9, 166].
* [cite_start]**Rekayasa Spasial:** Teknik augmentasi unik diterapkan dengan cara mengekstrak komponen "titik" dari satu set gambar, lalu menempatkannya secara cerdas pada gambar karakter dasar lainnya untuk membentuk 6 karakter Jawi tambahan (seperti 'Ca', 'Nga', 'Pa', 'Ga') dalam 22 bentuk tulisan (terpisah, awal, tengah, dan akhir)[cite: 159, 184, 185].
* [cite_start]**Hasil:** Proses ini berhasil menciptakan dataset baru yang siap pakai dan dapat diakses publik, yang menjadi fondasi untuk melatih model AI modern[cite: 13, 367].

### C. Validasi Performa: Akurasi Terbukti
[cite_start]Efektivitas dataset hasil augmentasi ini divalidasi dengan melatih dan menguji dua arsitektur *deep learning* terkemuka[cite: 10, 215]:
* [cite_start]**InceptionV3:** Mencapai akurasi **95%**[cite: 551].
* [cite_start]**ResNet34:** Menunjukkan performa terbaik dengan akurasi **96%**[cite: 11, 611].

[cite_start]Keberhasilan ini membuktikan secara ilmiah bahwa model *deep learning* mampu mengenali karakter Jawi hasil augmentasi dengan sangat akurat dan konsisten, bahkan untuk kelas karakter yang memiliki bentuk serupa[cite: 12].

### D. Implementasi Aplikasi: `EfficientNet-B0`
Aplikasi **BelajarJawi** mengimplementasikan model `EfficientNet-B0-AutoAugment_bs32_lr1em03.onnx`. Pemilihan model ini didasarkan pada keberhasilan yang telah divalidasi dalam penelitian kami. EfficientNet-B0 adalah arsitektur *state-of-the-art* yang terkenal dengan efisiensi komputasi dan akurasi tinggi, menjadikannya pilihan ideal untuk inferensi cepat dan akurat langsung di perangkat pengguna (*on-device*).

---

## 3. Teknologi & Arsitektur

* **Framework:** Flutter
* **Bahasa:** Dart
* **Deep Learning (On-Device AI):**
    * **Model:** `EfficientNet-B0-AutoAugment_bs32_lr1em03.onnx`
    * [cite_start]**Dasar Ilmiah:** Model ini dilatih menggunakan metodologi dan dataset yang diinspirasi oleh penelitian kami, yang membuktikan keberhasilan klasifikasi aksara Jawi dengan akurasi hingga 96%[cite: 611].
    * **Runtime:** ONNX Runtime (`flutter_onnxruntime`) untuk inferensi *on-device* yang cepat, privat, dan tidak memerlukan koneksi internet.
* **Database Lokal:** `sqflite` untuk manajemen riwayat deteksi.
* **Manajemen State:** State diangkat ke widget `MainNavigator`.

---

## 4. Fitur & Fungsionalitas

* **Klasifikasi Real-time:** Deteksi huruf Jawi secara instan dari kamera atau galeri.
* **Pembelajaran Interaktif:** Hasil deteksi dilengkapi penjelasan informatif mengenai huruf.
* **Riwayat Deteksi:** Menyimpan semua hasil klasifikasi untuk ditinjau kembali.
* **UI Modern & Intuitif:** Antarmuka yang bersih dan mudah digunakan.

---

## 5. Lisensi & Ketersediaan Model

* **Kode Sumber (Source Code):** Proyek ini dilisensikan di bawah **Lisensi MIT**.
* [cite_start]**Model AI:** Model klasifikasi `EfficientNet-B0` adalah **aset pribadi (proprietary)** yang lahir dari penelitian akademis oleh saya dan tim, sehingga **tidak disertakan** dalam repositori ini[cite: 3].

### Cara Menjalankan Proyek
Untuk menjalankan aplikasi, Anda perlu menyediakan model ONNX Anda sendiri yang kompatibel.
1.  Latih model klasifikasi gambar Anda.
2.  Ekspor model ke format `.onnx`.
3.  Letakkan file model di direktori `assets/models/` dan perbarui `assetPath` di `home_screen.dart`.
4.  Pastikan `assets/models/` telah ditambahkan ke `pubspec.yaml`.
