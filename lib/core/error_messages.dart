import 'package:firebase_auth/firebase_auth.dart';

class ErrorMessages {
  static String getFromFirebaseException(dynamic e) {
    if (e is FirebaseAuthException) {
      switch (e.code) {
        case 'user-not-found':
          return 'Nenhum usuário encontrado para este e-mail.';
        case 'wrong-password':
          return 'Senha incorreta. Tente novamente.';
        case 'email-already-in-use':
          return 'Este e-mail já está sendo usado por outra conta.';
        case 'invalid-email':
          return 'O formato do e-mail é inválido.';
        case 'weak-password':
          return 'A senha fornecida é muito fraca.';
        case 'user-disabled':
          return 'Este usuário foi desativado.';
        case 'operation-not-allowed':
          return 'A operação de login por e-mail e senha não está habilitada.';
        case 'too-many-requests':
          return 'Muitas tentativas. Tente novamente mais tarde.';
        case 'network-request-failed':
          return 'Erro de rede. Verifique sua conexão com a internet.';
        default:
          return 'Ocorreu um erro inesperado: ${e.message}';
      }
    }
    return 'Ocorreu um erro desconhecido. Tente novamente.';
  }
}
