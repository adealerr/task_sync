import 'package:flutter/material.dart';
import 'package:task_sync/core/colors.dart';

class ChatDetailNarrowPage extends StatefulWidget {
  final String chatName;

  const ChatDetailNarrowPage({super.key, required this.chatName});

  @override
  State<ChatDetailNarrowPage> createState() => _ChatDetailNarrowPageState();
}

class _ChatDetailNarrowPageState extends State<ChatDetailNarrowPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Message> _messages = [
    Message(sender: 'user', text: 'Привет, как дела?', time: '14:10'),
    Message(sender: 'other', text: 'Привет! Всё хорошо, а у тебя?', time: '14:12'),
  ];

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;
    setState(() {
      _messages.add(Message(
        sender: 'user',
        text: _controller.text.trim(),
        time: TimeOfDay.now().format(context),
      ));
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: lightBackground,),
          onPressed: Navigator.of(context).pop,
        ),
        backgroundColor: lightPrimary,
        title: Text(
          widget.chatName,
          style: const TextStyle(
            fontSize: 20,
            color: lightBackground,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                reverse: true,
                padding: const EdgeInsets.all(8),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final msg = _messages[_messages.length - index - 1];
                  final isUser = msg.sender == 'user';
                  return Align(
                    alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: isUser ? lightPrimary : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                        children: [
                          Text(
                            msg.text,
                            style: TextStyle(
                              color: isUser ? Colors.white : Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            msg.time,
                            style: TextStyle(
                              fontSize: 10,
                              color: isUser ? Colors.white70 : Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Введите сообщение...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: _sendMessage,
                    color: Colors.blueAccent,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}

class Message {
  final String sender;
  final String text;
  final String time;

  Message({required this.sender, required this.text, required this.time});
}
