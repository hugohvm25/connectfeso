import 'dart:convert';
import 'package:http/http.dart' as http;

class GeminiService {
  final String apiKey = "AIzaSyAaAY-GFQQhyPCAVq8fxaG7UTnfT_OlDfU";

  Future<String> obterResposta(String pergunta) async {
    final url = Uri.parse("https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateText?key=$apiKey");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "prompt": {
          "text": "Você é um guia turístico virtual. Responda de forma amigável e informativa.\nUsuário: $pergunta\nGuia:"
        }
      }),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data["candidates"][0]["output"];
    } else {
      return "Desculpe, não consegui entender. Tente novamente.";
    }
  }
}
