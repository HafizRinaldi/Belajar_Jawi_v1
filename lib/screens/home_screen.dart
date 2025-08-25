import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:flutter_onnxruntime/flutter_onnxruntime.dart';

class PredictionResult {
  final File imageFile;
  final String label;
  final String base64Image;

  PredictionResult({
    required this.imageFile,
    required this.label,
    required this.base64Image,
  });
}

class HomeScreen extends StatefulWidget {
  final Function(PredictionResult) onPredictionComplete;

  const HomeScreen({super.key, required this.onPredictionComplete});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  bool _isProcessing = false;
  File? _pickedImage;
  img.Image? _cachedImage;
  String? _base64Image;

  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: source,
      imageQuality: 70,
    );

    if (image != null) {
      final imageBytes = await image.readAsBytes();
      setState(() {
        _pickedImage = File(image.path);
        _cachedImage = img.decodeImage(imageBytes);
        _base64Image = base64Encode(imageBytes);
      });
      _runInference();
    }
  }

  Future<void> _runInference() async {
    if (_cachedImage == null || _pickedImage == null || _base64Image == null)
      return;

    setState(() {
      _isProcessing = true;
    });

    try {
      final assetPath =
          'assets/models/EfficientNet-B0-AutoAugment_bs32_lr1em03.onnx';
      final classNamesPath = 'assets/models/imagenet-simple-labels.json';
      final session = await OnnxRuntime().createSessionFromAsset(assetPath);
      final resizedImage = img.copyResize(
        _cachedImage!,
        width: 224,
        height: 224,
      );
      final inputData = Float32List(1 * 3 * 224 * 224);
      final means = [0.485, 0.456, 0.406];
      final stds = [0.229, 0.224, 0.225];

      for (int y = 0; y < 224; y++) {
        for (int x = 0; x < 224; x++) {
          final pixel = resizedImage.getPixel(x, y);
          inputData[y * 224 + x] = (pixel.r / 255.0 - means[0]) / stds[0];
          inputData[224 * 224 + y * 224 + x] =
              (pixel.g / 255.0 - means[1]) / stds[1];
          inputData[2 * 224 * 224 + y * 224 + x] =
              (pixel.b / 255.0 - means[2]) / stds[2];
        }
      }

      final inputName = session.inputNames.first;
      final outputName = session.outputNames.first;
      final inputTensor = await OrtValue.fromList(inputData, [1, 3, 224, 224]);
      final outputs = await session.run({inputName: inputTensor});
      final scores =
          (await outputs[outputName]!.asFlattenedList()).cast<double>();
      final probabilities = _applySoftmax(scores);
      double maxProbability = 0.0;
      int maxIndex = 0;
      for (int i = 0; i < probabilities.length; i++) {
        if (probabilities[i] > maxProbability) {
          maxProbability = probabilities[i];
          maxIndex = i;
        }
      }

      final String classNamesJson = await rootBundle.loadString(classNamesPath);
      final List<dynamic> classNames = jsonDecode(classNamesJson);
      final String topPrediction =
          (maxIndex < classNames.length)
              ? classNames[maxIndex]
              : 'Tidak Dikenali';

      final result = PredictionResult(
        imageFile: _pickedImage!,
        label: topPrediction,
        base64Image: _base64Image!,
      );

      widget.onPredictionComplete(result);

      await inputTensor.dispose();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Terjadi error saat prediksi: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isProcessing = false;
          _pickedImage = null;
        });
      }
    }
  }

  List<double> _applySoftmax(List<double> logits) {
    double maxLogit = logits.reduce(math.max);
    List<double> expValues =
        logits.map((logit) => math.exp(logit - maxLogit)).toList();
    double sumExp = expValues.reduce((a, b) => a + b);
    return expValues.map((exp) => exp / sumExp).toList();
  }

  Widget _buildInfoRow(IconData icon, String text, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 14, color: Colors.grey.shade800),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionContainer({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInitialView() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.camera_enhance_outlined,
            size: 60,
            color: Colors.green.shade700,
          ),
          const SizedBox(height: 8),
          Text(
            "Mulai Deteksi Huruf",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
            ),
          ),
          const SizedBox(height: 4),
          _buildSectionContainer(
            title: "Fitur & Teknologi",
            children: [
              _buildInfoRow(
                Icons.psychology,
                "Ditenagai oleh AI Deep Learning (EfficientNet-B0).",
                Colors.blue.shade700,
              ),
              const SizedBox(height: 12),
              _buildInfoRow(
                Icons.verified,
                "Akurasi model mencapai 98% dalam pengenalan.",
                Colors.orange.shade700,
              ),
              const SizedBox(height: 12),
              _buildInfoRow(
                Icons.history_edu,
                "Membantu melestarikan Aksara Jawi.",
                Colors.green.shade700,
              ),
            ],
          ),
          const SizedBox(height: 2),
          _buildSectionContainer(
            title: "Tata Cara Penggunaan",
            children: [
              _buildInfoRow(
                Icons.touch_app,
                "Pilih 'Ambil Gambar' atau 'Galeri'.",
                Colors.blue.shade700,
              ),
              const SizedBox(height: 12),
              _buildInfoRow(
                Icons.image_search,
                "Hasil deteksi akan muncul di tab 'Hasil'.",
                Colors.orange.shade700,
              ),
              const SizedBox(height: 12),
              _buildInfoRow(
                Icons.save,
                "Simpan hasil dan lihat di tab 'Histori'.",
                Colors.green.shade700,
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'DETEKSI',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF2E7D32), Color(0xFF4CAF50)],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),
              Expanded(
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(8.0),
                    child:
                        _isProcessing
                            ? const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircularProgressIndicator(),
                                SizedBox(height: 16),
                                Text(
                                  "Menganalisis Gambar...",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            )
                            : (_pickedImage != null
                                ? Image.file(_pickedImage!, fit: BoxFit.contain)
                                : _buildInitialView()),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed:
                    _isProcessing ? null : () => _pickImage(ImageSource.camera),
                icon: const Icon(Icons.camera_alt, color: Colors.white),
                label: const Text(
                  'Ambil Gambar',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade700,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed:
                    _isProcessing
                        ? null
                        : () => _pickImage(ImageSource.gallery),
                icon: const Icon(Icons.image, color: Colors.white),
                label: const Text(
                  'Galeri',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
