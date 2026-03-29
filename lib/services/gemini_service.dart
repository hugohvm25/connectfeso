import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GeminiService {
  // A chave agora é carregada exclusivamente do arquivo .env (seguro)
  final String _apiKey = dotenv.env['GEMINI_API_KEY'] ?? "";

  Future<String> obterResposta(String pergunta) async {
    if (_apiKey.isEmpty) {
      return "Erro: Chave de API do Gemini não configurada no arquivo .env";
    }

    final url = Uri.parse("https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=$_apiKey");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "contents": [
            {
              "parts": [
                {
                  "text": "Você é um guia turístico virtual do Centro Universitário Serra dos Órgãos (UNIFESO). "
                      "Responda de forma amigável e informativa sobre a instituição.\n"
                      "Responda apenas sobre o UNIFESO. Se perguntarem algo fora desse contexto, informe gentilmente que você é um guia do campus.\n"
                      "Usuário: $pergunta\nGuia:"
                }
              ]
            }
          ]
        }),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        if (data.containsKey("candidates") && data["candidates"].isNotEmpty) {
          return data["candidates"][0]["content"]["parts"][0]["text"];
        } else {
          return "Desculpe, o guia não conseguiu processar sua pergunta agora.";
        }
      } else {
        // Log interno para desenvolvedor, sem expor detalhes sensíveis na UI se possível
        print("Erro Gemini API: ${response.statusCode}");
        return "Desculpe, o serviço de guia está temporariamente indisponível.";
      }
    } catch (e) {
      print("Erro na conexão com Gemini: $e");
      return "Erro de conexão. Verifique sua internet.";
    }
  }
}
