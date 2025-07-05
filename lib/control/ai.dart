import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:link_verse/models/bookmark.dart';

Future<String?> generateContent(String prompt) async {
  const apiKey = 'AIzaSyB35kG1G57I6qg7GRxyUCY8tZcgZ0nG0VE';
  final url = Uri.parse(
    'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=$apiKey',
  );

  final headers = {
    'Content-Type': 'application/json',
  };

  final body = jsonEncode({
    "contents": [
      {
        "parts": [
          {
            "text": prompt
          }
        ]
      }
    ]
  });

  try {
    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return responseData['candidates'][0]['content']['parts'][0]['text'];
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}

Future<dynamic> inspectUrl(String url) async {
  String prompt = """
Given the url: $url
write 3-5 lines summary on the content.
suggest images Urls related to the content or exist in the url page, and ensure they exist and downloadable
suggest 3-5 tags on the content, general or specific tags, 2 words at most for each
return the result as json only only json
{
"summary": "...",
"images":["http://...",".."],
"tags": ["..",".."]
}
""";
  final response = await generateContent(prompt);
  if (response != null) {
    RegExp regExp = RegExp(r'```json\n(.*)\n```', multiLine: true, dotAll: true);
    final match = regExp.firstMatch(response);
    if (match != null) {
      final result = jsonDecode(match.group(1)!);
      return result;
    }
  }
  return null;
}

Future<void> inspectBookmark(Bookmark bookmark) async {
  final result = await inspectUrl(bookmark.url);
  if (result != null) {
    bookmark.summary = result['summary'] ?? '';
    bookmark.tags = List<String>.from(result['tags'] ?? [] );
    bookmark.imageUrls = List<String>.from(result['images'] ?? [] );
  }
}
