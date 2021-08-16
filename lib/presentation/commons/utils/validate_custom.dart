class ValidateCustom {
  String validateLogin(String value) {
    if (value.isEmpty) {
      return 'Please, fill this field';
    }
    return null;
  }
}
