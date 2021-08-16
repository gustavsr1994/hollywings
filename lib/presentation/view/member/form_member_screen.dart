import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:hollywings/data/models/author/author_response.dart';
import 'package:hollywings/data/models/genre/genre_response.dart';
import 'package:hollywings/data/models/member/member_request.dart';
import 'package:hollywings/data/models/member/member_response.dart';
import 'package:hollywings/data/repositories/author_data_source.dart';
import 'package:hollywings/data/repositories/genre_data_source.dart';
import 'package:hollywings/data/repositories/member_data_source.dart';
import 'package:hollywings/presentation/commons/style/color_palette.dart';
import 'package:hollywings/presentation/commons/utils/datetime_formatter.dart';
import 'package:hollywings/presentation/commons/utils/decoration_text_field.dart';
import 'package:hollywings/presentation/commons/utils/text_styles.dart';
import 'package:get/get.dart';
import 'package:hollywings/presentation/commons/utils/validate_custom.dart';
import 'package:hollywings/presentation/controller/member_controller.dart';

class FormMemberScreen extends StatefulWidget {
  @override
  _FormMemberScreenState createState() => _FormMemberScreenState();
}

class _FormMemberScreenState extends State<FormMemberScreen>
    with ValidateCustom {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final birthController = TextEditingController();
  final addressController = TextEditingController();
  final listGenre = <GenreResponse>[].obs;
  final listAuthor = <AuthorResponse>[].obs;

  final dataMember = MemberResponse().obs;
  int genreSelected = null;
  int authorSelected = null;

  var id;

  @override
  void initState() {
    super.initState();
    id = Get.arguments;
    getListGenre();
    getListAuthor();
    if (id != null) {
      getData(id);
    }
  }

  void getData(int id) async {
    var result = await MemberDataSourceApi().getMemberById(id);
    dataMember.value = result;
    nameController.text = dataMember.value.nama;
    birthController.text =
        DatetimeFormatter().formatDate(dataMember.value.tanggalLahir);
    addressController.text = dataMember.value.alamat;

    dataMember.value.genreFavorit.forEach((element) {
      genreSelected = element.id;
    });
    dataMember.value.pengarangFavorit.forEach((element) {
      authorSelected = element.id;
    });
  }

  void getListGenre() async {
    var result = await GenreDataSourceApi().getAllGenre();
    listGenre.value = result;
  }

  void getListAuthor() async {
    var result = await AuthorDataSourceApi().getAllAuthor();
    listAuthor.value = result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Member'),
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
            crossAxisAlignment: CrossAxisAlignment.start,
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
                      label: 'Name Member')),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: birthController,
                cursorColor: colorAccent,
                onTap: () => methodBirthDate(),
                validator: validateLogin,
                decoration: DecorationTextField.vegaInputDecoration(
                    label: 'Birth Date Member',
                    suffixIcon: IconButton(
                      onPressed: null,
                      icon: Icon(Icons.calendar_today_outlined),
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                  style: TextStyle(fontSize: 17),
                  controller: addressController,
                  cursorColor: colorAccent,
                  validator: validateLogin,
                  decoration: DecorationTextField.vegaInputDecoration(
                      label: 'Address Member')),
              SizedBox(
                height: 32,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text('Genre'),
              ),
              Obx(() => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
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
                  )),
              SizedBox(
                height: 32,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text('Author'),
              ),
              Obx(() => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: DropdownButton(
                      hint: Text('Author'),
                      isExpanded: true,
                      value: authorSelected,
                      items: listAuthor.value.map((item) {
                        return DropdownMenuItem(
                          child: Text(item.nama),
                          value: item.id,
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          authorSelected = value;
                        });
                      },
                    ),
                  )),
              GetX<MemberController>(
                builder: (controller) => Center(
                  child: Text(controller.state.value,),
                ),
              )
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
      var genreListSelected = <int>[];
      genreListSelected.add(genreSelected);

      var authorListSelected = <int>[];
      authorListSelected.add(authorSelected);

      var request = MemberRequest(
          nama: name,
          tanggalLahir: birthDate,
          alamat: addressController.text,
          genreFavorit: genreListSelected,
          pengarangFavorit: authorListSelected);
      Get.find<MemberController>().submitDataMember(request, id);
    }
  }
}
