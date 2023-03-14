
import 'package:http/http.dart' as http;


Future<void> postNewsFeed(String title, String url) async {
  final response = await http.post(
    Uri.parse('https://news.ycombinator.com/submit'),
    body: {'title': title, 'url': url},
  );

  if (response.statusCode == 200) {
    // The post was successful.
    print('Post successful!');
  } else {
    // There was an error.
    print('Error posting news feed: ${response.statusCode}');
  }
}

