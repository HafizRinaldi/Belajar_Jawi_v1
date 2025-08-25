import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_onnxruntime_examples/database/database.dart';
import 'package:flutter_onnxruntime_examples/database/profile.dart';
import 'package:flutter_onnxruntime_examples/screens/result_screen.dart';
import 'package:intl/intl.dart';
import 'package:recase/recase.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late Future<List<ProfileModel>> _historyFuture;

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  void _loadHistory() {
    setState(() {
      _historyFuture = DatabaseHelper.getAllProfile();
    });
  }

  Future<void> _deleteItem(int id) async {
    await DatabaseHelper.deleteItem(id);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Item berhasil dihapus.'),
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 2),
      ),
    );
    _loadHistory();
  }

  void _showConfirmDeleteDialog(BuildContext context, ProfileModel item) {
    Widget cancelButton = TextButton(
      child: const Text("Batal"),
      onPressed: () => Navigator.pop(context),
    );
    Widget continueButton = TextButton(
      child: const Text("Hapus", style: TextStyle(color: Colors.red)),
      onPressed: () {
        Navigator.pop(context);
        _deleteItem(item.id!);
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text("Konfirmasi Hapus"),
      content: Text(
        "Anda yakin ingin menghapus item '${item.name?.titleCase}' dari riwayat?",
      ),
      actions: [cancelButton, continueButton],
    );
    showDialog(context: context, builder: (BuildContext context) => alert);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          _loadHistory();
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: const Text(
                'RIWAYAT',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              backgroundColor: Colors.green,
              centerTitle: true,
              floating: true,
              snap: true,
              elevation: 4.0,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: FutureBuilder<List<ProfileModel>>(
                future: _historyFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      heightFactor: 5,
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("Terjadi kesalahan: ${snapshot.error}"),
                    );
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      heightFactor: 5,
                      child: Text(
                        "Riwayat masih kosong",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    );
                  }
                  final pList = snapshot.data!;
                  return ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: pList.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final item = pList[pList.length - 1 - index];
                      return _buildHistoryItem(context, item);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryItem(BuildContext context, ProfileModel item) {
    String formattedDate = "Waktu tidak diketahui";
    if (item.timestamp != null) {
      final dateTime = DateTime.parse(item.timestamp!);
      formattedDate = DateFormat(
        'dd MMM yyyy, HH:mm',
        'id_ID',
      ).format(dateTime);
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 12.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.memory(
                base64Decode(item.image64bit!),
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name!.titleCase,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    formattedDate,
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.visibility, color: Colors.blue.shade700),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResultScreen(historyItem: item),
                      ),
                    );
                  },
                  tooltip: 'Lihat Detail',
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.redAccent),
                  onPressed: () => _showConfirmDeleteDialog(context, item),
                  tooltip: 'Hapus',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
