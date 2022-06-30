import 'package:assignment2_riverpod/utils/app_urls.dart';
import 'package:assignment2_riverpod/view/post_detail_screen.dart';
import 'package:assignment2_riverpod/view/post_detail_screen3.dart';
import 'package:assignment2_riverpod/view/post_detail_screen2.dart';
import 'package:assignment2_riverpod/view/post_list_screen.dart';
import 'package:assignment2_riverpod/view/post_list_screen3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "posts",
      theme: ThemeData(
          primaryColor: Colors.orange,
          brightness: Brightness.light,
          primarySwatch: Colors.orange,
          textTheme: const TextTheme(
            headline1: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
            headline2: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
            headline3: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Colors.black87),
          ),
          splashColor: Colors.lightGreen),
      initialRoute: AppUrls.home3,
      routes: {
        AppUrls.home: (_) => const PostListScreen(),
        AppUrls.home3: (_) => const PostListScreen3(),
        AppUrls.detail: (_) => const PostDetailScreen(),
        AppUrls.detail2: (_) => const PostDetailScreen2(),
        AppUrls.detail3: (_) => const PostDetailScreen3(),
      },
    );
  }
}
