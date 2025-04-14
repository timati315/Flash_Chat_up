import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatGPTService {
  final String apiKey =
      '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'; // подставь свой ключ
  final String apiUrl = 'https://api.openai.com/v1/chat/completions';

  Future<String> getChatResponse(String prompt) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        'model': 'gpt-3.5-turbo',
        'messages': [
          {
            'role': 'user',
            'content': prompt,
          },
        ],
        'max_tokens': 150,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      return responseData['choices'][0]['message']['content'].trim();
    } else {
      throw Exception(
        'Ошибка при получении ответа от API: ${response.statusCode}\n${response.body}',
      );
    }
  }
}
