import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hollywings/data/models/genre/genre_response.dart';
import 'package:hollywings/presentation/commons/style/color_palette.dart';
import 'package:hollywings/presentation/commons/utils/text_styles.dart';

class CardGenre {
  Widget cardListGenre(
      BuildContext context, GenreResponse data) {
    return InkWell(
        onTap: () {
          _navigateToFormGenre(data.id);
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.all(8),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
              border: Border.all(color: colorPrimary),
              borderRadius: BorderRadius.circular(20)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                data.name.toUpperCase(),
                style:
                    textLargerColor(boldCondition: true, color: colorPrimary),
              ),
              Text('Edit',
                  style:
                      textSmallColor(boldCondition: false, color: colorPrimary))
            ],
          ),
        ));
  }

  void _navigateToFormGenre(int id) async {
    Get.toNamed('/formGenre', arguments: id);
  }
}
