import 'package:get/get.dart';
import 'package:hollywings/data/models/book/book_request.dart';
import 'package:hollywings/data/models/book/book_response.dart';
import 'package:hollywings/data/models/genre/genre_response.dart';
import 'package:hollywings/data/repositories/api_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class BookDataSource extends GetConnect {
  Future<List<BookResponse>> getAllBook();
  Future<BookResponse> getBookById(int id);
  Future<GenreResponse> insertBook(BookRequest request);
  Future<GenreResponse> updateBook(BookRequest request, int id);
}

class BookDataSourceApi extends BookDataSource {
  @override
  Future<List<BookResponse>> getAllBook() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var headers = {'Authorization': "Bearer $token"};
    Response response =
        await get(ApiConstant.baseUrl + 'buku/', headers: headers);
    var listBook = <BookResponse>[];
    for (var index = 0; index < response.body.length; index++) {
      listBook.add(BookResponse.fromJson(response.body[index]));
    }
    return listBook;
  }

  @override
  Future<BookResponse> getBookById(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var headers = {'Authorization': "Bearer $token"};
    Response response =
        await get(ApiConstant.baseUrl + 'buku/$id', headers: headers);

    return BookResponse.fromJson(response.body);
  }

  @override
  Future<GenreResponse> insertBook(BookRequest request) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var headers = {'Authorization': "Bearer $token"};
    // final formData = FormData(request.toJson());
    Response response = await post(
        ApiConstant.baseUrl + 'buku/', request.toJson(),
        headers: headers);

    print('Message : ${response.bodyString}');
    return GenreResponse.fromJson(response.body);
  }

  @override
  Future<GenreResponse> updateBook(BookRequest request, int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var headers = {'Authorization': "Bearer $token"};
    // final formData = FormData(request.toJson());
    Response response = await put(
        ApiConstant.baseUrl + 'buku/$id', request.toJson(),
        headers: headers);

    print('Message : ${response.bodyString}');
    return GenreResponse.fromJson(response.body);
  }
}
