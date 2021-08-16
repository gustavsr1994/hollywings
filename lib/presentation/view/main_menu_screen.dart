import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hollywings/presentation/controller/author_controller.dart';
import 'package:hollywings/presentation/controller/book_controller.dart';
import 'package:hollywings/presentation/controller/member_controller.dart';
import 'package:hollywings/presentation/view/author/list_author_screen.dart';
import 'package:hollywings/presentation/view/book/list_book_screen.dart';
import 'package:hollywings/presentation/view/genre/list_genre_screen.dart';
import 'package:hollywings/presentation/view/member/list_member_screen.dart';
import 'package:hollywings/presentation/controller/genre_controller.dart';

class MainMenuScreen extends StatefulWidget {
  @override
  _MainMenuScreenState createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  final genreController = Get.put(GenreController());
  final memberController = Get.put(MemberController());
  final authorController = Get.put(AuthorController());
  final bookController = Get.put(BookController());

  int _bottomNavIndex = 0;
  List<Widget> _listTab() => [
        ListMemberScreen(),
        ListAuthorScreen(),
        ListBookScreen(),
        ListGenreScreen()
      ];

  List<BottomNavigationBarItem> _bottomNavBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.portrait),
      label: 'Member',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.portrait_rounded),
      label: 'Author',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.book),
      label: 'Book',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.file_copy),
      label: 'Genre',
    ),
  ];

  // var listDataGenre = <GenreResponse>[].obs;
  @override
  void initState() {
    super.initState();
    genreController.getAllGenre();
    memberController.getAllMember();
    authorController.getAllAuthor();
    bookController.getAllBook();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> listTab = _listTab();
    return Scaffold(
      body: IndexedStack(
        index: _bottomNavIndex,
        children: listTab,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _bottomNavIndex,
        items: _bottomNavBarItems,
        onTap: (value) {
          setState(() {
            _bottomNavIndex = value;
          });
        },
        backgroundColor: Colors.white,
      ),
    );
  }
}
