import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hollywings/data/models/genre/genre_response.dart';
import 'package:hollywings/presentation/commons/style/color_palette.dart';
import 'package:hollywings/presentation/commons/utils/text_styles.dart';
import 'package:hollywings/presentation/commons/utils/widgets/card_genre.dart';
import 'package:hollywings/presentation/controller/genre_controller.dart';

class ListGenreScreen extends StatefulWidget {
  @override
  _ListGenreScreenState createState() => _ListGenreScreenState();
}

class _ListGenreScreenState extends State<ListGenreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('List Genre'),
          backgroundColor: colorPrimary,
          actions: [
            GestureDetector(
              onTap: () => Get.toNamed('/formGenre'),
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
        body: GetX<GenreController>(
          builder: (controller) {
            if (controller.state.value == 'Loading') {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (controller.state.value == 'HasData') {
              return SingleChildScrollView(
                child: Column(
                  children: [listGenre(controller.listGenre)],
                ),
              );
            }
            return Container();
          },
        ));
  }

  Widget listGenre(List<GenreResponse> data) {
    return Container(
      child: ListView.builder(
        padding: EdgeInsets.all(0),
        itemCount: data.length,
        itemBuilder: (context, index) {
          return CardGenre().cardListGenre(context, data[index]);
        },
        shrinkWrap: true,
        physics: ScrollPhysics(),
      ),
    );
  }
}
