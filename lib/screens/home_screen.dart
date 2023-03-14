import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hacker_news/controller/news+provider.dart';
import 'package:hacker_news/controller/post_news.dart';
import 'package:hacker_news/models/news_model.dart';
import 'package:hacker_news/screens/show_news.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
class NewsHome extends StatefulWidget {
  const NewsHome({super.key});

  @override
  State<NewsHome> createState() => _NewsHomeState();
}

class _NewsHomeState extends State<NewsHome> {
  @override
  void initState() {
    super.initState();
    final NewsStroryProvider controller = context.read<NewsStroryProvider>();

    controller.topStories();
  }

  @override
  Widget build(BuildContext context) {
    final NewsStroryProvider controller = context.watch<NewsStroryProvider>();
    TextEditingController searchController = TextEditingController();

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
          elevation: 0.0,
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          height: size.height,
          width: size.width,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 5,),
               const Text('Click  On The News To Read '),
                SizedBox(
                  height: size.height * .7,
                  width: size.width,
                  child: ListView.builder(
                    itemCount: controller.storyList.length,
                    itemBuilder: (context, index) {
                      final Story story = controller.storyList[index];

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NewsView(url: story.url)),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          margin: EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.green.withOpacity(.1),
                          ),
                          //   child: ListTile(
                          //     title: Text(story.title),
                          //     subtitle: Text(story.url),
                          //   ),
                          // );
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                story.title,
                                style: GoogleFonts.poppins(
                                  color: Colors.blue,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                story.url,
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: size.height * .15,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          controller: searchController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.only(right: 10.0, left: 20.0),
                            fillColor: Colors.grey.withOpacity(.4),
                            focusColor: Colors.grey.withOpacity(.4),
                            filled: true,
                            hintText: "Post your News",
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      InkWell(
                        onTap: () async {
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   await SnackBar(
                          //     content: Text('News Posted'),
                          //     duration: Duration(seconds: 2),
                          //   ),
                          // );
                          Fluttertoast .showToast(
                              msg: "This is a Toast message",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              textColor: Colors.white,
                              fontSize: 16.0);
                          postNewsFeed('title', 'url');
                        },
                        child: const Icon(Icons.send),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
