
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hacker_news/screens/comment.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsView extends StatefulWidget {
  final String? url;
  final String? title;

  NewsView({this.url, this.title});

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color(0xfff5f8fd),
          title: Text(
            'Hacker News',
            style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                height: 27 / 18),
          ),
          actions: [
            IconButton(
                onPressed: () {
                   Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CommentsPage(storyId: 5,)),
                          );
                },
                icon: Icon(
                  Icons.comment,
                  color: Colors.black,
                ))
          ],
          elevation: 0.0,
        ),
        body: Stack(
          children: [
            Container(
              height: size.height,
              width: size.width,
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 20.h),
              child: WebView(
                initialUrl: widget.url,
                javascriptMode: JavascriptMode.unrestricted,
                onPageFinished: (finish) {
                  setState(() {
                    isLoading = false;
                  });
                },
              ),
            ),
            isLoading
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 10,
                        ),
                        Text('The Story is loading'),
                      ],
                    ),
                  )
                : Stack(),
          ],
        ),
      ),
    );
  }
}
