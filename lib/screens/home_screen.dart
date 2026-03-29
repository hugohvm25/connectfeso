import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../services/auth_service.dart';
import 'login_screen.dart';
import 'chat_screen.dart';
import 'ar_screen.dart';
import '360_screen.dart';
import 'localization_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthService _authService = AuthService();
  late final WebViewController _controller;
  int _loadingProgress = 0;

  @override
  void initState() {
    super.initState();

    final PlatformWebViewControllerCreationParams params =
    const PlatformWebViewControllerCreationParams();

    final WebViewController controller =
    WebViewController.fromPlatformCreationParams(params)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            setState(() {
              _loadingProgress = progress;
            });
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            setState(() {
              _loadingProgress = 100;
            });
          },
        ),
      )
      ..loadRequest(Uri.parse('https://www.unifeso.edu.br'));

    if (controller.platform is AndroidWebViewController) {
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }

    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF006B64),
        title: Image.asset("assets/connect_feso_branco.png", height: 50),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app, color: Colors.white, size: 30),
            onPressed: () async {
              await _authService.signOut();
              if (!mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Desconectado com sucesso!")),
              );
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          if (_loadingProgress < 100)
            LinearProgressIndicator(
              value: _loadingProgress / 100.0,
              backgroundColor: Colors.grey[200],
              color: const Color(0xFF006B64),
              minHeight: 3,
            ),
          
          Container(
            color: Colors.grey[200],
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: () async {
                    if (await _controller.canGoBack()) {
                      _controller.goBack();
                    }
                  },
                  icon: const Icon(Icons.arrow_back),
                  label: const Text("Voltar"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF006B64),
                    foregroundColor: Colors.white,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    if (await _controller.canGoForward()) {
                      _controller.goForward();
                    }
                  },
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text("Avançar"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF006B64),
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: WebViewWidget(controller: _controller),
          ),
        ],
      ),
      floatingActionButton: _buildSpeedDial(),
    );
  }

  Widget _buildSpeedDial() {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: const IconThemeData(color: Colors.white, size: 30),
      backgroundColor: const Color(0xFF006B64),
      foregroundColor: Colors.white,
      children: [
        SpeedDialChild(
          child: const Icon(Icons.view_in_ar, color: Colors.white),
          backgroundColor: const Color(0xFF006B64),
          label: "Realidade Aumentada",
          labelStyle: const TextStyle(fontSize: 14, color: Colors.white),
          labelBackgroundColor: const Color(0xFF006B64),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ARScreen()),
            );
          },
        ),
        SpeedDialChild(
          child: const Icon(Icons.chat, color: Colors.white),
          backgroundColor: const Color(0xFF006B64),
          label: "Connect Chat",
          labelStyle: const TextStyle(fontSize: 14, color: Colors.white),
          labelBackgroundColor: const Color(0xFF006B64),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChatScreen()),
            );
          },
        ),
        SpeedDialChild(
          child: Image.asset(
            'assets/360-graus.png',
            width: 30,
            height: 30,
            color: Colors.white,
          ),
          backgroundColor: const Color(0xFF006B64),
          label: "Tour 360º",
          labelStyle: const TextStyle(fontSize: 14, color: Colors.white),
          labelBackgroundColor: const Color(0xFF006B64),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const TourScreen(campusId: '1'),
              ),
            );
          },
        ),
        SpeedDialChild(
          child: const Icon(Icons.map_outlined, color: Colors.white),
          backgroundColor: const Color(0xFF006B64),
          label: "Localização",
          labelStyle: const TextStyle(fontSize: 14, color: Colors.white),
          labelBackgroundColor: const Color(0xFF006B64),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LocalizationScreen(),
              ),
            );
          },
        ),
      ],
    );
  }
}
