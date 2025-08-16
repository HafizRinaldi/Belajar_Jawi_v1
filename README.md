# Aplikasi Deteksi Huruf Jawi dengan MobileNetV2

Aplikasi Android yang dibuat dengan Flutter ini menggunakan model *deep learning* MobileNetV2 untuk mendeteksi dan mengklasifikasikan huruf-huruf Jawi secara *real-time* maupun melalui gambar dari galeri.

<img src="a/home_page.jpg" width="300">

## 📜 Tentang Aplikasi

Aplikasi ini dirancang untuk memudahkan pengguna dalam mengenali berbagai bentuk huruf Jawi, termasuk bentuk tunggal (*terpisah*) maupun bentuk bersambung di awal, tengah, dan akhir kata. Dibangun untuk platform Android menggunakan framework **Flutter**, aplikasi ini memanfaatkan arsitektur MobileNetV2 yang ringan dan efisien, sehingga cocok untuk dijalankan pada perangkat *mobile*.

## ✨ Fitur-fitur

- **Deteksi Real-time:** Pengguna dapat langsung mengarahkan kamera ke tulisan Jawi untuk mendapatkan hasil klasifikasi secara langsung.
- **Deteksi dari Galeri:** Selain deteksi langsung, pengguna juga dapat memilih gambar yang sudah ada dari galeri untuk dianalisis.
- **Riwayat Deteksi:** Setiap hasil klasifikasi akan disimpan dalam menu riwayat, memungkinkan pengguna untuk melihat kembali hasil deteksi sebelumnya.
- **Antarmuka Sederhana:** Desain antarmuka yang bersih dan intuitif membuat aplikasi ini mudah digunakan oleh berbagai kalangan.

<img src="a/Screenshot_1755363470.png" width="300">

## 🧠 Teknologi yang Digunakan

### Flutter
Antarmuka pengguna aplikasi ini dibangun menggunakan Flutter, *UI toolkit* dari Google untuk membangun aplikasi *multi-platform* yang indah dan dapat dikompilasi secara *native* dari satu basis kode.

### Aksara Jawi
Aksara Jawi adalah sistem tulisan yang diadaptasi dari aksara Arab untuk menuliskan Bahasa Melayu. Aplikasi ini dapat mengenali huruf-huruf Jawi tambahan seperti 'Ca', 'Nga', 'Pa', 'Ga', dan 'Nya' dalam berbagai bentuknya.

### MobileNetV2
**MobileNetV2** adalah arsitektur *Convolutional Neural Network* (CNN) yang dioptimalkan untuk perangkat dengan sumber daya terbatas. Model untuk aplikasi ini melalui beberapa tahap. **Sebelumnya, ada proses *data science* untuk membersihkan dataset** dari data yang tidak relevan atau berkualitas buruk. Setelah dataset bersih, model secara spesifik **dilatih dan di-augmentasi** untuk meningkatkan akurasi dan ketahanannya dalam mengidentifikasi karakter Jawi dari berbagai sumber gambar. Dengan model yang telah terlatih ini, aplikasi dapat melakukan klasifikasi gambar dengan cepat dan akurat langsung di perangkat pengguna.

## 🚀 Cara Penggunaan

1.  **Buka Aplikasi:** Anda akan disambut dengan halaman utama.
2.  **Pilih Sumber Gambar:**
    * Pilih **"Ambil Gambar"** untuk menggunakan kamera.
    * Pilih **"Galeri"** untuk memilih gambar dari penyimpanan perangkat Anda.
3.  **Proses Klasifikasi:** Aplikasi akan memproses gambar untuk mendeteksi huruf Jawi.
4.  **Lihat Hasil:** Hasil klasifikasi akan ditampilkan di layar.
5.  **Simpan & Riwayat:** Hasil akan otomatis tersimpan di menu **"Riwayat"** untuk diakses kembali.

<img src="a/Screenshot_1755363466.png" width="300">

## 🔠 Daftar Huruf yang Dapat Dikenali

Berdasarkan file `labels.txt`, model ini dapat mengenali variasi dari huruf-huruf Jawi berikut:

-   Nya (Terpisah, Terhubung di Awal, Tengah, dan Akhir)
-   Nga (Terpisah, Terhubung di Awal, Tengah, dan Akhir)
-   Pa (Terpisah, Terhubung di Awal, Tengah, dan Akhir)
-   Ga (Terpisah, Terhubung di Awal, Tengah, dan Akhir)
-   Va (Terpisah dan Terhubung di Akhir)
-   Ca (Terpisah, Terhubung di Awal, Tengah, dan Akhir)
