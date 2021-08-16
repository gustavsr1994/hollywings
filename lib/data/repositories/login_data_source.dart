import 'package:hollywings/data/models/login/login_request.dart';
import 'package:hollywings/data/models/login/login_response.dart';
import 'package:get/get.dart';
import 'package:hollywings/data/repositories/api_constant.dart';

abstract class LoginDataSource extends GetConnect {
  Future<LoginResponse> login(LoginRequest request);
}

class LoginDataSourceApi extends LoginDataSource {
  @override
  Future<LoginResponse> login(LoginRequest request) async {
    final formData = FormData(request.toJson());
    var result = await post(
      ApiConstant.baseUrl + 'api/user/authenticate',
      formData,
      contentType: 'application/x-www-form-urlencoded',
    );

    return LoginResponse.fromJson(result.body);
  }
}
