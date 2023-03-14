import 'package:flutter/material.dart';
import 'package:hacker_news/controller/news_controller.dart';
import 'package:hacker_news/models/news_model.dart';

class NewsStroryProvider extends ChangeNotifier {
  List<Story> storyList = [];

  topStories() async {
    final topStoryIds = await fetchTopStoryIds();

    final stories = await Future.wait(
      topStoryIds.take(20).map((storyId) => fetchStory(storyId)),
    );
    storyList = stories;
    notifyListeners();
  }
}
