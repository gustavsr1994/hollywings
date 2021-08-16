import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hollywings/data/models/book/book_response.dart';
import 'package:hollywings/presentation/commons/style/color_palette.dart';
import 'package:hollywings/presentation/commons/utils/text_styles.dart';
import 'package:hollywings/presentation/commons/utils/widgets/card_book.dart';
import 'package:hollywings/presentation/controller/book_controller.dart';

class ListBookScreen extends StatefulWidget {
  @override
  _ListBookScreenState createState() => _ListBookScreenState();
}

class _ListBookScreenState extends State<ListBookScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('List Book'),
          backgroundColor: colorPrimary,
          actions: [
            GestureDetector(
              onTap: () => Get.toNamed('/formBook'),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    'Add',
                    style: textMediumColor(
                        boldCondition: true, color: colorAccent),
                  ),
                ),
              ),
            )
          ],
        ),
        body: GetX<BookController>(
          builder: (controller) {
            if (controller.state.value == 'Loading') {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (controller.state.value == 'HasData') {
              return SingleChildScrollView(
                child: Column(
                  children: [listBook(controller.listBook)],
                ),
              );
            }
            return Container();
          },
        ));
  }

  Widget listBook(List<BookResponse> data) {
    return Container(
      child: ListView.builder(
        padding: EdgeInsets.all(0),
        itemCount: data.length,
        itemBuilder: (context, index) {
          return CardBook().cardListBook(context, data[index]);
        },
        shrinkWrap: true,
        physics: ScrollPhysics(),
      ),
    );
  }
}
