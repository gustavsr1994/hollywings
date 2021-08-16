import 'package:get/get.dart';
import 'package:hollywings/data/models/author/author_request.dart';
import 'package:hollywings/data/models/author/author_response.dart';
import 'package:hollywings/data/models/genre/genre_response.dart';
import 'package:hollywings/data/repositories/api_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthorDataSource extends GetConnect {
  Future<List<AuthorResponse>> getAllAuthor();
  Future<AuthorResponse> getAuthorById(int id);
  Future<GenreResponse> insertAuthor(AuthorRequest request);
  Future<GenreResponse> updateAuthor(AuthorRequest request, int id);
}

class AuthorDataSourceApi extends AuthorDataSource {
  @override
  Future<List<AuthorResponse>> getAllAuthor() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var headers = {'Authorization': "Bearer $token"};
    Response response =
        await get(ApiConstant.baseUrl + 'pengarang/', headers: headers);
    var listAuthor = <AuthorResponse>[];
    for (var index = 0; index < response.body.length; index++) {
      listAuthor.add(AuthorResponse.fromJson(response.body[index]));
    }
    return listAuthor;
  }

  @override
  Future<AuthorResponse> getAuthorById(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var headers = {'Authorization': "Bearer $token"};
    Response response =
        await get(ApiConstant.baseUrl + 'pengarang/$id', headers: headers);

    return AuthorResponse.fromJson(response.body);
  }

  @override
  Future<GenreResponse> insertAuthor(AuthorRequest request) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var headers = {'Authorization': "Bearer $token"};
    // final formData = FormData(request.toJson());
    Response response = await post(
        ApiConstant.baseUrl + 'pengarang/', request.toJson(),
        headers: headers);

    print('Message : ${response.bodyString}');
    return GenreResponse.fromJson(response.body);
  }

  @override
  Future<GenreResponse> updateAuthor(AuthorRequest request, int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var headers = {'Authorization': "Bearer $token"};
    // final formData = FormData(request.toJson());
    Response response = await put(
        ApiConstant.baseUrl + 'pengarang/$id', request.toJson(),
        headers: headers);

    print('Message : ${response.bodyString}');
    return GenreResponse.fromJson(response.body);
  }
}
