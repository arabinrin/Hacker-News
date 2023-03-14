import 'dart:convert';

import 'package:hacker_news/models/news_model.dart';
import 'package:http/http.dart' as http;

Future<List<int>> fetchTopStoryIds() async {
  final response = await http.get(Uri.https('hacker-news.firebaseio.com', '/v0/topstories.json'));

  if (response.statusCode == 200) {
    return List<int>.from(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load top story');
  }
}

Future<Story> fetchStory(int storyId) async {
  final response = await http.get(Uri.https('hacker-news.firebaseio.com', '/v0/item/$storyId.json'));

  if (response.statusCode == 200) {
    return Story.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load story $storyId');
  }
}

