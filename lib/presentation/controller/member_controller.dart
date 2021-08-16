import 'package:get/get.dart';
import 'package:hollywings/data/models/member/member_request.dart';
import 'package:hollywings/data/models/member/member_response.dart';
import 'package:hollywings/data/repositories/member_data_source.dart';

class MemberController extends GetxController {
  var listMember = <MemberResponse>[].obs;
  var member = MemberResponse().obs;
  var state = ''.obs;

  void getAllMember() async {
    state.value = 'Loading';
    var result = await MemberDataSourceApi().getAllMember();
    listMember.value = result;
    if (listMember.value == null) {
      state.value = 'NoData';
    } else {
      state.value = 'HasData';
    }
    listMember.refresh();
  }

  void submitDataMember(MemberRequest request, int id) async {
    var result;
    if (id == null) {
      result = await MemberDataSourceApi().insertMember(request);
      member.value = result;
      getAllMember();
      Get.back();
    } else {
      result = await MemberDataSourceApi().updateMember(request, id);
      if (result.id == id) {
        member.value = result;
        getAllMember();
        Get.back();
      }else{
        state.value = 'Error';
      }
    }
  }
}
