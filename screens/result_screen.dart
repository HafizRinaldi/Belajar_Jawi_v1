import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_onnxruntime_examples/data/hijaiyah_info.dart';
import 'package:flutter_onnxruntime_examples/database/database.dart';
import 'package:flutter_onnxruntime_examples/database/profile.dart';
import 'package:flutter_onnxruntime_examples/screens/home_screen.dart';

class ResultScreen extends StatelessWidget {
  final PredictionResult? result;
  final ProfileModel? historyItem;
  final VoidCallback? onDetectAgain;

  const ResultScreen({
    super.key,
    this.result,
    this.historyItem,
    this.onDetectAgain,
  });

  Future<void> _saveToHistory(BuildContext context) async {
    if (result == null) return;

    final profile = ProfileModel(
      name: result!.label,
      image64bit: result!.base64Image,
      timestamp: DateTime.now().toIso8601String(),
    );
    await DatabaseHelper.insertProfile(profile.toMap());

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Hasil berhasil disimpan ke riwayat.'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
  }

  Widget _buildEmptyStateInfoCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
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
              "Membantu melestarikan Aksara Jawi yang bersejarah.",
              Colors.green.shade700,
            ),
          ],
        ),
      ),
    );
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

  @override
  Widget build(BuildContext context) {
    final bool isFromHistory = historyItem != null;
    final displayLabel = isFromHistory ? historyItem!.name : result?.label;
    final displayImage =
        isFromHistory
            ? Image.memory(base64Decode(historyItem!.image64bit!))
            : (result != null ? Image.file(result!.imageFile) : null);

    final String description =
        hijaiyahInfo[displayLabel ?? ''] ??
        'Informasi untuk huruf ini tidak tersedia.';

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: isFromHistory,
        title: const Text(
          'HASIL KLASIFIKASI',
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
      body:
          (displayImage == null)
              ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.search_off,
                        size: 80,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Belum ada klasifikasi terakhir.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                      const SizedBox(height: 24),
                      _buildEmptyStateInfoCard(),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: onDetectAgain,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 12,
                          ),
                        ),
                        child: const Text(
                          'Mulai Deteksi Sekarang',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              )
              : Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Card(
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            SizedBox(height: 200, child: displayImage),
                            const SizedBox(height: 20),
                            Text(
                              displayLabel ?? 'Tidak Dikenali',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[800],
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.0),
                              child: Divider(),
                            ),
                            Text(
                              description,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.shade700,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    if (!isFromHistory)
                      ElevatedButton.icon(
                        onPressed: () => _saveToHistory(context),
                        icon: const Icon(Icons.save_alt, color: Colors.white),
                        label: const Text(
                          'Simpan ke Riwayat',
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
                  ],
                ),
              ),
    );
  }
}
