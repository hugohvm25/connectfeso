import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GeminiService {
  // Configurações carregadas do .env
  final String _apiKey = dotenv.env['GEMINI_API_KEY'] ?? "";
  final String _modelName = dotenv.env['GEMINI_MODEL'] ?? "gemini-1.5-flash";

  late final GenerativeModel _model;

  GeminiService() {
    if (_apiKey.isNotEmpty) {
      _model = GenerativeModel(
        model: _modelName,
        apiKey: _apiKey,
        generationConfig: GenerationConfig(
          temperature: 0.7,
          topK: 40,
          topP: 0.95,
          maxOutputTokens: 1024,
        ),
      );
    }
  }

  Future<String> obterResposta(String pergunta) async {
    if (_apiKey.isEmpty) {
      return "Erro: Chave de API do Gemini não configurada no arquivo .env";
    }

    try {
      final content = [
        Content.text(
          "Você é um guia turístico virtual do Centro Universitário Serra dos Órgãos (UNIFESO). "
          "Responda de forma amigável e informativa sobre a instituição.\n"
          "Responda apenas sobre o UNIFESO. Se perguntarem algo fora desse contexto, informe gentilmente que você é um guia do campus.\n"
          "Usuário: $pergunta"
        )
      ];

      final response = await _model.generateContent(content);
      
      if (response.text != null && response.text!.isNotEmpty) {
        return response.text!;
      } else {
        return "Desculpe, o guia não conseguiu processar sua pergunta agora.";
      }
    } catch (e) {
      print("Erro no Gemini: $e");
      if (e.toString().contains("429")) {
        return "Limite de mensagens atingido. Tente novamente em breve.";
      }
      return "Erro de conexão ou serviço indisponível. Verifique sua internet.";
    }
  }
}
