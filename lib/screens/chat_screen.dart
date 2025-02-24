import 'package:flutter/material.dart';
import '../services/gemini_service.dart';
import '../widgets/chat_message.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];
  final GeminiService _geminiService = GeminiService();
  bool _isLoading = false;

  void _enviarMensagem() async {
    String pergunta = _controller.text.trim();
    if (pergunta.isEmpty) return;

    setState(() {
      _messages.add({"role": "user", "text": pergunta});
      _isLoading = true;
    });

    _controller.clear();
    String resposta = await _geminiService.obterResposta(pergunta);

    setState(() {
      _messages.add({"role": "bot", "text": resposta});
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Guia Virtual")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return ChatMessage(
                  text: _messages[index]["text"]!,
                  isUser: _messages[index]["role"] == "user",
                );
              },
            ),
          ),
          if (_isLoading) CircularProgressIndicator(),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(labelText: "Pergunte algo..."),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _enviarMensagem,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
