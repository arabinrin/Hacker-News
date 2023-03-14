import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class CommentsPage extends StatefulWidget {
  final int storyId;

  CommentsPage({required this.storyId});

  @override
  _CommentsPageState createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  List<dynamic> _comments = [];

  @override
  void initState() {
    super.initState();
    _fetchComments();
  }

  Future<void> _fetchComments() async {
    final response = await http.get(
      Uri.parse('https://hacker-news.firebaseio.com/v0/item/${widget.storyId}.json'),
    );

    if (response.statusCode == 200) {
      final story = json.decode(response.body);

      if (story['kids'] != null) {
        final commentIds = List<dynamic>.from(story['kids']);

        for (final commentId in commentIds) {
          final commentResponse = await http.get(
            Uri.parse('https://hacker-news.firebaseio.com/v0/item/$commentId.json'),
          );

          if (commentResponse.statusCode == 200) {
            final comment = json.decode(commentResponse.body);
            setState(() {
              _comments.add(comment);
            });
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color(0xfff5f8fd),
          title: Text(
            ' News Comments',
            style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                height: 27 / 18),
          ),
          elevation: 0.0,
        ),
      body: Container(
        child: ListView.builder(
          itemCount: _comments.length,
          itemBuilder: (context, index) {
            final comment = _comments[index];
            return ListTile(
              title: Text(comment['text'] ?? 'Comment not available'),
              subtitle: Text(comment['by'] ?? ''),
            );
          },
        ),
      ),
    );
  }
}
