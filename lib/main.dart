import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onnxruntime_examples/screens/history_screen.dart';
import 'package:flutter_onnxruntime_examples/screens/home_screen.dart';
import 'package:flutter_onnxruntime_examples/screens/result_screen.dart';

import 'package:intl/date_symbol_data_local.dart'; // <-- Impor ini

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BelajarJawi',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.grey[100],
        fontFamily: 'Poppins',
      ),
      home: const MainNavigator(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainNavigator extends StatefulWidget {
  const MainNavigator({super.key});

  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  final _pageController = PageController(initialPage: 1);
  final _notchBottomBarController = NotchBottomBarController(index: 1);
  PredictionResult? _lastPrediction;

  List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages = [
      ResultScreen(
        result: _lastPrediction,
        onDetectAgain: () => _changePage(1),
      ),
      HomeScreen(
        onPredictionComplete: (result) {
          setState(() {
            _lastPrediction = result;
            _pages[0] = ResultScreen(
              result: _lastPrediction,
              onDetectAgain: () => _changePage(1),
            );
          });
          _changePage(0);
        },
      ),
      const HistoryScreen(),
    ];
  }

  void _changePage(int index) {
    _pageController.jumpToPage(index);
    _notchBottomBarController.jumpTo(index);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: _pages,
      ),
      extendBody: true,
      bottomNavigationBar: AnimatedNotchBottomBar(
        notchBottomBarController: _notchBottomBarController,
        color: Colors.white,
        showLabel: true,
        itemLabelStyle: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
        shadowElevation: 5,
        kBottomRadius: 28.0,
        notchColor: Colors.green,
        bottomBarItems: const [
          BottomBarItem(
            inActiveItem: Icon(
              Icons.image_search_outlined,
              color: Colors.blueGrey,
            ),
            activeItem: Icon(Icons.image_search, color: Colors.white),
            itemLabel: 'Hasil',
          ),
          BottomBarItem(
            inActiveItem: Icon(
              Icons.camera_alt_outlined,
              color: Colors.blueGrey,
            ),
            activeItem: Icon(Icons.camera_alt, color: Colors.white),
            itemLabel: 'Deteksi',
          ),
          BottomBarItem(
            inActiveItem: Icon(Icons.history_outlined, color: Colors.blueGrey),
            activeItem: Icon(Icons.history, color: Colors.white),
            itemLabel: 'Histori',
          ),
        ],
        onTap: (index) {
          _pageController.jumpToPage(index);
        },
        kIconSize: 24.0,
      ),
    );
  }
}
