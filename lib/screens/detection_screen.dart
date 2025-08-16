// lib/app/presentation/screens/detection/detection_screen.dart
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/database.dart';
import 'package:flutter_application_1/database/profile.dart';
import 'package:screenshot/screenshot.dart';
import 'package:tflite/tflite.dart';

class DetectionScreen extends StatefulWidget {
  final File? fileImage;
  const DetectionScreen({Key? key, required this.fileImage}) : super(key: key);

  @override
  _DetectionScreenState createState() => _DetectionScreenState();
}

class _DetectionScreenState extends State<DetectionScreen> {
  final ScreenshotController screenshotController = ScreenshotController();
  List<dynamic> listOutputs = [];
  String? hasil;
  bool isLoading = true;
  File? image;

  @override
  void initState() {
    super.initState();
    if (widget.fileImage != null) {
      processImage(widget.fileImage!);
    }
  }

  Future<void> processImage(File image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      imageMean: 0,
      imageStd: 255,
      numResults: 2,
      threshold: 0.5,
      asynch: true,
    );
    if (mounted) {
      setState(() {
        isLoading = false;
        listOutputs = output ?? [];
        image = widget.fileImage!;
        if (listOutputs.isNotEmpty) {
          hasil = listOutputs[0]["label"];
        } else {
          hasil = "Tidak Terdeteksi";
        }
      });
    }
  }

  String _uint8ListTob64(Uint8List uint8list) {
    return base64Encode(uint8list);
  }

  Future<String?> _captureScreenshot() async {
    final image = await screenshotController.capture();
    if (image != null) {
      return _uint8ListTob64(image);
    }
    return null;
  }

  void _showConfirmSaveDialog(BuildContext context) {
    Widget cancelButton = TextButton(
      child: const Text("Tidak"),
      onPressed: () => Navigator.pop(context),
    );
    Widget continueButton = TextButton(
      child: const Text("Iya"),
      onPressed: () async {
        Navigator.pop(context);
        String? byte64String = await _captureScreenshot();
        if (byte64String != null) {
          await DatabaseHelper.insertProfile(
            ProfileModel(
                    name: hasil ?? "Tidak Terdeteksi", image64bit: byte64String)
                .toMap(),
          );
        }
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text("Peringatan"),
      content: const Text("Simpan Gambar?"),
      actions: [cancelButton, continueButton],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) => alert,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          'HASIL KLASIFIKASI',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              height: 50,
            ),
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        border: Border.all(color: Colors.green, width: 1),
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Column(
                        children: [
                          Screenshot(
                            controller: screenshotController,
                            child: widget.fileImage != null
                                ? Image.file(widget.fileImage!)
                                : const Text("No image selected"),
                          ),
                          const SizedBox(height: 20),
                          isLoading
                              ? const CircularProgressIndicator()
                              : Text(
                                  hasil ?? "Processing...",
                                  style: const TextStyle(
                                    fontSize: 25,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    if (widget.fileImage != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 35.0),
                        child: ElevatedButton.icon(
                          onPressed: () {
                            _showConfirmSaveDialog(context);
                          },
                          icon: const Icon(
                            Icons.photo_library,
                            size: 30,
                          ),
                          label: const Text(
                            'Simpan Gambar',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            minimumSize: const Size.fromHeight(60),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
