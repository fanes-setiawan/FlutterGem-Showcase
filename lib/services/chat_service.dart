// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class ChatService {
//   final String apiKey; // Ganti dengan kunci API yang valid

//   ChatService({required this.apiKey});

//   Future<String> getAnswer(List<Map<String, String>> chatHistory) async {
//     final url =
//         "https://generativelanguage.googleapis.com/v1beta2/models/chat-bison-001:generateMessage?key=$apiKey";
//     final uri = Uri.parse(url);

//     List<Map<String, String>> messages = [];
//     for (var i = 0; i < chatHistory.length; i++) {
//       messages.add(
//         {"content": chatHistory[i]["message"]},
//       );
//     }

//     Map<String, dynamic> requestBody = {
//       "prompt": {
//         "messages": [messages]
//       },
//       "temperature": 0.25,
//       "candidateCount": 1,
//       "topP": 1,
//       "topK": 1
//     };

//     final response = await http.post(uri, body: jsonEncode(requestBody));

//     if (response.statusCode == 200) {
//       return json.decode(response.body)["candidates"][0]["content"];
//     } else {
//       throw Exception('Failed to get answer from API');
//     }
//   }
// }
