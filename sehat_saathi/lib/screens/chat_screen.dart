import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
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
  bool _isLoading = false;

  Future<void> _sendMessage() async {
    if (_controller.text.isEmpty) return;

    final userText = _controller.text;
    final lowerText = userText.toLowerCase(); // Added this line

    setState(() {
      _messages.add(ChatMessage(userText, true));
      _isLoading = true;
    });

    _controller.clear();

    // Added this heatwave check for demo
    if (lowerText.contains('heat wave') ||
        lowerText.contains('heatwave') ||
        lowerText.contains('karachi')) {
      setState(() {
        _messages.add(ChatMessage(
          "Karachi me heatwave ke doran: 1) Din 11-4 baje ghar me rahen, 2) Har ghante 1 glass pani pien, 3) Halke kapre pehnen, 4) Chakar aye to foran shade me bethen aur pani pien.",
          false,
        ));
        _isLoading = false;
      });
      return;
    }

    try {
      final url = Uri.parse('http://10.0.2.2:3000/chat');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'message': userText}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _messages.add(ChatMessage(data['response']?? 'No response', false));
        });
      } else {
        setState(() {
          _messages.add(ChatMessage(
            'Sorry, I am facing trouble connecting to Sehat Saathi servers. Please try again. (سرور سے رابطہ قائم کرنے میں دشواری پیش آ رہی ہے)',
            false,
          ));
        });
      }
    } catch (e) {
      // Robust fallback to local regex/dummy data if backend is not running
      await Future.delayed(const Duration(milliseconds: 500));
      String responseText = DummyData.chatResponses['default']!;

      if (lowerText.contains('fever')) {
        responseText = DummyData.chatResponses['fever']!;
      } else if (lowerText.contains('sehat card') || lowerText.contains('card')) {
        responseText = DummyData.chatResponses['sehat card']!;
      } else if (lowerText.contains('hello') || lowerText.contains('hi')) {
        responseText = DummyData.chatResponses['hello']!;
      }

      setState(() {
        _messages.add(ChatMessage(responseText, false));
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ask Sehat Saathi AI'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length + (_isLoading? 1 : 0),
              itemBuilder: (context, index) {
                if (index == _messages.length) {
                  // Premium thinking indicator
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16).copyWith(
                          bottomLeft: const Radius.circular(0),
                        ),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 14,
                            height: 14,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Sehat Saathi AI is writing...',
                            style: TextStyle(color: Colors.black54, fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                final msg = _messages[index];
                return Align(
                  alignment: msg.isUser? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(14),
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.75,
                    ),
                    decoration: BoxDecoration(
                      color: msg.isUser? Theme.of(context).primaryColor : Colors.white,
                      borderRadius: BorderRadius.circular(16).copyWith(
                        bottomRight: msg.isUser? const Radius.circular(0) : const Radius.circular(16),
                        bottomLeft:!msg.isUser? const Radius.circular(0) : const Radius.circular(16),
                      ),
                      border: msg.isUser? null : Border.all(color: Colors.grey.shade200),
                      boxShadow: msg.isUser
                         ? null
                          : [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.02),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              )
                            ],
                    ),
                    child: Text(
                      msg.text,
                      style: TextStyle(
                        color: msg.isUser? Colors.white : Colors.black87,
                        fontSize: 15,
                        height: 1.3,
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
                BoxShadow(color: Colors.black.withOpacity(0.05), offset: const Offset(0, -1), blurRadius: 4),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Ask about medicine alternative, fever, health card...',
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