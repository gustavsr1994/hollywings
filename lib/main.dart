import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hollywings/presentation/view/author/form_author_screen.dart';
import 'package:hollywings/presentation/view/book/form_book_screen.dart';
import 'package:hollywings/presentation/view/genre/form_genre_screen.dart';
import 'package:hollywings/presentation/view/login_screen.dart';
import 'package:hollywings/presentation/view/main_menu_screen.dart';
import 'package:hollywings/presentation/view/member/form_member_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/',
      getPages: [
        GetPage(
            name: '/', page: () => LoginScreen(), transition: Transition.fade),
        GetPage(
            name: '/main',
            page: () => MainMenuScreen(),
            transition: Transition.zoom),
        GetPage(name: '/formGenre', page: () => FormGenreScreen()),
        GetPage(name: '/formAuthor', page: () => FormAuthorScreen()),
        GetPage(name: '/formBook', page: () => FormBookScreen()),
        GetPage(name: '/formMember', page: () => FormMemberScreen())
      ],
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
