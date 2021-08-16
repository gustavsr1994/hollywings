import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/i18n/date_picker_i18n.dart';
import 'package:get/get.dart';
import 'package:hollywings/data/models/author/author_request.dart';
import 'package:hollywings/data/models/author/author_response.dart';
import 'package:hollywings/data/models/genre/genre_response.dart';
import 'package:hollywings/data/repositories/author_data_source.dart';
import 'package:hollywings/data/repositories/genre_data_source.dart';
import 'package:hollywings/presentation/commons/style/color_palette.dart';
import 'package:hollywings/presentation/commons/utils/datetime_formatter.dart';
import 'package:hollywings/presentation/commons/utils/decoration_text_field.dart';
import 'package:hollywings/presentation/commons/utils/text_styles.dart';
import 'package:hollywings/presentation/commons/utils/validate_custom.dart';
import 'package:hollywings/presentation/controller/author_controller.dart';

class FormAuthorScreen extends StatefulWidget {
  @override
  _FormAuthorScreenState createState() => _FormAuthorScreenState();
}

class _FormAuthorScreenState extends State<FormAuthorScreen>
    with ValidateCustom {
  final nameController = TextEditingController();
  final birthController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final dataAuthor = AuthorResponse().obs;
  final listGenre = <GenreResponse>[].obs;
  int genreSelected = null;
  var id;

  @override
  void initState() {
    super.initState();
    id = Get.arguments;
    getListGenre();
    if (id != null) {
      getData(id);
    }
  }

  void getData(int id) async {
    var result = await AuthorDataSourceApi().getAuthorById(id);
    dataAuthor.value = result;
    nameController.text = dataAuthor.value.nama;
    birthController.text =
        DatetimeFormatter().formatDate(dataAuthor.value.tanggalLahir);
    genreSelected = dataAuthor.value.genreSpecialization.id;
  }

  void getListGenre() async {
    var result = await GenreDataSourceApi().getAllGenre();
    listGenre.value = result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Author'),
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
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              TextFormField(
                  style: TextStyle(fontSize: 17),
                  controller: nameController,
                  cursorColor: colorAccent,
                  validator: validateLogin,
                  decoration: DecorationTextField.vegaInputDecoration(
                      label: 'Name Author')),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: birthController,
                cursorColor: colorAccent,
                onTap: () => methodBirthDate(),
                validator: validateLogin,
                decoration: DecorationTextField.vegaInputDecoration(
                    label: 'Birth Date',
                    suffixIcon: IconButton(
                      onPressed: null,
                      icon: Icon(Icons.calendar_today_outlined),
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Text('Genre'),
              ),
              Obx(() => Padding(
                    padding: EdgeInsets.all(8.0),
                    child: DropdownButton(
                      hint: Text('Genre'),
                      isExpanded: true,
                      value: genreSelected,
                      items: listGenre.value.map((item) {
                        return DropdownMenuItem(
                          child: Text(item.name),
                          value: item.id,
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          genreSelected = value;
                        });
                      },
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void methodBirthDate() async {
    var startDatePicked = await DatePicker.showSimpleDatePicker(
      context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1000),
      dateFormat: "dd MMMM yyyy",
      locale: DateTimePickerLocale.en_us,
      looping: false,
    );
    birthController.text =
        DatetimeFormatter().formatDatePicker(startDatePicked);
  }

  void submit() async {
    if (formKey.currentState.validate()) {
      var name = 'GSR ${nameController.text}';
      var birthDate =
          DatetimeFormatter().formatBackendDate(birthController.text);

      var request = AuthorRequest(
          nama: name,
          tanggalLahir: birthDate,
          genreSpecialization: genreSelected);
      Get.find<AuthorController>().submitDataAuthor(request, id);
    }
  }
}
