import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter_application_1/screens/detection_screen.dart';
import 'package:flutter_application_1/screens/history_screen.dart';
import 'package:flutter_application_1/screens/home_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();

  final firstCamera = cameras[0];
  runApp(MyApp(camera: firstCamera));
}

class MyApp extends StatelessWidget {
  final CameraDescription camera;
  const MyApp({Key? key, required this.camera}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Layout Example',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: MyHomePage(camera: camera),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final CameraDescription camera;
  const MyHomePage({Key? key, required this.camera}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var isLoading = false;
  final _pageController = PageController(initialPage: 1);
  final NotchBottomBarController _controller =
      NotchBottomBarController(index: 1);

  File? image;
  Future loadModel() async {
    await Tflite.loadModel(
      model: 'assets/models/jawi.tflite',
      labels: 'assets/models/labels.txt',
    );
  }

  void onImageSelected(File newImage) {
    setState(() {
      image = newImage;
    });
    _pageController.jumpToPage(0);
    _controller.jumpTo(0);
  }

  @override
  void initState() {
    super.initState();
    isLoading = true;
    loadModel().then((value) {
      setState(() => isLoading = false);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          DetectionScreen(fileImage: image),
          CameraScreen(
            camera: widget.camera,
            onImageSelected: onImageSelected, // Kirim fungsi callback
          ),
          HistoryScreen(),
        ],
      ),
      bottomNavigationBar: AnimatedNotchBottomBar(
        notchBottomBarController: _controller,
        color: Colors.green,
        notchColor: Colors.green,
        itemLabelStyle: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
        bottomBarItems: const [
          BottomBarItem(
            inActiveItem: Icon(Icons.refresh_outlined, color: Colors.white),
            activeItem: Icon(Icons.refresh, color: Colors.white),
            itemLabel: "Hasil",
          ),
          BottomBarItem(
            inActiveItem: Icon(Icons.camera_alt, color: Colors.white),
            activeItem: Icon(Icons.camera_alt, color: Colors.white),
            itemLabel: 'Deteksi',
          ),
          BottomBarItem(
            inActiveItem: Icon(Icons.history, color: Colors.white),
            activeItem: Icon(Icons.history, color: Colors.white),
            itemLabel: 'Histori',
          ),
        ],
        onTap: (index) {
          _pageController.jumpToPage(index);
        },
      ),
    );
  }
}
