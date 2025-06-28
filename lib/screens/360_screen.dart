// import 'package:flutter/material.dart';
// import 'package:panorama_viewer/panorama_viewer.dart';
//
// class TourScreen extends StatefulWidget {
//   const TourScreen({super.key});
//
//   @override
//   State<TourScreen> createState() => _TourScreenState();
// }
//
// class _TourScreenState extends State<TourScreen> {
//   int _index = 0;
//
//   final List<String> images = [
//     'assets/patio_sede_relogio.jpg',
//     'assets/patio_sede.jpg',
//     'assets/sede_casarao.jpg',
//   ];
//
//   void _goToNextImage() {
//     setState(() {
//       _index = (_index + 1) % images.length;
//     });
//   }
//
//   void _goToPreviousImage() {
//     setState(() {
//       _index = (_index - 1 + images.length) % images.length;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFF5F5F5),
//       appBar: AppBar(
//         backgroundColor: Color(0xFF006B64),
//         title: Image.asset(
//           "assets/tour_360_branco_sem_fundo.png",
//           height: 40,
//         ),
//         iconTheme: IconThemeData(color: Colors.white),
//       ),
//       body:
//       Stack(
//         children: [
//           // Imagem 360º renderizada
//           PanoramaViewer(
//             animSpeed: 0.1,
//             sensorControl: SensorControl.orientation,
//             child: Image.asset(images[_index]),
//           ),
//
//           // Simulando Hotspot 1
//           if (_index == 0)
//             Positioned(
//               bottom: 30,
//               right: 20,
//               child: IconButton(
//                 icon: Icon(Icons.arrow_circle_right, size: 60, color: Color(0xFF006B64)),
//                 onPressed: _goToNextImage,
//               ),
//               // child: FloatingActionButton(
//               //   backgroundColor: Color(0xFF006B64),
//               //   onPressed: _goToNextImage,
//               //   child: Icon(Icons.arrow_circle_right, color: Colors.white),
//               // ),
//             ),
//
//           // Simulando Hotspot 2
//           if (_index == 1)
//             Positioned(
//               bottom: 30,
//               right: 20,
//                 child: IconButton(
//                   icon: Icon(Icons.arrow_circle_right, size: 60, color: Color(0xFF006B64)),
//                   onPressed: _goToNextImage,
//                 ),
//               // child: FloatingActionButton(
//               //   backgroundColor: Color(0xFF006B64),
//               //   onPressed: _goToNextImage,
//               //   child: Icon(Icons.arrow_forward, color: Colors.white),
//               // ),
//             ),
//
//           if (_index == 1)
//             Positioned(
//               bottom: 30,
//               left: 20,
//                 child: IconButton(
//                   icon: Icon(Icons.arrow_circle_left, size: 60, color: Color(0xFF006B64)),
//                   onPressed: _goToPreviousImage,
//                 ),
//               // child: FloatingActionButton(
//               //   backgroundColor: Color(0xFF006B64),
//               //   onPressed: _goToPreviousImage,
//               //   child: Icon(Icons.arrow_back, color: Colors.white),
//               // ),
//             ),
//
//           if (_index == 2)
//             Positioned(
//               bottom: 30,
//               left: 20,
//               child: IconButton(
//                 icon: Icon(Icons.arrow_circle_left, size: 60, color: Color(0xFF006B64)),
//                 onPressed: _goToPreviousImage,
//               ),
//               // child: FloatingActionButton(
//               //   backgroundColor: Color(0xFF006B64),
//               //   onPressed: _goToPreviousImage,
//               //   child: Icon(Icons.arrow_back, color: Colors.white),
//               // ),
//             ),
//         ],
//       ),
//     );
//   }
// }
//

import 'package:flutter/material.dart';
import 'package:panorama_viewer/panorama_viewer.dart';

class TourScreen extends StatefulWidget {
  final String campusId;

  const TourScreen({Key? key, required this.campusId}) : super(key: key);

  @override
  State<TourScreen> createState() => _TourScreenState();
}

class _TourScreenState extends State<TourScreen> {
  late List<AssetImage> images;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    images = _getImagesForCampus(widget.campusId);
  }

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
      body: Stack(
        children: [
          // Imagem 360º renderizada
          PanoramaViewer(
            animSpeed: 0.1,
            sensorControl: SensorControl.orientation,
            child: Image(image: images[_index]),
          ),

          // Botão próximo
          if (_index < images.length - 1)
            Positioned(
              bottom: 30,
              right: 20,
              child: IconButton(
                icon: Icon(Icons.arrow_circle_right, size: 60, color: Color(0xFF006B64)),
                onPressed: _goToNextImage,
              ),
            ),

          // Botão anterior
          if (_index > 0)
            Positioned(
              bottom: 30,
              left: 20,
              child: IconButton(
                icon: Icon(Icons.arrow_circle_left, size: 60, color: Color(0xFF006B64)),
                onPressed: _goToPreviousImage,
              ),
            ),
        ],
      ),
    );
  }

  List<AssetImage> _getImagesForCampus(String id) {
    switch (id) {
      case '1':
        return [
          AssetImage('assets/360/sede/sede_fachada.jpg'),
          AssetImage('assets/360/sede/patio_sede_relogio.jpg'),
          AssetImage('assets/360/sede/patio_sede.jpg'),
          AssetImage('assets/360/sede/sede_casarao.jpg'),
        ];
      case '2':
        return [
          AssetImage('assets/360/quinta_paraiso/teste1.jpg'),
          AssetImage('assets/360/quinta_paraiso/teste2.jpg'),
        ];
      case '3':
        return [
          AssetImage('assets/360/proarte/proarte.jpg'),
          AssetImage('assets/360/proarte/teste1.jpg'),
        ];
      default:
        return [AssetImage('assets/360/default.jpg')];
    }
  }
}


