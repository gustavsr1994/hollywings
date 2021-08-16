import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hollywings/data/models/login/login_request.dart';
import 'package:hollywings/data/repositories/login_data_source.dart';
import 'package:hollywings/presentation/commons/style/color_palette.dart';
import 'package:hollywings/presentation/commons/utils/decoration_text_field.dart';
import 'package:hollywings/presentation/commons/utils/text_styles.dart';
import 'package:hollywings/presentation/commons/utils/validate_custom.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with ValidateCustom {
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameFocus = FocusNode();
  final passwordFocus = FocusNode();
  var message = ' '.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                TextFormField(
                    style: TextStyle(fontSize: 17),
                    autofocus: true,
                    controller: usernameController,
                    cursorColor: colorAccent,
                    validator: validateLogin,
                    focusNode: usernameFocus,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (value) {
                      usernameFocus.unfocus();
                      FocusScope.of(context).requestFocus(passwordFocus);
                    },
                    decoration: DecorationTextField.vegaInputDecoration(
                        label: 'Username')),
                SizedBox(height: 10),
                TextFormField(
                    style: TextStyle(fontSize: 17),
                    controller: passwordController,
                    cursorColor: colorAccent,
                    validator: validateLogin,
                    focusNode: passwordFocus,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (value) {
                      passwordFocus.unfocus();
                    },
                    decoration: DecorationTextField.vegaInputDecoration(
                        label: 'Password')),
                SizedBox(height: 20),
                Obx(
                  () => Text(
                    '$message.',
                    style:
                        textMediumColor(boldCondition: true, color: colorError),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          color: colorAccent,
                        )),
                    color: colorPrimary,
                    onPressed: () {
                      if (formKey.currentState.validate()) {
                        final models = LoginRequest(
                            username: usernameController.text,
                            password: passwordController.text);
                        login(models);
                        // Get.offNamed('/main');
                      }
                    },
                    child: Text(
                      'Submit',
                      style: textMediumColor(
                          boldCondition: true, color: colorAccent),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }

  void login(LoginRequest models) async {
    var result = await LoginDataSourceApi().login(models);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (result.status) {
      message.value = result.reason;
      prefs.setString('token', result.data.accessToken);
      print(result.data.accessToken);
      Get.offNamed('/main');
    } else {
      message.value = result.reason;
    }
  }
}
