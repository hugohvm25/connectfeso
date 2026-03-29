import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../core/error_messages.dart';
import '../core/app_colors.dart';
import '../core/app_assets.dart';
import '../widgets/custom_auth_widgets.dart';
import 'home_screen.dart';
import 'resetpass_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Login Controllers
  final TextEditingController _loginEmailController = TextEditingController();
  final TextEditingController _loginPasswordController = TextEditingController();
  bool _loginObscurePassword = true;
  bool _loginIsLoading = false;

  // Register Controllers
  final TextEditingController _regNameController = TextEditingController();
  final TextEditingController _regEmailController = TextEditingController();
  final TextEditingController _regPasswordController = TextEditingController();
  bool _regObscurePassword = true;
  bool _regIsLoading = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  void _togglePage() {
    if (_currentPage == 0) {
      _pageController.animateToPage(1, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    } else {
      _pageController.animateToPage(0, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    }
  }

  Future<void> _loginWithEmail() async {
    if (_loginEmailController.text.trim().isEmpty || _loginPasswordController.text.trim().isEmpty) {
      _showAlertDialog('Por favor, preencha todos os campos.');
      return;
    }

    setState(() => _loginIsLoading = true);
    try {
      await _auth.signInWithEmailAndPassword(
        email: _loginEmailController.text.trim(),
        password: _loginPasswordController.text.trim(),
      );

      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } catch (e) {
      _showAlertDialog(ErrorMessages.getFromFirebaseException(e));
    } finally {
      if (mounted) setState(() => _loginIsLoading = false);
    }
  }

  Future<void> _register() async {
    if (_regNameController.text.trim().isEmpty || 
        _regEmailController.text.trim().isEmpty || 
        _regPasswordController.text.trim().isEmpty) {
      _showAlertDialog('Por favor, preencha todos os campos.');
      return;
    }

    setState(() => _regIsLoading = true);
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _regEmailController.text.trim(),
        password: _regPasswordController.text.trim(),
      );

      await userCredential.user?.updateDisplayName(_regNameController.text.trim());

      if (!mounted) return;
      _showSuccessDialog('Cadastro realizado com sucesso! Agora você pode fazer login.');
    } catch (e) {
      _showAlertDialog(ErrorMessages.getFromFirebaseException(e));
    } finally {
      if (mounted) setState(() => _regIsLoading = false);
    }
  }

  Future<void> _loginWithGoogle() async {
    setState(() => _loginIsLoading = true);
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      if (googleAuth == null) {
        setState(() => _loginIsLoading = false);
        return;
      }

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);
      
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } catch (e) {
      _showAlertDialog(ErrorMessages.getFromFirebaseException(e));
    } finally {
      if (mounted) setState(() => _loginIsLoading = false);
    }
  }

  void _showAlertDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text("Aviso"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("OK", style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text("Sucesso!", style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _togglePage();
              },
              child: const Text("IR PARA LOGIN", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Fundo Verde no Topo
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
          ),
          
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  // Logo Branca
                  Image.asset(
                    AppAssets.logoConnectFesoBranco,
                    height: 60,
                  ),
                  const SizedBox(height: 30),
                  
                  // Card Principal com o Seletor Embutido
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Seletor Interno (Botões embutidos no card)
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: Container(
                              height: 55,
                              decoration: BoxDecoration(
                                color: AppColors.background,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Stack(
                                children: [
                                  // Fundo Animado do Botão Selecionado
                                  AnimatedAlign(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                    alignment: _currentPage == 0 ? Alignment.centerLeft : Alignment.centerRight,
                                    child: Container(
                                      width: (MediaQuery.of(context).size.width - 68) / 2,
                                      height: 45,
                                      margin: const EdgeInsets.symmetric(horizontal: 5),
                                      decoration: BoxDecoration(
                                        color: AppColors.primary,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                  ),
                                  // Botões de Texto
                                  Row(
                                    children: [
                                      Expanded(
                                        child: GestureDetector(
                                          behavior: HitTestBehavior.opaque,
                                          onTap: () => _pageController.animateToPage(0, duration: const Duration(milliseconds: 400), curve: Curves.easeInOut),
                                          child: Center(
                                            child: Text(
                                              "LOGIN",
                                              style: TextStyle(
                                                color: _currentPage == 0 ? Colors.white : AppColors.textSecondary,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: GestureDetector(
                                          behavior: HitTestBehavior.opaque,
                                          onTap: () => _pageController.animateToPage(1, duration: const Duration(milliseconds: 400), curve: Curves.easeInOut),
                                          child: Center(
                                            child: Text(
                                              "CADASTRO",
                                              style: TextStyle(
                                                color: _currentPage == 1 ? Colors.white : AppColors.textSecondary,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          
                          // PageView para os Formulários
                          SizedBox(
                            height: 460, // Ajuste conforme necessário
                            child: PageView(
                              controller: _pageController,
                              onPageChanged: (index) => setState(() => _currentPage = index),
                              children: [
                                _buildLoginFields(),
                                _buildRegisterFields(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  const Text("OU", style: TextStyle(color: Colors.black38, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  
                  // Botão do Google fora do card principal
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: OutlinedButton(
                      onPressed: _loginWithGoogle,
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 55),
                        side: BorderSide(color: Colors.grey.shade300),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(AppAssets.imgGoogleLogo, height: 24),
                          const SizedBox(width: 12),
                          const Text('Entrar com Google', style: TextStyle(color: Colors.black87, fontSize: 16)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginFields() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          const Text(
            "Bem-vindo de volta!",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primary),
          ),
          const SizedBox(height: 20),
          CustomTextField(
            hint: "E-mail",
            controller: _loginEmailController,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 15),
          CustomTextField(
            hint: "Senha",
            controller: _loginPasswordController,
            isPassword: true,
            obscureText: _loginObscurePassword,
            onToggleVisibility: () => setState(() => _loginObscurePassword = !_loginObscurePassword),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ResetPassScreen()));
              },
              child: const Text("Esqueceu a senha?", style: TextStyle(color: AppColors.primary)),
            ),
          ),
          const SizedBox(height: 10),
          CustomButton(text: "ENTRAR", onPressed: _loginWithEmail, isLoading: _loginIsLoading),
        ],
      ),
    );
  }

  Widget _buildRegisterFields() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          const Text(
            "Crie sua Conta",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primary),
          ),
          const SizedBox(height: 20),
          CustomTextField(hint: "Nome Completo", controller: _regNameController),
          const SizedBox(height: 15),
          CustomTextField(
            hint: "E-mail",
            controller: _regEmailController,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 15),
          CustomTextField(
            hint: "Senha",
            controller: _regPasswordController,
            isPassword: true,
            obscureText: _regObscurePassword,
            onToggleVisibility: () => setState(() => _regObscurePassword = !_regObscurePassword),
          ),
          const SizedBox(height: 30),
          CustomButton(text: "CADASTRAR", onPressed: _register, isLoading: _regIsLoading),
        ],
      ),
    );
  }
}
