import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:flutter_holo_date_picker/i18n/date_picker_i18n.dart';
import 'package:hollywings/data/models/author/author_response.dart';
import 'package:hollywings/data/models/book/book_request.dart';
import 'package:hollywings/data/models/book/book_response.dart';
import 'package:hollywings/data/models/genre/genre_response.dart';
import 'package:get/get.dart';
import 'package:hollywings/data/repositories/author_data_source.dart';
import 'package:hollywings/data/repositories/book_data_source.dart';
import 'package:hollywings/data/repositories/genre_data_source.dart';
import 'package:hollywings/presentation/commons/style/color_palette.dart';
import 'package:hollywings/presentation/commons/utils/datetime_formatter.dart';
import 'package:hollywings/presentation/commons/utils/decoration_text_field.dart';
import 'package:hollywings/presentation/commons/utils/text_styles.dart';
import 'package:hollywings/presentation/commons/utils/validate_custom.dart';
import 'package:hollywings/presentation/controller/book_controller.dart';

class FormBookScreen extends StatefulWidget {
  @override
  _FormBookScreenState createState() => _FormBookScreenState();
}

class _FormBookScreenState extends State<FormBookScreen> with ValidateCustom {
  final titleController = TextEditingController();
  final locationController = TextEditingController();
  final priceController = TextEditingController();
  final yearController = TextEditingController();
  final keywordController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final dataBook = BookResponse().obs;
  final listGenre = <GenreResponse>[].obs;
  final listAuthor = <AuthorResponse>[].obs;

  int genreSelected = null;
  int authorSelected = null;
  String keywordSelected = null;
  bool isBorrow = true;

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
    var result = await BookDataSourceApi().getBookById(id);
    dataBook.value = result;
    titleController.text = dataBook.value.judul;
    locationController.text = dataBook.value.lokasi;
    priceController.text = dataBook.value.harga.toString();
    yearController.text = dataBook.value.tahunTerbit;

    dataBook.value.genre.forEach((element) {
      genreSelected = element.id;
    });
    dataBook.value.pengarang.forEach((element) {
      authorSelected = element.id;
    });
    dataBook.value.keyword.forEach((element) {
      keywordSelected = element;
    });
    keywordController.text = keywordSelected;
    isBorrow = dataBook.value.pinjam;
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
        title: Text('Form Book'),
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
                  controller: titleController,
                  cursorColor: colorAccent,
                  validator: validateLogin,
                  decoration: DecorationTextField.vegaInputDecoration(
                      label: 'Title Book')),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: priceController,
                validator: validateLogin,
                decoration: DecorationTextField.vegaInputDecoration(
                  label: 'Price Book',
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: locationController,
                validator: validateLogin,
                decoration: DecorationTextField.vegaInputDecoration(
                  label: 'Location',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: keywordController,
                validator: validateLogin,
                decoration: DecorationTextField.vegaInputDecoration(
                  label: 'Keyword',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: yearController,
                cursorColor: colorAccent,
                onTap: () => methodBirthDate(),
                validator: validateLogin,
                decoration: DecorationTextField.vegaInputDecoration(
                    label: 'Year Release',
                    suffixIcon: IconButton(
                      onPressed: null,
                      icon: Icon(Icons.calendar_today_outlined),
                    )),
              ),
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
              SizedBox(
                height: 32,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text("Choice (Can Borrow/Can't Borrow"),
              ),
              Row(
                children: [
                  Radio(
                    value: true,
                    groupValue: isBorrow,
                    activeColor: colorPrimary,
                    onChanged: (status) {
                      setState(() {
                        isBorrow = status;
                      });
                    },
                  ),
                  Text(
                    'Can Borrow',
                    style: textMediumColor(
                        boldCondition: false, color: colorPrimary),
                  ),
                ],
              ),
              Row(
                children: [
                  Radio(
                    value: false,
                    groupValue: isBorrow,
                    activeColor: colorPrimary,
                    onChanged: (status) {
                      setState(() {
                        isBorrow = status;
                      });
                    },
                  ),
                  Text(
                    "Can't Borrow",
                    style: textMediumColor(
                        boldCondition: false, color: colorPrimary),
                  ),
                ],
              ),
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
      dateFormat: "yyyy",
      locale: DateTimePickerLocale.en_us,
      looping: false,
    );
    yearController.text =
        DatetimeFormatter().formatDatePickerYear(startDatePicked);
  }

  void submit() async {
    if (formKey.currentState.validate()) {
      var name = 'GSR ${titleController.text}';
      var genreListSelected = <int>[];
      genreListSelected.add(genreSelected);

      var authorListSelected = <int>[];
      authorListSelected.add(authorSelected);
      var keywordListSelected = <String>[];
      keywordListSelected.add(keywordController.text);

      var request = BookRequest(
          judul: name,
          harga: int.parse(priceController.text),
          lokasi: locationController.text,
          tahunTerbit: yearController.text,
          genre: genreListSelected,
          pengarang: authorListSelected,
          keyword: keywordListSelected,
          pinjam: isBorrow);
      Get.find<BookController>().submitDataBook(request, id);
    }
  }
}
