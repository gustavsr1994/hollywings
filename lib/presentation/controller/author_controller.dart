import 'package:get/get.dart';
import 'package:hollywings/data/models/author/author_request.dart';
import 'package:hollywings/data/models/author/author_response.dart';
import 'package:hollywings/data/repositories/author_data_source.dart';

class AuthorController extends GetxController {
  var listAuthor = <AuthorResponse>[].obs;
  var author = AuthorResponse().obs;
  var state = ''.obs;

  void getAllAuthor() async {
    state.value = 'Loading';
    var result = await AuthorDataSourceApi().getAllAuthor();
    listAuthor.value = result;
    if (listAuthor.value == null) {
      state.value = 'NoData';
    } else {
      state.value = 'HasData';
    }
    listAuthor.refresh();
  }

  void submitDataAuthor(AuthorRequest request, int id) async {
    var result;
    if (id == null) {
      result = await AuthorDataSourceApi().insertAuthor(request);
      author.value = result;
      getAllAuthor();
      Get.back();
    } else {
      result = await AuthorDataSourceApi().updateAuthor(request, id);
      if (result.id == id) {
        author.value = result;
        getAllAuthor();
        Get.back();
      } else {
        state.value = 'Error';
      }
    }
  }
}
