import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/database.dart';
import 'package:flutter_application_1/database/profile.dart';
import 'package:recase/recase.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<ProfileModel> pList = [];

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    pList = await DatabaseHelper.getAllProfile();
    setState(() {});
  }

  Future<void> _deleteItem(int id) async {
    await DatabaseHelper.deleteItem(id);
    _loadHistory();
    debugPrint("aaaaaaa");
  }

  void _showImageDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            height: 350,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: MemoryImage(
                  const Base64Decoder().convert(pList[index].image64bit!),
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }

  void _showConfirmDeleteDialog(BuildContext context, int index) {
    Widget cancelButton = TextButton(
      child: const Text("Tidak"),
      onPressed: () => Navigator.pop(context),
    );
    Widget continueButton = TextButton(
      child: const Text("Iya"),
      onPressed: () {
        Navigator.pop(context);
        _deleteItem(pList[index].id!);
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text("Peringatan"),
      content: const Text("Hapus Gambar?"),
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
          'RIWAYAT',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              Expanded(
                child: pList.isNotEmpty
                    ? ListView.builder(
                        itemCount: pList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () =>
                                        _showImageDialog(context, index),
                                    child: Container(
                                      height: 70,
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: Colors.green, width: 1),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(15),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Image.memory(
                                            const Base64Decoder().convert(
                                              pList[index].image64bit!,
                                            ),
                                            width: 50,
                                            height: 50,
                                            fit: BoxFit.cover,
                                          ),
                                          const SizedBox(width: 20),
                                          Expanded(
                                            child: Text(
                                              pList[index].name!.titleCase,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                GestureDetector(
                                  onTap: () =>
                                      _showConfirmDeleteDialog(context, index),
                                  child: Container(
                                    width: 70,
                                    height: 70,
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        "Delete",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      )
                    : const Center(child: Text("Empty")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

