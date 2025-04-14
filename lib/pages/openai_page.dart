import 'package:flash_chat_dubl_3/OpenAI/open_ai_service.dart';
import 'package:flash_chat_dubl_3/componets/my_textfield.dart';
import 'package:flutter/material.dart';

class ChatGpt extends StatefulWidget {
  const ChatGpt({super.key});

  @override
  State<ChatGpt> createState() => _chatGptState();
}

class _chatGptState extends State<ChatGpt> {
  final TextEditingController _contoller = TextEditingController();
  final ChatGPTService _chatGPTService = ChatGPTService();
  String _response = '';
  List<Map<String, String>> _messages =
      []; // Список для хранения сообщений (с указанием, кто отправил)

  void _getResponse() async {
    final prompt = _contoller.text;
    if (prompt.isEmpty) return; // Проверка на пустой запрос

    setState(() {
      _messages.add({
        'sender': 'Вы',
        'message': prompt
      }); // Добавление сообщения пользователя
    });

    try {
      final response = await _chatGPTService.getChatResponse(prompt);
      setState(() {
        _messages.add({
          'sender': 'ChatGPT',
          'message': response
        }); // Добавление ответа ChatGPT
      });
    } catch (e) {
      setState(() {
        _messages.add({
          'sender': 'ChatGPT',
          'message': 'Error: $e'
        }); // В случае ошибки добавляем сообщение об ошибке
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('OpenAI '),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  reverse:
                      false, // Прокрутка вверх, чтобы последние сообщения были видны
                  child: Column(
                    children: [
                      for (var message in _messages)
                        Align(
                          alignment: message['sender'] == 'Вы'
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 10, bottom: 10),
                            margin: const EdgeInsets.only(
                                left: 20, right: 20, top: 10, bottom: 10),
                            decoration: BoxDecoration(
                              color: message['sender'] == 'Вы'
                                  ? Colors.green
                                  : Theme.of(context).colorScheme.secondary,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              message['message']!,
                              style: TextStyle(
                                color: message['sender'] == 'Вы'
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: MyTextfield(
                      hintText: 'Введите ваш запрос... ',
                      controller: _contoller,
                      obscureText: false,
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                    margin: const EdgeInsets.only(right: 25),
                    child: IconButton(
                      onPressed: _getResponse,
                      icon: const Icon(
                        Icons.arrow_upward,
                        color: Colors.white,
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
