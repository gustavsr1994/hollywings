import 'package:get/get.dart';
import 'package:hollywings/data/models/genre/genre_response.dart';
import 'package:hollywings/data/models/member/member_request.dart';
import 'package:hollywings/data/models/member/member_response.dart';
import 'package:hollywings/data/repositories/api_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class MemberDataSource extends GetConnect {
  Future<List<MemberResponse>> getAllMember();
  Future<MemberResponse> getMemberById(int id);
  Future<GenreResponse> insertMember(MemberRequest request);
  Future<GenreResponse> updateMember(MemberRequest request, int id);
}

class MemberDataSourceApi extends MemberDataSource {
  @override
  Future<List<MemberResponse>> getAllMember() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var headers = {'Authorization': "Bearer $token"};
    Response response =
        await get(ApiConstant.baseUrl + 'member/', headers: headers);
    var listMember = <MemberResponse>[];
    for (var index = 0; index < response.body.length; index++) {
      listMember.add(MemberResponse.fromJson(response.body[index]));
    }
    return listMember;
  }

  @override
  Future<MemberResponse> getMemberById(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var headers = {'Authorization': "Bearer $token"};
    Response response =
        await get(ApiConstant.baseUrl + 'member/$id', headers: headers);

    return MemberResponse.fromJson(response.body);
  }

  @override
  Future<GenreResponse> insertMember(MemberRequest request) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var headers = {'Authorization': "Bearer $token"};
    // final formData = FormData(request.toJson());
    Response response = await post(
        ApiConstant.baseUrl + 'member/', request.toJson(),
        headers: headers);

    print('Message : ${response.bodyString}');
    return GenreResponse.fromJson(response.body);
  }

  @override
  Future<GenreResponse> updateMember(MemberRequest request, int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var headers = {'Authorization': "Bearer $token"};
    // final formData = FormData(request.toJson());
    Response response = await put(
        ApiConstant.baseUrl + 'member/$id', request.toJson(),
        headers: headers);
    print('Message : ${response.bodyString}');
    return GenreResponse.fromJson(response.body);
  }
}
