// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:my_clean_city/models/message_model.dart';
import 'package:my_clean_city/widgets/text_custom.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

class ChatIaScreen extends StatefulWidget {
  const ChatIaScreen({super.key});

  @override
  State<ChatIaScreen> createState() => _ChatIaScreenState();
}

class _ChatIaScreenState extends State<ChatIaScreen>
    with TickerProviderStateMixin {
  final gemini = Gemini.instance;
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<MessageModel> _messages = [];
  bool _isLoading = false;
  late AnimationController _animationController;

  final String systemPrompt = """
Tu es CleanCityAi, un assistant spécialisé dans le recyclage et le tri des ordures de toutes natures.
Ton rôle est de :
  - Répondre uniquement aux questions liées aux ordures : recyclage, tri, réduction des déchets
  - Expliquer à l'utilisateur comment mieux trier ses ordures et quels sont les impacts environnementaux positifs
  - Donner des astuces pratiques pour réduire son impact carbone et adopter de bons réflexes écologiques
Si la question n’est pas liée à ces thèmes, réponds simplement :
  "Désolé, je ne peux répondre qu'aux questions concernant le recyclage et le tri des ordures."
Sois toujours clair, concis et pratique dans tes réponses.
  """;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  /// 🔹 Envoi du message à l'IA Gemini
  Future<void> _sendMessage(String text) async {
    if (text.trim().isEmpty || _isLoading) return;

    setState(() {
      _messages.add(
        MessageModel(message: text, isUser: true, timeSpam: DateTime.now()),
      );
      _isLoading = true;
    });
    _scrollToBottom();

    try {
      // 🔸 Appel réel à Gemini via la méthode `prompt`
      final response = await gemini.prompt(
        parts: [
          Part.text("$systemPrompt\n\nQuestion de l'utilisateur : $text"),
        ],
      );

      final iaResponse = response?.output ?? 
        "Je n'ai pas pu générer de réponse. Veuillez réessayer.";

      setState(() {
        _messages.add(
          MessageModel(
            message: iaResponse,
            isUser: false,
            timeSpam: DateTime.now(),
          ),
        );
        _isLoading = false;
      });
      _scrollToBottom();
    } catch (e) {
      setState(() {
        _isLoading = false;
        _messages.add(
          MessageModel(
            message: "Erreur : impossible d'obtenir une réponse de l'IA.",
            isUser: false,
            timeSpam: DateTime.now(),
          ),
        );
      });
      debugPrint("Erreur Gemini: $e");
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              height: 32,
              width: 32,
              decoration: BoxDecoration(
                color: Colors.lightGreenAccent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.smart_toy, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                TextCustom(
                  data: 'AI Chatbot',
                  fontSize: 16,
                  color: Color(0xFF1F2937),
                  fontWeight: FontWeight.w600,
                ),
                TextCustom(
                  data: 'Powered by Gemini',
                  fontSize: 12,
                  color: Color(0xFF10B981),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                return Align(
                  alignment:
                      msg.isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: msg.isUser
                          ? Colors.lightGreenAccent
                          : const Color(0xFFF3F4F6),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(msg.message),
                  ),
                );
              },
            ),
          ),
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      color: Colors.lightGreenAccent,
                      strokeWidth: 2,
                    ),
                  ),
                  SizedBox(width: 12),
                  Text(
                    "CleanCityAi réfléchit...",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Color(0xFFE5E7EB))),
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3F4F6),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: TextField(
                        controller: _textController,
                        textInputAction: TextInputAction.send,
                        maxLines: null,
                        decoration: const InputDecoration(
                          hintText: 'Tapez un message...',
                          hintStyle: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF9CA3AF),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          border: InputBorder.none,
                        ),
                        onSubmitted: (value) {
                          if (value.trim().isNotEmpty && !_isLoading) {
                            _sendMessage(value.trim());
                            _textController.clear();
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  GestureDetector(
                    onTap: () {
                      final text = _textController.text.trim();
                      if (text.isNotEmpty && !_isLoading) {
                        _sendMessage(text);
                        _textController.clear();
                      }
                    },
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: const BoxDecoration(
                        color: Colors.lightGreenAccent,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.send_outlined,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
