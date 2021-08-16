import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hollywings/data/models/genre/genre_response.dart';
import 'package:hollywings/data/repositories/genre_data_source.dart';
import 'package:hollywings/presentation/commons/style/color_palette.dart';
import 'package:hollywings/presentation/commons/utils/decoration_text_field.dart';
import 'package:hollywings/presentation/commons/utils/text_styles.dart';
import 'package:hollywings/presentation/commons/utils/validate_custom.dart';
import 'package:hollywings/presentation/controller/genre_controller.dart';

class FormGenreScreen extends StatefulWidget {
  @override
  _FormGenreScreenState createState() => _FormGenreScreenState();
}

class _FormGenreScreenState extends State<FormGenreScreen> with ValidateCustom {
  final nameGenreController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final dataGenre = GenreResponse().obs;
  @override
  void initState() {
    super.initState();
    var id = Get.arguments;
    if (id != null) {
      getData(id);
    }
  }

  void getData(int id) async {
    var result = await GenreDataSourceApi().getGenreById(id);
    dataGenre.value = result;
    nameGenreController.text = dataGenre.value.name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Genre'),
        backgroundColor: colorPrimary,
        actions: [
          GestureDetector(
            onTap: () => submit(),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  'Submit',
                  style:
                      textMediumColor(boldCondition: true, color: colorAccent),
                ),
              ),
            ),
          )
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextFormField(
                    style: TextStyle(fontSize: 17),
                    controller: nameGenreController,
                    cursorColor: colorAccent,
                    validator: validateLogin,
                    decoration: DecorationTextField.vegaInputDecoration(
                        label: 'Name Genre')),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void submit() async {
    var id = Get.arguments;
    if (formKey.currentState.validate()) {
      var name = 'GSR ${nameGenreController.text}';
      Get.find<GenreController>().submitDataGenre(id, name);
    }
  }
}
