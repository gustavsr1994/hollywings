import 'package:get/get.dart';
import 'package:hollywings/data/models/genre/genre_response.dart';
import 'package:hollywings/data/repositories/genre_data_source.dart';

class GenreController extends GetxController {
  var listGenre = <GenreResponse>[].obs;
  var genre = GenreResponse().obs;
  var state = ''.obs;

  void getAllGenre() async {
    state.value = 'Loading';
    var result = await GenreDataSourceApi().getAllGenre();
    listGenre.value = result;
    if (listGenre.value == null) {
      state.value = 'NoData';
    } else {
      state.value = 'HasData';
    }
    listGenre.refresh();
  }

  void submitDataGenre(int id, String name) async {
    var result;
    if (id == null) {
      result = await GenreDataSourceApi().insertGenre(name);
      genre.value = result;
      getAllGenre();
      Get.back();
    } else {
      result = await GenreDataSourceApi()
          .updateGenre(GenreResponse(id: id, name: name));
      if (result.id == id) {
        genre.value = result;
        getAllGenre();
        Get.back();
      } else {
        state.value = 'Error';
      }
    }
  }
}
