import 'package:flutter/material.dart';
import '../data/dummy_data.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class ChatMessage {
  final String text;
  final bool isUser;
  ChatMessage(this.text, this.isUser);
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<ChatMessage> _messages = [
    ChatMessage(DummyData.chatResponses['hello']!, false)
  ];

  void _sendMessage() {
    if (_controller.text.isEmpty) return;

    final userText = _controller.text;
    setState(() {
      _messages.add(ChatMessage(userText, true));
    });

    _controller.clear();

    // Mock bot response
    Future.delayed(const Duration(milliseconds: 500), () {
      String response = DummyData.chatResponses['default']!;
      
      final lowerText = userText.toLowerCase();
      if (lowerText.contains('fever')) {
        response = DummyData.chatResponses['fever']!;
      } else if (lowerText.contains('sehat card') || lowerText.contains('card')) {
        response = DummyData.chatResponses['sehat card']!;
      } else if (lowerText.contains('hello') || lowerText.contains('hi')) {
        response = DummyData.chatResponses['hello']!;
      }

      setState(() {
        _messages.add(ChatMessage(response, false));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ask Sehat Saathi'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                return Align(
                  alignment: msg.isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: msg.isUser ? Theme.of(context).primaryColor : Colors.white,
                      borderRadius: BorderRadius.circular(16).copyWith(
                        bottomRight: msg.isUser ? const Radius.circular(0) : const Radius.circular(16),
                        bottomLeft: !msg.isUser ? const Radius.circular(0) : const Radius.circular(16),
                      ),
                      border: msg.isUser ? null : Border.all(color: Colors.grey.shade300),
                    ),
                    child: Text(
                      msg.text,
                      style: TextStyle(
                        color: msg.isUser ? Colors.white : Colors.black87,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.black12, offset: const Offset(0, -1), blurRadius: 4),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Type your message...',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.green),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
