import 'package:flutter/material.dart';
import 'package:panorama_viewer/panorama_viewer.dart';

class TourScreen extends StatefulWidget {
  const TourScreen({super.key});

  @override
  State<TourScreen> createState() => _TourScreenState();
}

class _TourScreenState extends State<TourScreen> {
  int _index = 0;

  final List<String> images = [
    'assets/patio_sede_relogio.jpg',
    'assets/patio_sede.jpg',
    'assets/sede_casarao.jpg',
  ];

  void _goToNextImage() {
    setState(() {
      _index = (_index + 1) % images.length;
    });
  }

  void _goToPreviousImage() {
    setState(() {
      _index = (_index - 1 + images.length) % images.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Color(0xFF006B64),
        title: Image.asset(
          "assets/tour_360_branco_sem_fundo.png",
          height: 40,
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body:
      Stack(
        children: [
          // Imagem 360º renderizada
          PanoramaViewer(
            animSpeed: 0.1,
            sensorControl: SensorControl.orientation,
            child: Image.asset(images[_index]),
          ),

          // Simulando Hotspot 1
          if (_index == 0)
            Positioned(
              bottom: 30,
              right: 20,
              child: IconButton(
                icon: Icon(Icons.arrow_circle_right, size: 60, color: Color(0xFF006B64)),
                onPressed: _goToNextImage,
              ),
              // child: FloatingActionButton(
              //   backgroundColor: Color(0xFF006B64),
              //   onPressed: _goToNextImage,
              //   child: Icon(Icons.arrow_circle_right, color: Colors.white),
              // ),
            ),

          // Simulando Hotspot 2
          if (_index == 1)
            Positioned(
              bottom: 30,
              right: 20,
                child: IconButton(
                  icon: Icon(Icons.arrow_circle_right, size: 60, color: Color(0xFF006B64)),
                  onPressed: _goToNextImage,
                ),
              // child: FloatingActionButton(
              //   backgroundColor: Color(0xFF006B64),
              //   onPressed: _goToNextImage,
              //   child: Icon(Icons.arrow_forward, color: Colors.white),
              // ),
            ),

          if (_index == 1)
            Positioned(
              bottom: 30,
              left: 20,
                child: IconButton(
                  icon: Icon(Icons.arrow_circle_left, size: 60, color: Color(0xFF006B64)),
                  onPressed: _goToPreviousImage,
                ),
              // child: FloatingActionButton(
              //   backgroundColor: Color(0xFF006B64),
              //   onPressed: _goToPreviousImage,
              //   child: Icon(Icons.arrow_back, color: Colors.white),
              // ),
            ),

          if (_index == 2)
            Positioned(
              bottom: 30,
              left: 20,
              child: IconButton(
                icon: Icon(Icons.arrow_circle_left, size: 60, color: Color(0xFF006B64)),
                onPressed: _goToPreviousImage,
              ),
              // child: FloatingActionButton(
              //   backgroundColor: Color(0xFF006B64),
              //   onPressed: _goToPreviousImage,
              //   child: Icon(Icons.arrow_back, color: Colors.white),
              // ),
            ),
        ],
      ),
    );
  }
}

