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
  late String currentCampusId;

  @override
  void initState() {
    super.initState();
    currentCampusId = widget.campusId;
    images = _getImagesForCampus(currentCampusId);
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

  void _changeCampus(String campusId) {
    setState(() {
      currentCampusId = campusId;
      images = _getImagesForCampus(campusId);
      _index = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF006B64),
        title: Image.asset(
          "assets/tour_360_branco_sem_fundo.png",
          height: 40,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          // Imagem 360º renderizada
          PanoramaViewer(
            animSpeed: 0.1,
            sensorControl: SensorControl.orientation,
            child: Image(image: images[_index]),
          ),

          // === Ícones de Campus (Carrossel no topo) ===
          Positioned(
            top: 16,
            left: 0,
            right: 0,
            child: SizedBox(
              height: 80,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 55),
                child: Row(
                  children: [
                    _buildCampusIcon("1", 'assets/foto_sede.jpg'),
                    const SizedBox(width: 30),
                    _buildCampusIcon("2", 'assets/foto_fazenda.jpg'),
                    const SizedBox(width: 30),
                    _buildCampusIcon("3", 'assets/foto_proarte.jpg'),
                    const SizedBox(width: 30),
                  ],
                ),
              ),
            ),
          ),

          // Botão próximo
          if (images.length > 1)
            Positioned(
              bottom: 30,
              right: 20,
              child: IconButton(
                icon: const Icon(Icons.arrow_circle_right, size: 60, color: Color(0xFF006B64)),
                onPressed: _goToNextImage,
              ),
            ),

          // Botão anterior
          if (images.length > 1)
            Positioned(
              bottom: 30,
              left: 20,
              child: IconButton(
                icon: const Icon(Icons.arrow_circle_left, size: 60, color: Color(0xFF006B64)),
                onPressed: _goToPreviousImage,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCampusIcon(String campusId, String imagePath) {
    return GestureDetector(
      onTap: () => _changeCampus(campusId),
      child: CircleAvatar(
        radius: 40,
        backgroundColor: Colors.white,
        backgroundImage: AssetImage(imagePath),
        child: currentCampusId == campusId
            ? Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFF006B64), width: 5),
          ),
        )
            : null,
      ),
    );
  }

  List<AssetImage> _getImagesForCampus(String id) {
    switch (id) {
      case '1':
        return [
          const AssetImage('assets/360/sede/sede_fachada.jpg'),
          const AssetImage('assets/360/sede/patio_sede_relogio.jpg'),
          const AssetImage('assets/360/sede/patio_sede.jpg'),
          const AssetImage('assets/360/sede/sede_casarao.jpg'),
        ];
      case '2': // Quinta do Paraíso (Fazenda)
        return [
          const AssetImage('assets/360/quinta_paraiso/fazenda_fachada.jpg'),
          const AssetImage('assets/360/quinta_paraiso/fazenda_alice.jpg'),
          const AssetImage('assets/360/quinta_paraiso/fazenda_quadra.jpg'),
        ];
      case '3':
        return [
          const AssetImage('assets/360/proarte/proarte.jpg'),
          const AssetImage('assets/360/proarte/teste1.jpg'),
        ];
      default:
        return [const AssetImage('assets/360/default.jpg')];
    }
  }
}
