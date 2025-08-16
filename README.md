# Jawi Letter Detection Application with MobileNetV2

This Android application, built with Flutter, uses a MobileNetV2 deep learning model to detect and classify Jawi letters in real-time or from images in the gallery.

<img src="screenshoot/Screenshot_1755363446.jpg" width="300">

## 📜 About The Application

This app is designed to help users recognize various forms of Jawi letters, including their isolated (*terpisah*) forms as well as their connected forms at the beginning, middle, and end of a word. Built for the Android platform using the **Flutter** framework, this application leverages the lightweight and efficient MobileNetV2 architecture, making it ideal for running on mobile devices.

## ✨ Features

- **Real-time Detection:** Users can point their camera directly at Jawi script to get an instant classification.
- **Detection from Gallery:** In addition to live detection, users can also select existing images from their gallery for analysis.
- **Detection History:** Every classification result is saved in the history menu, allowing users to review previous detections.
- **Simple Interface:** A clean and intuitive interface design makes this application easy to use for everyone.

## 🧠 Technology Used

### Flutter
The application's user interface is built using Flutter, Google's UI toolkit for building beautiful, natively compiled applications for mobile, web, and desktop from a single codebase.

### Jawi Script
The Jawi script is a writing system adapted from the Arabic script for writing the Malay language. In addition to the standard Arabic letters, there are several additional letters in the Jawi script to represent sounds that do not exist in Arabic, such as 'Ca', 'Nga', 'Pa', 'Ga', and 'Nya'. This application can recognize these letters in their various forms.

### MobileNetV2
**MobileNetV2** is a Convolutional Neural Network (CNN) architecture optimized for devices with limited resources. Its main advantage lies in its high computational efficiency without a significant sacrifice in accuracy. The model for this application was specifically **trained and augmented** to improve its accuracy and robustness in identifying Jawi characters from various image sources. With this trained MobileNetV2 model, the application can perform image classification quickly and accurately directly on the user's device.

## 🚀 How to Use

1.  **Open the Application:** You will be greeted by the main page.
2.  **Select Image Source:**
    * Choose **"Ambil Gambar" (Take Picture)** to use the camera.
    * Choose **"Galeri" (Gallery)** to select an image from your device's storage.
3.  **Classification Process:** After the image is taken or selected, the application will process it to detect the Jawi letter.
4.  **View Results:** The classification result will be displayed on the screen, complete with the detected letterform.
5.  **Save & History:** The result will be automatically saved in the **"Riwayat" (History)** menu for future access.

## 🔠 List of Recognizable Letters

Based on the `labels.txt` file, this model can recognize variations of the following Jawi letters:

- Nya (Isolated, Initial, Medial, and Final forms)
- Nga (Isolated, Initial, Medial, and Final forms)
- Pa (Isolated, Initial, Medial, and Final forms)
- Ga (Isolated, Initial, Medial, and Final forms)
- Va (Isolated and Final forms)
- Ca (Isolated, Initial, Medial, and Final forms)






