import 'package:get/get.dart';
import 'package:hollywings/data/models/genre/genre_response.dart';
import 'package:hollywings/data/repositories/api_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class GenreDataSource extends GetConnect {
  Future<List<GenreResponse>> getAllGenre();
  Future<GenreResponse> getGenreById(int id);
  Future<GenreResponse> insertGenre(String nameGenre);
  Future<GenreResponse> updateGenre(GenreResponse request);
}

class GenreDataSourceApi extends GenreDataSource {
  @override
  Future<List<GenreResponse>> getAllGenre() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var headers = {'Authorization': "Bearer $token"};
    Response response =
        await get(ApiConstant.baseUrl + 'genre', headers: headers);
    var listGenre = <GenreResponse>[];
    for (var index = 0; index < response.body.length; index++) {
      listGenre.add(GenreResponse.fromJson(response.body[index]));
    }
    return listGenre;
  }

  @override
  Future<GenreResponse> getGenreById(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var headers = {'Authorization': "Bearer $token"};
    Response response =
        await get(ApiConstant.baseUrl + 'genre/$id', headers: headers);

    return GenreResponse.fromJson(response.body);
  }

  @override
  Future<GenreResponse> insertGenre(String nameGenre) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var headers = {'Authorization': "Bearer $token"};
    final formData = FormData({'name': nameGenre});
    Response response =
        await post(ApiConstant.baseUrl + 'genre', formData, headers: headers);

    return GenreResponse.fromJson(response.body);
  }

  @override
  Future<GenreResponse> updateGenre(GenreResponse request) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var headers = {'Authorization': "Bearer $token"};
    final formData = FormData(request.toJson());
    Response response =
        await put(ApiConstant.baseUrl + 'genre', formData, headers: headers);

    return GenreResponse.fromJson(response.body);
  }
}
