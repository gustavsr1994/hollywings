import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hollywings/data/models/author/author_response.dart';
import 'package:hollywings/data/models/book/book_response.dart';
import 'package:hollywings/presentation/commons/style/color_palette.dart';
import 'package:hollywings/presentation/commons/utils/text_styles.dart';

class CardBook {
  Widget cardListBook(BuildContext context, BookResponse data) {
    return InkWell(
        onTap: () {
          _navigateToFormBook(data.id);
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
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.judul.toUpperCase(),
                    style: textLargerColor(
                        boldCondition: true, color: colorPrimary),
                  ),
                  Text(
                    data.harga.toString(),
                    style: textMediumColor(
                        boldCondition: false, color: colorPrimary),
                  ),
                  Text(
                    data.lokasi,
                    style: textMediumColor(
                        boldCondition: false, color: colorPrimary),
                  )
                ],
              ),
              Text('Edit',
                  style:
                      textSmallColor(boldCondition: false, color: colorPrimary))
            ],
          ),
        ));
  }

  void _navigateToFormBook(int id) async {
    Get.toNamed('/formBook', arguments: id);
  }
}
