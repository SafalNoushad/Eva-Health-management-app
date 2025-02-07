import 'package:flutter/material.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({Key? key}) : super(key: key);

  @override
  _ChatbotScreenState createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final List<ChatMessage> _messages = [];
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    _addBotMessage(
        "Hello! I'm your menstrual health assistant. How can I help you today?");
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    ChatMessage message = ChatMessage(
      text: text,
      isUser: true,
    );
    setState(() {
      _messages.insert(0, message);
      _isTyping = true;
    });
    _scrollToBottom();
    _getBotResponse(text);
  }

  void _getBotResponse(String userMessage) {
    // Simulating a delay for bot response
    Future.delayed(const Duration(seconds: 1), () {
      String botResponse = _generateBotResponse(userMessage);
      _addBotMessage(botResponse);
      setState(() {
        _isTyping = false;
      });
      _scrollToBottom();
    });
  }

  void _addBotMessage(String text) {
    ChatMessage botMessage = ChatMessage(
      text: text,
      isUser: false,
    );
    setState(() {
      _messages.insert(0, botMessage);
    });
  }

  String _generateBotResponse(String userMessage) {
    userMessage = userMessage.toLowerCase();
    if (userMessage.contains("hello") || userMessage.contains("hi")) {
      return "Hello! How can I assist you with your menstrual health today?";
    } else if (userMessage.contains("period")) {
      return "Your period is a natural part of your menstrual cycle. It usually occurs every 21-35 days and lasts for 2-7 days. Is there anything specific you'd like to know about your period?";
    } else if (userMessage.contains("cramp")) {
      return "Menstrual cramps are common. To alleviate discomfort, you can try:\n\n1. Using a heating pad\n2. Gentle exercise like walking or yoga\n3. Over-the-counter pain relievers\n4. Staying hydrated\n\nIf your cramps are severe, it's best to consult with a healthcare provider.";
    } else if (userMessage.contains("pms")) {
      return "Premenstrual Syndrome (PMS) can include symptoms like mood swings, bloating, and breast tenderness. These typically occur 1-2 weeks before your period. Some ways to manage PMS include regular exercise, stress reduction techniques, and a balanced diet.";
    } else if (userMessage.contains("track")) {
      return "Tracking your menstrual cycle can help you understand your body better. You can log your period dates, symptoms, and mood in the app. Would you like me to show you how to use the tracking feature?";
    } else {
      return "I'm not sure how to respond to that. Can you please rephrase your question or ask about a specific menstrual health topic?";
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            reverse: true,
            itemCount: _messages.length,
            itemBuilder: (context, index) => _messages[index],
          ),
        ),
        if (_isTyping)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text("Bot is typing..."),
          ),
        const Divider(height: 1.0),
        Container(
          decoration: BoxDecoration(color: Theme.of(context).cardColor),
          child: _buildTextComposer(),
        ),
      ],
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).colorScheme.secondary),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration: InputDecoration(
                  hintText: "Ask me anything about menstrual health",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.surface,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                icon: const Icon(Icons.send),
                onPressed: () => _handleSubmitted(_textController.text),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  const ChatMessage({Key? key, required this.text, required this.isUser})
      : super(key: key);

  final String text;
  final bool isUser;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUser)
            Container(
              margin: const EdgeInsets.only(right: 16.0),
              child: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                child: const Icon(Icons.health_and_safety, color: Colors.white),
              ),
            ),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Text(isUser ? 'You' : 'Health Assistant',
                    style: Theme.of(context).textTheme.titleMedium),
                Container(
                  margin: const EdgeInsets.only(top: 5.0),
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: isUser
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Text(text),
                ),
              ],
            ),
          ),
          if (isUser)
            Container(
              margin: const EdgeInsets.only(left: 16.0),
              child: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: const Icon(Icons.person, color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }
}
