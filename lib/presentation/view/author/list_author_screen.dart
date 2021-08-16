import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hollywings/data/models/author/author_response.dart';
import 'package:hollywings/presentation/commons/style/color_palette.dart';
import 'package:hollywings/presentation/commons/utils/text_styles.dart';
import 'package:hollywings/presentation/commons/utils/widgets/card_author.dart';
import 'package:hollywings/presentation/controller/author_controller.dart';

class ListAuthorScreen extends StatefulWidget {
  @override
  _ListAuthorScreenState createState() => _ListAuthorScreenState();
}

class _ListAuthorScreenState extends State<ListAuthorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('List Author'),
          backgroundColor: colorPrimary,
          actions: [
            GestureDetector(
              onTap: () => Get.toNamed('/formAuthor'),
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
        body: GetX<AuthorController>(
          builder: (controller) {
            if (controller.state.value == 'Loading') {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (controller.state.value == 'HasData') {
              return SingleChildScrollView(
                child: Column(
                  children: [listAuthor(controller.listAuthor)],
                ),
              );
            }
            return Container();
          },
        ));
  }

  Widget listAuthor(List<AuthorResponse> data) {
    return Container(
      child: ListView.builder(
        padding: EdgeInsets.all(0),
        itemCount: data.length,
        itemBuilder: (context, index) {
          return CardAuthor().cardListAuthor(context, data[index]);
        },
        shrinkWrap: true,
        physics: ScrollPhysics(),
      ),
    );
  }
}
