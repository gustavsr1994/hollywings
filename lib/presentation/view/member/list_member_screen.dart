import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hollywings/data/models/member/member_response.dart';
import 'package:hollywings/presentation/commons/style/color_palette.dart';
import 'package:hollywings/presentation/commons/utils/text_styles.dart';
import 'package:hollywings/presentation/commons/utils/widgets/card_member.dart';
import 'package:hollywings/presentation/controller/member_controller.dart';

class ListMemberScreen extends StatefulWidget {
  @override
  _ListMemberScreenState createState() => _ListMemberScreenState();
}

class _ListMemberScreenState extends State<ListMemberScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('List Member'),
          backgroundColor: colorPrimary,
          actions: [
            GestureDetector(
              onTap: () => Get.toNamed('/formMember'),
              child: Center(
                  child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Add',
                  style:
                      textMediumColor(boldCondition: true, color: colorAccent),
                ),
              )),
            )
          ],
        ),
        body: GetX<MemberController>(
          builder: (controller) {
            if (controller.state.value == 'Loading') {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (controller.state.value == 'HasData') {
              return SingleChildScrollView(
                child: Column(
                  children: [listMember(controller.listMember)],
                ),
              );
            }
            return Container();
          },
        ));
  }

  Widget listMember(List<MemberResponse> data) {
    return Container(
      child: ListView.builder(
        padding: EdgeInsets.all(0),
        itemCount: data.length,
        itemBuilder: (context, index) {
          return CardMember().cardListMember(context, data[index]);
        },
        shrinkWrap: true,
        physics: ScrollPhysics(),
      ),
    );
  }
}
